CREATE TABLE [dbo].[SQL_Error_Logs]
(
[Asset_ID] [int] NULL,
[Logdate] [datetime2] NULL,
[ProcessInfo] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorLogText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
