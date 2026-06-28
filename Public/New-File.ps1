<#
.SYNOPSIS
    Creates a new file.

.DESCRIPTION
    This function creates a new file at the specified path with the given name.
    Additional arguments can be passed to customize the creation process.

.PARAMETER Value
    The name of the file to create.

.PARAMETER Path
    The path where the file will be created.

.PARAMETER Arguments
    Additional arguments to pass to the New-Item cmdlet.
#>
function New-File {
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

    New-Item -ItemType File -Path $Path -Value $Value @Arguments
}