# LubeLogger PowerShell Module

A PowerShell wrapper for the [LubeLogger](https://github.com/hargata/lubelog) API — a self-hosted vehicle maintenance and fuel tracking application.

> **Disclaimer:** AI assistance (GitHub Copilot) was used to help write documentation and repetitive boilerplate code. All design decisions, implementation direction, and testing were performed by a human.

## About LubeLogger

LubeLogger is a free, open-source web application that helps you track vehicle maintenance, fuel costs, and service history. Learn more at: https://lubelogger.com

## LubeLogger PowerShell Module Features

- Query vehicles and their details
- Retrieve vehicle reminders with filtering by ID, tags, or urgency
- Consistent authentication via API key or Windows credentials
- Structured PowerShell object output for pipeline integration
- Error handling with detailed status messages

## Installation

1. Clone this repository or download the module folder
2. Place the `LubeLogger-Pwsh` folder in your PowerShell modules directory
3. Import the module:

```powershell
Import-Module LubeLoggerPwsh
```

## Quick Start

### Using API Key

```powershell
# Get all vehicles
Get-LLVehicle -BaseUrl "https://your-lubelogger-instance.com" -ApiKey "your-api-key"

# Get all reminders
Get-LLReminder -BaseUrl "https://your-lubelogger-instance.com" -ApiKey "your-api-key"
```

### Using Basic Authentication

```powershell
$creds = Get-Credential
Get-LLVehicle -BaseUrl "https://your-lubelogger-instance.com" -Credential $creds
Get-LLReminder -BaseUrl "https://your-lubelogger-instance.com" -Credential $creds
```

### Filter Reminders

```powershell
# Get reminders for a specific vehicle
Get-LLReminder -BaseUrl "https://your-lubelogger-instance.com" -ApiKey "your-api-key" -Id "123"

# Get urgent reminders
Get-LLReminder -BaseUrl "https://your-lubelogger-instance.com" -ApiKey "your-api-key" -Urgencies "Urgent"
```

## Functions

### Get-LLVehicle
Retrieves vehicle information from LubeLogger.

```powershell
Get-Help Get-LLVehicle -Full
```

### Get-LLReminder
Retrieves vehicle reminders with optional filtering by ID, tags, or urgency level.

```powershell
Get-Help Get-LLReminder -Full
```

## Requirements

- PowerShell 7.5 or later
- Windows, macOS, or Linux
- Network access to a LubeLogger instance

## License

See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome. See `.github/instructions/` for development guidelines.