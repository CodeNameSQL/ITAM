CREATE TABLE [dbo].[Asset_Types]
(
[Asset_Type] [tinyint] NOT NULL,
[Asset_Type_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Asset_Type_Desc] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asset_Types] ADD CONSTRAINT [PK__Asset_Ty__A79C1AB43CEF953E] PRIMARY KEY CLUSTERED  ([Asset_Type]) ON [PRIMARY]
GO
