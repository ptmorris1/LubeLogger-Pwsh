function Get-LLVehicle {
<#
.SYNOPSIS
    Gets vehicles from the LubeLogger API.

.DESCRIPTION
    Calls the /api/vehicles endpoint and returns the response content in a consistent
    PSCustomObject wrapper. Authentication supports either ApiKey or PSCredential.

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (for example: https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this OR ApiKey, not both.

.EXAMPLE
    Get-LLVehicle -BaseUrl "https://lulogger.domain.com" -ApiKey "your-api-key"

    Returns all vehicles using API key authentication.

.EXAMPLE
    $creds = Get-Credential -UserName "your-username"
    Get-LLVehicle -BaseUrl "https://lulogger.domain.com" -Credential $creds

    Returns all vehicles using Basic authentication.

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
        [PSCredential]$Credential
    )

    $base = $BaseUrl.TrimEnd('/')
    $url = "$base/api/vehicles"

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

        $vehicles = $null
        try {
            $vehicles = $response.Content | ConvertFrom-Json
        } catch {
            $vehicles = $response.Content
        }

        [PSCustomObject]@{
            Url           = $url
            StatusCode    = $response.StatusCode
            StatusMessage = 'The request succeeded'
            Vehicles      = $vehicles
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
            Vehicles      = $null
            Success       = $false
        }
    }
}
