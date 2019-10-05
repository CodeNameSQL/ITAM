#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Start-ServerAssetScan {
    <#
    .SYNOPSIS
        Runs the Asset analysis against all servers listed as an Asset.

    .DESCRIPTION
        Runs an asset management analysis against all servers loaded to the Assets Table in ITAM.  
        The scan inludes the gathering hardware configuration, SQL Configurations, and more.

    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Start-ServerAssetScan 
                Runs a scan against all systems listed in the Assets Table
    #>

    begin{
        $CleanUpSQL = "
            Exec ITAM.dbo.Cleanup_Staging_Tables
        "

        $sql = "Select
        a.Asset_ID, a.Asset_Name, a.Asset_type from ITAM.dbo.Asset a where a.Asset_Name <> 'Dev-Server1'
        "

    }

    process{
    #Clean up old records in the staging location prior to next asset scan    
    Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $CleanUpSQL

    #Get a list of all servers for the asset scan
    $Servers = Invoke-DbaQuery -ServerInstance Localhost -Database ITAM -Query $sql

    #Set Asset status to runnin
    
    #loop through the result set and run the asset scan.
    foreach ($Server in $Servers) {

        try {
                Get-ServerResourceInfo -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop              
            }

        try {
                Get-InstalledUpdates -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop 
            } 

        try {
                Get-DatabaseConfigurationInfo -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop  
            } 

        try {
                Get-SQLAgentJobStatus -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop 
            } 

        try {
                Get-ErrorLogInfo -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop 
            } 

        try {
                Get-DiskDriveSpace -AssetID $Server.Asset_ID -AssetName $Server.Asset_Name $Server.Asset_type
            } catch {
                $ErrorMessage = $_.Exception.Message
                Invoke-DbaQuery -SqlInstance Localhost -Database ITAM -Query $UpdateToFailed
                Write-Error -Message $ErrorMessage -ErrorAction Stop 
            }  
        } 
    }
}