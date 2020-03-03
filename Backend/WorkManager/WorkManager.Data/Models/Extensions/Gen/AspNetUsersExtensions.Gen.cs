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
	public partial class AspNetUsers : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class AspNetUsersExtension
	{
		public static AspNetUsers Id(this IQueryable<AspNetUsers> query, string key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static AspNetUsers Id(this IEnumerable<AspNetUsers> query, string key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<AspNetUsers> query, string key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
