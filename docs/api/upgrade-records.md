# Upgrade Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/upgraderecords/all` | Gets Upgrade Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/upgraderecords` | Gets Upgrade Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/upgraderecords/add` | Adds an Upgrade Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/upgraderecords/update` | Updates an Upgrade Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/upgraderecords/delete` | Deletes an Upgrade Record | `id` *(required)* — Id of the Upgrade Record |  |
