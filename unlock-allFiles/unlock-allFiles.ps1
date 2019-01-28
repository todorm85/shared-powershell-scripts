<#
.SYNOPSIS
    Unlocks all files and/or directories recursively for a given path or file path.
.EXAMPLE
    PS C:\> unlock-allFiles.ps1 -path "C:\docs"
    PS C:\> unlock-allFiles.ps1 -path "C:\temp.dat"
.INPUTS
    $path: The path to the file or directory is mandatory
.NOTES
    The script requires the presense of the sysinternals handle tool in the same directory. https://docs.microsoft.com/en-us/sysinternals/downloads/handle
#>
Param(
    [Parameter(Mandatory = $true)]$path
)

$handlesList = "& `".\handle.exe`" $path"
$pids = New-Object -TypeName System.Collections.ArrayList
$handlesList | ForEach-Object { 
    $isFound = $_ -match "^.*pid: (?<pid>.*?) .*$"
    if ($isFound) {
        $id = $Matches.pid
        if (-not $pids.Contains($id)) {
            $pids.Add($id) > $null
        }
    }
}

$pids | % {
    if (-not $_) { return }
    Get-Process -Id $_ | % {
        if (-not $_) { return }
        Stop-Process $_ -Force -ErrorAction SilentlyContinue
    }
}