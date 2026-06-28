<#
.SYNOPSIS
Get the various IP addresses from network adapters.

.DESCRIPTION
Return IP addresses from network adapters based on the specified switches types (Ethernet, Wireless, Bluetooth).

.PARAMETER Ethernet
Include Ethernet adapters in the results.
.PARAMETER Wireless
Include Wireless adapters in the results.
.PARAMETER Bluetooth
Include Bluetooth adapters in the results.

.EXAMPLE
# Get Hyper V interfaces and IP addresses
Get-NetAdaptersInfo -Ethernet | Where-Object { $_.Name -match "HyperV"}
#>
function Get-NetAdaptersInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [switch]$Ethernet = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Wireless = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Bluetooth = $false
    )

    $matcher = ""
    
    if ($Ethernet) {
        $matcher = "$(if($matcher) { `"$matcher|`" } else { `"`" })ethernet"
    }
    
    if ($Wireless) {
        $matcher = "$(if($matcher) { `"$matcher|`" } else { `"`" })wi-fi"
    }

    if ($Bluetooth) {
        $matcher = "$(if($matcher) { `"$matcher|`" } else { `"`" })bluetooth"
    }

    Get-NetAdapter | Where-Object { $_.InterfaceAlias -match $matcher } | Select-Object `
        InterfaceAlias,
    @{n = "IPv4"; e = { Get-NetIPAddress -InterfaceAlias $_.InterfaceAlias | Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}$' } } }
}