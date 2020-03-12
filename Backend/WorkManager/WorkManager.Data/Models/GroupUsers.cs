using System;
using System.Collections.Generic;

namespace WorkManager.Data.Models
{
    public partial class GroupUsers
    {
        public int Id { get; set; }
        public int? GroupId { get; set; }
        public string UserId { get; set; }

        public virtual Groups Group { get; set; }
        public virtual AspNetUsers User { get; set; }
    }
}
