# Supply Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/supplyrecords/all` | Gets Supply Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/supplyrecords` | Gets Supply Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/supplyrecords/add` | Adds a Supply Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, partNumber, partSupplier, partQuantity, description, cost, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/supplyrecords/update` | Updates a Supply Record for a vehicle | Body: id, date, partNumber, partSupplier, partQuantity, description, cost, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/supplyrecords/delete` | Deletes a Supply Record | `id` *(required)* — Id of the Supply Record |  |
