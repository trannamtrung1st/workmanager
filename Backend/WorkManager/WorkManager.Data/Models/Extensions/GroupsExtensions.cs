using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TNT.Core.Helpers.Data;
using System.Security.Claims;

namespace WorkManager.Data.Models.Extensions
{
    public static partial class GroupsExtension
    {
        #region READ
        public static IQueryable<Groups> Filter(
            this IQueryable<Groups> query, GroupFilter filter, ClaimsPrincipal principal, string roleManagerId)
        {
            if (filter.ids != null)
                query = query.Where(p => filter.ids.Contains(p.Id));
            if (filter.name_contains != null)
                query = query.Where(p => filter.name_contains.Any(s => p.Name.Contains(s, StringComparison.OrdinalIgnoreCase)));
            if (!principal.IsInRole("Admin"))
                query = query.Where(p => p.GroupUsers.Any(u =>
                    u.UserId == principal.Identity.Name && u.RoleId == roleManagerId));
            return query;
        }

        public static IQueryable<Groups> QueryFields(this IQueryable<Groups> query, string[] generalFields)
        {
            var finalFields = new List<string>();
            foreach (var f in generalFields)
            {
                if (GroupGeneralFields.Mapping.ContainsKey(f))
                    finalFields.AddRange(GroupGeneralFields.Mapping[f]);
            }
            var fieldsArr = finalFields.ToArray();
            query = query.SelectOnly(SelectOption.ByPropertyName, fieldsArr);
            return query;
        }

        public static object SelectFields(this IQueryable<Groups> query, string[] generalFields, int? count)
        {
            var list = new List<IDictionary<string, object>>();
            var model = query.ToList();
            foreach (var p in model)
            {
                var obj = new Dictionary<string, object>();
                foreach (var f in generalFields)
                {
                    switch (f)
                    {
                        case GroupGeneralFields.INFO:
                            obj["id"] = p.Id;
                            obj["name"] = p.Name;
                            obj["description"] = p.Description;
                            obj["created_time"] = p.CreatedTime;
                            obj["created_user_id"] = p.CreatedUser;
                            break;
                        case GroupGeneralFields.CREATED_USER:
                            obj["created_user"] = new
                            {
                                id = p.CreatedUserNavigation.Id,
                                username = p.CreatedUserNavigation.UserName,
                                full_name = p.CreatedUserNavigation.FullName
                            };
                            break;
                        case GroupGeneralFields.GROUP_USERS:
                            obj["group_users"] = p.GroupUsers.Select(u => new
                            {
                                id = u.Id,
                                user = new
                                {
                                    id = u.UserId,
                                    full_name = u.User.FullName,
                                    username = u.User.UserName
                                },
                                role = u.Role.Name
                            }).ToList();
                            break;
                    }
                }
                list.Add(obj);
            }

            var resp = new Dictionary<string, object>();
            resp["results"] = list;
            if (count != null)
                resp["total_count"] = count;
            return resp;
        }

        public static IQueryable<Groups> Sort(this IQueryable<Groups> query,
            string[] sortings)
        {
            foreach (var s in sortings)
            {
                var asc = s[0] == 'a';
                var fieldName = s.Remove(0, 1);
                switch (fieldName)
                {
                    case GroupSortFields.Name:
                        if (asc)
                            query = query.OrderBy(p => p.Name);
                        else query = query.OrderByDescending(p => p.Name);
                        break;
                }
            }
            return query;
        }

        public static IQueryable<Groups> SelectPage(
            this IQueryable<Groups> query, int page, int limit)
        {
            return query.Skip(page * limit).Take(limit);
        }

        public static object GetData(this IQueryable<Groups> query,
           GroupFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal, ClaimsPrincipal principal, string roleManagerId)
        {
            query = query.Filter(filter, principal, roleManagerId);
            query = query.QueryFields(fields);
            query = query.Sort(sorts);
            int? count = null;
            if (countTotal)
                count = query.Count();
            query = query.SelectPage(page, limit);
            var result = query.SelectFields(fields, count);
            return result;
        }
        #endregion
    }
}