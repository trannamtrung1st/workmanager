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
	public partial interface IGroupsRepository : IBaseRepository<Groups, int>
	{
	}
	
	public partial class GroupsRepository : BaseRepository<Groups, int>, IGroupsRepository
	{
		public GroupsRepository(DbContext context) : base(context)
		{
		}
		
		#region CRUD area
		public override Groups FindById(int key)
		{
			var entity = QuerySet.FirstOrDefault(
				e => e.Id == key);
			return entity;
		}
		
		public override async Task<Groups> FindByIdAsync(int key)
		{
			var entity = await QuerySet.FirstOrDefaultAsync(
				e => e.Id == key);
			return entity;
		}
		
		#endregion
	}
}
