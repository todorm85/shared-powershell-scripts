Param(
    [Parameter(Mandatory=$true)]
    $port
)

(Get-NetTCPConnection -LocalPort $port).OwningProcess