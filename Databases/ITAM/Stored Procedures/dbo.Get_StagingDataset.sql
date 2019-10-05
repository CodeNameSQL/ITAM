SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
=========================================================================================================
Author:		Higginbotham, Joshua
Create date: 05/01/2019
Description:	Return all data from the staging locations for Demo
Changes:
	Date		Developer				Notes
=========================================================================================================

=========================================================================================================
=========================================================================================================
*/

CREATE PROCEDURE [dbo].[Get_StagingDataset]
AS
BEGIN
    SELECT *
    FROM stage.SQL_Resource_Info AS sri;
    SELECT *
    FROM stage.SQL_Instance_Info AS sii;
    SELECT *
    FROM stage.SQL_Database_Info AS sdi;
    SELECT *
    FROM stage.SQL_Job_Info AS sji;
    SELECT *
    FROM stage.Server_Updates AS su;
END;
GO
