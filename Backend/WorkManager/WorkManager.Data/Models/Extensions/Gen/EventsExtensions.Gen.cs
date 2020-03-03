using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WorkManager.Data.ViewModels;
using WorkManager.Data.Models;
using WorkManager.Data.Global;

namespace WorkManager.Data.Models
{
	public partial class Events : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class EventsExtension
	{
		public static Events Id(this IQueryable<Events> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static Events Id(this IEnumerable<Events> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<Events> query, int key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
