
param (
    [string]$file,
    [switch]$run,
    [switch]$clean
)

if ($clean -and -not $run) {
    Write-Host "Error: The '-clean' switch can only be used along with '-run'."
    exit 0
}

if (-not $file -and $args.Count -gt 0) {
    $file = $args[0]
}


if (-not $file) {
    $cmdname = $MyInvocation.InvocationName
    $msg = "`nNAME`n    $cmdname`n`nUSAGE`n    $cmdname [-filename] <filename> [-run] [-clean]"
    $msg += "`n`nEXAMPLES`n    $cmdname -filename hello.c`n    $cmdname main.cpp`n`n"
    Write-Host $msg
    Write-Host "Supply values for the following parameters:"
    $file = Read-Host "Filename"
}


if (-not $file) {
    Write-Host "Invalid input. Terminating..."
    exit 1
}

$fileName = [System.IO.Path]::GetFileNameWithoutExtension($file)
$fileExtension = [System.IO.Path]::GetExtension($file)


switch ($fileExtension.ToLower()) {
    ".c" {
        & gcc $file -o "$fileName.exe"
    }
    ".cpp" {
        & g++ $file -o "$fileName.exe"
    }
    default {
        Write-Host "Invalid file extension: '$fileExtension'. Expected '.c' or '.cpp'."
        exit 1
    }
}

if ($run) {
    & ./$fileName.exe
}

if ($clean) {
    & Remove-Item ./$fileName.exe
}
# Write-Host "Compilation successful. Output file: $fileName.exe"
exit 0
