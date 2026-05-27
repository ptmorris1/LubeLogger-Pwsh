---
icon: lucide/circle-play
---

# Get started

LubeLogger-Pwsh is a PowerShell module for working with the LubeLogger API from scripts, terminals, and automation workflows.

## What is LubeLogger?

[LubeLogger](https://lubelogger.com) is a vehicle maintenance and record-keeping platform. It helps track vehicles, odometer history, reminders, and service-related data through both a web interface and an API.

## What this module provides

- PowerShell commands for common LubeLogger API operations
- Consistent authentication support for API key and credential-based flows
- Command patterns that make API usage easier in scripts and automation

!!! note

    The module currently covers core read scenarios first (for example vehicles, reminders, odometer data, and calendar output), with additional endpoint coverage expanding over time.

- See release history on [CHANGELOG.md](CHANGELOG.md)

## Quick start example

```powershell
$creds = Get-Credential
Get-LLVehicle -BaseUrl "https://lubelogger.domain.com" -Credential $creds
```
