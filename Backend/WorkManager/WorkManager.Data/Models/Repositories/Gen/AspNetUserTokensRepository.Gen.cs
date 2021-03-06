using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WorkManager.Data.Models;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace WorkManager.Data.Models.Repositories
{
	public partial interface IAspNetUserTokensRepository : IBaseRepository<AspNetUserTokens, AspNetUserTokensPK>
	{
	}
	
	public partial class AspNetUserTokensRepository : BaseRepository<AspNetUserTokens, AspNetUserTokensPK>, IAspNetUserTokensRepository
	{
		public AspNetUserTokensRepository(DbContext context) : base(context)
		{
		}
		
		#region CRUD area
		public override AspNetUserTokens FindById(AspNetUserTokensPK key)
		{
			var entity = QuerySet.FirstOrDefault(
				e => e.UserId == key.UserId && e.LoginProvider == key.LoginProvider && e.Name == key.Name);
			return entity;
		}
		
		public override async Task<AspNetUserTokens> FindByIdAsync(AspNetUserTokensPK key)
		{
			var entity = await QuerySet.FirstOrDefaultAsync(
				e => e.UserId == key.UserId && e.LoginProvider == key.LoginProvider && e.Name == key.Name);
			return entity;
		}
		
		#endregion
	}
}
