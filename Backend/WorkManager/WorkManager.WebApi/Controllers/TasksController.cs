﻿using System;
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

namespace WorkManager.WebApi.Controllers
{
    [Route("api/tasks")]
    [ApiController]
    [InjectionFilter]
    public class TasksController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

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

                var result = domain.GetTasksData(filter,
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
                    _uow.SaveChanges();
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
                    _uow.SaveChanges();
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
                    var domain = Service<TaskDomain>();
                    var entity = domain.CreateTask(model, ofUser, User);
                    _uow.SaveChanges();
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
                _uow.SaveChanges();
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