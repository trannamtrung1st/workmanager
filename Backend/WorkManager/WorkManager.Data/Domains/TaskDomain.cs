using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using TNT.Core.Helpers.DI;
using WorkManager.Data.Models;
using WorkManager.Data.Models.Extensions;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.ViewModels;

namespace WorkManager.Data.Domains
{
    public class TaskDomain : BaseDomain
    {
        public TaskDomain(ServiceInjection inj) : base(inj)
        {
        }
        public IQueryable<Tasks> Tasks
        {
            get
            {
                return _uow.GetService<ITasksRepository>().Get();
            }
        }

        public Tasks CreateTask(CreateTaskViewModel model, AppUsers ofUser, ClaimsPrincipal principal)
        {
            var repo = _uow.GetService<ITasksRepository>();
            return repo.Create(model, ofUser, principal.Identity.Name);
        }

        public object GetTasksData(TaskFilter filter,
            string[] sorts,
            string[] fields,
            int page,
            int limit, bool countTotal)
        {
            return Tasks.GetData(filter, sorts, fields, page, limit, countTotal);
        }

        public Tasks EditTask(Tasks entity, EditTaskViewModel model)
        {
            var repo = _uow.GetService<ITasksRepository>();
            repo.Edit(entity, model);
            return entity;
        }
        public Tasks Delete(Tasks entity)
        {
            var repo = _uow.GetService<ITasksRepository>();
            return repo.Remove(entity).Entity;
        }
    }
}
