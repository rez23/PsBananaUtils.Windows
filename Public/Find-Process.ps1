<#
.SYNOPSIS
Finds processes by name and optionally stops them.

.DESCRIPTION
Less or more like Get-Process, but with default multiple match

.PARAMETER Pattern
Process name pattern to search.

.PARAMETER Stop
Stops matching processes instead of returning them.

.PARAMETER Force
Stops processes without confirmation and passes -Force to Stop-Process.

.EXAMPLE
Find-Process -Pattern "code"

Lists processes with names that match "code".

.EXAMPLE
Find-Process -Pattern "node" -Stop -Force

Stops matching node processes without confirmation.
#>
function Find-Process {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$Pattern = '',

        [switch]$Exact = $false,
        [switch]$Stop = $false,
        [switch]$Force = $false
    )

    $Processes = $null
    if ($Exact) {
        $Processes = Get-Process $Pattern
    }
    else {
        $Processes = Get-Process "*${Pattern}*"
    }

    if ($Stop) {
        if ($Stop -and $Force) {
            $Processes | ForEach-Object {
                Write-Host "[*] Stopping process: $($_.Name) (ID: $($_.Id))"
                Stop-Process -Id $_.Id -Force
            }
        } else {
            if ($Processes.Count -gt 0) {
                Write-Warning "[*] Found $($Processes.Count) matching processes, Use -Force to stop them without confirmation."
            } else {
                $Processes | Stop-Process -Confirm
            }
        }
    }

    $processes
}