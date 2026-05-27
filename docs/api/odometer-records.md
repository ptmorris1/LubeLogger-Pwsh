# Odometer Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/odometerrecords/all` | Gets Odometer Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space | `Get-LLOdometerRecord` |
| GET | `/api/vehicle/odometerrecords` | Gets Odometer Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/odometerrecords/latest` | Gets latest Odometer Reading for a vehicle | `vehicleId` *(required)* — Id of the vehicle |  |
| POST | `/api/vehicle/odometerrecords/add` | Adds an Odometer Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`autoIncludeEquipment` *(optional)* — Automatically include all currently equipped equipment. Accepts true/false<br>Body: date, initialOdometer, odometer, notes, tags, extraFields, files, equipmentRecordId |  |
| PUT | `/api/vehicle/odometerrecords/update` | Updates an Odometer Record for a vehicle | Body: id, date, initialOdometer, odometer, notes, tags, extraFields, files, equipmentRecordId |  |
| PUT | `/api/vehicle/odometerrecords/recalculate` | Recalculate Odometer Record distance for a vehicle | `vehicleId` *(required)* — Id of the vehicle |  |
| DELETE | `/api/vehicle/odometerrecords/delete` | Deletes an Odometer Record | `id` *(required)* — Id of the Odometer Record |  |
