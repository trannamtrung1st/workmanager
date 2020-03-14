using FirebaseAdmin.Messaging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
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

        public void SubscribeToTopic(AspNetUsers user, string topic)
        {
            var iDomain = _uow.GetService<IdentityDomain>();
            var tokens = iDomain.GetTokensNameStartsWith(user, "Firebase", "FCMToken");
            FirebaseMessaging.DefaultInstance.SubscribeToTopicAsync(tokens, topic);
        }
        public void SubscribeToTopic(AppUsers user, string topic)
        {
            var iDomain = _uow.GetService<IdentityDomain>();
            var tokens = iDomain.GetTokensNameStartsWith(user, "Firebase", "FCMToken");
            FirebaseMessaging.DefaultInstance.SubscribeToTopicAsync(tokens, topic);
        }
        public void UnsubscribeFromTopic(AspNetUsers user, string topic)
        {
            var iDomain = _uow.GetService<IdentityDomain>();
            var tokens = iDomain.GetTokensNameStartsWith(user, "Firebase", "FCMToken");
            FirebaseMessaging.DefaultInstance.UnsubscribeFromTopicAsync(tokens, topic);
        }

        public void UnsubscribeFromTopic(List<string> tokens, string topic)
        {
            FirebaseMessaging.DefaultInstance.UnsubscribeFromTopicAsync(tokens, topic);
        }

        public void UnsubscribeFromTopic(AppUsers user, string topic)
        {
            var iDomain = _uow.GetService<IdentityDomain>();
            var tokens = iDomain.GetTokensNameStartsWith(user, "Firebase", "FCMToken");
            FirebaseMessaging.DefaultInstance.UnsubscribeFromTopicAsync(tokens, topic);
        }

        public void Notify(Message mess)
        {
            FirebaseMessaging.DefaultInstance.SendAsync(mess);
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

        public Events EditGroup(Groups group, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "EDIT_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = group.Id
                }),
                Message = $"Admin edited group \"{group.Name}\"",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events ChangeUserRoleInGroup(GroupUsers groupUsers, string roleName, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CHANGE_USER_ROLE_IN_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = groupUsers.GroupId,
                    user_id = groupUsers.UserId,
                    role_name = roleName
                }),
                Message = $"Admin change role of {groupUsers.User.UserName}" +
                $" in group \"{groupUsers.Group.Name}\" to {roleName}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events DeleteGroup(Groups group, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "DELETE_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = group.Id,
                }),
                Message = $"Admin deleted {group.Name}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events DeleteTask(Tasks task, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "DELETE_TASK",
                Data = JsonConvert.SerializeObject(new
                {
                    task_id = task.Id,
                }),
                Message = $"{task.Name} has been deleted " +
                $"by {principal.FindFirstValue(AppClaimTypes.Username)}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events CreateTask(Tasks task, AppUsers toUser, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CREATE_TASK",
                Data = JsonConvert.SerializeObject(new
                {
                    task_id = task.Id,
                    user_id = task.OfUser
                }),
                Message = $"{task.Name} has been assigned to {toUser.UserName} " +
                $"by {principal.FindFirstValue(AppClaimTypes.Username)}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events ChangeTaskStatus(Tasks task, ChangeTaskStatusViewModel model,
            ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CHANGE_TASK_STATUS",
                Data = JsonConvert.SerializeObject(new
                {
                    task_id = task.Id,
                    status = model.status
                }),
                Message = $"{task.Name} status has been changed to {model.status} " +
                $"by {principal.FindFirstValue(AppClaimTypes.Username)}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }


        public Events EditTask(Tasks task, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "EDIT_TASK",
                Data = JsonConvert.SerializeObject(new
                {
                    task_id = task.Id,
                }),
                Message = $"{task.Name} has been edited by {principal.FindFirstValue(AppClaimTypes.Username)}",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events AddUserToGroup(Groups group, AppUsers user, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "ADD_USER_TO_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = group.Id,
                    user_id = user.Id,
                }),
                Message = $"Admin add {user.UserName} to group \"{group.Name}\"",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events RemoveUserFromGroup(GroupUsers groupUser, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "REMOVE_USER_FROM_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = groupUser.GroupId,
                    user_id = groupUser.UserId,
                }),
                Message = $"Admin remove {groupUser.User.UserName} from group \"{groupUser.Group.Name}\"",
                Time = DateTime.UtcNow,
                UserId = principal.Identity.Name
            }).Entity;
        }

        public Events CreateGroup(Groups group, ClaimsPrincipal principal)
        {
            return _repo.Create(new Events
            {
                Action = "CREATE_GROUP",
                Data = JsonConvert.SerializeObject(new
                {
                    group_id = group.Id
                }),
                Message = $"Admin created group \"{group.Name}\"",
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
