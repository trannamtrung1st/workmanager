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
	public partial interface IAspNetRoleClaimsRepository : IBaseRepository<AspNetRoleClaims, int>
	{
	}
	
	public partial class AspNetRoleClaimsRepository : BaseRepository<AspNetRoleClaims, int>, IAspNetRoleClaimsRepository
	{
		public AspNetRoleClaimsRepository(DbContext context) : base(context)
		{
		}
		
		#region CRUD area
		public override AspNetRoleClaims FindById(int key)
		{
			var entity = QuerySet.FirstOrDefault(
				e => e.Id == key);
			return entity;
		}
		
		public override async Task<AspNetRoleClaims> FindByIdAsync(int key)
		{
			var entity = await QuerySet.FirstOrDefaultAsync(
				e => e.Id == key);
			return entity;
		}
		
		#endregion
	}
}
