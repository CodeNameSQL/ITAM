CREATE TABLE [dbo].[Asset]
(
[Asset_ID] [bigint] NOT NULL IDENTITY(1000, 1),
[Asset_Name] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Asset_Type] [tinyint] NOT NULL,
[Last_Scan_Date] [datetime] NOT NULL,
[Last_Scan_Status_Id] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asset] ADD CONSTRAINT [PK__Assets__991B5946CBE3DCBA] PRIMARY KEY CLUSTERED  ([Asset_ID]) ON [PRIMARY]
GO
