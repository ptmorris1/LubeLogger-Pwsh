# Repair Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/repairrecords/all` | Gets Repair Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/repairrecords` | Gets Repair Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/repairrecords/add` | Adds a Repair Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/repairrecords/update` | Updates a Repair Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/repairrecords/delete` | Deletes a Repair Record | `id` *(required)* — Id of the Repair Record |  |
