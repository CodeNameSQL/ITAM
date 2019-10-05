#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Update-DBAScripts {
    <#
    .SYNOPSIS
        Updates defined scripts against system.
  
    .DESCRIPTION
        Runs an asset management analysis against all servers loaded to the Assets Table in ITAM.  
        The scan inludes the gathering hardware configuration, SQL Configurations, and more.
  
    .PARAMETER WhatIf
        Shows what would happen if the command were to run. No actions are actually performed.
    
    .EXAMPLE
        PS C:\> Update-DBAScripts 
            
  #>
  
    begin {

        $sql = "Select
        a.Asset_ID, a.Asset_Name, a.Asset_type from ITAM.dbo.Asset a
        "
    }	
  
    process {
        #Get a list of all servers for the asset scan
        $Servers = Invoke-DbaQuery -ServerInstance Localhost -Database ITAM -Query $sql
    
        #loop through the result set and run the asset scan.
        foreach ($Server in $Servers) {
            #Update sp_Blitz scripts to the latest version
            Invoke-DBAQuery -ServerInstance $Server.Asset_Name -Database DBATools -InputFIle "C:\Development\Asset_Management\SQL_Scripts\sp_Blitz.sql"
            Invoke-DBAQuery -ServerInstance $Server.Asset_Name -Database DBATools -InputFIle "C:\Development\Asset_Management\SQL_Scripts\sp_BlitzFirst.sql"
            Invoke-DBAQuery -ServerInstance $Server.Asset_Name -Database DBATools -InputFIle "C:\Development\Asset_Management\SQL_Scripts\sp_BlitzIndex.sql"
            Invoke-DBAQuery -ServerInstance $Server.Asset_Name -Database DBATools -InputFIle "C:\Development\Asset_Management\SQL_Scripts\sp_BlitzWho.sql"
        }
    }
  }