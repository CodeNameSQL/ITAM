CREATE TABLE [dbo].[Server_Updates]
(
[Asset_ID] [int] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HotFixID] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InstalledBy] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InstalledOn] [datetime2] NULL
) ON [PRIMARY]
GO
