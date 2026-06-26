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