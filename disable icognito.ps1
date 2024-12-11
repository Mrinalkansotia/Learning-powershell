$registryPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$itemPropertyName = "IncognitoModeAvailability"
$itemValue = 1
if (Test-Path -Path $registryPath) {
    if (Get-ItemProperty -Path $registryPath -Name $itemPropertyName -ErrorAction SilentlyContinue) {
        Set-ItemProperty -Path $registryPath -Name $itemPropertyName -Value $itemValue
    } else {
        New-ItemProperty -Path $registryPath -Name $itemPropertyName -PropertyType DWORD -Value $itemValue
    }
}