# Notes

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/notes/all` | Gets Notes for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space |  |
| GET | `/api/vehicle/notes` | Gets Notes for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space |  |
| POST | `/api/vehicle/notes/add` | Adds a Note for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, noteText, pinned, tags, extraFields, files |  |
| PUT | `/api/vehicle/notes/update` | Updates a Note for a vehicle | Body: id, description, noteText, pinned, tags, extraFields, files |  |
| DELETE | `/api/vehicle/notes/delete` | Deletes a Note | `id` *(required)* — Id of the Note |  |
