using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using TNT.Core.Helpers.Data;
using WorkManager.Data.ViewModels;

namespace WorkManager.Data.Models.Extensions
{
    public static partial class AspNetAspNetUsersExtension
    {
        #region READ
        public static IQueryable<AspNetUsers> Filter(
            this IQueryable<AspNetUsers> query, UserFilter filter, ClaimsPrincipal principal, string roleManagerId)
        {
            if (filter.ids != null)
                query = query.Where(p => filter.ids.Contains(p.Id));
            if (filter.name_contains != null)
                query = query.Where(p =>
                filter.name_contains.Any(s => p.FullName.Contains(s, StringComparison.OrdinalIgnoreCase)));
            if (filter.username != null)
                query = query.Where(p => p.UserName == filter.username);
            if (filter.employee_code != null)
                query = query.Where(p => p.EmployeeCode == filter.employee_code);
            if (!principal.IsInRole("Admin"))
                query = query.Where(p => p.Id == principal.Identity.Name || p.GroupUsers.Any(gu =>
                    gu.Group.GroupUsers.Any(
                        gus => gus.UserId == principal.Identity.Name
                            && gus.RoleId == roleManagerId)));
            return query;
        }

        public static IQueryable<AspNetUsers> QueryFields(this IQueryable<AspNetUsers> query, string[] generalFields)
        {
            var finalFields = new List<string>();
            foreach (var f in generalFields)
            {
                if (UserGeneralFields.Mapping.ContainsKey(f))
                    finalFields.AddRange(UserGeneralFields.Mapping[f]);
            }
            var fieldsArr = finalFields.ToArray();
            query = query.SelectOnly(SelectOption.ByPropertyName, fieldsArr);
            return query;
        }

        public static object SelectFields(this IQueryable<AspNetUsers> query, string[] generalFields, int? count)
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
                        case UserGeneralFields.INFO:
                            obj["id"] = p.Id;
                            obj["full_name"] = p.FullName;
                            obj["username"] = p.UserName;
                            obj["email"] = p.Email;
                            obj["phone_number"] = p.PhoneNumber;
                            obj["employee_code"] = p.EmployeeCode;
                            break;
                        case UserGeneralFields.ROLE:
                            obj["role"] = p.AspNetUserRoles.FirstOrDefault()?.Role.Name;
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

        public static IQueryable<AspNetUsers> Sort(this IQueryable<AspNetUsers> query,
            string[] sortings)
        {
            foreach (var s in sortings)
            {
                var asc = s[0] == 'a';
                var fieldName = s.Remove(0, 1);
                switch (fieldName)
                {
                    case UserSortFields.Username:
                        if (asc)
                            query = query.OrderBy(p => p.UserName);
                        else query = query.OrderByDescending(p => p.UserName);
                        break;
                }
            }
            return query;
        }

        public static IQueryable<AspNetUsers> SelectPage(
            this IQueryable<AspNetUsers> query, int page, int limit)
        {
            return query.Skip(page * limit).Take(limit);
        }

        public static object GetData(this IQueryable<AspNetUsers> query,
           UserFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal, ClaimsPrincipal principal, string roleMangerId)
        {
            query = query.Filter(filter, principal, roleMangerId);
            query = query.QueryFields(fields);
            query = query.Sort(sorts);
            int? count = null;
            if (countTotal)
                count = query.Count();
            query = query.SelectPage(page, limit);
            var result = query.SelectFields(fields, count);
            return result;
        }

        public static AppUsers FirstByEmpCode(this IQueryable<AppUsers> users, string empCode)
        {
            return users.FirstOrDefault(u => u.EmployeeCode == empCode);
        }
        public static AspNetUsers FirstByEmpCode(this IQueryable<AspNetUsers> users, string empCode)
        {
            return users.FirstOrDefault(u => u.EmployeeCode == empCode);
        }
        public static IQueryable<AppUsers> ByEmpCode(this IQueryable<AppUsers> users, string empCode)
        {
            return users.Where(u => u.EmployeeCode == empCode);
        }
        public static IQueryable<AspNetUsers> ByEmpCode(this IQueryable<AspNetUsers> users, string empCode)
        {
            return users.Where(u => u.EmployeeCode == empCode);
        }


        #endregion
    }

}
