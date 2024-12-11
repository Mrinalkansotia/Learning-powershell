# Script to create a new empty Outlook profile and set it as default

$ofc = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$OfficeInstall = Get-ChildItem -Path $ofc -Recurse | Where-Object {
    $_.GetValue('DisplayName') -like "Microsoft Office*" -or $_.GetValue('DisplayName') -like "Microsoft 365 Apps*"
}

if ($OfficeInstall) {
    try {
        $Version = $OfficeInstall.GetValue('DisplayVersion')[0..3] -join ""
        $RegPath = "HKCU:\SOFTWARE\Microsoft\Office\$Version\Outlook\Profiles"

        New-Item -Path $RegPath -Name "NewProfile" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\$Version\Outlook" -Name "DefaultProfile" -Value "NewProfile"

        Write-Host "Outlook profile created successfully. Restart Outlook to set up the new profile."
    } catch {
        Write-Error "Error creating Outlook profile: $_"
    }
} else {
    Write-Host "Microsoft Office or Microsoft 365 Apps not found. Please ensure the software is installed."
}
