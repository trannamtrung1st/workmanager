using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using TNT.Core.Helpers.DI;
using WorkManager.Data.Models;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.ViewModels;

namespace WorkManager.Data.Domains
{
    public class EventDomain : BaseDomain
    {
        public EventDomain(ServiceInjection inj) : base(inj)
        {
        }

        [Inject]
        protected IEventsRepository _repo;

        public IQueryable<Events> Events
        {
            get
            {
                return _uow.GetService<IEventsRepository>().Get();
            }
        }

        public Events CreateUser(RegisterViewModel model, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CREATE_USER",
                Data = JsonConvert.SerializeObject(new { model.username, model.role }),
                Message = $"Admin created {model.username} with role {model.role}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

    }
}
