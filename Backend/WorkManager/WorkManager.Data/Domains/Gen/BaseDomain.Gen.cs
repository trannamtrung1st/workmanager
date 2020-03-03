using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using WorkManager.Data.Models;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.ViewModels;
using TNT.Core.Helpers.DI;

namespace WorkManager.Data.Domains
{
	public abstract partial class BaseDomain
	{
		[Inject]
		protected readonly IUnitOfWork _uow;
		
		public BaseDomain(ServiceInjection inj)
		{
			inj.Inject(this);
		}
		
	}
}
