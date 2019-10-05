CREATE TABLE [stage].[SQL_Database_Info]
(
[Asset_ID] [int] NULL,
[database_id] [int] NULL,
[dbName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[state_desc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataFiles] [int] NULL,
[Data MB] [int] NULL,
[LogFiles] [int] NULL,
[Log MB] [int] NULL,
[User access] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Recovery model] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[compatibility level] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Creation date] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last backup] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fulltext] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[autoclose] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[page verify option] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[read only] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[autoshrink] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[standby] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cleanly shutdown] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
