function ConvertFrom-ICal {
<#
.SYNOPSIS
    Converts iCalendar (ICS) text into PowerShell event objects.

.DESCRIPTION
    Parses ICS content and emits one PSCustomObject for each VEVENT block.
    This is intended to work with CalendarData returned from Get-LLCalendar.

.PARAMETER CalendarData
    Raw iCalendar text content.

.EXAMPLE
    $response = Get-LLCalendar -BaseUrl "https://car.phunky1.com" -Credential $creds
    ConvertFrom-ICal -CalendarData $response.CalendarData

    Converts the ICS response into one object per event.

.OUTPUTS
    PSCustomObject with commonly used event properties.

.NOTES
    This function only parses ICS content.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$CalendarData
    )

    begin {
        function ConvertTo-ICalDateTime {
            param(
                [Parameter(Mandatory)]
                [string]$Value
            )

            $raw = $Value.Trim()
            $isUtc = $raw.EndsWith('Z')
            if ($isUtc) {
                $raw = $raw.TrimEnd('Z')
            }

            $styles = [System.Globalization.DateTimeStyles]::None
            if ($isUtc) {
                $styles = [System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal
            }

            if ($raw -match '^\d{8}T\d{6}$') {
                return [datetime]::ParseExact($raw, 'yyyyMMddTHHmmss', [System.Globalization.CultureInfo]::InvariantCulture, $styles)
            }

            if ($raw -match '^\d{8}$') {
                return [datetime]::ParseExact($raw, 'yyyyMMdd', [System.Globalization.CultureInfo]::InvariantCulture, $styles)
            }

            return $null
        }
    }

    process {
        # Unfold folded ICS lines (continuations start with whitespace).
        $rawLines = $CalendarData -split "`r?`n"
        $lines = New-Object System.Collections.Generic.List[string]

        foreach ($line in $rawLines) {
            if ($line -match '^[ \t]' -and $lines.Count -gt 0) {
                $lines[$lines.Count - 1] += $line.TrimStart()
            } else {
                [void]$lines.Add($line)
            }
        }

        $inEvent = $false
        $currentProps = @{}

        foreach ($line in $lines) {
            $trimmed = $line.Trim()

            if ($trimmed -eq 'BEGIN:VEVENT') {
                $inEvent = $true
                $currentProps = @{}
                continue
            }

            if ($trimmed -eq 'END:VEVENT') {
                if ($inEvent) {
                    $uid = if ($currentProps.ContainsKey('UID')) { $currentProps['UID'] } else { $null }
                    $summary = if ($currentProps.ContainsKey('SUMMARY')) { $currentProps['SUMMARY'] } else { $null }
                    $description = if ($currentProps.ContainsKey('DESCRIPTION')) { $currentProps['DESCRIPTION'] } else { $null }
                    $location = if ($currentProps.ContainsKey('LOCATION')) { $currentProps['LOCATION'] } else { $null }
                    $priority = if ($currentProps.ContainsKey('PRIORITY')) { [int]$currentProps['PRIORITY'] } else { $null }
                    $status = if ($currentProps.ContainsKey('STATUS')) { $currentProps['STATUS'] } else { $null }

                    $dtStart = $null
                    if ($currentProps.ContainsKey('DTSTART')) {
                        $dtStart = ConvertTo-ICalDateTime -Value $currentProps['DTSTART']
                    }

                    $dtEnd = $null
                    if ($currentProps.ContainsKey('DTEND')) {
                        $dtEnd = ConvertTo-ICalDateTime -Value $currentProps['DTEND']
                    }

                    $dtStamp = $null
                    if ($currentProps.ContainsKey('DTSTAMP')) {
                        $dtStamp = ConvertTo-ICalDateTime -Value $currentProps['DTSTAMP']
                    }

                    [PSCustomObject]@{
                        UID         = $uid
                        Summary     = $summary
                        Description = $description
                        Location    = $location
                        Status      = $status
                        Priority    = $priority
                        DtStart     = $dtStart
                        DtEnd       = $dtEnd
                        DtStamp     = $dtStamp
                        Properties  = [hashtable]$currentProps
                    }
                }

                $inEvent = $false
                $currentProps = @{}
                continue
            }

            if (-not $inEvent) {
                continue
            }

            if ($trimmed -match '^([^:;]+)(?:;[^:]*)?:(.*)$') {
                $name = $Matches[1].ToUpperInvariant()
                $value = $Matches[2]

                if ($currentProps.ContainsKey($name)) {
                    $existing = $currentProps[$name]
                    if ($existing -is [System.Collections.IList]) {
                        [void]$existing.Add($value)
                    } else {
                        $list = New-Object System.Collections.ArrayList
                        [void]$list.Add($existing)
                        [void]$list.Add($value)
                        $currentProps[$name] = $list
                    }
                } else {
                    $currentProps[$name] = $value
                }
            }
        }
    }
}
