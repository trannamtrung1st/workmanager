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
	public partial class GroupUsers : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class GroupUsersExtension
	{
		public static GroupUsers Id(this IQueryable<GroupUsers> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static GroupUsers Id(this IEnumerable<GroupUsers> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<GroupUsers> query, int key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
