# Set variable for the name of the service
$serviceName = "TapiSrv"

try {
    # Stop the service and set startup type to Disabled
    Get-Service -Name $serviceName | Stop-Service -PassThru | Set-Service -StartupType Disabled -WhatIf

    # Confirm that the service is disabled
    Get-Service -Name $serviceName | Select-Object Name, Status, StartType 
} catch {
    Write-Error "An error occurred: $_"
}
