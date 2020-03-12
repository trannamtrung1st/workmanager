using Newtonsoft.Json;
using WorkManager.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace WorkManager.Data.ViewModels
{
    public partial class GroupsViewModel : BaseViewModel<Groups>
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

        public GroupsViewModel(Groups entity) : base(entity)
        {
        }

        public GroupsViewModel()
        {
        }

    }

    public class CreateGroupViewModel : BaseViewModel<Groups>
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Group name is required")]
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("description")]
        public string Description { get; set; }

        public CreateGroupViewModel()
        {
        }

        public CreateGroupViewModel(Groups entity) : base(entity)
        {
        }

    }

    public class RemoveUserFromGroupViewModel
    {
        public int id { get; set; }
    }

    public class AddUserToGroupViewModel
    {
        public string user_id { get; set; }
        public int group_id { get; set; }
    }
    public class ChangeUserRoleInGroupViewModel
    {
        public int id { get; set; }
    }

    public class EditGroupViewModel : BaseViewModel<Groups>
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Group name is required")]
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("description")]
        public string Description { get; set; }

        public EditGroupViewModel()
        {
        }

        public EditGroupViewModel(Groups entity) : base(entity)
        {
        }

    }

    public class GroupGeneralFields
    {
        public const string INFO = "info";
        public const string CREATED_USER = "created_user";
        public const string GROUP_USERS = "group_users";

        public static readonly IDictionary<string, string[]> Mapping =
            new Dictionary<string, string[]>()
            {
                {
                    INFO, new string[]{ "Id","Name","Description", "CreatedTime","CreatedUser" }
                },
                {
                    GROUP_USERS, new string[]{ "GroupUsers"}
                },
                {
                    CREATED_USER, new string[]{
                        "CreatedUserNavigation.Id",
                        "CreatedUserNavigation.UserName", "CreatedUserNavigation.FullName"}
                }
            };
    }

    public class GroupSortFields
    {
        public const string Name = "name";
    }

    public class GroupFilter
    {
        public int[] ids { get; set; }
        public string[] name_contains { get; set; }
    }

}