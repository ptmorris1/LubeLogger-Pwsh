@{
    ModuleVersion          = '1.0.0'
    Guid                   = '12345678-1234-1234-1234-123456789012'
    CompanyName            = 'Your Organization'
    Author                 = 'Your Name'
    Copyright              = '2026 Your Organization'
    RootModule             = 'LubeLoggerPwsh.psm1'
    PowerShellVersion      = '7.5'
    CompatiblePSEditions   = @('Core')
    Description            = 'PowerShell wrapper for the LubeLogger API'
    AliasesToExport        = '*'
    FileList               = @(
        'LubeLoggerPwsh.psm1',
        'LubeLoggerPwsh.psd1',
        'public/Get-LLVehicle.ps1',
        'public/Get-LLReminder.ps1'
    )
    
    PrivateData = @{
        PSData = @{
            Tags = 'Windows', 'LubeLogger', 'PowerShell', 'PSEdition_Core', 'API'
            ProjectURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh'
            LicenseURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh/blob/main/LICENSE'
            ReleaseNotes = @'
# v1.0.0 - Initial Release
- Get-LLReminder: Retrieve reminders with optional filtering by vehicle ID, tags, or urgency levelsh
- Initialize-ApiRequest: Internal helper for consistent authentication
'@
        }
    }
}
