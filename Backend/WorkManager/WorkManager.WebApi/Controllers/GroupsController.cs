using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WorkManager.Data;
using WorkManager.Data.Models;
using WorkManager.Data.Domains;
using WorkManager.Data.ViewModels;
using TNT.Core.Http.DI;
using WorkManager.Data.Models.Extensions;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Authorization;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/groups")]
    [ApiController]
    [InjectionFilter]
    public class GroupsController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [HttpGet("")]
        [Authorize(Roles = "Admin,Manager")]
        public IActionResult Get([FromQuery]GroupFilter filter,
            [FromQuery]string[] sorts,
            [FromQuery]string[] fields,
            [FromQuery]int page = 0,
            [FromQuery]int limit = 50,
            [FromQuery]bool count_total = false)
        {
            try
            {
                var domain = Service<GroupDomain>();

                if (fields.Length == 0)
                    fields = new string[] { GroupGeneralFields.INFO };
                else
                {
                    var maps = GroupGeneralFields.Mapping;
                    if (fields.Any(f => f == null || !maps.ContainsKey(f)))
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Data = null,
                            Message = ResultCode.Unsupported.DisplayName() + ": fields"
                        });
                }

                var result = domain.GetGroupsData(filter,
                    sorts,
                    fields, page, limit, count_total);
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

        [HttpPatch("{id}")]
        [Authorize(Roles = "Admin")]
        public IActionResult Edit(int id,
            EditGroupViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var domain = Service<GroupDomain>();
                    var group = domain.Groups.Id(id);
                    if (group == null)
                        return NotFound(new ApiResult()
                        {
                            Code = ResultCode.NotFound,
                            Message = ResultCode.NotFound.DisplayName()
                        });

                    domain.EditGroup(group, model);
                    _uow.SaveChanges();
                    _logger.CustomProperties(new { id, model }).Info("Edit group");

                    return NoContent();
                }

                var message = "";
                if (ModelState.ContainsKey("name"))
                    message += string.Join('\n',
                        ModelState["name"].Errors.Select(e => e.ErrorMessage).ToList());

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

        [HttpPost("")]
        [Authorize(Roles = "Admin")]
        public IActionResult Create(CreateGroupViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var domain = Service<GroupDomain>();
                    var entity = domain.CreateGroup(model, User);
                    _uow.SaveChanges();
                    _logger.CustomProperties(new { model }).Info("Create group");

                    return Ok(entity.Id);
                }

                var message = "";
                if (ModelState.ContainsKey("name"))
                    message += string.Join('\n',
                        ModelState["name"].Errors.Select(e => e.ErrorMessage).ToList());

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

        [HttpPost("user")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> AddUserToGroup(AddUserToGroupViewModel model)
        {
            try
            {
                var iDomain = Service<IdentityDomain>();
                var domain = Service<GroupDomain>();
                var addedUser = await iDomain.GetUserById(model.user_id);
                var group = domain.Groups.Id(model.group_id);
                if (addedUser == null || group == null)
                    return NotFound(new ApiResult
                    {
                        Code = ResultCode.NotFound,
                        Data = null,
                        Message = ResultCode.NotFound.DisplayName()
                    });
                var mess = "";
                if (group.GroupUsers.Any(u => u.UserId == addedUser.Id))
                    mess += "User already in group\n";
                var roles = await iDomain.GetRoles(addedUser);
                if (roles.Contains("Admin"))
                    mess += "Can not add admin to a group\n";
                if (!string.IsNullOrEmpty(mess))
                    return BadRequest(new ApiResult
                    {
                        Code = ResultCode.FailValidation,
                        Message = mess,
                        Data = null
                    });

                var entity = domain.AddUserToGroup(group, addedUser);
                _uow.SaveChanges();
                _logger.CustomProperties(new { model }).Info("Add user to group");

                return Ok(entity.Id);
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

        [HttpDelete("user")]
        [Authorize(Roles = "Admin")]
        public IActionResult RemoveUserFromGroup(RemoveUserFromGroupViewModel model)
        {
            try
            {
                var domain = Service<GroupDomain>();
                var groupUser = domain.GroupUsers.Id(model.id);
                if (groupUser == null)
                    return NotFound(new ApiResult
                    {
                        Code = ResultCode.NotFound,
                        Data = null,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                var entity = domain.RemoveUserFromGroup(groupUser);
                _uow.SaveChanges();
                _logger.CustomProperties(new { model }).Info("Remove user from group");

                return Ok(entity.Id);
            }
            catch (SqlException)
            {
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = null,
                    Message = "Can not delete because group has dependencies"
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

        [HttpPatch("user")]
        [Authorize(Roles = "Admin")]
        public IActionResult ChangeUserRoleInGroup(ChangeUserRoleInGroupViewModel model)
        {
            try
            {
                var domain = Service<GroupDomain>();
                var groupUser = domain.GroupUsers.Id(model.id);
                if (groupUser == null)
                    return NotFound(new ApiResult
                    {
                        Code = ResultCode.NotFound,
                        Data = null,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                var entity = domain.ChangeUserRoleInGroup(groupUser);
                _uow.SaveChanges();
                _logger.CustomProperties(new { model }).Info("Change user role in group");

                return Ok(entity.Id);
            }
            catch (SqlException)
            {
                return BadRequest(new ApiResult()
                {
                    Code = ResultCode.FailValidation,
                    Data = null,
                    Message = "Can not delete because group has dependencies"
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
        public IActionResult Delete(int id)
        {
            try
            {
                var domain = Service<GroupDomain>();
                var group = domain.Groups.Id(id);
                if (group == null)
                    return NotFound(new ApiResult()
                    {
                        Code = ResultCode.NotFound,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                domain.Delete(group);
                _uow.SaveChanges();
                _logger.CustomProperties(new { id }).Info("Delete group");

                return NoContent();
            }
            catch (Exception e)
            {
                if (e.InnerException != null
                    && e.InnerException.GetType() == typeof(SqlException))
                    return BadRequest(new ApiResult()
                    {
                        Code = ResultCode.FailValidation,
                        Data = null,
                        Message = "Can not delete because group has dependencies"
                    });
                _logger.Error(e);
                return Error(new ApiResult()
                {
                    Code = ResultCode.UnknownError,
                    Message = ResultCode.UnknownError.DisplayName() + ": " + e.Message
                });
            }
        }

    }
}