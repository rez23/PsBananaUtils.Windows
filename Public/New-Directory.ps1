<#
.SYNOPSIS
    Creates a new directory.

.DESCRIPTION
    This function creates a new directory at the specified path with the given name.
    Additional arguments can be passed to customize the creation process.

.PARAMETER Value
    The name of the directory to create.

.PARAMETER Path
    The path where the directory will be created.

.PARAMETER Arguments
    Additional arguments to pass to the New-Item cmdlet.
#>
function New-Directory {
    [CmdletBinding()]
    [OutputType([System.IO.FileSystemInfo])]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Value,

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipeline = $true)]
        [string]$Path,

        [Parameter(ValueFromRemainingArguments = $true)]
        [object[]]$Arguments = @()
    )

    New-Item -ItemType Directory -Path $Path -Value $Value @Arguments
}