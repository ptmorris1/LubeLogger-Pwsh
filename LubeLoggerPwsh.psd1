@{
    ModuleVersion          = '0.1.0'
    Guid                   = '12345678-1234-1234-1234-123456789012'
    CompanyName            = 'Patrick Morris'
    Author                 = 'Patrick Morris'
    Copyright              = '2026 Patrick Morris'
    RootModule             = 'LubeLoggerPwsh.psm1'
    PowerShellVersion      = '7.5'
    CompatiblePSEditions   = @('Core')
    Description            = 'PowerShell wrapper for the LubeLogger API'
    AliasesToExport        = '*'
    FileList               = @(
        'LubeLoggerPwsh.psm1',
        'LubeLoggerPwsh.psd1',
        'public/ConvertFrom-ICal.ps1',
        'public/Get-LLVehicle.ps1',
        'public/Get-LLReminder.ps1',
        'public/Get-LLCalendar.ps1',
        'public/Get-LLVehicleInfo.ps1',
        'public/Get-LLVehicleAdjustedOdometer.ps1',
        'public/Get-LLOdometerRecord.ps1'
    )
    
    PrivateData = @{
        PSData = @{
            Tags = 'Windows', 'LubeLogger', 'PowerShell', 'PSEdition_Core', 'API'
            ProjectURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh'
            LicenseURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh/blob/main/LICENSE'
            ReleaseNotes = @'
# v0.1.0 - Initial Release
- Get-LLVehicle: Retrieve vehicles from /api/vehicles using ApiKey or Credential authentication.
- Get-LLReminder: Retrieve reminders from /api/vehicle/reminders/all with optional Id, Tags, and Urgencies filters.
- Get-LLCalendar: Retrieve calendar data from /api/calendar with optional OutputPath file save.
- ConvertFrom-ICal: Convert ICS calendar content to PowerShell event objects.
- Get-LLVehicleInfo: Retrieve extended vehicle info from /api/vehicle/info.
- Get-LLVehicleAdjustedOdometer: Retrieve adjusted odometer data from /api/vehicle/adjustedodometer with required VehicleId and Odometer parameters.
- Get-LLOdometerRecord: Retrieve odometer records from /api/vehicle/odometerrecords/all with optional Id, StartDate, EndDate, and Tags filters.
'@
        }
    }
}
