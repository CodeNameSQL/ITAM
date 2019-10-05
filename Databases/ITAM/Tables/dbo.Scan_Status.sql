CREATE TABLE [dbo].[Scan_Status]
(
[Scan_Status_Id] [tinyint] NOT NULL,
[Scan_Status_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Scan_Status_Desc] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Scan_Status] ADD CONSTRAINT [PK__Scan_Sta__FDDCFCA568B592F2] PRIMARY KEY CLUSTERED  ([Scan_Status_Id]) ON [PRIMARY]
GO
