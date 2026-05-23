function Get-LLCalendar {
<#
.SYNOPSIS
    Gets the vehicle maintenance calendar from the LubeLogger API in ICS format.

.DESCRIPTION
    Calls the /api/calendar endpoint and returns the response as an ICS calendar string.
    Optionally saves the ICS content to a file if -OutputPath is provided.
    Authentication supports either ApiKey or PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this instead of ApiKey.

.PARAMETER OutputPath
    Optional. File path to save the ICS content (e.g. C:\calendar\lubelogger.ics).
    If not provided the ICS content is returned in the output object.

.EXAMPLE
    Get-LLCalendar -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key"

    Returns the calendar ICS content in the output object.

.EXAMPLE
    Get-LLCalendar -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key" -OutputPath "C:\calendar\lubelogger.ics"

    Saves the calendar ICS file to the specified path.

.EXAMPLE
    $creds = Get-Credential
    Get-LLCalendar -BaseUrl "https://lulogger.domain.com" -Credential $creds -OutputPath "C:\calendar\lubelogger.ics"

    Saves the calendar ICS file using Basic authentication.

.OUTPUTS
    PSCustomObject with Url, StatusCode, StatusMessage, CalendarData, OutputPath, and Success properties.

.NOTES
    The ICS file can be imported into calendar applications such as Outlook, Google Calendar, or Apple Calendar.
#>
    [CmdletBinding(DefaultParameterSetName = 'ApiKey')]
    param(
        [Parameter(Mandatory)]
        [string]$BaseUrl,

        [Parameter(Mandatory, ParameterSetName = 'ApiKey')]
        [string]$ApiKey,

        [Parameter(Mandatory, ParameterSetName = 'Credential')]
        [PSCredential]$Credential,

        [Parameter()]
        [string]$OutputPath
    )

    $base = $BaseUrl.TrimEnd('/')
    $url = "$base/api/calendar"

    $pwshVersion = $PSVersionTable.PSVersion.ToString()
    $userAgent = "LubeLoggerPwsh/$pwshVersion"

    if ($PSCmdlet.ParameterSetName -eq 'ApiKey') {
        $headers = @{ 'X-Api-Key' = $ApiKey }
    } else {
        $username = $Credential.UserName
        $password = $Credential.GetNetworkCredential().Password
        $base64Creds = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${username}:${password}"))
        $headers = @{ 'Authorization' = "Basic $base64Creds" }
    }

    try {
        $response = Invoke-WebRequest -Uri $url `
            -Headers $headers `
            -UserAgent $userAgent `
            -Method Get `
            -ErrorAction Stop

        $calendarData = $response.Content
        $savedPath = $null
        if ($PSBoundParameters.ContainsKey('OutputPath')) {
            $resolvedDir = Split-Path -Path $OutputPath -Parent
            if ($resolvedDir -and -not (Test-Path $resolvedDir)) {
                New-Item -ItemType Directory -Path $resolvedDir -Force | Out-Null
            }
            Set-Content -Path $OutputPath -Value $calendarData -Encoding utf8 -NoNewline
            $savedPath = (Resolve-Path $OutputPath).Path
        }

        [PSCustomObject]@{
            Url           = $url
            StatusCode    = $response.StatusCode
            StatusMessage = 'The request succeeded'
            CalendarData  = if ($savedPath) { $null } else { $calendarData }
            OutputPath    = $savedPath
            Success       = ($response.StatusCode -eq 200)
        }
    } catch {
        $statusCode = $null
        $statusMessage = $_.Exception.Message

        if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusMessage = switch ($statusCode) {
                401 { 'Authentication failed: API key or username/password is invalid.' }
                403 { 'Access denied for supplied credentials.' }
                404 { 'Endpoint not found.' }
                default { $_.Exception.Message }
            }
        }

        [PSCustomObject]@{
            Url           = $url
            StatusCode    = $statusCode
            StatusMessage = $statusMessage
            CalendarData  = $null
            OutputPath    = $null
            Success       = $false
        }
    }
}
