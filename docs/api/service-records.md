# Service Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/servicerecords/all` | Gets Service Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/servicerecords` | Gets Service Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/servicerecords/add` | Adds a Service Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, description, cost, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/servicerecords/update` | Updates a Service Record for a vehicle | Body: id, date, odometer, description, cost, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/servicerecords/delete` | Deletes a Service Record | `id` *(required)* — Id of the Service Record |  |
