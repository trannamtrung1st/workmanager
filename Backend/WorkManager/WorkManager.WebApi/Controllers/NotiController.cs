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
using FirebaseAdmin;
using FirebaseAdmin.Messaging;

namespace WorkManager.WebApi.Controllers
{
    [Route("api/noti")]
    [ApiController]
    [InjectionFilter]
    public class NotiController : BaseController
    {
        private static NLog.Logger _logger = NLog.LogManager.GetCurrentClassLogger();

        [HttpPost("")]
        public async Task<IActionResult> Notify(Message mess)
        {
            try
            {
                var result = await FirebaseMessaging.DefaultInstance.SendAsync(mess);
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

    }
}