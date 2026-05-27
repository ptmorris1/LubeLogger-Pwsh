# Equipment Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/equipmentrecords/all` | Gets Equipment Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/equipmentrecords` | Gets Equipment Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/equipmentrecords/add` | Adds an Equipment Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, isEquipped, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/equipmentrecords/update` | Updates an Equipment Record for a vehicle | Body: id, description, isEquipped, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/equipmentrecords/delete` | Deletes an Equipment Record | `id` *(required)* — Id of the Equipment Record |  |
