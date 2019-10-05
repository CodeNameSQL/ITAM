#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-InstalledUpdates {
    <#
    .SYNOPSIS
        Returns all updates against the system.

    .DESCRIPTION
        This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script

    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Get-InstalledUpdates -AssetID 1000 -AssetName LocalHost -AssetType 1
                Runs a check against all installed updates for the local system.
	#>

    [CmdletBinding()]
    param (
        [object[]]$AssetID,
        [object[]]$AssetName,
        [object[]]$AssetType
    )
	
    process {
        $MyResults = Get-HotFix -ComputerName $AssetName | Select-Object @{N='Asset_ID';E={$AssetID}}, Description, HotFixID, InstalledBy, InstalledOn | ConvertTo-DbaDataTable
        Write-DbaDataTable -InputObject $MyResults -SqlInstance Localhost -Database ITAM -Table Stage.Server_Updates -AutoCreateTable -Verbose
    }
}
