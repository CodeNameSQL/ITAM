#ValidationTags#Messaging,FlowControl,Pipeline,CodeStyle#
function Get-SQLAgentJobStatus {
  <#
  .SYNOPSIS
      Runs the Asset analysis against all servers listed as an Asset.

  .DESCRIPTION
      This script is part of the ITAM process and is called by the Start-ServerAssetScan.ps1 script

  .PARAMETER WhatIf
      Shows what would happen if the command were to run. No actions are actually performed.
  
  .EXAMPLE
      PS C:\> Get-SQLAgentJobStatus -AssetID 1000 -AssetName LocalHost -AssetType 1
              Runs a scan against all systems listed in the Assets Table
#>

  [CmdletBinding()]
  param (
      [object[]]$AssetID,
      [object[]]$AssetName,
      [object[]]$AssetType
  )

  begin {
      $sql = "
      select 
      $AssetID as [Asset_Id],
      Getdate() as [RunTime],
      j.job_id,
      j.name,
      js.step_id,
      js.step_name,
      last_run_outcome = case when js.last_run_outcome = 0 then 'Failed'
            when js.last_run_outcome = 1 then 'Succeeded'
            when js.last_run_outcome = 2 then 'Retry'
            when js.last_run_outcome = 3 then 'Canceled'
            else 'Unknown'
           end,
      last_run_datetime = msdb.dbo.agent_datetime(
           case when js.last_run_date = 0 then NULL else js.last_run_date end,
           case when js.last_run_time = 0 then NULL else js.last_run_time end)
    from msdb.dbo.sysjobs j
      inner join msdb.dbo.sysjobsteps js
       on j.job_id = js.job_id;
    "
  }	

  process {
      $MyResults = Invoke-DbaQuery -ServerInstance $AssetName -Database Master -Query $sql | ConvertTo-DbaDataTable
      Write-DbaDataTable -InputObject $MyResults -SqlInstance Localhost -Database ITAM -Table stage.SQL_Job_Info -AutoCreateTable -Verbose
  }
}