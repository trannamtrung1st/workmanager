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

        public Events DeleteUser(AppUsers user, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "DELETE_USER",
                Data = JsonConvert.SerializeObject(new
                {
                    user_id = user.Id,
                }),
                Message = $"Admin deleted user \"{user.UserName}\"",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events CreateUser(AppUsers user, RegisterViewModel model, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CREATE_USER",
                Data = JsonConvert.SerializeObject(new
                {
                    user_id = user.Id
                }),
                Message = $"Admin created user \"{model.username}\"",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

    }
}
