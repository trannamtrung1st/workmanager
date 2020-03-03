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
	public partial interface IProductsRepository : IBaseRepository<Products, int>
	{
	}
	
	public partial class ProductsRepository : BaseRepository<Products, int>, IProductsRepository
	{
		public ProductsRepository(DbContext context) : base(context)
		{
		}
		
		#region CRUD area
		public override Products FindById(int key)
		{
			var entity = QuerySet.FirstOrDefault(
				e => e.Id == key);
			return entity;
		}
		
		public override async Task<Products> FindByIdAsync(int key)
		{
			var entity = await QuerySet.FirstOrDefaultAsync(
				e => e.Id == key);
			return entity;
		}
		
		#endregion
	}
}
