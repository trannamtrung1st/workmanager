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
using Newtonsoft.Json;
using TNT.Core.Helpers.DI;
using FirebaseAdmin.Messaging;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/tasks")]
    [ApiController]
    [InjectionFilter]
    public class TasksController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [Inject]
        private EventDomain _eDomain;

        [HttpGet("")]
        [Authorize]
        public IActionResult Get([FromQuery]TaskFilter filter,
            [FromQuery]string[] sorts,
            [FromQuery]string[] fields,
            [FromQuery]int page = 0,
            [FromQuery]int limit = 50,
            [FromQuery]bool count_total = false)
        {
            try
            {
                var domain = Service<TaskDomain>();

                if (fields.Length == 0)
                    fields = new string[] { TaskGeneralFields.INFO };
                else
                {
                    var maps = TaskGeneralFields.Mapping;
                    if (fields.Any(f => f == null || !maps.ContainsKey(f)))
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Data = null,
                            Message = ResultCode.Unsupported.DisplayName() + ": fields"
                        });
                }

                var iDomain = _uow.GetService<IdentityDomain>();
                var result = domain.Tasks.GetData(filter,
                    sorts,
                    fields, page, limit, count_total, User);
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
        [Authorize]
        public IActionResult Edit(int id,
            EditTaskViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var domain = Service<TaskDomain>();
                    var task = domain.Tasks.Id(id);
                    if (task == null)
                        return NotFound(new ApiResult()
                        {
                            Code = ResultCode.NotFound,
                            Message = ResultCode.NotFound.DisplayName()
                        });

                    domain.EditTask(task, model);
                    var ev = _eDomain.EditTask(task, User);
                    _uow.SaveChanges();

                    if (task.OfUser != task.CreatedUser)
                    {
                        var data = new Dictionary<string, string>();
                        data["title"] = "Your task has been edited";
                        data["message"] = ev.Message;
                        _eDomain.Notify(new Message
                        {
                            Topic = User.Identity.Name == task.OfUser ? task.CreatedUser : task.OfUser,
                            Data = data
                        });
                    }

                    _logger.CustomProperties(new { id, model }).Info("Edit task");

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

        [HttpPost("{id}/status")]
        [Authorize]
        public IActionResult ChangeStatus(int id,
            [FromForm] ChangeTaskStatusViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var domain = Service<TaskDomain>();
                    var task = domain.Tasks.Id(id);
                    if (task == null)
                        return NotFound(new ApiResult()
                        {
                            Code = ResultCode.NotFound,
                            Message = ResultCode.NotFound.DisplayName()
                        });

                    //validation
                    var mess = "";
                    var status = JsonConvert.DeserializeObject<IEnumerable<string>>(task.Status);
                    switch (model.status)
                    {
                        case "DOING":
                            if (!status.Contains("NEW") && !status.Contains(model.status))
                                mess += "Can not change to DOING\n";
                            break;
                        case "DONE":
                            if (!status.Contains("DOING") && !status.Contains(model.status))
                                mess += "Can not finish\n";
                            if (string.IsNullOrWhiteSpace(model.task_report))
                                mess += "Must have report";
                            break;
                        case "CANCEL":
                            if ((status.Contains("DONE") || status.Contains("FINISH CONFIRM"))
                                && !status.Contains(model.status))
                                mess += "Can not cancel\n";
                            if (string.IsNullOrWhiteSpace(model.task_report))
                                mess += "Must have report\n";
                            break;
                        case "ACCEPTED":
                            if (status.Contains("FINISH CONFIRMED") && !status.Contains(model.status))
                                mess += "Already finish\n";
                            if (status.Contains("CANCEL"))
                                mess += "Already cancel\n";
                            if (string.IsNullOrWhiteSpace(model.manager_review))
                                mess += "Must have a review\n";
                            break;
                        case "DECLINED":
                            if (status.Contains("FINISH CONFIRMED") && !status.Contains(model.status))
                                mess += "Already finish\n";
                            if (status.Contains("CANCEL"))
                                mess += "Already cancel\n";
                            if (string.IsNullOrWhiteSpace(model.manager_review))
                                mess += "Must have a review\n";
                            break;
                        case "FINISH CONFIRMED":
                            if (!status.Contains("DONE") && !status.Contains(model.status))
                                mess += "Haven't done yet\n";
                            if (string.IsNullOrWhiteSpace(model.manager_review))
                                mess += "Must have a review\n";
                            break;
                        default:
                            mess += "Unsupported status\n";
                            break;
                    }
                    if (!string.IsNullOrEmpty(mess))
                        return BadRequest(new ApiResult
                        {
                            Code = ResultCode.FailValidation,
                            Message = mess
                        });
                    //end validation

                    domain.ChangeStatus(task, model);
                    var ev = _eDomain.ChangeTaskStatus(task, model, User);
                    _uow.SaveChanges();

                    if (task.OfUser != task.CreatedUser)
                    {
                        var data = new Dictionary<string, string>();
                        data["title"] = "Your task status has been changed";
                        data["message"] = ev.Message;
                        _eDomain.Notify(new Message
                        {
                            Topic = User.Identity.Name == task.OfUser ? task.CreatedUser : task.OfUser,
                            Data = data
                        });
                    }

                    _logger.CustomProperties(new { id, model }).Info("Change status");

                    return NoContent();
                }

                var message = "";
                message += string.Join('\n',
                    ModelState["status"].Errors.Select(e => e.ErrorMessage).ToList());
                message += string.Join('\n',
                    ModelState["mark"].Errors.Select(e => e.ErrorMessage).ToList());
                message += string.Join('\n',
                    ModelState["id"].Errors.Select(e => e.ErrorMessage).ToList());
                message += string.Join('\n',
                    ModelState["manager_review"].Errors.Select(e => e.ErrorMessage).ToList());

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
        [Authorize]
        public IActionResult Create(CreateTaskViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var iDomain = Service<IdentityDomain>();
                    var ofUser = iDomain.GetUserByEmpCode(model.EmployeeCode);
                    if (ofUser == null)
                        return NotFound(new ApiResult
                        {
                            Code = ResultCode.NotFound,
                            Message = "Not found assigned user"
                        });
                    var createUser = iDomain.DataUsers.Id(User.Identity.Name);
                    if (!User.IsInRole("Admin") && ofUser.Id != createUser.Id &&
                        !createUser.GroupUsers.Where(g => g.Role.Name == "Manager")
                            .Any(g => g.Group.GroupUsers.Any(gu => gu.UserId == ofUser.Id && gu.Role.Name != "Manager")))
                        return NotFound(new ApiResult
                        {
                            Code = ResultCode.Unauthorized,
                            Message = "You don't have the right to assign task to this user"
                        });
                    if (ofUser.Id != User.Identity.Name && model.GroupId == null)
                        return BadRequest(new ApiResult
                        {
                            Code = ResultCode.Unauthorized,
                            Message = "Can not assign personal task to other user"
                        });
                    var domain = Service<TaskDomain>();
                    Tasks entity;
                    Events ev;
                    using (var trans = _uow.BeginTransaction())
                    {
                        entity = domain.CreateTask(model, ofUser, User);
                        _uow.SaveChanges();
                        ev = _eDomain.CreateTask(entity, ofUser, User);
                        _uow.SaveChanges();
                        trans.Commit();
                    }
                    if (entity.OfUser != entity.CreatedUser)
                    {
                        var data = new Dictionary<string, string>();
                        data["title"] = "You have a new task";
                        data["message"] = ev.Message;
                        _eDomain.Notify(new Message
                        {
                            Topic = entity.OfUser,
                            Data = data
                        });
                    }

                    _logger.CustomProperties(new { model }).Info("Create task");

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
        [Authorize]
        public IActionResult Delete(int id)
        {
            try
            {
                var domain = Service<TaskDomain>();
                var task = domain.Tasks.Id(id);
                if (task == null)
                    return NotFound(new ApiResult()
                    {
                        Code = ResultCode.NotFound,
                        Message = ResultCode.NotFound.DisplayName()
                    });

                domain.Delete(task);
                var ev = _eDomain.DeleteTask(task, User);
                _uow.SaveChanges();

                if (task.OfUser != task.CreatedUser)
                {
                    var data = new Dictionary<string, string>();
                    data["title"] = "Your task has been deleted";
                    data["message"] = ev.Message;
                    _eDomain.Notify(new Message
                    {
                        Topic = task.OfUser,
                        Data = data
                    });
                }

                _logger.CustomProperties(new { id }).Info("Delete task");

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
                        Message = "Can not delete because task has dependencies"
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