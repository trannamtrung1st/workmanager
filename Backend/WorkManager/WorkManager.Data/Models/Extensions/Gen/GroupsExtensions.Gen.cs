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
	public partial class Groups : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class GroupsExtension
	{
		public static Groups Id(this IQueryable<Groups> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static Groups Id(this IEnumerable<Groups> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<Groups> query, int key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
