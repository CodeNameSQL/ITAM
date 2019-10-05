#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-ErrorLogInfo {
    <#
    .SYNOPSIS
        Pulls back ErrorLog data from the SQL Server Instance.
  
    .DESCRIPTION
        This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script
  
    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Get-ErrorLogInfo -AssetID 1000 -AssetName LocalHost -AssetType 1
        Returns the currect errorlog records against the local system sql instance.
                
  #>
  
    [CmdletBinding()]
    param (
        [object[]]$AssetID,
        [object[]]$AssetName,
        [object[]]$AssetType
    )
  
    begin {

        Invoke-DBAQuery -ServerInstance $AssetName -Database ITAM_Utils -InputFIle "C:\Development\ITAM\SQL_Scripts\ReadErrorLogs_Proc.sql"

        $sql ="
        EXEC dbo.ReadErrorLogs
        "
    }	
  
    process {
        $MyResults = Invoke-DbaQuery -ServerInstance $AssetName -Database Master -Query $sql | Select-Object @{N='Asset_ID';E={$AssetID}}, Logdate, ProcessInfo, ErrorLogText | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance Localhost -Database ITAM -Table stage.SQL_Error_Logs -AutoCreateTable -Verbose
    }
  }