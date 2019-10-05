If OBJECT_ID('dbo.ReadErrorLogs') is NULL
    Exec ('Create Procedure dbo.ReadErrorLogs as Return 0;')
GO

Alter procedure dbo.ReadErrorLogs
as 

BEGIN
    Declare @sql nvarchar(2000)
    if EXISTS ( select *
                from ITAM_Utils.dbo.sysobjects
                where id = OBJECT_ID(N'ITAM_Utils.dbo.ErrorLog')
              )
                
    Drop Table ITAM_Utils.dbo.Errorlog;

    Create Table ITAM_Utils.dbo.ErrorLog
    (
        LogDate DateTime not null,
        ProcessInfo NVARCHAR(50),
        ErrorLogText NVARCHAR(max)
    )

    Insert Into ITAM_Utils.dbo.ErrorLog
    (
            LogDate,
            ProcessInfo,
            ErrorLogText
    )
    Exec sp_readErrorLog 0
    
    Select Logdate, ProcessInfo, ErrorLogText from ITAM_Utils.dbo.Errorlog
End