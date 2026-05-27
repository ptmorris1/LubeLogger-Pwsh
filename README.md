# LubeLogger PowerShell Module

A PowerShell wrapper for the [LubeLogger](https://github.com/hargata/lubelog) API — a self-hosted vehicle maintenance and fuel tracking application.

> **Disclaimer:** AI assistance (GitHub Copilot) was used to help write documentation and repetitive boilerplate code. All design decisions, implementation direction, and testing were performed by a human.

## About LubeLogger

LubeLogger is a free, open-source web application that helps you track vehicle maintenance, fuel costs, and service history. Learn more at: https://lubelogger.com

## LubeLogger PowerShell Module Features

- API wrappers for LubeLogger endpoints with consistent auth and output patterns
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

See the full endpoint and implementation matrix in [docs/api/index.md](docs/api/index.md).

Release history is tracked in [docs/CHANGELOG.md](docs/CHANGELOG.md).

Function help documentation will be expanded over time.

## Requirements

- PowerShell 7.5 or later
- Windows, macOS, or Linux
- Network access to a LubeLogger instance

## License

See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome. See `.github/instructions/` for development guidelines.