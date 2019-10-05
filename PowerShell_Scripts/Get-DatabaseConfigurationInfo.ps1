#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-DatabaseConfigurationInfo {
    <#
    .SYNOPSIS
        Returns database configuration info for the system.

    .DESCRIPTION
        This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script

    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Get-DatabaseConfigurationInfo -AssetID 1000 -AssetName LocalHost -AssetType 1
	#>

    [CmdletBinding()]
    param (
        [object[]]$AssetID,
        [object[]]$AssetName,
        [object[]]$AssetType
    )
	
    begin {
        $sql = @"
        SELECT
        $AssetID as 'Asset_ID',  
        SERVERPROPERTY('MachineName') AS MachineName,
        CASE 
            WHEN  SERVERPROPERTY('InstanceName') IS NULL THEN ''
            ELSE SERVERPROPERTY('InstanceName')
        END AS InstanceName,
        '' as Port, --need to update to strip from Servername. Note: Assumes Registered Server is named with Port
        SUBSTRING ( (SELECT @@VERSION),1, CHARINDEX('-',(SELECT @@VERSION))-1 ) as ProductName,
        SERVERPROPERTY('ProductVersion') AS ProductVersion,  
        SERVERPROPERTY('ProductLevel') AS ProductLevel,
        SERVERPROPERTY('ProductMajorVersion') AS ProductMajorVersion,
        SERVERPROPERTY('ProductMinorVersion') AS ProductMinorVersion,
        SERVERPROPERTY('ProductBuild') AS ProductBuild,
        SERVERPROPERTY('Edition') AS Edition,
        CASE SERVERPROPERTY('EngineEdition')
            WHEN 1 THEN 'PERSONAL'
            WHEN 2 THEN 'STANDARD'
            WHEN 3 THEN 'ENTERPRISE'
            WHEN 4 THEN 'EXPRESS'
            WHEN 5 THEN 'SQL DATABASE'
            WHEN 6 THEN 'SQL DATAWAREHOUSE'
        END AS EngineEdition,  
        CASE SERVERPROPERTY('IsHadrEnabled')
            WHEN 0 THEN 'The Always On Availability Groups feature is disabled'
            WHEN 1 THEN 'The Always On Availability Groups feature is enabled'
            ELSE 'Not applicable'
        END AS HadrEnabled,
        CASE SERVERPROPERTY('HadrManagerStatus')
            WHEN 0 THEN 'Not started, pending communication'
            WHEN 1 THEN 'Started and running'
            WHEN 2 THEN 'Not started and failed'
            ELSE 'Not applicable'
        END AS HadrManagerStatus,
        CASE SERVERPROPERTY('IsSingleUser') WHEN 0 THEN 'No' ELSE 'Yes' END AS InSingleUserMode,
        CASE SERVERPROPERTY('IsClustered')
            WHEN 1 THEN 'Clustered'
            WHEN 0 THEN 'Not Clustered'
            ELSE 'Not applicable'
        END AS IsClustered,
        '' as ServerEnvironment,
        '' as ServerStatus,
        '' as Comments
"@
        $sql2 = @"
        SELECT $AssetID as 'Asset_ID',database_id,
CONVERT(VARCHAR(25), DB.name) AS dbName,
CONVERT(VARCHAR(10), DATABASEPROPERTYEX(name, 'status')) AS [Status],
state_desc,
 (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS DataFiles,
 (SELECT SUM((size*8)/1024) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data MB],
 (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS LogFiles,
 (SELECT SUM((size*8)/1024) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log MB],
user_access_desc AS [User access],
recovery_model_desc AS [Recovery model],
CASE compatibility_level
WHEN 60 THEN '60 (SQL Server 6.0)'
WHEN 65 THEN '65 (SQL Server 6.5)'
WHEN 70 THEN '70 (SQL Server 7.0)'
WHEN 80 THEN '80 (SQL Server 2000)'
WHEN 90 THEN '90 (SQL Server 2005)'
WHEN 100 THEN '100 (SQL Server 2008)'
WHEN 110 THEN '110 (SQL Server 2012)'
WHEN 120 THEN '120 (SQL Server 2014)'
WHEN 130 THEN '130 (SQL Server 2016)'
WHEN 140 THEN '140 (SQL Server 2017)'
END AS [compatibility level],
CONVERT(VARCHAR(20), create_date, 103) + ' ' + CONVERT(VARCHAR(20), create_date, 108) AS [Creation date],
-- last backup
ISNULL((SELECT TOP 1
CASE TYPE WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),Backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
CONVERT(VARCHAR(20), backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_start_date, 108) + ' – ' +
CONVERT(VARCHAR(20), backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_finish_date, 108) +
' (' + CAST(DATEDIFF(second, BK.backup_start_date,
BK.backup_finish_date) AS VARCHAR(4)) + ' '
+ 'seconds)'
FROM msdb..backupset BK WHERE BK.database_name = DB.name ORDER BY backup_set_id DESC),'-') AS [Last backup],
CASE WHEN is_fulltext_enabled = 1 THEN 'Fulltext enabled' ELSE '' END AS [fulltext],
CASE WHEN is_auto_close_on = 1 THEN 'autoclose' ELSE '' END AS [autoclose],
page_verify_option_desc AS [page verify option],
CASE WHEN is_read_only = 1 THEN 'read only' ELSE '' END AS [read only],
CASE WHEN is_auto_shrink_on = 1 THEN 'autoshrink' ELSE '' END AS [autoshrink],
CASE WHEN is_in_standby = 1 THEN 'standby' ELSE '' END AS [standby],
CASE WHEN is_cleanly_shutdown = 1 THEN 'cleanly shutdown' ELSE '' END AS [cleanly shutdown] FROM sys.databases DB
WHERE CONVERT(VARCHAR(25), DB.name) NOT IN ('DBAMaintain','Master','Model','MSDB','TempDB')
ORDER BY dbName, [Last backup] DESC, NAME
"@    
    }	
	
    process {
        $MyResults = Invoke-DbaQuery -ServerInstance $AssetName -Database Master -Query $sql | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance localhost -Database ITAM -Table Stage.SQL_Instance_Info -AutoCreateTable -Verbose

        $MyResults = Invoke-DbaQuery -ServerInstance $AssetName -Database Master -Query $sql2 | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance localhost -Database ITAM -Table Stage.SQL_Database_Info -AutoCreateTable -Verbose
    }
}