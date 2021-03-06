using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using WorkManager.Data.Models;
using WorkManager.Data.Models.Repositories;
using WorkManager.Data.ViewModels;
using TNT.Core.Helpers.DI;
using Microsoft.Extensions.DependencyInjection;

namespace WorkManager.Data.Global
{
	public static partial class G
	{
		public static IMapper Mapper { get; private set; }
		private static List<Action<IMapperConfigurationExpression>> MapperConfigs
			= new List<Action<IMapperConfigurationExpression>>();
		//{
			//cfg =>
			//{
			//	cfg.CreateMap<AspNetRoleClaims, AspNetRoleClaimsViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetRoles, AspNetRolesViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetUserClaims, AspNetUserClaimsViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetUserLogins, AspNetUserLoginsViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetUserRoles, AspNetUserRolesViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetUserTokens, AspNetUserTokensViewModel>().ReverseMap();
			//	cfg.CreateMap<AspNetUsers, AspNetUsersViewModel>().ReverseMap();
			//	cfg.CreateMap<Events, EventsViewModel>().ReverseMap();
			//	cfg.CreateMap<GroupUsers, GroupUsersViewModel>().ReverseMap();
			//	cfg.CreateMap<Groups, GroupsViewModel>().ReverseMap();
			//	cfg.CreateMap<Logs, LogsViewModel>().ReverseMap();
			//	cfg.CreateMap<Products, ProductsViewModel>().ReverseMap();
			//	cfg.CreateMap<Tasks, TasksViewModel>().ReverseMap();
		//	}
		//};
		private static void ConfigureAutomapper()
		{
			//AutoMapper
			var mapConfig = new MapperConfiguration(cfg =>
			{
				foreach (var c in MapperConfigs)
				{
					c.Invoke(cfg);
				}
			});
			G.Mapper = mapConfig.CreateMapper();
			
		}
		
		private static void ConfigureIoC(IServiceCollection services)
		{
			//IoC
			services.AddScoped<UnitOfWork>()
				.AddScoped<IUnitOfWork, UnitOfWork>()
				.AddScoped<DbContext, WorkContext>()
				.AddScoped<IAspNetRoleClaimsRepository, AspNetRoleClaimsRepository>()
				.AddScoped<IAspNetRolesRepository, AspNetRolesRepository>()
				.AddScoped<IAspNetUserClaimsRepository, AspNetUserClaimsRepository>()
				.AddScoped<IAspNetUserLoginsRepository, AspNetUserLoginsRepository>()
				.AddScoped<IAspNetUserRolesRepository, AspNetUserRolesRepository>()
				.AddScoped<IAspNetUserTokensRepository, AspNetUserTokensRepository>()
				.AddScoped<IAspNetUsersRepository, AspNetUsersRepository>()
				.AddScoped<IEventsRepository, EventsRepository>()
				.AddScoped<IGroupUsersRepository, GroupUsersRepository>()
				.AddScoped<IGroupsRepository, GroupsRepository>()
				.AddScoped<ILogsRepository, LogsRepository>()
				.AddScoped<IProductsRepository, ProductsRepository>()
				.AddScoped<ITasksRepository, TasksRepository>();
			ServiceInjection.Register(new List<Type>(){ typeof(G) });
		}
		
	}
}
