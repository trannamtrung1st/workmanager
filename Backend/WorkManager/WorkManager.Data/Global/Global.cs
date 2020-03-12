using Microsoft.Extensions.DependencyInjection;
using NLog;
using WorkManager.Data.Models;
using WorkManager.Data.Domains;
using WorkManager.Data.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;

namespace WorkManager.Data.Global
{
    public static partial class G
    {
        public static Random Random { get; set; }
        public static void Configure(IServiceCollection services)
        {
            MapperConfigs.Add(cfg =>
            {
                cfg.CreateMap<Products, ProductsViewModel>().ReverseMap();
                cfg.CreateMap<Products, CreateProductViewModel>().ReverseMap();
                cfg.CreateMap<Products, EditProductViewModel>().ReverseMap();
                cfg.CreateMap<Groups, GroupsViewModel>().ReverseMap();
                cfg.CreateMap<Groups, CreateGroupViewModel>().ReverseMap();
                cfg.CreateMap<Groups, EditGroupViewModel>().ReverseMap();
            });
            ConfigureAutomapper();
            ConfigureIoC(services);

            //extra
            services.AddScoped<TemplateDomain>();
            services.AddScoped<IdentityDomain>();
            services.AddScoped<EventDomain>();
            services.AddScoped<GroupDomain>();

            Random = new Random();
        }

        //SET ANSI_NULLS ON
        //  SET QUOTED_IDENTIFIER ON
        //  CREATE TABLE [dbo].[Logs] (
        //	  [Id] [int] IDENTITY(1,1) NOT NULL,
        //	  [MachineName] [nvarchar](50) NOT NULL,
        //	  [Logged] [datetime] NOT NULL,
        //	  [Level] [nvarchar](50) NOT NULL,
        //	  [Message] [nvarchar](max) NOT NULL,
        //	  [UserId] [nvarchar](100),
        //	  [UserName] [nvarchar](100),
        //	  [Data] [nvarchar](max),
        //	  [Logger] [nvarchar](250) NULL,
        //	  [Callsite] [nvarchar](max) NULL,
        //	  [Exception] [nvarchar](max) NULL,
        //    CONSTRAINT [PK_dbo.Log] PRIMARY KEY CLUSTERED ([Id] ASC)
        //      WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
        //  ) ON [PRIMARY]

        public static void ConfigureLogging()
        {
            var config = new NLog.Config.LoggingConfiguration();

            // Targets where to log to: File and Console
            var nConf = App.Instance.NLog;
            var logDb = new NLog.Targets.DatabaseTarget()
            {
                Name = nConf.Name,
                DBProvider = nConf.DBProvider,
                ConnectionString = nConf.ConnectionString,
                CommandType = nConf.CommandType,
                CommandText = nConf.CommandText,
            };

            foreach (var para in nConf.Parameters)
                logDb.Parameters.Add(new NLog.Targets.DatabaseParameterInfo(para.Name, para.Layout));
            // Rules for mapping loggers to targets            
            config.AddRule(LogLevel.Info, LogLevel.Fatal, logDb);

            // Apply config           
            NLog.LogManager.Configuration = config;
        }

    }
}