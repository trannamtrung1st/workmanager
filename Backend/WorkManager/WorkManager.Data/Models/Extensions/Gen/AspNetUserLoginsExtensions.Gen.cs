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
	public partial class AspNetUserLoginsPK
	{
		public string LoginProvider { get; set; }
		public string ProviderKey { get; set; }
	}
	
	public partial class AspNetUserLogins : BaseEntity
	{
	}
	
}


namespace WorkManager.Data.Models.Extensions
{
	public static partial class AspNetUserLoginsExtension
	{
		public static AspNetUserLogins Id(this IQueryable<AspNetUserLogins> query, AspNetUserLoginsPK key)
		{
			return query.FirstOrDefault(
				e => e.LoginProvider == key.LoginProvider && e.ProviderKey == key.ProviderKey);
		}
		
		public static AspNetUserLogins Id(this IEnumerable<AspNetUserLogins> query, AspNetUserLoginsPK key)
		{
			return query.FirstOrDefault(
				e => e.LoginProvider == key.LoginProvider && e.ProviderKey == key.ProviderKey);
		}
		
		public static bool Existed(this IQueryable<AspNetUserLogins> query, AspNetUserLoginsPK key)
		{
			return query.Any(
				e => e.LoginProvider == key.LoginProvider && e.ProviderKey == key.ProviderKey);
		}
		
	}
}
