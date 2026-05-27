# Plan Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/planrecords/all` | Gets Plan Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records |  |
| GET | `/api/vehicle/planrecords` | Gets Plan Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records |  |
| POST | `/api/vehicle/planrecords/add` | Adds a Plan Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, cost, type, priority, progress, notes, extraFields, files |  |
| PUT | `/api/vehicle/planrecords/update` | Updates a Plan Record for a vehicle | Body: id, description, cost, type, priority, progress, notes, extraFields, files |  |
| DELETE | `/api/vehicle/planrecords/delete` | Deletes a Plan Record | `id` *(required)* — Id of the Plan Record |  |
