CREATE TABLE [stage].[SQL_Resource_Info]
(
[Asset_ID] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MaxMemorySetting(MB)] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhysicalServerMemory(MB)] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RemainingMemory(MB)] [bigint] NULL,
[CPUCount] [int] NULL,
[LastReboot] [datetime2] NULL,
[DaysUp] [int] NULL
) ON [PRIMARY]
GO
