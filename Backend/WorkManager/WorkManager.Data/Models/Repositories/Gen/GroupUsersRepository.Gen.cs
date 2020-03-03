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
	public partial interface IGroupUsersRepository : IBaseRepository<GroupUsers, int>
	{
	}
	
	public partial class GroupUsersRepository : BaseRepository<GroupUsers, int>, IGroupUsersRepository
	{
		public GroupUsersRepository(DbContext context) : base(context)
		{
		}
		
		#region CRUD area
		public override GroupUsers FindById(int key)
		{
			var entity = QuerySet.FirstOrDefault(
				e => e.Id == key);
			return entity;
		}
		
		public override async Task<GroupUsers> FindByIdAsync(int key)
		{
			var entity = await QuerySet.FirstOrDefaultAsync(
				e => e.Id == key);
			return entity;
		}
		
		#endregion
	}
}
