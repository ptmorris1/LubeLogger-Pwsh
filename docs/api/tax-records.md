# Tax Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/taxrecords/all` | Gets Tax Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/taxrecords` | Gets Tax Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/taxrecords/add` | Adds a Tax Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, description, cost, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/taxrecords/update` | Updates a Tax Record for a vehicle | Body: id, date, description, cost, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/taxrecords/delete` | Deletes a Tax Record | `id` *(required)* — Id of the Tax Record |  |
