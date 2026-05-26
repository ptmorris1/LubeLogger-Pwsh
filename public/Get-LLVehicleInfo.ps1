function Get-LLVehicleInfo {
<#
.SYNOPSIS
    Gets extended vehicle information from the LubeLogger API.

.DESCRIPTION
    Calls the /api/vehicle/info endpoint and returns the response content in a
    consistent PSCustomObject wrapper. Authentication supports either ApiKey or
    PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this OR ApiKey, not both.

.PARAMETER VehicleId
    Optional. Vehicle ID to filter vehicle info to a specific vehicle.

.EXAMPLE
    Get-LLVehicleInfo -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key"

    Returns vehicle info using API key authentication.

.EXAMPLE
    $creds = Get-Credential -UserName "your-username"
    Get-LLVehicleInfo -BaseUrl "https://lulogger.domain.com" -Credential $creds

    Returns vehicle info using Basic authentication.

.EXAMPLE
    Get-LLVehicleInfo -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key" -VehicleId "123"

    Returns vehicle info for vehicle ID 123.

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

        [Parameter()]
        [string]$VehicleId
    )

    $base = $BaseUrl.TrimEnd('/')
    $url = "$base/api/vehicle/info"

    $query = @()
    if ($PSBoundParameters.ContainsKey('VehicleId')) {
        $encodedVehicleId = [System.Net.WebUtility]::UrlEncode($VehicleId)
        $query += "vehicleId=$encodedVehicleId"
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

        $vehicleInfo = $null
        try {
            $vehicleInfo = $response.Content | ConvertFrom-Json
        } catch {
            $vehicleInfo = $response.Content
        }

        [PSCustomObject]@{
            Url           = $url
            StatusCode    = $response.StatusCode
            StatusMessage = 'The request succeeded'
            VehicleInfo   = $vehicleInfo
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
            VehicleInfo   = $null
            Success       = $false
        }
    }
}