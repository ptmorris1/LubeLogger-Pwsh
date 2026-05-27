# Reminder Records

> Urgencies valid values: `NotUrgent`, `VeryUrgent`, `Urgent`, `PastDue`

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/reminders/all` | Gets Reminder Records for all vehicles | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies | `Get-LLReminder` |
| GET | `/api/vehicle/reminders` | Gets Reminder Records for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>`id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies |  |
| POST | `/api/vehicle/reminders/add` | Adds a Reminder Record for a vehicle | `vehicleId` *(required)* — Id of the vehicle<br>Body: description, dueDate, dueOdometer, metric, notes, tags |  |
| PUT | `/api/vehicle/reminders/update` | Updates a Reminder Record for a vehicle | Body: id, description, dueDate, dueOdometer, metric, notes, tags |  |
| DELETE | `/api/vehicle/reminders/delete` | Deletes a Reminder Record | `id` *(required)* — Id of the Reminder Record |  |
