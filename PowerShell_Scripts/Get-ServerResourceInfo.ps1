#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-ServerResourceInfo {
    <#
    .SYNOPSIS
        Runs the Asset analysis against all servers listed as an Asset.

    .DESCRIPTION
        This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script

    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Get-ServerResourceInfo -AssetID 1000 -AssetName LocalHost -AssetType 1
                
	#>

    [CmdletBinding()]
    param (
        [object[]]$AssetID,
        [object[]]$AssetName,
        [object[]]$AssetType
    )
	
    begin {
        $sql = "
			Begin
			SELECT '$AssetID' as 'Asset_ID',
	  			 CAST(c.value_in_use AS VARCHAR(20)) AS 'MaxMemorySetting(MB)',
       			 CAST((CAST(m.total_physical_memory_kb AS BIGINT) / 1024) AS VARCHAR(20)) AS 'PhysicalServerMemory(MB)',
	   			 (CAST(m.total_physical_memory_kb AS BIGINT) / 1024) - CAST(c.value_in_use AS BIGINT) AS 'RemainingMemory(MB)',
	   			 d.cpu_count AS 'CPUCount',
	   			 d.sqlserver_start_time AS 'LastReboot',
	   			 DATEDIFF(DAY,d.sqlserver_start_time,GETDATE()) AS 'DaysUp'
			FROM sys.dm_os_sys_memory m
    			INNER JOIN sys.configurations c
        			ON c.name = 'max server memory (MB)'
				INNER JOIN sys.dm_os_sys_info d
					ON d.cpu_count <> 0
			End
			"
    }	
	
    process {
        $MyResults = Invoke-DbaQuery -ServerInstance $AssetName -Database Master -Query $sql | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance Localhost -Database ITAM -Table stage.SQL_Resource_Info -AutoCreateTable -Verbose
    }
}