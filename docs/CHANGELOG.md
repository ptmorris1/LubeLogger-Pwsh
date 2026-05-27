---
icon: lucide/square-pen
---

# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0]

### Added
- Initial module release.
- Added `Get-LLVehicle` to retrieve vehicles from `/api/vehicles`.
- Added `Get-LLReminder` to retrieve reminders from `/api/vehicle/reminders/all` with optional filters.
- Added `Get-LLCalendar` to retrieve calendar data from `/api/calendar` with optional file output.
- Added `ConvertFrom-ICal` to convert ICS calendar content into PowerShell objects.
- Added `Get-LLVehicleInfo` to retrieve extended vehicle info from `/api/vehicle/info`.
- Added `Get-LLVehicleAdjustedOdometer` to retrieve adjusted odometer data from `/api/vehicle/adjustedodometer` with required `VehicleId` and `Odometer` parameters.
- Added `Get-LLOdometerRecord` to retrieve records from `/api/vehicle/odometerrecords/all` with optional `Id`, `StartDate`, `EndDate`, and `Tags` filters.

---

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).