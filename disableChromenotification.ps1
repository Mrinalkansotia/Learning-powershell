$regPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$valueName = "DefaultNotificationsSetting"
$valueData = 2

if (Test-Path -Path $regPath) {
    $value = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue
    if ($value -eq $null) {
        New-ItemProperty -Path $regPath -Name $valueName -Value $valueData -PropertyType DWord -Force > $null
    } else {
        Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord -Force > $null
    }
}