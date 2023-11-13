
param (
    [string]$action = 'add'
)

if (-not $action -and $args.Count -gt 0) {
    $action = $args[0]
}

switch ($action.ToLower()) {
    'add' {
        & Import-Module posh-git
        $GitPromptSettings.DefaultPromptSuffix = "`n$ "
    }
    'remove' {
        & Remove-Module posh-git
    }
    'rm' {
        & Remove-Module posh-git
    }
    default {
        $cmdname = $MyInvocation.InvocationName
        $msg = "`nNAME`n    $cmdname`n`nUSAGE`n    $cmdname [-action] [add | rm | remove]"
        $msg += "`n`nEXAMPLES`n    $cmdname add`n    $cmdname rm`n`n"
        Write-Host $msg
    }
}