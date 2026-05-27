# Gas Records

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/gasrecords/all` | Gets Gas Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space<br>`useMPG` *(optional)* — Use MPG Calculations<br>`useUKMPG` *(optional)* — Use UK MPG Calculations |  |
| GET | `/api/vehicle/gasrecords` | Gets Gas Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`startDate` *(optional)* — Minimum date for records<br>`endDate` *(optional)* — Maximum date for records<br>`tags` *(optional)* — Tags separated by space<br>`useMPG` *(optional)* — Use MPG Calculations<br>`useUKMPG` *(optional)* — Use UK MPG Calculations |  |
| POST | `/api/vehicle/gasrecords/add` | Adds a Gas Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: date, odometer, fuelConsumed, cost, isFillToFull, missedFuelUp, notes, tags, extraFields, files |  |
| PUT | `/api/vehicle/gasrecords/update` | Updates a Gas Record for a vehicle | Body: id, date, odometer, fuelConsumed, cost, isFillToFull, missedFuelUp, notes, tags, extraFields, files |  |
| DELETE | `/api/vehicle/gasrecords/delete` | Deletes a Gas Record | `id` *(required)* — Id of the Gas Record |  |
