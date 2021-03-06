using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore;
using WorkManager.Data.Global;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.Domains;
using WorkManager.Data.Models;
using Microsoft.Extensions.DependencyInjection;

namespace WorkManager.Data.Models
{
	public partial interface IUnitOfWork
	{
		T GetService<T>();
		int SaveChanges();
		Task<int> SaveChangesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken));
		IDbContextTransaction BeginTransaction();
		
	}
	public partial class UnitOfWork: IUnitOfWork
	{
		public UnitOfWork(IServiceProvider scope, DbContext context)
		{
			this.scope = scope;
			this.context = context;
		}
		
		protected readonly IServiceProvider scope;
		protected readonly DbContext context;
		
		public T GetService<T>()
		{
			return scope.GetService<T>();
		}
		
		public IDbContextTransaction BeginTransaction()
		{
			var trans = this.context.Database.BeginTransaction();
			return trans;
		}
		
		public int SaveChanges()
		{
			return this.context.SaveChanges();
		}
		
		public async Task<int> SaveChangesAsync(System.Threading.CancellationToken cancellationToken = default(System.Threading.CancellationToken))
		{
			return await this.context.SaveChangesAsync(cancellationToken);
		}
		
	}
}
