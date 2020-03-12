using System;
using System.Collections.Generic;

namespace WorkManager.Data.Models
{
    public partial class Events
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public DateTime? Time { get; set; }
        public string Action { get; set; }
        public string Data { get; set; }
        public string Message { get; set; }

        public virtual AspNetUsers User { get; set; }
    }
}
