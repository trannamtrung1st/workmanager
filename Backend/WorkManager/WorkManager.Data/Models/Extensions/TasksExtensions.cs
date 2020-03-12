﻿using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TNT.Core.Helpers.Data;

namespace WorkManager.Data.Models.Extensions
{
    public static partial class TasksExtension
    {
        #region READ
        public static IQueryable<Tasks> Filter(
            this IQueryable<Tasks> query, TaskFilter filter)
        {
            if (filter.ids != null)
                query = query.Where(p => filter.ids.Contains(p.Id));
            if (filter.name_contains != null)
                query = query.Where(p => filter.name_contains.Any(s => p.Name.Contains(s, StringComparison.OrdinalIgnoreCase)));
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

        public static object GetData(this IQueryable<Tasks> query,
           TaskFilter filter,
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