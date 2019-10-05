SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
=========================================================================================================
Author:		Higginbotham, Joshua
Create date: 05/01/2019
Description:	Removes all records from staging tables prior to Asset Scan
Changes:
	Date		Developer				Notes
=========================================================================================================

=========================================================================================================
=========================================================================================================
*/

CREATE PROCEDURE [dbo].[Cleanup_Staging_Tables]
AS
BEGIN
	TRUNCATE TABLE stage.Server_Updates
	TRUNCATE TABLE stage.SQL_Database_Info
	TRUNCATE TABLE stage.SQL_Instance_Info
	TRUNCATE TABLE stage.SQL_Job_Info
	TRUNCATE TABLE stage.SQL_Resource_Info
    TRUNCATE TABLE stage.SQL_Error_Logs
    TRUNCATE TABLE stage.Server_Drive_Space
END;
GO
