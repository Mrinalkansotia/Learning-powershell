# Get the top 5 memory-consuming services
$services = Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 5

# Loop through each service and restart it
foreach ($service in $services) {
    Write-Host "Restarting $($service.ProcessName) service..."
    Restart-Service -Name $service.ProcessName -Force
}
