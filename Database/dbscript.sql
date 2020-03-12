USE [master]
GO
/****** Object:  Database [WorkManager]    Script Date: 3/12/2020 8:05:32 PM ******/
CREATE DATABASE [WorkManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WorkManager', FILENAME = N'T:\ITs\SqlServer\ServerInstances\MSSQL12.TNT\MSSQL\DATA\WorkManager.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WorkManager_log', FILENAME = N'T:\ITs\SqlServer\ServerInstances\MSSQL12.TNT\MSSQL\DATA\WorkManager_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WorkManager] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WorkManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WorkManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WorkManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WorkManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WorkManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WorkManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [WorkManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WorkManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WorkManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WorkManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WorkManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WorkManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WorkManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WorkManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WorkManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WorkManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WorkManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WorkManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WorkManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WorkManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WorkManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WorkManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WorkManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WorkManager] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WorkManager] SET  MULTI_USER 
GO
ALTER DATABASE [WorkManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WorkManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WorkManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WorkManager] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WorkManager] SET DELAYED_DURABILITY = DISABLED 
GO
USE [WorkManager]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](100) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](100) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](100) NOT NULL,
	[RoleId] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[FullName] [nvarchar](max) NOT NULL,
	[EmployeeCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](100) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](100) NULL,
	[Time] [datetime] NULL,
	[Action] [varchar](50) NULL,
	[Data] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUser] [nvarchar](100) NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupUsers]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[UserId] [nvarchar](100) NULL,
	[RoleId] [nvarchar](100) NULL,
 CONSTRAINT [PK_GroupUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [nvarchar](50) NULL,
	[Logged] [datetime] NULL,
	[Level] [nvarchar](50) NULL,
	[Message] [nvarchar](max) NULL,
	[UserId] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[Data] [nvarchar](max) NULL,
	[Logger] [nvarchar](250) NULL,
	[Callsite] [nvarchar](max) NULL,
	[Exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 3/12/2020 8:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[SourceId] [int] NULL,
	[TaskContent] [nvarchar](max) NULL,
	[TaskReport] [nvarchar](max) NULL,
	[ManagerReview] [nvarchar](max) NULL,
	[Mark] [int] NULL,
	[ReviewTime] [datetime] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Deadline] [datetime] NULL,
	[Status] [varchar](50) NULL,
	[CreatedTime] [datetime] NULL,
	[CreatedUser] [nvarchar](100) NULL,
	[OfUser] [nvarchar](100) NULL,
	[ConfirmImage] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200303143634_Init', N'2.2.6-servicing-10079')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20200303150932_AddEmpInfo', N'2.2.6-servicing-10079')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'0e5e3af3-3728-45b3-a289-f0946b2fc229', N'Admin', N'ADMIN', N'e1b0be20-fe0c-4f8f-9dd0-ebd92cc0be9f')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'6e80006b-796b-4145-a82a-b0ee5252c23e', N'User', N'USER', N'4f00e154-2753-4438-96b4-1485e7c52b69')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'8f90bc1d-9e34-4b41-a93f-fa79cda09728', N'Manager', N'MANAGER', N'14873cfc-34bd-4007-b723-997fe184ddfc')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'0e5e3af3-3728-45b3-a289-f0946b2fc229')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [FullName], [EmployeeCode]) VALUES (N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'ADMIN', N'trannamtrung1st@gmail.com', N'TRANNAMTRUNG1ST@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEE1YDpwacJH6P9XCtlsLFNfkxGw5h7Y8KZaWEA07vGI2WqwPC5+jJZrq4xczE2JAjQ==', N'IREXUQWHHIOIQFG6DKKN74YEBQYE2PRH', N'7ac79c56-7954-45f5-84aa-9d87bb41b1a7', N'0765441077', 0, 0, NULL, 1, 0, N'Trần Nam Trung', N'EMPADMIN125052')
SET IDENTITY_INSERT [dbo].[Events] ON 

INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (1, NULL, CAST(N'2020-03-12T02:50:16.113' AS DateTime), N'CREATE_USER', N'{"username":"admin","role":"Admin"}', N'Admin created admin with role Admin')
INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (2, NULL, CAST(N'2020-03-12T02:52:21.093' AS DateTime), N'CREATE_USER', N'{"username":"admin","role":"Admin"}', N'Admin created admin with role Admin')
INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (3, N'39717329-d5a2-4cf4-b5ca-bed576c22802', CAST(N'2020-03-12T07:00:49.697' AS DateTime), N'CREATE_USER', N'{"username":"trung","role":"User"}', N'Admin created trung with role User')
INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (4, N'39717329-d5a2-4cf4-b5ca-bed576c22802', CAST(N'2020-03-12T07:01:45.537' AS DateTime), N'CREATE_USER', N'{"username":"trung","role":"User"}', N'Admin created trung with role User')
INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (5, N'39717329-d5a2-4cf4-b5ca-bed576c22802', CAST(N'2020-03-12T08:22:46.077' AS DateTime), N'CREATE_USER', N'{"username":"batman","role":"Manager"}', N'Admin created batman with role Manager')
INSERT [dbo].[Events] ([Id], [UserId], [Time], [Action], [Data], [Message]) VALUES (6, N'39717329-d5a2-4cf4-b5ca-bed576c22802', CAST(N'2020-03-12T09:30:07.473' AS DateTime), N'CREATE_USER', N'{"username":"gayboy","role":"User"}', N'Admin created gayboy with role User')
SET IDENTITY_INSERT [dbo].[Events] OFF
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (1, N'SE130097', CAST(N'2020-03-03T15:42:30.967' AS DateTime), N'Info', N'Login user', N'1980337d-9f78-4d57-bcc2-c7cce36d9b7c', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (2, N'SE130097', CAST(N'2020-03-03T16:59:01.867' AS DateTime), N'Info', N'Create product', N'', N'', N'{"model":{"name":"TNT"}}', N'WorkManager.WebApi.Controllers.ProductsController', N'WorkManager.WebApi.Controllers.ProductsController.Create', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (3, N'SE130097', CAST(N'2020-03-03T16:59:06.597' AS DateTime), N'Info', N'Create product', N'', N'', N'{"model":{"name":"ABC"}}', N'WorkManager.WebApi.Controllers.ProductsController', N'WorkManager.WebApi.Controllers.ProductsController.Create', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (4, N'SE130097', CAST(N'2020-03-03T16:59:09.563' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: value
   at System.String.IndexOf(String value, Int32 startIndex, Int32 count, StringComparison comparisonType)
   at lambda_method(Closure , String )
   at System.Linq.Enumerable.WhereArrayIterator`1.MoveNext()
   at System.Linq.Enumerable.Any[TSource](IEnumerable`1 source)
   at System.Linq.Enumerable.WhereEnumerableIterator`1.MoveNext()
   at System.Linq.Enumerable.EnumerablePartition`1.MoveNext()
   at System.Linq.Enumerable.SelectIPartitionIterator`2.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Repositories.ProductsRepository.SelectFields(IQueryable`1 from, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Repositories\ProductsRepository.cs:line 87
   at WorkManager.Data.Models.Repositories.ProductsRepository.GetData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Repositories\ProductsRepository.cs:line 148
   at WorkManager.Data.Domains.TemplateDomain.GetProductsData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\TemplateDomain.cs:line 36
   at WorkManager.WebApi.Controllers.ProductsController.Get(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\ProductsController.cs:line 47', N'', N'', N'', N'WorkManager.WebApi.Controllers.ProductsController', N'WorkManager.WebApi.Controllers.ProductsController.Get', N'System.ArgumentNullException: Value cannot be null.
Parameter name: value
   at System.String.IndexOf(String value, Int32 startIndex, Int32 count, StringComparison comparisonType)
   at lambda_method(Closure , String )
   at System.Linq.Enumerable.WhereArrayIterator`1.MoveNext()
   at System.Linq.Enumerable.Any[TSource](IEnumerable`1 source)
   at System.Linq.Enumerable.WhereEnumerableIterator`1.MoveNext()
   at System.Linq.Enumerable.EnumerablePartition`1.MoveNext()
   at System.Linq.Enumerable.SelectIPartitionIterator`2.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Repositories.ProductsRepository.SelectFields(IQueryable`1 from, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Repositories\ProductsRepository.cs:line 87
   at WorkManager.Data.Models.Repositories.ProductsRepository.GetData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Repositories\ProductsRepository.cs:line 148
   at WorkManager.Data.Domains.TemplateDomain.GetProductsData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\TemplateDomain.cs:line 36
   at WorkManager.WebApi.Controllers.ProductsController.Get(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\ProductsController.cs:line 47')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (5, N'SE130097', CAST(N'2020-03-03T17:07:38.780' AS DateTime), N'Error', N'System.InvalidOperationException: The property ''Id'' is not a navigation property of entity type ''Products''. The ''Include(string)'' method can only be used with a ''.'' separated list of navigation property names.
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.WalkNavigations(IEntityType entityType, IReadOnlyList`1 navigationPropertyPaths, IncludeLoadTree includeLoadTree, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.TryPopulateIncludeLoadTree(IncludeResultOperator includeResultOperator, IncludeLoadTree includeLoadTree, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.CreateIncludeLoadTrees(QueryModel queryModel, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.CompileIncludes(QueryModel queryModel, Boolean trackingQuery, Boolean asyncQuery, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.EntityQueryModelVisitor.OptimizeQueryModel(QueryModel queryModel, Boolean asyncQuery)
   at Microsoft.EntityFrameworkCore.Query.RelationalQueryModelVisitor.OptimizeQueryModel(QueryModel queryModel, Boolean asyncQuery)
   at Microsoft.EntityFrameworkCore.Query.EntityQueryModelVisitor.CreateQueryExecutor[TResult](QueryModel queryModel)
   at Microsoft.EntityFrameworkCore.Storage.Database.CompileQuery[TResult](QueryModel queryModel)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.CompileQueryCore[TResult](Expression query, IQueryModelGenerator queryModelGenerator, IDatabase database, IDiagnosticsLogger`1 logger, Type contextType)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.<>c__DisplayClass13_0`1.<Execute>b__0()
   at Microsoft.EntityFrameworkCore.Query.Internal.CompiledQueryCache.GetOrAddQueryCore[TFunc](Object cacheKey, Func`1 compiler)
   at Microsoft.EntityFrameworkCore.Query.Internal.CompiledQueryCache.GetOrAddQuery[TResult](Object cacheKey, Func`1 compiler)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.Execute[TResult](Expression query)
   at Microsoft.EntityFrameworkCore.Query.Internal.EntityQueryProvider.Execute[TResult](Expression expression)
   at Remotion.Linq.QueryableBase`1.GetEnumerator()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.ProductsExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\ProductsExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.ProductsExtension.GetData(IQueryable`1 query, ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\ProductsExtensions.cs:line 105
   at WorkManager.Data.Domains.TemplateDomain.GetProductsData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\TemplateDomain.cs:line 37
   at WorkManager.WebApi.Controllers.ProductsController.Get(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\ProductsController.cs:line 47', N'', N'', N'', N'WorkManager.WebApi.Controllers.ProductsController', N'WorkManager.WebApi.Controllers.ProductsController.Get', N'System.InvalidOperationException: The property ''Id'' is not a navigation property of entity type ''Products''. The ''Include(string)'' method can only be used with a ''.'' separated list of navigation property names.
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.WalkNavigations(IEntityType entityType, IReadOnlyList`1 navigationPropertyPaths, IncludeLoadTree includeLoadTree, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.TryPopulateIncludeLoadTree(IncludeResultOperator includeResultOperator, IncludeLoadTree includeLoadTree, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.CreateIncludeLoadTrees(QueryModel queryModel, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.Internal.IncludeCompiler.CompileIncludes(QueryModel queryModel, Boolean trackingQuery, Boolean asyncQuery, Boolean shouldThrow)
   at Microsoft.EntityFrameworkCore.Query.EntityQueryModelVisitor.OptimizeQueryModel(QueryModel queryModel, Boolean asyncQuery)
   at Microsoft.EntityFrameworkCore.Query.RelationalQueryModelVisitor.OptimizeQueryModel(QueryModel queryModel, Boolean asyncQuery)
   at Microsoft.EntityFrameworkCore.Query.EntityQueryModelVisitor.CreateQueryExecutor[TResult](QueryModel queryModel)
   at Microsoft.EntityFrameworkCore.Storage.Database.CompileQuery[TResult](QueryModel queryModel)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.CompileQueryCore[TResult](Expression query, IQueryModelGenerator queryModelGenerator, IDatabase database, IDiagnosticsLogger`1 logger, Type contextType)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.<>c__DisplayClass13_0`1.<Execute>b__0()
   at Microsoft.EntityFrameworkCore.Query.Internal.CompiledQueryCache.GetOrAddQueryCore[TFunc](Object cacheKey, Func`1 compiler)
   at Microsoft.EntityFrameworkCore.Query.Internal.CompiledQueryCache.GetOrAddQuery[TResult](Object cacheKey, Func`1 compiler)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryCompiler.Execute[TResult](Expression query)
   at Microsoft.EntityFrameworkCore.Query.Internal.EntityQueryProvider.Execute[TResult](Expression expression)
   at Remotion.Linq.QueryableBase`1.GetEnumerator()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.ProductsExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\ProductsExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.ProductsExtension.GetData(IQueryable`1 query, ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\ProductsExtensions.cs:line 105
   at WorkManager.Data.Domains.TemplateDomain.GetProductsData(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\TemplateDomain.cs:line 37
   at WorkManager.WebApi.Controllers.ProductsController.Get(ProductFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\ProductsController.cs:line 47')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (6, N'SE130097', CAST(N'2020-03-12T02:29:32.263' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (7, N'SE130097', CAST(N'2020-03-12T02:31:39.607' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (8, N'SE130097', CAST(N'2020-03-12T02:31:57.200' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (9, N'SE130097', CAST(N'2020-03-12T02:32:08.673' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (10, N'SE130097', CAST(N'2020-03-12T02:32:21.883' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (11, N'SE130097', CAST(N'2020-03-12T02:36:14.373' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 147')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (12, N'SE130097', CAST(N'2020-03-12T02:41:19.470' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model)', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''EmployeeCode'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 115
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model)')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (13, N'SE130097', CAST(N'2020-03-12T02:43:21.890' AS DateTime), N'Error', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''FullName'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles)
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model)', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while updating the entries. See the inner exception for details. ---> System.Data.SqlClient.SqlException: Cannot insert the value NULL into column ''FullName'', table ''WorkManager.dbo.AspNetUsers''; column does not allow nulls. INSERT fails.
The statement has been terminated.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(DbContext _, ValueTuple`2 parameters, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IReadOnlyList`1 entriesToSave, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.CreateAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user)
   at Microsoft.AspNetCore.Identity.UserManager`1.CreateAsync(TUser user, String password)
   at WorkManager.Data.Domains.IdentityDomain.CreateUserWithRolesAsync(AppUsers user, String password, IEnumerable`1 roles)
   at WorkManager.WebApi.Controllers.UsersController.Register(RegisterViewModel model)')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (14, N'SE130097', CAST(N'2020-03-12T02:50:16.010' AS DateTime), N'Info', N'Register new user', N'175045ee-0a39-4e98-94bc-ff1ac1a89664', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (15, N'SE130097', CAST(N'2020-03-12T02:52:21.053' AS DateTime), N'Info', N'Register new user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (16, N'SE130097', CAST(N'2020-03-12T03:30:33.833' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (17, N'SE130097', CAST(N'2020-03-12T03:32:14.240' AS DateTime), N'Error', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Domains.IdentityDomain.GenerateTokenResponse(AuthenticationTicket ticket) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 200
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 99', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Domains.IdentityDomain.GenerateTokenResponse(AuthenticationTicket ticket) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 200
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 99')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (18, N'SE130097', CAST(N'2020-03-12T03:37:00.610' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (19, N'SE130097', CAST(N'2020-03-12T04:05:44.233' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (20, N'SE130097', CAST(N'2020-03-12T04:06:21.727' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (21, N'SE130097', CAST(N'2020-03-12T04:10:50.137' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (22, N'SE130097', CAST(N'2020-03-12T04:10:58.993' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (23, N'SE130097', CAST(N'2020-03-12T04:12:09.543' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (24, N'SE130097', CAST(N'2020-03-12T04:12:30.380' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (25, N'SE130097', CAST(N'2020-03-12T04:14:20.187' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (26, N'SE130097', CAST(N'2020-03-12T04:14:45.293' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (27, N'SE130097', CAST(N'2020-03-12T04:14:52.163' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (28, N'SE130097', CAST(N'2020-03-12T04:17:05.630' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (29, N'SE130097', CAST(N'2020-03-12T04:17:17.110' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (30, N'SE130097', CAST(N'2020-03-12T04:22:21.293' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (31, N'SE130097', CAST(N'2020-03-12T04:28:30.810' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (32, N'SE130097', CAST(N'2020-03-12T04:28:38.190' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (33, N'SE130097', CAST(N'2020-03-12T04:28:46.850' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (34, N'SE130097', CAST(N'2020-03-12T04:30:32.393' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (35, N'SE130097', CAST(N'2020-03-12T04:52:28.020' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (36, N'SE130097', CAST(N'2020-03-12T06:09:47.357' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (37, N'SE130097', CAST(N'2020-03-12T06:09:55.577' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (38, N'SE130097', CAST(N'2020-03-12T06:11:49.457' AS DateTime), N'Error', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.ArgumentNullException: Value cannot be null.
Parameter name: userName
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at WorkManager.Data.Domains.IdentityDomain.AuthenticateAsync(String username, String password) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 234
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 44')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (39, N'SE130097', CAST(N'2020-03-12T06:11:57.767' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (40, N'SE130097', CAST(N'2020-03-12T06:28:03.387' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (41, N'SE130097', CAST(N'2020-03-12T06:28:19.643' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (42, N'SE130097', CAST(N'2020-03-12T06:29:24.503' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (43, N'SE130097', CAST(N'2020-03-12T06:30:51.020' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (44, N'SE130097', CAST(N'2020-03-12T06:32:16.647' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (45, N'SE130097', CAST(N'2020-03-12T06:36:31.023' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (46, N'SE130097', CAST(N'2020-03-12T06:38:10.117' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (47, N'SE130097', CAST(N'2020-03-12T06:42:35.650' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (48, N'SE130097', CAST(N'2020-03-12T06:52:29.277' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (49, N'SE130097', CAST(N'2020-03-12T06:53:34.057' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (50, N'SE130097', CAST(N'2020-03-12T07:00:49.640' AS DateTime), N'Info', N'Register new user', N'da287523-ef87-4682-a606-4f0ce1d0d146', N'trung', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (51, N'SE130097', CAST(N'2020-03-12T07:01:45.533' AS DateTime), N'Info', N'Register new user', N'5b537008-169f-4d9c-9b3a-9f8a5d023723', N'trung', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (52, N'SE130097', CAST(N'2020-03-12T07:05:32.387' AS DateTime), N'Info', N'Login user', N'5b537008-169f-4d9c-9b3a-9f8a5d023723', N'trung', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (53, N'SE130097', CAST(N'2020-03-12T07:05:56.427' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (54, N'SE130097', CAST(N'2020-03-12T07:51:02.037' AS DateTime), N'Error', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''Discriminator''.
Invalid column name ''Discriminator''.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncQueryingEnumerable`1.AsyncEnumerator.BufferlessMoveNext(DbContext _, Boolean buffer, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncQueryingEnumerable`1.AsyncEnumerator.MoveNext(CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncLinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext(CancellationToken cancellationToken)
   at System.Linq.AsyncEnumerable.Aggregate_[TSource,TAccumulate,TResult](IAsyncEnumerable`1 source, TAccumulate seed, Func`3 accumulator, Func`2 resultSelector, CancellationToken cancellationToken) in D:\a\1\s\Ix.NET\Source\System.Interactive.Async\Aggregate.cs:line 120
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.GetRolesAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.GetRolesAsync(TUser user)
   at WorkManager.Data.Domains.IdentityDomain.GetIdentityAsync(AppUsers user, String scheme) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 253
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 87
ClientConnectionId:4306e382-bc73-4a17-b223-02314461cbfe
Error Number:207,State:1,Class:16', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''Discriminator''.
Invalid column name ''Discriminator''.
   at System.Data.SqlClient.SqlCommand.<>c.<ExecuteDbDataReaderAsync>b__122_0(Task`1 result)
   at System.Threading.Tasks.ContinuationResultTaskFromResultTask`2.InnerInvoke()
   at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location where exception was thrown ---
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot)
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteAsync(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncQueryingEnumerable`1.AsyncEnumerator.BufferlessMoveNext(DbContext _, Boolean buffer, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncQueryingEnumerable`1.AsyncEnumerator.MoveNext(CancellationToken cancellationToken)
   at Microsoft.EntityFrameworkCore.Query.Internal.AsyncLinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext(CancellationToken cancellationToken)
   at System.Linq.AsyncEnumerable.Aggregate_[TSource,TAccumulate,TResult](IAsyncEnumerable`1 source, TAccumulate seed, Func`3 accumulator, Func`2 resultSelector, CancellationToken cancellationToken) in D:\a\1\s\Ix.NET\Source\System.Interactive.Async\Aggregate.cs:line 120
   at Microsoft.AspNetCore.Identity.EntityFrameworkCore.UserStore`9.GetRolesAsync(TUser user, CancellationToken cancellationToken)
   at Microsoft.AspNetCore.Identity.UserManager`1.GetRolesAsync(TUser user)
   at WorkManager.Data.Domains.IdentityDomain.GetIdentityAsync(AppUsers user, String scheme) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Domains\IdentityDomain.cs:line 253
   at WorkManager.WebApi.Controllers.UsersController.LogIn(AuthorizationGrantViewModel model) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 87
ClientConnectionId:4306e382-bc73-4a17-b223-02314461cbfe
Error Number:207,State:1,Class:16')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (55, N'SE130097', CAST(N'2020-03-12T07:54:57.053' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (56, N'SE130097', CAST(N'2020-03-12T07:56:13.797' AS DateTime), N'Error', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:2c87cbec-bb8a-4edb-8fba-838eefc7f049
Error Number:207,State:1,Class:16', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:2c87cbec-bb8a-4edb-8fba-838eefc7f049
Error Number:207,State:1,Class:16')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (57, N'SE130097', CAST(N'2020-03-12T08:00:13.350' AS DateTime), N'Error', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:a7a6042e-c007-48d2-8e56-1a97c6b50c5c
Error Number:207,State:1,Class:16', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:a7a6042e-c007-48d2-8e56-1a97c6b50c5c
Error Number:207,State:1,Class:16')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (58, N'SE130097', CAST(N'2020-03-12T08:02:20.310' AS DateTime), N'Error', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:af54788d-5914-4559-a325-87cf42205e6a
Error Number:207,State:1,Class:16', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:af54788d-5914-4559-a325-87cf42205e6a
Error Number:207,State:1,Class:16')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (59, N'SE130097', CAST(N'2020-03-12T08:02:50.667' AS DateTime), N'Error', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:aca46cac-2856-422b-aea7-de8ee7889ef6
Error Number:207,State:1,Class:16', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.Data.SqlClient.SqlException (0x80131904): Invalid column name ''UserId1''.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlDataReader.TryConsumeMetaData()
   at System.Data.SqlClient.SqlDataReader.get_MetaData()
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite, String method)
   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   at System.Data.Common.DbCommand.ExecuteReader()
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.Execute(IRelationalConnection connection, DbCommandMethod executeMethod, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Storage.Internal.RelationalCommand.ExecuteReader(IRelationalConnection connection, IReadOnlyDictionary`2 parameterValues)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryBuffer.CorrelateSubquery[TInner,TOut,TCollection](Int32 correlatedCollectionId, INavigation navigation, Func`2 resultCollectionFactory, MaterializedAnonymousObject& outerKey, Boolean tracking, Func`1 correlatedCollectionFactory, Func`3 correlationPredicate)
   at lambda_method(Closure , QueryContext , ValueBuffer )
   at Microsoft.EntityFrameworkCore.Query.ExpressionVisitors.Internal.ProjectionShaper.TypedProjectionShaper`3.Shape(QueryContext queryContext, ValueBuffer& valueBuffer)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.BufferlessMoveNext(DbContext _, Boolean buffer)
   at Microsoft.EntityFrameworkCore.SqlServer.Storage.Internal.SqlServerExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Query.Internal.QueryingEnumerable`1.Enumerator.MoveNext()
   at Microsoft.EntityFrameworkCore.Query.Internal.LinqOperatorProvider.ExceptionInterceptor`1.EnumeratorExceptionInterceptor.MoveNext()
   at System.Collections.Generic.List`1.AddEnumerable(IEnumerable`1 enumerable)
   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 42
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145
ClientConnectionId:aca46cac-2856-422b-aea7-de8ee7889ef6
Error Number:207,State:1,Class:16')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (60, N'SE130097', CAST(N'2020-03-12T08:06:38.783' AS DateTime), N'Error', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (61, N'SE130097', CAST(N'2020-03-12T08:07:02.217' AS DateTime), N'Error', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (62, N'SE130097', CAST(N'2020-03-12T08:07:11.960' AS DateTime), N'Error', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145', N'', N'', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Get', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.SelectFields(IQueryable`1 query, String[] generalFields, Nullable`1 count) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 59
   at WorkManager.Data.Models.Extensions.AspNetAppUsersExtension.GetData(IQueryable`1 query, UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean countTotal) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.Data\Models\Extensions\AppUsersExtensions.cs:line 112
   at WorkManager.WebApi.Controllers.UsersController.Get(UserFilter filter, String[] sorts, String[] fields, Int32 page, Int32 limit, Boolean count_total) in T:\FPT\STUDY\SPRING2020\PRM391\Project\Backend\WorkManager\WorkManager.WebApi\Controllers\UsersController.cs:line 145')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (63, N'SE130097', CAST(N'2020-03-12T08:22:46.023' AS DateTime), N'Info', N'Register new user', N'e3d606ba-8847-45bf-8b75-bec723c50966', N'batman', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (64, N'SE130097', CAST(N'2020-03-12T09:30:07.233' AS DateTime), N'Info', N'Register new user', N'ba9777a2-46d2-4f99-baf1-c1f397b850a5', N'gayboy', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.Register', N'')
INSERT [dbo].[Logs] ([Id], [MachineName], [Logged], [Level], [Message], [UserId], [UserName], [Data], [Logger], [Callsite], [Exception]) VALUES (65, N'SE130097', CAST(N'2020-03-12T11:56:13.953' AS DateTime), N'Info', N'Login user', N'39717329-d5a2-4cf4-b5ca-bed576c22802', N'admin', N'', N'WorkManager.WebApi.Controllers.UsersController', N'WorkManager.WebApi.Controllers.UsersController.LogIn', N'')
SET IDENTITY_INSERT [dbo].[Logs] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name]) VALUES (2, N'TNT')
INSERT [dbo].[Products] ([Id], [Name]) VALUES (3, N'ABC')
SET IDENTITY_INSERT [dbo].[Products] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_GroupUsers]    Script Date: 3/12/2020 8:05:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_GroupUsers] ON [dbo].[GroupUsers]
(
	[GroupId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  DEFAULT (N'') FOR [EmployeeCode]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_AspNetUsers]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_AspNetUsers] FOREIGN KEY([CreatedUser])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_AspNetUsers]
GO
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_GroupUsers_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [FK_GroupUsers_AspNetRoles]
GO
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_GroupUsers_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [FK_GroupUsers_AspNetUsers]
GO
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_GroupUsers_Groups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [FK_GroupUsers_Groups]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_AspNetUsers] FOREIGN KEY([CreatedUser])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_AspNetUsers]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_AspNetUsers1] FOREIGN KEY([OfUser])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_AspNetUsers1]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Tasks] FOREIGN KEY([SourceId])
REFERENCES [dbo].[Tasks] ([Id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Tasks]
GO
USE [master]
GO
ALTER DATABASE [WorkManager] SET  READ_WRITE 
GO
