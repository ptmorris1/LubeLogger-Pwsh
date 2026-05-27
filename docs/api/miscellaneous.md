# Miscellaneous

| Method | Endpoint | Description | Parameters | PowerShell Function |
|--------|----------|-------------|------------|---------------------|
| GET | `/api/calendar` | Gets reminders calendar in ICS format | — | `Get-LLCalendar` |
| GET | `/api/extrafields` | Gets configured extra fields | — |  |
| POST | `/api/documents/upload` | Upload Documents | Body: file |  |
| GET | `/api/whoami` | Gets information for current user | — |  |
| GET | `/api/info` | Gets server information for LubeLogger instance | — |  |
| GET | `/api/version` | Gets current version for LubeLogger instance | `checkForUpdate` *(optional)* — Check for updates |  |
