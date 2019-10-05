CREATE TABLE [stage].[SQL_Job_Info]
(
[Asset_Id] [int] NULL,
[RunTime] [datetime2] NULL,
[job_id] [uniqueidentifier] NULL,
[name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[step_id] [int] NULL,
[step_name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_run_outcome] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_run_datetime] [datetime2] NULL
) ON [PRIMARY]
GO
