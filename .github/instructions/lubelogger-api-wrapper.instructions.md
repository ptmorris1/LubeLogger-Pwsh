---
description: "Use when writing PowerShell functions to wrap LubeLogger API endpoints. Covers parameter patterns, authentication, error handling, response formatting, and help documentation following healthchecks-pwsh conventions."
applyTo: "public/**/*.ps1"
name: "LubeLogger API Wrapper Functions"
---

# LubeLogger API Wrapper Function Guidelines

This module follows PowerShell best practices adapted from the **healthchecks-pwsh** module pattern. All functions wrap LubeLogger API endpoints consistently.

## Function Naming Convention
Prefix verb with LL for example Get-LLVehicle
Use approved PowerShell verbs with LubeLogger resource nouns:

| Pattern | Verb | Examples |
|---------|------|----------|
| **Query/Retrieve** | Get- | `Get-Vehicle`, `Get-MaintenanceRecord`, `Get-FuelEvent`, `Get-Reminder` |
| **Create** | New- | `New-Vehicle`, `New-MaintenanceRecord`, `New-Reminder` |
| **Update** | Set- | `Set-Vehicle`, `Set-MaintenanceRecord`, `Set-Reminder` |
| **Delete** | Remove- | `Remove-Vehicle`, `Remove-MaintenanceRecord`, `Remove-Reminder` |

**Note:** Always use singular resource names (Vehicle, not Vehicles).

## Mandatory Parameters (All Functions)

Every function **must** have `$BaseUrl` and **one** authentication parameter set — either `$ApiKey` **or** `$Credential` (`[PSCredential]`). Never require both.

```powershell
[CmdletBinding(DefaultParameterSetName = 'ApiKey')]
param(
    [Parameter(Mandatory)]
    [string]$BaseUrl,   # LubeLogger base URL (e.g., https://lulogger.domain.com)
    
    # Authentication: API Key OR PSCredential (one set is required)
    [Parameter(Mandatory, ParameterSetName = 'ApiKey')]
    [string]$ApiKey,
    
    [Parameter(Mandatory, ParameterSetName = 'Credential')]
    [PSCredential]$Credential,
    
    # ... function-specific parameters follow
)
```

Use `ParameterSetName` to enforce mutual exclusivity. The caller provides `$ApiKey` **or** `$Credential`, never both.

## Optional Parameters

Use explicit type declarations for clarity:

```powershell
[string]$VehicleId,      # IDs as strings
[string]$VehicleName,    # Single values
[string[]]$Tags,         # Arrays use [type[]]
[int]$Limit,             # Integers for numeric values
[bool]$Active,           # Booleans with PSBoundParameters check
[switch]$IncludeArchived # Switches for flags
```

For optional **boolean** parameters, use `$PSBoundParameters` to distinguish explicit `$false` from not-provided:

```powershell
if ($PSBoundParameters.ContainsKey('Active')) {
    $body.active = $Active
}
```

## Function Header - Comment-Based Help

Every function requires this help structure:

```powershell
<#
.SYNOPSIS
    [One-line description of what the function does]

.DESCRIPTION
    [Detailed explanation. Include what resource is affected and the outcome.]
    
    [Add any important context about LubeLogger behavior or API limitations.]

.PARAMETER BaseUrl
    The base URL of the LubeLogger instance (e.g., https://lulogger.domain.com).

.PARAMETER ApiKey
    The LubeLogger API key for authentication. Use this OR Credential, not both.

.PARAMETER Credential
    PSCredential used for Basic authentication. Use this instead of ApiKey.

.PARAMETER VehicleId
    [Resource-specific description]

.EXAMPLE
    # Using API Key
    Get-Vehicle -ApiKey "your-key" -BaseUrl "https://lulogger.domain.com" -VehicleId "123"
    
    Returns the vehicle with ID 123 using API key auth.

.EXAMPLE
    # Using Basic Auth
    $creds = Get-Credential -UserName "your-username"
    Get-Vehicle -Credential $creds -BaseUrl "https://lulogger.domain.com" -VehicleId "123"
    
    Returns the vehicle with ID 123 using Basic auth.

.OUTPUTS
    PSCustomObject with [properties] and [Success] properties.

.NOTES
    [Important usage notes, rate limits, authentication requirements, or caveats]
#>
```

**Key points:**
- Help examples must be realistic and executable
- Always document output structure
- Include authentication caveats in NOTES

## BaseUrl Normalization

Always normalize the BaseUrl to prevent double-slash issues:

```powershell
# Ensure BaseUrl does not end with a slash
$base = $BaseUrl.TrimEnd('/')

# Build endpoint URL
$url = "$base/api/reminders"           # Endpoint example
$url = "$base/api/vehicles/$VehicleId" # With resource ID
```

## Authentication

LubeLogger supports two authentication methods. Each function accepts **either** an API key **or** a PSCredential — never both at the same time. Use `ParameterSetName` to enforce this.

### API Key Authentication

```powershell
if ($PSCmdlet.ParameterSetName -eq 'ApiKey') {
    $headers = @{ 'X-Api-Key' = $ApiKey }
}
```

Preferred for automation. API keys are more secure, easier to rotate, and recommended for API integrations per LubeLogger docs.

### Basic Auth (PSCredential)

```powershell
if ($PSCmdlet.ParameterSetName -eq 'Credential') {
    $username = $Credential.UserName
    $password = $Credential.GetNetworkCredential().Password
    $base64Creds = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${username}:${password}"))
    $headers = @{ 'Authorization' = "Basic $base64Creds" }
}
```

Use for instances that rely on local username/password login. **Not recommended for SSO users.**

## User-Agent Header

Every request must include a dynamic User-Agent:

```powershell
$pwshVersion = $PSVersionTable.PSVersion.ToString()
$userAgent = "LubeLoggerPwsh/$pwshVersion"
```

This tracks API usage and PowerShell version distribution.

## API Request - Two Patterns

### Pattern A: Authenticated Endpoints (Most LubeLogger calls)

```powershell
try {
    $response = Invoke-WebRequest -Uri $url `
        -Headers $headers `
        -UserAgent $userAgent `
        -Method Get `
        -ErrorAction Stop
    
    # Process response...
    
} catch {
    # Handle error...
}
```


For endpoints with filters (e.g., `GET /api/reminders?active=true`):

```powershell
$query = @()
if ($Active) { $query += "active=$($Active.ToString().ToLower())" }
if ($Limit) { $query += "limit=$Limit" }
    $url += "?" + ($query -join '&')
}
```

### Pattern C: POST/PUT with JSON Body

```powershell
$body = @{}
if ($PSBoundParameters.ContainsKey('VehicleName')) { 
    $body.name = $VehicleName 
}
if ($PSBoundParameters.ContainsKey('Make')) { 
    $body.make = $Make 
}

$jsonBody = $body | ConvertTo-Json -Depth 5

$response = Invoke-WebRequest -Uri $url `
    -Headers $headers `
        ## API Request Patterns
    -UserAgent $userAgent `
    -Method Post `
    -Body $jsonBody `
    -ContentType 'application/json' `
    -ErrorAction Stop
```

## Response Handling - Success Path

    ## Authentication
```powershell
# Status code mapping
$statusMsg = switch ($response.StatusCode) {
    200 { "The request succeeded" }
    201 { "Resource created successfully" }
    204 { "Request succeeded, no content" }
    400 { "The request is malformed or invalid parameters" }
    401 { "The API key is missing or invalid" }
    403 { "Access denied with the provided API key" }
    404 { "The specified resource does not exist" }
    429 { "Rate limit exceeded, retry later" }
    500 { "LubeLogger server error" }
    default { "Unknown response status" }
}

# Parse JSON response
$body = $null
try {
    $body = $response.Content | ConvertFrom-Json
    
    # Handle different response structures
    if ($body -is [System.Collections.IEnumerable] -and $body -isnot [string]) {
        $result = $body  # Array of resources
    } else {
        $result = $body  # Single resource object
    }
} catch {
    $result = $response.Content  # Fallback to raw content
}
```

## Response Handling - Error Path

```powershell
catch {
    $status = $null
    $statusMsg = $null
    
    # Extract HTTP status from exception
    if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
        $status = $_.Exception.Response.StatusCode.value__
        $statusMsg = switch ($status) {
            401 { "The API key is missing or invalid" }
            403 { "Access denied, check API key permissions" }
            404 { "The specified resource does not exist" }
            429 { "Rate limit exceeded, retry later" }
            500 { "LubeLogger server error" }
            default { $_.Exception.Message }
        }
        
        # Attempt to parse error details from response body
        try {
            $stream = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $errorBody = $reader.ReadToEnd() | ConvertFrom-Json
            $result = $errorBody
        } catch {
            $result = $null
        }
    } else {
        $statusMsg = $_.Exception.Message
        $result = $null
    }
}
```

## Output Object Format

All functions return a consistent PSCustomObject structure:

### GET Single Resource
```powershell
[PSCustomObject]@{
    Url            = $url
    StatusCode     = $response.StatusCode
    StatusMessage  = $statusMsg
    Vehicle        = $result          # Resource name varies
    Success        = ($response.StatusCode -eq 200)
}
```

### GET Collection/List
```powershell
[PSCustomObject]@{
    Url            = $url
    StatusCode     = $response.StatusCode
    StatusMessage  = $statusMsg
    Vehicles       = $result          # Plural, matches collection
    Success        = ($response.StatusCode -eq 200)
}
```

### POST/PUT (Create/Update)
```powershell
[PSCustomObject]@{
    Url            = $url
    StatusCode     = $response.StatusCode
    StatusMessage  = $statusMsg
    Vehicle        = $result
    Success        = ($response.StatusCode -in @(200, 201))
}
```

### DELETE
```powershell
[PSCustomObject]@{
    Url              = $url
    StatusCode       = $response.StatusCode
    StatusMessage    = $statusMsg
    DeletedVehicle   = $result  # Prefix with "Deleted"
    Success          = ($response.StatusCode -eq 200)
}
```

### Simple Actions (Enable/Disable/Refresh)
```powershell
[PSCustomObject]@{
    Url            = $url
    StatusCode     = $response.StatusCode
    StatusMessage  = $statusMsg
    Success        = ($response.StatusCode -eq 200)
}
```

**Key rule:** Always include `Success`, `StatusCode`, `StatusMessage`, and `Url` in every response object.

## Error Handling Principles

1. **Always use `-ErrorAction Stop`** on `Invoke-WebRequest` to catch HTTP errors
2. **Never suppress errors silently** — return them in the output object
3. **Provide actionable status messages** for common HTTP codes (401, 403, 404, 429)
4. **Parse error response bodies** when available to provide detailed feedback
5. **Fall back gracefully** if JSON parsing fails (return raw content)

## Module Structure

```
LubeLogger-Pwsh/
├── LubeLoggerPwsh.psd1         # Module manifest
├── LubeLoggerPwsh.psm1         # Dot-sources public functions
├── .github/
│   └── instructions/           # This file
└── public/
    ├── Get-Vehicle.ps1         # Query functions
    ├── Get-Reminder.ps1
    ├── New-Vehicle.ps1         # Create functions
    ├── Set-Vehicle.ps1         # Update functions
    └── Remove-Vehicle.ps1      # Delete functions
```

## Module Manifest (.psd1) Structure

```powershell
@{
    ModuleVersion          = '1.0.0'
    Guid                   = '[unique-guid]'
    CompanyName            = 'Your Name'
    Author                 = 'Your Name'
    RootModule             = 'LubeLoggerPwsh.psm1'
    PowerShellVersion      = '7.5'
    CompatiblePSEditions   = @('Core')  # PowerShell Core only
    Description            = 'PowerShell wrapper for the LubeLogger API'
    AliasesToExport        = '*'
    FileList               = @('LubeLoggerPwsh.psm1', 'LubeLoggerPwsh.psd1')
    
    PrivateData = @{
        PSData = @{
            Tags = 'Windows', 'LubeLogger', 'PowerShell', 'PSEdition_Core', 'API'
            ProjectURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh'
            LicenseURI   = 'https://github.com/ptmorris1/LubeLogger-Pwsh/blob/main/LICENSE'
            ReleaseNotes = 'Initial release'
        }
    }
}
```

## Module File (.psm1) - Auto-Loading Pattern

```powershell
# Dot source all public functions
Get-ChildItem -Path "$PSScriptRoot\public\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName
}
```

This auto-loads all functions in `public/` without explicit exports.

## Testing Your Functions

Before committing, test each function with:

```powershell
# Import the module
Import-Module ./LubeLoggerPwsh.psd1

# Test with API Key
$result = Get-Reminder -ApiKey "test-key" -BaseUrl "https://lulogger.domain.com"
$result | Format-List  # Verify output structure

# Test with Basic Auth
$creds = Get-Credential -UserName "your-username"
$result = Get-Reminder -Credential $creds -BaseUrl "https://lulogger.domain.com"
$result | Format-List
```

Verify:
- ✅ All mandatory parameters are required
- ✅ Output object has `Success`, `StatusCode`, `StatusMessage`, `Url`
- ✅ Help examples are realistic
- ✅ Error handling returns proper PSCustomObject (never throws)

## Key Principles

1. **Consistency over cleverness** — match the healthchecks-pwsh patterns exactly
2. **Explicit > implicit** — always name parameters and properties clearly
3. **Fail gracefully** — always return PSCustomObject, never throw
4. **Document thoroughly** — help includes realistic examples
5. **Test authentication early** — verify API key handling before building complex functions
