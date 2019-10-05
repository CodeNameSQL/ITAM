CREATE TABLE [dbo].[SQL_Instance_Info]
(
[Asset_ID] [int] NULL,
[MachineName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InstanceName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Port] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductVersion] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductLevel] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductMajorVersion] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductMinorVersion] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductBuild] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Edition] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EngineEdition] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HadrEnabled] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HadrManagerStatus] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InSingleUserMode] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsClustered] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ServerEnvironment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ServerStatus] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
