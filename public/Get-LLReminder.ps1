function Get-LLReminder {
<#
.SYNOPSIS
    Gets reminders from the LubeLogger API.

.DESCRIPTION
    Calls the /api/reminders/all endpoint and returns reminders with optional filtering
    by vehicle ID, tags, or urgency levels. Authentication supports either ApiKey or
    PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this instead of ApiKey.

.PARAMETER Id
    Optional. Filter reminders by vehicle ID.

.PARAMETER Tags
    Optional. Filter reminders by one or more tags.

.PARAMETER Urgencies
    Optional. Filter reminders by urgency level.

.EXAMPLE
    Get-LLReminder -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key"

    Returns all reminders using API key authentication.

.EXAMPLE
    $creds = Get-Credential -UserName "your-username"
    Get-LLReminder -BaseUrl "https://lulogger.domain.com" -Credential $creds

    Returns all reminders using Basic authentication.

.EXAMPLE
    Get-LLReminder -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key" -Id "123"

    Returns reminders for vehicle ID 123.

.EXAMPLE
    Get-LLReminder -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key" -Urgencies "Urgent"

    Returns reminders with High urgency level.

.OUTPUTS
    PSCustomObject with Url, StatusCode, StatusMessage, Reminders, and Success properties.

.NOTES
    Supports optional filtering via Id, Tags, and Urgencies parameters.
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
        [string]$Id,

        [Parameter()]
        [string[]]$Tags,

        [Parameter()]
        [ValidateSet('NotUrgent', 'VeryUrgent', 'Urgent', 'PastDue')]
        [string]$Urgencies
    )

    $base = $BaseUrl.TrimEnd('/')
    
    # Build URL with optional vehicle ID
    if ($PSBoundParameters.ContainsKey('Id')) {
        $url = "$base/api/vehicles/$Id/reminders/all"
    } else {
        $url = "$base/api/vehicle/reminders/all"
    }

    # Add optional query parameters
    $query = @()
    if ($PSBoundParameters.ContainsKey('Tags')) {
        foreach ($tag in $Tags) {
            $query += "tags=$([System.Net.WebUtility]::UrlEncode($tag))"
        }
    }
    if ($PSBoundParameters.ContainsKey('Urgencies')) {
        $query += "urgencies=$([System.Net.WebUtility]::UrlEncode($Urgencies))"
    }
    
    if ($query.Count -gt 0) {
        $url += "?" + ($query -join '&')
    }

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

        $reminders = $null
        try {
            $reminders = $response.Content | ConvertFrom-Json
        } catch {
            $reminders = $response.Content
        }

        [PSCustomObject]@{
            Url           = $url
            StatusCode    = $response.StatusCode
            StatusMessage = 'The request succeeded'
            Reminders     = $reminders
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
            Reminders     = $null
            Success       = $false
        }
    }
}
