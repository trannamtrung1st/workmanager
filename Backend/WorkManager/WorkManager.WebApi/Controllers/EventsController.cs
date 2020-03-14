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
using TNT.Core.Helpers.DI;
using FirebaseAdmin.Messaging;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/events")]
    [ApiController]
    [InjectionFilter]
    public class EventsController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [Inject]
        private EventDomain _eDomain;

        [HttpGet("")]
        //[Authorize]
        public IActionResult Get([FromQuery]EventFilter filter,
            [FromQuery]string[] sorts,
            [FromQuery]string[] fields,
            [FromQuery]int page = 0,
            [FromQuery]int limit = 50,
            [FromQuery]bool count_total = false)
        {
            try
            {
                var domain = Service<EventDomain>();

                if (fields.Length == 0)
                    fields = new string[] { EventGeneralFields.INFO };
                else
                {
                    var maps = EventGeneralFields.Mapping;
                    if (fields.Any(f => f == null || !maps.ContainsKey(f)))
                        return BadRequest(new ApiResult()
                        {
                            Code = ResultCode.Unsupported,
                            Data = null,
                            Message = ResultCode.Unsupported.DisplayName() + ": fields"
                        });
                }

                var result = domain.Events.GetData(filter,
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

    }
}