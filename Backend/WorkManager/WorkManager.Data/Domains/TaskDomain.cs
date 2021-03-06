﻿using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
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

        public Tasks EditTask(Tasks entity, EditTaskViewModel model)
        {
            var repo = _uow.GetService<ITasksRepository>();
            repo.Edit(entity, model);
            return entity;
        }

        public Tasks ChangeStatus(Tasks entity, ChangeTaskStatusViewModel model)
        {
            var currentStatus = JsonConvert.DeserializeObject<List<string>>(entity.Status);
            currentStatus.Remove(model.status);
            switch (model.status)
            {
                case "DOING":
                    currentStatus.Remove("NEW");
                    currentStatus.Add(model.status);

                    entity.StartTime = DateTime.UtcNow;
                    break;
                case "DONE":
                    currentStatus.Remove("DOING");
                    currentStatus.Remove("DUE SOON");
                    currentStatus.Add(model.status);

                    entity.EndTime = DateTime.UtcNow;
                    entity.TaskReport = model.task_report;
                    if (model.confirm_image != null)
                        entity.ConfirmImage = UploadConfirmImage(entity, model.confirm_image);
                    break;
                case "CANCEL":
                    currentStatus.Remove("DOING");
                    currentStatus.Remove("NEW");
                    currentStatus.Add(model.status);

                    entity.TaskReport = model.task_report;
                    break;
                case "DECLINED":
                    currentStatus.Remove("ACCEPTED");
                    currentStatus.Add(model.status);

                    entity.Mark = model.mark;
                    entity.ReviewTime = DateTime.UtcNow;
                    entity.ManagerReview = model.manager_review;
                    break;
                case "ACCEPTED":
                    currentStatus.Remove("DECLINED");
                    currentStatus.Add(model.status);

                    entity.ManagerReview = model.manager_review;
                    entity.Mark = model.mark;
                    break;
                case "FINISH CONFIRMED":
                    currentStatus.Remove("DUE SOON");
                    currentStatus.Remove("ACCEPTED");
                    currentStatus.Remove("DECLINED");
                    currentStatus.Add(model.status);

                    entity.Mark = model.mark;
                    entity.Status = model.status;
                    entity.ManagerReview = model.manager_review;
                    entity.ReviewTime = DateTime.UtcNow;
                    break;
                default: throw new Exception("Unsupported status");
            }
            entity.Status = JsonConvert.SerializeObject(currentStatus);
            return entity;
        }

        public string UploadConfirmImage(Tasks task, IFormFile file)
        {
            var relFolderPath = $"/uploads/tasks/{task.Id}";
            Directory.CreateDirectory($"{App.Instance.AppWebRoot}{relFolderPath}");
            var relPath = 
                $"{relFolderPath}/{task.OfUserNavigation.UserName}-{task.Id}-" +
                $"{task.EndTime?.ToString("ddMMyyyyhhmm")}.png";
            using (var stream = new FileStream(
                $"{App.Instance.AppWebRoot}{relPath}", FileMode.Create))
            {
                file.CopyTo(stream);
            }
            return relPath;
        }

        public Tasks Delete(Tasks entity)
        {
            var repo = _uow.GetService<ITasksRepository>();
            return repo.Remove(entity).Entity;
        }
    }
}
