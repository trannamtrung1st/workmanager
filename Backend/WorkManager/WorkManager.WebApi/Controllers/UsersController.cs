using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WorkManager.Data;
using WorkManager.Data.Models;
using WorkManager.Data.Domains;
using WorkManager.Data.ViewModels;
using TNT.Core.Helpers.DI;
using TNT.Core.Http.DI;
using WorkManager.Data.Models.Extensions;
using System.Data.SqlClient;
using FirebaseAdmin.Messaging;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/users")]
    [ApiController]
    [InjectionFilter]
    public class UsersController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [Inject]
        private readonly IdentityDomain _iDomain;

        [Inject]
        private readonly EventDomain _eDomain;

        #region OAuth
        [HttpPost("login")]
        public async Task<IActionResult> LogIn(AuthorizationGrantViewModel model)
        {
            try
            {
                AppUsers user = null;
                switch (model.grant_type)
                {
                    case "password":
                    case null:
                        {
                            user = await
                                _iDomain.AuthenticateAsync(model.username, model.password);
                            if (user == null)
                            {
                                return Unauthorized(new ApiResult()
                                {
                                    Code = ResultCode.Unauthorized,
                                    Message = "Invalid username or password"
                                });
                            }
                        }
                        break;
                    case "refresh_token":
                        {
                            var validResult = _iDomain.ValidateRefreshToken(model.refresh_token);
                            if (validResult == null)
                            {
                                return Unauthorized(new ApiResult()
                                {
                                    Code = ResultCode.Unauthorized,
                                    Message = "Invalid refresh_token"
                                });
                            }
                            user = await _iDomain.GetUserById(validResult.Identity.Name);
                            if (user == null)
                            {
                                return Unauthorized(new ApiResult()
                                {
                                    Code = ResultCode.Unauthorized,
                                    Message = "Invalid user identity"
                                });
                            }
                        }
                        break;
                    default:
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Message = "Unsupported grant_type"
                        });
                }

                var identity =
                    await _iDomain.GetIdentityAsync(user, JwtBearerDefaults.AuthenticationScheme);

                var principal = new ClaimsPrincipal(identity);
                var utcNow = DateTime.UtcNow;
                var props = new AuthenticationProperties()
                {
                    IssuedUtc = utcNow,
                    ExpiresUtc = utcNow.AddHours(App.Instance.TokenValidHours)
                };
                var ticket = new AuthenticationTicket(principal, props,
                    principal.Identity.AuthenticationType);

                var resp = _iDomain.GenerateTokenResponse(ticket);

                if (model.fcm_token != null)
                {
                    var linkResult = await _iDomain.LinkFCMToken(user, model.fcm_token);
                    if (!linkResult.Succeeded)
                        throw new Exception("Can not link FCM token");
                }

                _logger.CustomProperties(user).Info("Login user");
                return Ok(resp);
            }
            catch (Exception e)
            {
                _logger.Error(e);

                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<IActionResult> Logout(LogoutViewModel model)
        {
            try
            {
                AppUsers user = await _iDomain.GetUserById(User.Identity.Name);

                var unlinkToken = _iDomain.UnlinkFCMToken(model.fcm_token);
                _uow.SaveChanges();

                _logger.CustomProperties(user).Info("Login user");
                return Ok(unlinkToken);
            }
            catch (Exception e)
            {
                _logger.Error(e);

                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }
        #endregion


        [HttpGet("")]
        [Authorize]
        public IActionResult Get([FromQuery]UserFilter filter,
            [FromQuery]string[] sorts,
            [FromQuery]string[] fields,
            [FromQuery]int page = 0,
            [FromQuery]int limit = 50,
            [FromQuery]bool count_total = false)
        {
            try
            {
                if (fields.Length == 0)
                    fields = new string[] { UserGeneralFields.INFO };
                else
                {
                    var maps = UserGeneralFields.Mapping;
                    if (fields.Any(f => f == null || !maps.ContainsKey(f)))
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Data = null,
                            Message = ResultCode.Unsupported.DisplayName() + ": fields"
                        });
                }

                var roleManager = _iDomain.GetRoleByName("Manager");
                var result = _iDomain.DataUsers.GetData(filter,
                    sorts,
                    fields, page, limit, count_total, User, roleManager.Id);
                return Ok(new ApiResult()
                {
                    Code = ResultCode.Success,
                    Data = result,
                    Message = ResultCode.Success.DisplayName()
                });
            }
            catch (Exception e)
            {
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpGet("token-info")]
        [Authorize]
        public IActionResult GetTokenInfo()
        {
            try
            {
                var resp = new TokenInfo(User.Identity.Name, User.Claims);
                return Ok(resp);
            }
            catch (Exception e)
            {
                _logger.Error(e);

                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpPost("")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var user = _iDomain.ToUser(model);
                    var result = await _iDomain.CreateUserWithRolesAsync(user, model.password);
                    if (result.Succeeded)
                    {
                        _logger.CustomProperties(user).Info("Register new user");
                        _eDomain.CreateUser(user, model, User);
                        _uow.SaveChanges();

                        return NoContent();
                    }
                    foreach (var err in result.Errors)
                        ModelState.AddModelError(err.Code, err.Description);
                }

                var message = "";
                if (ModelState.ContainsKey("password"))
                    message += "Invalid password\n";
                if (ModelState.ContainsKey("confirm_password"))
                    message += "The password and confirm password are not matched\n";
                if (ModelState.ContainsKey("username"))
                    message += "Invalid username\n";
                if (ModelState.ContainsKey("DuplicateUserName"))
                    message += "Username has already existed\n";
                if (string.IsNullOrWhiteSpace(model.employee_code))
                    message += "Can not leave blank Employee code\n";
                else if (model.employee_code.Length < 6)
                    message += "Employee code must have minimum length of 6\n";
                if (string.IsNullOrWhiteSpace(model.full_name))
                    message += "Can not leave blank Full name\n";
                if (ModelState.ContainsKey("phone"))
                    message += "Invalid phone number\n";
                if (ModelState.ContainsKey("email"))
                    message += "Invalid email address\n";
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = message
                });
            }
            catch (Exception e)
            {
                _logger.Error(e);

                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(string id)
        {
            try
            {
                var user = await _iDomain.GetUserById(id);
                if (user == null)
                    return NotFound(new ApiResult()
                    {
                        Code = ResultCode.NotFound,
                        Data = null,
                        Message = ResultCode.NotFound.DisplayName()
                    });
                var mess = "";
                var roles = await _iDomain.GetRoles(user);
                if (roles.Contains("Admin"))
                    mess += "Can not remove admin";
                if (!string.IsNullOrEmpty(mess))
                    return BadRequest(new ApiResult()
                    {
                        Code = ResultCode.FailValidation,
                        Message = mess,
                        Data = null
                    });

                var result = await _iDomain.Remove(user);
                if (result.Succeeded)
                {
                    var ev = _eDomain.DeleteUser(user, User);
                    _uow.SaveChanges();

                    var data = new Dictionary<string, string>();
                    data["title"] = "So sorry";
                    data["message"] = ev.Message;
                    _eDomain.Notify(new Message
                    {
                        Topic = user.Id,
                        Data = data
                    });

                    return NoContent();
                }
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
                });
            }
            catch (SqlException)
            {
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = null,
                    Message = "Can not delete because user has dependencies"
                });
            }
            catch (Exception e)
            {
                _logger.Error(e);

                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }


        #region ADMIN
        //[HttpPost("role")]
        //public async Task<IActionResult> AddRole(AddRolesToUserViewModel model)
        //{
        //    try
        //    {
        //        var user = await _iDomain.GetUserByUserName(model.username);
        //        if (user == null)
        //            return NotFound("User not found");
        //        var result = await _iDomain.AddUserToRoles(user, model.roles);
        //        if (result.Succeeded)
        //            return NoContent();
        //        foreach (var err in result.Errors)
        //            ModelState.AddModelError(err.Code, err.Description);
        //        return BadRequest(new ApiResult()
        //        {
        //            Code = ResultCode.FailValidation,
        //            Data = ModelState,
        //            Message = ResultCode.FailValidation.DisplayName()
        //        });
        //    }
        //    catch (Exception e)
        //    {
        //        _logger.Error(e);

        //        return Error(new ApiResult()
        //        {
        //            Code = ResultCode.UnknownError,
        //            Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
        //        });
        //    }
        //}

        //[HttpDelete("role")]
        //public async Task<IActionResult> RemoveRole(RemoveRolesFromUserViewModel model)
        //{
        //    try
        //    {
        //        var user = await _iDomain.GetUserByUserName(model.username);
        //        if (user == null)
        //            return NotFound("User not found");
        //        var result = await _iDomain.RemoveUserFromRoles(user, model.roles);
        //        if (result.Succeeded)
        //            return NoContent();
        //        foreach (var err in result.Errors)
        //            ModelState.AddModelError(err.Code, err.Description);
        //        return BadRequest(new ApiResult()
        //        {
        //            Code = ResultCode.FailValidation,
        //            Data = ModelState,
        //            Message = ResultCode.FailValidation.DisplayName()
        //        });
        //    }
        //    catch (Exception e)
        //    {
        //        _logger.Error(e);

        //        return Error(new ApiResult()
        //        {
        //            Code = ResultCode.UnknownError,
        //            Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
        //        });
        //    }
        //}
        #endregion
    }
}