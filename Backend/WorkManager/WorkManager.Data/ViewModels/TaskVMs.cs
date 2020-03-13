using Newtonsoft.Json;
using WorkManager.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace WorkManager.Data.ViewModels
{
    public partial class TasksViewModel : BaseViewModel<Tasks>
    {
        [JsonProperty("id")]
        public int Id { get; set; }
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("description")]
        public string Description { get; set; }
        [JsonProperty("created_time")]
        public DateTime? CreatedTime { get; set; }
        [JsonProperty("created_user")]
        public string CreatedUser { get; set; }

        public TasksViewModel(Tasks entity) : base(entity)
        {
        }

        public TasksViewModel()
        {
        }

    }

    public class CreateTaskViewModel : BaseViewModel<Tasks>
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Task name is required")]
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("task_content")]
        public string TaskContent { get; set; }
        [JsonProperty("deadline")]
        public DateTime? Deadline { get; set; }
        [JsonProperty("employee_code")]
        public string EmployeeCode { get; set; }
        [JsonProperty("source_id")]
        public string SourceId { get; set; }

        public CreateTaskViewModel()
        {
        }

        public CreateTaskViewModel(Tasks entity) : base(entity)
        {
        }

    }

    public class EditTaskViewModel : BaseViewModel<Tasks>
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Task name is required")]
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("description")]
        public string Description { get; set; }

        public EditTaskViewModel()
        {
        }

        public EditTaskViewModel(Tasks entity) : base(entity)
        {
        }

    }

    public class TaskGeneralFields
    {
        public const string INFO = "info";
        public const string OF_USER = "of_user";
        public const string CREATED_USER = "created_user";

        public static readonly IDictionary<string, string[]> Mapping =
            new Dictionary<string, string[]>()
            {
                {
                    INFO, new string[]{ "Id","Name","TaskContent", "Status","Deadline", "OfUser" }
                },
                {
                    OF_USER, new string[]{ "OfUserNavigation.Id", "OfUserNavigation.UserName",
                        "OfUserNavigation.FullName" }
                },
                {
                    CREATED_USER, new string[]{ "CreatedUserNavigation.Id", "CreatedUserNavigation.UserName",
                        "CreatedUserNavigation.FullName" }
                },
            };
    }

    public class TaskSortFields
    {
        public const string Name = "name";
    }

    public class TaskFilter
    {
        public int[] ids { get; set; }
        public DateTime? from_date { get; set; }
        public DateTime? to_date { get; set; }
        public string status { get; set; }
        public string employee_code { get; set; }
    }

}