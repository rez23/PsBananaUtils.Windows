. "$PSScriptRoot\Public\Find-Process.ps1"
. "$PSScriptRoot\Public\Get-NetAdaptersInfo.ps1"
. "$PSScriptRoot\Public\New-Directory.ps1"
. "$PSScriptRoot\Public\New-File.ps1"
. "$PSScriptRoot\Public\New-Junction.ps1"
. "$PSScriptRoot\Public\New-Symlink.ps1"

$script:SettingUpCompletionForHyperVManager = {
    param($InherithFrom, $ExcludeProps, $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $already = @()
    if ($fakeBoundParameters.ContainsKey("Property")) {
        $already = $fakeBoundParameters["Property"] -split ","
    }

    $props = Get-Command -name Invoke-Command | Get-Member -MemberType Properties | Select-Object -Expand Name -Unique

    $props = $props |
    Where-Object { $_ -notin $ExcludedProps } |
    Where-Object { $_ -notin $already } |
    Where-Object { $_ -like "$wordToComplete*" }

    foreach ($p in $props) {
        [System.Management.Automation.CompletionResult]::new($p, $p, 'ParameterValue', $p)
    }
}

Register-ArgumentCompleter -CommandName New-Symlink -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $ExcludedProps = @("ItemType")

    & $script:SettingUpCompletionForHyperVManager `
        -InherithFrom New-Item `
        -ExcludedProps $ExcludedProps `
        -commandName $commandName `
        -parameterName $parameterName `
        -wordToComplete $wordToComplete `
        -commandAst $commandAst `
        -fakeBoundParameters $fakeBoundParameters
}

Register-ArgumentCompleter -CommandName New-Junction -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $ExcludedProps = @("ItemType")

    & $script:SettingUpCompletionForHyperVManager `
        -InherithFrom New-Item `
        -ExcludedProps $ExcludedProps `
        -commandName $commandName `
        -parameterName $parameterName `
        -wordToComplete $wordToComplete `
        -commandAst $commandAst `
        -fakeBoundParameters $fakeBoundParameters
}

Register-ArgumentCompleter -CommandName New-File -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $ExcludedProps = @("ItemType")

    & $script:SettingUpCompletionForHyperVManager `
        -InherithFrom New-Item `
        -ExcludedProps $ExcludedProps `
        -commandName $commandName `
        -parameterName $parameterName `
        -wordToComplete $wordToComplete `
        -commandAst $commandAst `
        -fakeBoundParameters $fakeBoundParameters
}

Register-ArgumentCompleter -CommandName New-Folder -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $ExcludedProps = @("ItemType")
    & $script:SettingUpCompletionForHyperVManager `
        -InherithFrom New-Item `
        -ExcludedProps $ExcludedProps `
        -commandName $commandName `
        -parameterName $parameterName `
        -wordToComplete $wordToComplete `
        -commandAst $commandAst `
        -fakeBoundParameters $fakeBoundParameters
}

Export-ModuleMember -Function (Get-ChildItem "$PSScriptRoot\Public\*.ps1" -Recurse | ForEach-Object { $_.BaseName }) `
    -Alias touch, ln, jn