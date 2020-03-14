using Newtonsoft.Json;
using WorkManager.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace WorkManager.Data.ViewModels
{

    public class EventGeneralFields
    {
        public const string INFO = "info";
        public const string DATA = "data";
        public const string USER = "user";

        public static readonly IDictionary<string, string[]> Mapping =
            new Dictionary<string, string[]>()
            {
                {
                    INFO, new string[]{ "Id","Message","Time","Action", "UserId" }
                },
                {
                    DATA, new string[]{ "Data" }
                },
                {
                    USER, new string[]{ "User.Id", "User.UserName", "User.FullName" }
                },
            };
    }

    public class EventSortFields
    {
        public const string Time = "time";
    }

    public class EventFilter
    {
        public int[] ids { get; set; }
        public int? task_id { get; set; }
        public string user_id { get; set; }
        public int? group_id { get; set; }
    }

}