using System;
using System.Collections.Generic;

namespace WorkManager.Data.Models
{
    public partial class Groups
    {
        public Groups()
        {
            GroupUsers = new HashSet<GroupUsers>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime? CreatedTime { get; set; }
        public string CreatedUser { get; set; }

        public virtual AspNetUsers CreatedUserNavigation { get; set; }
        public virtual ICollection<GroupUsers> GroupUsers { get; set; }
    }
}
