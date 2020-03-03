using System;
using System.Collections.Generic;

namespace WorkManager.Data.Models
{
    public partial class Tasks
    {
        public Tasks()
        {
            InverseSource = new HashSet<Tasks>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int? SourceId { get; set; }
        public string TaskContent { get; set; }
        public string TaskReport { get; set; }
        public string ManagerReview { get; set; }
        public int Mark { get; set; }
        public DateTime ReviewTime { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Status { get; set; }
        public DateTime CreatedTime { get; set; }
        public string CreatedUser { get; set; }
        public string OfUser { get; set; }
        public string ConfirmImage { get; set; }

        public virtual AspNetUsers CreatedUserNavigation { get; set; }
        public virtual AspNetUsers OfUserNavigation { get; set; }
        public virtual Tasks Source { get; set; }
        public virtual ICollection<Tasks> InverseSource { get; set; }
    }
}
