using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TNT.Core.Helpers.Data;
using Newtonsoft.Json;
using System.Security.Claims;

namespace WorkManager.Data.Models.Extensions
{
    public static partial class TasksExtension
    {
        #region READ
        public static IQueryable<Tasks> Filter(
            this IQueryable<Tasks> query, TaskFilter filter, ClaimsPrincipal principal)
        {
            if (filter.ids != null)
                query = query.Where(p => filter.ids.Contains(p.Id));
            if (filter.employee_code != null)
                query = query.Where(p => p.OfUserNavigation.EmployeeCode == filter.employee_code);
            if (filter.from_date != null)
            {
                var fromDate = filter.from_date?.ToUniversalTime().ToStartOfDay();
                query = query.Where(p => p.CreatedTime >= fromDate);
            }
            if (filter.to_date != null)
            {
                var toDate = filter.to_date?.ToUniversalTime().ToEndOfDay();
                query = query.Where(p => p.CreatedTime <= toDate);
            }
            if (filter.status != null)
                query = query.InStatus(filter.status);

            if (!principal.IsInRole("Admin"))
                query = query.Where(p => p.OfUser == principal.Identity.Name ||
                    p.CreatedUser == principal.Identity.Name);

            return query;
        }

        public static IQueryable<Tasks> QueryFields(this IQueryable<Tasks> query, string[] generalFields)
        {
            var finalFields = new List<string>();
            foreach (var f in generalFields)
            {
                if (TaskGeneralFields.Mapping.ContainsKey(f))
                    finalFields.AddRange(TaskGeneralFields.Mapping[f]);
            }
            var fieldsArr = finalFields.ToArray();
            query = query.SelectOnly(SelectOption.ByPropertyName, fieldsArr);
            return query;
        }

        public static object SelectFields(this IQueryable<Tasks> query, string[] generalFields, int? count)
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
                        case TaskGeneralFields.INFO:
                            obj["id"] = p.Id;
                            obj["name"] = p.Name;
                            obj["task_content"] = p.TaskContent;
                            obj["status"] = JsonConvert.DeserializeObject<IEnumerable<string>>(p.Status);
                            obj["deadline"] = p.Deadline;
                            break;
                        case TaskGeneralFields.DETAIL:
                            obj["start_time"] = p.StartTime;
                            obj["end_time"] = p.EndTime;
                            obj["created_time"] = p.CreatedTime;
                            obj["review_time"] = p.ReviewTime;
                            obj["source_id"] = p.SourceId;
                            obj["of_user_id"] = p.OfUser;
                            obj["created_user_id"] = p.CreatedUser;
                            break;
                        case TaskGeneralFields.OF_USER:
                            obj["of_user"] = new
                            {
                                id = p.OfUserNavigation.Id,
                                full_name = p.OfUserNavigation.FullName,
                                username = p.OfUserNavigation.UserName
                            };
                            break;
                        case TaskGeneralFields.SOURCE:
                            if (p.SourceId != null)
                                obj["source"] = new
                                {
                                    id = p.Source?.Id,
                                    name = p.Source?.Name,
                                };
                            break;
                        case TaskGeneralFields.CREATED_USER:
                            obj["created_user"] = new
                            {
                                id = p.CreatedUserNavigation.Id,
                                full_name = p.CreatedUserNavigation.FullName,
                                username = p.CreatedUserNavigation.UserName
                            };
                            break;
                        case TaskGeneralFields.REPORT:
                            obj["confirm_image"] = p.ConfirmImage;
                            obj["task_report"] = p.TaskReport;
                            break;
                        case TaskGeneralFields.REVIEW:
                            obj["manager_review"] = p.ManagerReview;
                            obj["mark"] = p.Mark;
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

        public static IQueryable<Tasks> Sort(this IQueryable<Tasks> query,
            string[] sortings)
        {
            foreach (var s in sortings)
            {
                var asc = s[0] == 'a';
                var fieldName = s.Remove(0, 1);
                switch (fieldName)
                {
                    case TaskSortFields.Name:
                        if (asc)
                            query = query.OrderBy(p => p.Name);
                        else query = query.OrderByDescending(p => p.Name);
                        break;
                }
            }
            return query;
        }

        public static IQueryable<Tasks> SelectPage(
            this IQueryable<Tasks> query, int page, int limit)
        {
            return query.Skip(page * limit).Take(limit);
        }

        public static IQueryable<Tasks> DueSoon(this IQueryable<Tasks> query)
        {
            var now = DateTime.UtcNow;
            return query.Where(q => (q.Deadline - now).Value.TotalHours <= 24);
        }
        public static IQueryable<Tasks> Late(this IQueryable<Tasks> query)
        {
            var now = DateTime.UtcNow;
            return query.Where(q => q.Deadline <= now);
        }
        public static IQueryable<Tasks> NotInStatus(this IQueryable<Tasks> query, string status)
        {
            return query.Where(q => !q.Status.Contains("\"" + status + "\""));
        }
        public static IQueryable<Tasks> InStatus(this IQueryable<Tasks> query, string status)
        {
            return query.Where(q => q.Status.Contains("\"" + status + "\""));
        }

        public static object GetData(this IQueryable<Tasks> query,
           TaskFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal, ClaimsPrincipal principal)
        {
            query = query.Filter(filter, principal);
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