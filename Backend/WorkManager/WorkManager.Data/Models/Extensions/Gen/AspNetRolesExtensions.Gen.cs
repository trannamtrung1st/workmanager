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
	public partial class AspNetRoles : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class AspNetRolesExtension
	{
		public static AspNetRoles Id(this IQueryable<AspNetRoles> query, string key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static AspNetRoles Id(this IEnumerable<AspNetRoles> query, string key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<AspNetRoles> query, string key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
