# Admin

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/vehicle/taxrecords/check` | Updates outdated recurring Tax Records | — |  |
| GET | `/api/vehicle/reminders/send` | Send Reminders out to collaborators | `id` *(optional)* — Id of the specific record<br>`tags` *(optional)* — Tags separated by space<br>`urgencies` *(optional)* — List of urgencies |  |
| GET | `/api/makebackup` | Creates a backup and returns download link | `output` *(optional)* — Accepted values: download, email, or leave blank for a link to the file |  |
| GET | `/api/tempfiles` | Gets files in temp directory | — |  |
| GET | `/api/cleanup` | Cleans out temp files and unlinked attachments | `deepClean` *(optional)* — Deletes unlinked attachments |  |
