using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;
using WorkManager.Data.ViewModels;

namespace WorkManager.Data.Models.Repositories
{
    public partial interface ITasksRepository
    {
        #region CREATE
        Tasks Convert(CreateTaskViewModel model);
        Tasks PrepareCreate(Tasks model);
        Tasks Create(CreateTaskViewModel model, AppUsers ofUser, string createdUserId);
        #endregion

        #region UPDATE
        Tasks Edit(Tasks entity, EditTaskViewModel editModel);
        #endregion

        #region DELETE
        Tasks Delete(Tasks entity);
        #endregion
    }
    public partial class TasksRepository
    {
        #region CREATE
        public Tasks Convert(CreateTaskViewModel model)
        {
            return model.ToEntity();
        }
        public Tasks PrepareCreate(Tasks model)
        {
            model.CreatedTime = DateTime.UtcNow;
            model.Deadline = model.Deadline?.ToUniversalTime();
            return model;
        }
        public Tasks Create(CreateTaskViewModel model, AppUsers ofUser, string createdUserId)
        {
            var entity = Convert(model);
            entity = PrepareCreate(entity);

            entity.CreatedUser = createdUserId;
            entity.OfUser = ofUser.Id;
            var status = new List<string> { "NEW" };
            if (ofUser.Id != createdUserId)
                status.Add("ACCEPTED");
            entity.Status = JsonConvert.SerializeObject(status);

            entity = Create(entity).Entity;
            return entity;
        }
        #endregion

        #region UPDATE
        public Tasks Edit(Tasks entity, EditTaskViewModel editModel)
        {
            entity.Name = editModel.Name;
            entity.TaskContent = editModel.TaskContent;
            entity.Deadline = editModel.Deadline?.ToUniversalTime();
            return entity;
        }
        #endregion

        #region DELETE
        public Tasks Delete(Tasks entity)
        {
            return Remove(entity).Entity;
        }
        #endregion
    }
}
