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
    public class GroupDomain : BaseDomain
    {
        public GroupDomain(ServiceInjection inj) : base(inj)
        {
        }
        public IQueryable<Groups> Groups
        {
            get
            {
                return _uow.GetService<IGroupsRepository>().Get();
            }
        }
        public IQueryable<GroupUsers> GroupUsers
        {
            get
            {
                return _uow.GetService<IGroupUsersRepository>().Get();
            }
        }

        public Groups CreateGroup(CreateGroupViewModel model, ClaimsPrincipal principal)
        {
            var repo = _uow.GetService<IGroupsRepository>();
            return repo.Create(model, principal.Identity.Name);
        }

        public object GetGroupsData(GroupFilter filter,
            string[] sorts,
            string[] fields,
            int page,
            int limit, bool countTotal)
        {
            return Groups.GetData(filter, sorts, fields, page, limit, countTotal);
        }

        public Groups EditGroup(Groups entity, EditGroupViewModel model)
        {
            var repo = _uow.GetService<IGroupsRepository>();
            repo.Edit(entity, model);
            return entity;
        }

        public GroupUsers RemoveUserFromGroup(GroupUsers group)
        {
            var repo = _uow.GetService<IGroupUsersRepository>();
            return repo.Remove(group).Entity;
        }

        public GroupUsers AddUserToGroup(Groups group, AppUsers user)
        {
            var repo = _uow.GetService<IGroupUsersRepository>();
            var iDomain = _uow.GetService<IdentityDomain>();
            var roleUser = iDomain.GetRoleByName("User");
            return repo.Create(new GroupUsers
            {
                GroupId = group.Id,
                UserId = user.Id,
                RoleId = roleUser.Id
            }).Entity;
        }

        public GroupUsers ChangeUserRoleInGroup(GroupUsers groupUser)
        {
            var iDomain = _uow.GetService<IdentityDomain>();
            AppRoles role;
            if (groupUser.Role.Name.Equals("User"))
                role = iDomain.GetRoleByName("Manager");
            else
                role = iDomain.GetRoleByName("User");
            groupUser.RoleId = role.Id;
            return groupUser;
        }

        public Groups Delete(Groups entity)
        {
            var repo = _uow.GetService<IGroupsRepository>();
            return repo.Remove(entity).Entity;
        }
    }
}
