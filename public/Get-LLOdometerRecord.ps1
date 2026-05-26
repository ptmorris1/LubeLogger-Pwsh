function Get-LLOdometerRecord {
<#
.SYNOPSIS
    Gets odometer records from the LubeLogger API.

.DESCRIPTION
    Calls /api/vehicle/odometerrecords/all and returns odometer records for all vehicles
    with optional filtering by record Id, StartDate, EndDate, and Tags.
    Authentication supports either ApiKey or PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this instead of ApiKey.

.PARAMETER Id
    Optional. Filter odometer records by the specific record ID.

.PARAMETER StartDate
    Optional. Minimum date for records.

.PARAMETER EndDate
    Optional. Maximum date for records.

.PARAMETER Tags
    Optional. Filter odometer records by one or more tags.

.EXAMPLE
    Get-LLOdometerRecord -BaseUrl "https://car.phunky1.com" -Credential $creds

    Returns odometer records for all vehicles using Basic authentication.

.EXAMPLE
    Get-LLOdometerRecord -BaseUrl "https://car.phunky1.com" -Credential $creds -Tags "maintenance", "trip"

    Returns odometer records filtered by tags.

.EXAMPLE
    Get-LLOdometerRecord -BaseUrl "https://car.phunky1.com" -Credential $creds -StartDate "2026-01-01" -EndDate "2026-01-31"

    Returns odometer records in the provided date range.

.OUTPUTS
    PSCustomObject with Url, StatusCode, StatusMessage, OdometerRecords, and Success properties.

.NOTES
    Credential auth is not supported for SSO users.
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
        [string]$StartDate,

        [Parameter()]
        [string]$EndDate,

        [Parameter()]
        [string[]]$Tags
    )

    $base = $BaseUrl.TrimEnd('/')
    $url = "$base/api/vehicle/odometerrecords/all"

    $query = @()

    if ($PSBoundParameters.ContainsKey('Id')) {
        $query += "id=$([System.Net.WebUtility]::UrlEncode($Id))"
    }

    if ($PSBoundParameters.ContainsKey('StartDate')) {
        $query += "startDate=$([System.Net.WebUtility]::UrlEncode($StartDate))"
    }

    if ($PSBoundParameters.ContainsKey('EndDate')) {
        $query += "endDate=$([System.Net.WebUtility]::UrlEncode($EndDate))"
    }

    if ($PSBoundParameters.ContainsKey('Tags')) {
        foreach ($tag in $Tags) {
            $query += "tags=$([System.Net.WebUtility]::UrlEncode($tag))"
        }
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

        $odometerRecords = $null
        try {
            $odometerRecords = $response.Content | ConvertFrom-Json
        } catch {
            $odometerRecords = $response.Content
        }

        [PSCustomObject]@{
            Url            = $url
            StatusCode     = $response.StatusCode
            StatusMessage  = 'The request succeeded'
            OdometerRecords = $odometerRecords
            Success        = ($response.StatusCode -eq 200)
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
            Url            = $url
            StatusCode     = $statusCode
            StatusMessage  = $statusMessage
            OdometerRecords = $null
            Success        = $false
        }
    }
}
