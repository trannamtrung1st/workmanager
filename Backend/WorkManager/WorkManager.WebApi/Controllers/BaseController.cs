using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using WorkManager.Data.Models;
using TNT.Core.Helpers.DI;

namespace WorkManager.WebApi.Controllers
{
    public abstract class BaseController : ControllerBase
    {
        [Inject]
        protected readonly IUnitOfWork _uow;

        public string UserId
        {
            get
            {
                return User.Identity.Name;
            }
        }

        protected T Service<T>()
        {
            return HttpContext.RequestServices.GetService<T>();
        }

        protected IActionResult Error<T>(T obj)
        {
            return StatusCode((int)HttpStatusCode.InternalServerError, obj);
        }

    }
}