using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TNT.Core.Helpers.Data;
using Newtonsoft.Json;

namespace WorkManager.Data.Models.Extensions
{
    public static partial class EventsExtension
    {
        #region READ
        public static IQueryable<Events> Filter(
            this IQueryable<Events> query, EventFilter filter)
        {
            if (filter.ids != null)
                query = query.Where(p => filter.ids.Contains(p.Id));
            if (filter.group_id != null)
                query = query.Where(p => p.Data.Contains($"\"group_id\":{filter.group_id}"));
            if (filter.task_id != null)
                query = query.Where(p => p.Data.Contains($"\"task_id\":{filter.task_id}"));
            if (filter.user_id != null)
                query = query.Where(p => p.Data.Contains($"\"user_id\":\"{filter.user_id}\""));
            return query;
        }

        public static IQueryable<Events> QueryFields(this IQueryable<Events> query, string[] generalFields)
        {
            var finalFields = new List<string>();
            foreach (var f in generalFields)
            {
                if (EventGeneralFields.Mapping.ContainsKey(f))
                    finalFields.AddRange(EventGeneralFields.Mapping[f]);
            }
            var fieldsArr = finalFields.ToArray();
            query = query.SelectOnly(SelectOption.ByPropertyName, fieldsArr);
            return query;
        }

        public static object SelectFields(this IQueryable<Events> query, string[] generalFields, int? count)
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
                        case EventGeneralFields.INFO:
                            obj["id"] = p.Id;
                            obj["action"] = p.Action;
                            obj["message"] = p.Message;
                            obj["time"] = p.Time;
                            obj["user_id"] = p.UserId;
                            break;

                        case EventGeneralFields.DATA:
                            obj["data"] = JsonConvert
                                .DeserializeObject<IDictionary<string, object>>(p.Data);
                            break;

                        case EventGeneralFields.USER:
                            obj["user"] = new
                            {
                                id = p.UserId,
                                full_name = p.User.FullName,
                                username = p.User.UserName
                            };
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

        public static IQueryable<Events> Sort(this IQueryable<Events> query,
            string[] sortings)
        {
            foreach (var s in sortings)
            {
                var asc = s[0] == 'a';
                var fieldName = s.Remove(0, 1);
                switch (fieldName)
                {
                    case EventSortFields.Time:
                        if (asc)
                            query = query.OrderBy(p => p.Time);
                        else query = query.OrderByDescending(p => p.Time);
                        break;
                }
            }
            return query;
        }

        public static IQueryable<Events> SelectPage(
            this IQueryable<Events> query, int page, int limit)
        {
            return query.Skip(page * limit).Take(limit);
        }

        public static object GetData(this IQueryable<Events> query,
           EventFilter filter,
           string[] sorts,
           string[] fields,
           int page,
           int limit, bool countTotal)
        {
            query = query.Filter(filter);
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