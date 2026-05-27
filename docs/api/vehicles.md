# Vehicles

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicles` | Gets list of vehicles user has access to | — | `Get-LLVehicle` |
| GET | `/api/vehicle/info` | Gets details for list of vehicles or a specific vehicle | `vehicleId` *(optional)* — Id of the vehicle | `Get-LLVehicleInfo` |
| GET | `/api/vehicle/adjustedodometer` | Gets odometer reading with adjustments applied | `vehicleId` *(required)* — Id of the vehicle<br>`odometer` *(required)* — Unadjusted odometer | `Get-LLVehicleAdjustedOdometer` |
| POST | `/api/vehicles/add` | Adds a vehicle | Body: year, make, model, identifier, licensePlate, fuelType, tags, extraFields |  |
| PUT | `/api/vehicles/update` | Updates a vehicle | Body: id, year, make, model, identifier, licensePlate, fuelType, tags, extraFields |  |
