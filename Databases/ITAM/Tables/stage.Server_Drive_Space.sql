CREATE TABLE [stage].[Server_Drive_Space]
(
[Asset_ID] [int] NULL,
[DeviceID] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DriveType] [bigint] NULL,
[VolumeName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Capacity] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FreeSpaceGB] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
