# Check Point hizmetlerini durdurma
$servicesToStop = @(
    "Check Point Endpoint Client Watchdog",
    "Check Point Endpoint Security VPN"
)

foreach ($service in $servicesToStop) {
    if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
        Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
        Write-Host "Stopped service: $service"
    } else {
        Write-Host "Service not found: $service"
    }
}

# trac.defaults dosyasının yedeğini oluşturma
$installPath = "C:\Program Files (x86)\CheckPoint\Endpoint Connect"
$defaultsFile = Join-Path -Path $installPath -ChildPath "trac.defaults"
$backupFile = Join-Path -Path $installPath -ChildPath "trac.defaults.bak"

if (Test-Path $defaultsFile) {
    Copy-Item -Path $defaultsFile -Destination $backupFile -Force
    Write-Host "Backup created: $backupFile"
} else {
    Write-Host "trac.defaults file not found!"
    exit
}

# trac.defaults dosyasını düzenleme
(Get-Content $defaultsFile) -replace 'route_conflict_resolution_method STRING "delete_create" GLOBAL 1', 'route_conflict_resolution_method STRING "modify" GLOBAL 1' | Set-Content $defaultsFile
Write-Host "Updated trac.defaults file"

# Hizmetleri yeniden başlatma
foreach ($service in $servicesToStop) {
    if (Get-Service -Name $service -ErrorAction SilentlyContinue) {
        Start-Service -Name $service -ErrorAction SilentlyContinue
        Write-Host "Started service: $service"
    }
}

Write-Host "Operation completed successfully."
