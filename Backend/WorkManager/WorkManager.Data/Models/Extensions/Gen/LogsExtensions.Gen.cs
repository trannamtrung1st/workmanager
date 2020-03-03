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
	public partial class Logs : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class LogsExtension
	{
		public static Logs Id(this IQueryable<Logs> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static Logs Id(this IEnumerable<Logs> query, int key)
		{
			return query.FirstOrDefault(
				e => e.Id == key);
		}
		
		public static bool Existed(this IQueryable<Logs> query, int key)
		{
			return query.Any(
				e => e.Id == key);
		}
		
	}
}
