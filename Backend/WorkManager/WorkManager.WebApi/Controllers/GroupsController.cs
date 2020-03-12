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
                return Ok(result);
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

    }
}