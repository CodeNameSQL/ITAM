#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-DiskDriveSpace {
    <#
    .SYNOPSIS
        Pulls back Drive space info against a server.

    .DESCRIPTION
        This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script

    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Get-DiskDriveSpace -AssetID 1000 -AssetName LocalHost -AssetType 1
                Runs a disk space check against the local system, with a type of SQL server
	#>

    [CmdletBinding()]
    param (
        [object[]]$AssetID,
        [object[]]$AssetName,
        [object[]]$AssetType
    )
		
    process {
        $MyResults = Get-WmiObject -ComputerName $AssetName -Class Win32_logicaldisk -Filter "DriveType = '3'" |
        Select-Object -Property @{N='Asset_ID';E={$AssetID}}, DeviceID, DriveType, VolumeName, 
        @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}},
        @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}} | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance Localhost -Database ITAM -Table stage.Server_Drive_Space -AutoCreateTable -Verbose
    }
}