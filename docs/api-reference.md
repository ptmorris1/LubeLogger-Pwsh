# LubeLogger API Reference

All endpoints require authentication via `X-Api-Key` header or HTTP Basic Auth.

**Legend:** ✅ = Function exists | ⬜ = Not yet implemented

---

## Vehicles

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicles` | Gets list of vehicles user has access to | — | `Get-LLVehicle` ✅ |
| GET | `/api/vehicle/info` | Gets details for list of vehicles or a specific vehicle | `vehicleId` *(optional)* — Id of the vehicle | `Get-LLVehicleInfo` ✅ |
| GET | `/api/vehicle/adjustedodometer` | Gets odometer reading with adjustments applied | `vehicleId` *(required)* — Id of the vehicle<br>`odometer` *(required)* — Unadjusted odometer | `Get-LLVehicleAdjustedOdometer` ✅ |
| POST | `/api/vehicles/add` | Adds a vehicle | Body: year, make, model, identifier, licensePlate, fuelType, tags, extraFields | ⬜ |
| PUT | `/api/vehicles/update` | Updates a vehicle | Body: id, year, make, model, identifier, licensePlate, fuelType, tags, extraFields | ⬜ |

---

## Odometer Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/odometerrecords/all` | Gets Odometer Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | `Get-LLOdometerRecord` ✅ |
| GET | `/api/vehicle/odometerrecords` | Gets Odometer Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/odometerrecords/latest` | Gets latest Odometer Reading for a vehicle | `vehicleId` *(required)* — Id of the vehicle | ⬜ |
| POST | `/api/vehicle/odometerrecords/add` | Adds an Odometer Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`autoIncludeEquipment` *(optional)* — Automatically include all currently equipped equipment. Accepts true/false<br>Body: date, initialOdometer, odometer, notes, tags, extraFields, files, equipmentRecordId | ⬜ |
| PUT | `/api/vehicle/odometerrecords/update` | Updates an Odometer Record for a vehicle | Body: id, date, initialOdometer, odometer, notes, tags, extraFields, files, equipmentRecordId | ⬜ |
| PUT | `/api/vehicle/odometerrecords/recalculate` | Recalculate Odometer Record distance for a vehicle | `vehicleId` *(required)* — Id of the vehicle | ⬜ |
| DELETE | `/api/vehicle/odometerrecords/delete` | Deletes an Odometer Record | `id` *(required)* — Id of the Odometer Record | ⬜ |

---

## Plan Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/planrecords/all` | Gets Plan Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records | ⬜ |
| GET | `/api/vehicle/planrecords` | Gets Plan Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records | ⬜ |
| POST | `/api/vehicle/planrecords/add` | Adds a Plan Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, cost, type, priority, progress, notes, extraFields, files | ⬜ |
| PUT | `/api/vehicle/planrecords/update` | Updates a Plan Record for a vehicle | Body: id, description, cost, type, priority, progress, notes, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/planrecords/delete` | Deletes a Plan Record | `id` *(required)* — Id of the Plan Record | ⬜ |

---

## Service Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/servicerecords/all` | Gets Service Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/servicerecords` | Gets Service Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/servicerecords/add` | Adds a Service Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/servicerecords/update` | Updates a Service Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/servicerecords/delete` | Deletes a Service Record | `id` *(required)* — Id of the Service Record | ⬜ |

---

## Repair Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/repairrecords/all` | Gets Repair Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/repairrecords` | Gets Repair Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/repairrecords/add` | Adds a Repair Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/repairrecords/update` | Updates a Repair Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/repairrecords/delete` | Deletes a Repair Record | `id` *(required)* — Id of the Repair Record | ⬜ |

---

## Upgrade Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/upgraderecords/all` | Gets Upgrade Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/upgraderecords` | Gets Upgrade Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/upgraderecords/add` | Adds an Upgrade Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/upgraderecords/update` | Updates an Upgrade Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/upgraderecords/delete` | Deletes an Upgrade Record | `id` *(required)* — Id of the Upgrade Record | ⬜ |

---

## Supply Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/supplyrecords/all` | Gets Supply Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/supplyrecords` | Gets Supply Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/supplyrecords/add` | Adds a Supply Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, partNumber, partSupplier, partQuantity, description, cost, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/supplyrecords/update` | Updates a Supply Record for a vehicle | Body: id, date, partNumber, partSupplier, partQuantity, description, cost, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/supplyrecords/delete` | Deletes a Supply Record | `id` *(required)* — Id of the Supply Record | ⬜ |

---

## Tax Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/taxrecords/all` | Gets Tax Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/taxrecords` | Gets Tax Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/taxrecords/add` | Adds a Tax Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, description, cost, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/taxrecords/update` | Updates a Tax Record for a vehicle | Body: id, date, description, cost, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/taxrecords/delete` | Deletes a Tax Record | `id` *(required)* — Id of the Tax Record | ⬜ |

---

## Gas Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/gasrecords/all` | Gets Gas Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space<br>`useMPG` *(optional)* — Use MPG Calculations<br>`useUKMPG` *(optional)* — Use UK MPG Calculations | ⬜ |
| GET | `/api/vehicle/gasrecords` | Gets Gas Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space<br>`useMPG` *(optional)* — Use MPG Calculations<br>`useUKMPG` *(optional)* — Use UK MPG Calculations | ⬜ |
| POST | `/api/vehicle/gasrecords/add` | Adds a Gas Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, fuelConsumed, cost, isFillToFull, missedFuelUp, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/gasrecords/update` | Updates a Gas Record for a vehicle | Body: id, date, odometer, fuelConsumed, cost, isFillToFull, missedFuelUp, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/gasrecords/delete` | Deletes a Gas Record | `id` *(required)* — Id of the Gas Record | ⬜ |

---

## Reminder Records

> **Urgencies valid values:** `NotUrgent`, `VeryUrgent`, `Urgent`, `PastDue`

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/reminders/all` | Gets Reminder Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies | `Get-LLReminder` ✅ |
| GET | `/api/vehicle/reminders` | Gets Reminder Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies | ⬜ |
| POST | `/api/vehicle/reminders/add` | Adds a Reminder Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, dueDate, dueOdometer, metric, notes, tags | ⬜ |
| PUT | `/api/vehicle/reminders/update` | Updates a Reminder Record for a vehicle | Body: id, description, dueDate, dueOdometer, metric, notes, tags | ⬜ |
| DELETE | `/api/vehicle/reminders/delete` | Deletes a Reminder Record | `id` *(required)* — Id of the Reminder Record | ⬜ |

---

## Equipment Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/equipmentrecords/all` | Gets Equipment Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/equipmentrecords` | Gets Equipment Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/equipmentrecords/add` | Adds an Equipment Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, isEquipped, notes, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/equipmentrecords/update` | Updates an Equipment Record for a vehicle | Body: id, description, isEquipped, notes, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/equipmentrecords/delete` | Deletes an Equipment Record | `id` *(required)* — Id of the Equipment Record | ⬜ |

---

## Notes

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/notes/all` | Gets Notes for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| GET | `/api/vehicle/notes` | Gets Notes for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space | ⬜ |
| POST | `/api/vehicle/notes/add` | Adds a Note for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, noteText, pinned, tags, extraFields, files | ⬜ |
| PUT | `/api/vehicle/notes/update` | Updates a Note for a vehicle | Body: id, description, noteText, pinned, tags, extraFields, files | ⬜ |
| DELETE | `/api/vehicle/notes/delete` | Deletes a Note | `id` *(required)* — Id of the Note | ⬜ |

---

## Miscellaneous

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/calendar` | Gets reminders calendar in ICS format | — | `Get-LLCalendar` ✅ |
| GET | `/api/extrafields` | Gets configured extra fields | — | ⬜ |
| POST | `/api/documents/upload` | Upload Documents | Body: file | ⬜ |
| GET | `/api/whoami` | Gets information for current user | — | ⬜ |
| GET | `/api/info` | Gets server information for LubeLogger instance | — | ⬜ |
| GET | `/api/version` | Gets current version for LubeLogger instance | `checkForUpdate` *(optional)* — Check for updates | ⬜ |

---

## Admin

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/taxrecords/check` | Updates outdated recurring Tax Records | — | ⬜ |
| GET | `/api/vehicle/reminders/send` | Send Reminders out to collaborators | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies | ⬜ |
| GET | `/api/makebackup` | Creates a backup and returns download link | `output` *(optional)* — Accepted values: download, email, or leave blank for a link to the file | ⬜ |
| GET | `/api/tempfiles` | Gets files in temp directory | — | ⬜ |
| GET | `/api/cleanup` | Cleans out temp files and unlinked attachments | `deepClean` *(optional)* — Deletes unlinked attachments | ⬜ |
