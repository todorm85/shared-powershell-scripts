Param(
    [Parameter(Mandatory=$true)]
    $port
)

Stop-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess -Force