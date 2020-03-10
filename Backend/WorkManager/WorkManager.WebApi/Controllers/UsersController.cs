﻿using System;
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
        #endregion

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

                        return NoContent();
                    }
                    foreach (var err in result.Errors)
                        ModelState.AddModelError(err.Code, err.Description);
                }

                var message = "";
                if (ModelState.ContainsKey("Password"))
                    message += "Invalid password\n";
                if (ModelState.ContainsKey("ConfirmPassword"))
                    message += "The password and confirm password are not matched\n";
                if (ModelState.ContainsKey("Username"))
                    message += "Invalid username\n";
                if (ModelState.ContainsKey("DuplicateUserName"))
                    message += "Username has already existed";

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

        #region ADMIN
        [HttpPost("role")]
        public async Task<IActionResult> AddRole(AddRolesToUserViewModel model)
        {
            try
            {
                var user = await _iDomain.GetUserByUserName(model.username);
                if (user == null)
                    return NotFound("User not found");
                var result = await _iDomain.AddUserToRoles(user, model.roles);
                if (result.Succeeded)
                    return NoContent();
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
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

        [HttpDelete("role")]
        public async Task<IActionResult> RemoveRole(RemoveRolesFromUserViewModel model)
        {
            try
            {
                var user = await _iDomain.GetUserByUserName(model.username);
                if (user == null)
                    return NotFound("User not found");
                var result = await _iDomain.RemoveUserFromRoles(user, model.roles);
                if (result.Succeeded)
                    return NoContent();
                foreach (var err in result.Errors)
                    ModelState.AddModelError(err.Code, err.Description);
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = ModelState,
                    Message = ResultCode.FailValidation.DisplayName()
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
        #endregion
    }
}