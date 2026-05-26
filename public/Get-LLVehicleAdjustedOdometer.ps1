function Get-LLVehicleAdjustedOdometer {
<#
.SYNOPSIS
    Gets adjusted odometer data from the LubeLogger API.

.DESCRIPTION
    Calls the /api/vehicle/adjustedodometer endpoint and returns the response
    content in a consistent PSCustomObject wrapper. Authentication supports
    either ApiKey or PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this OR ApiKey, not both.

.PARAMETER VehicleId
    The numeric vehicle ID to retrieve adjusted odometer data for.

.PARAMETER Odometer
    The numeric odometer value to use when requesting adjusted odometer data.

.EXAMPLE
    Get-LLVehicleAdjustedOdometer -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key" -VehicleId 123 -Odometer 45678

    Returns adjusted odometer data for vehicle 123 and odometer 45678 using API key authentication.

.EXAMPLE
    $creds = Get-Credential -UserName "your-username"
    Get-LLVehicleAdjustedOdometer -BaseUrl "https://lulogger.domain.com" -Credential $creds -VehicleId 123 -Odometer 45678

    Returns adjusted odometer data for vehicle 123 and odometer 45678 using Basic authentication.

.OUTPUTS
    PSCustomObject
#>
    [CmdletBinding(DefaultParameterSetName = 'ApiKey')]
    param(
        [Parameter(Mandatory)]
        [string]$BaseUrl,

        [Parameter(Mandatory, ParameterSetName = 'ApiKey')]
        [string]$ApiKey,

        [Parameter(Mandatory, ParameterSetName = 'Credential')]
        [PSCredential]$Credential,

        [Parameter(Mandatory)]
        [int]$VehicleId,

        [Parameter(Mandatory)]
        [int]$Odometer
    )

    $base = $BaseUrl.TrimEnd('/')
    $query = @(
        "vehicleId=$VehicleId"
        "odometer=$Odometer"
    )
    $url = "$base/api/vehicle/adjustedodometer?" + ($query -join '&')

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

        $adjustedOdometer = $null
        try {
            $adjustedOdometer = $response.Content | ConvertFrom-Json
        } catch {
            $adjustedOdometer = $response.Content
        }

        [PSCustomObject]@{
            Url              = $url
            StatusCode       = $response.StatusCode
            StatusMessage    = 'The request succeeded'
            AdjustedOdometer = $adjustedOdometer
            Success          = ($response.StatusCode -eq 200)
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
            Url              = $url
            StatusCode       = $statusCode
            StatusMessage    = $statusMessage
            AdjustedOdometer = $null
            Success          = $false
        }
    }
}