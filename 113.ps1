Install-Module -Name MSOnline | Import-Module MSOnline

# Set the number of days before expiration to check for
$daysBeforeExpiration = 2

# Get the current date
$currentDate = Get-Date

# Connect to MSOnline
Connect-MsolService

# Get all Microsoft licenses
$licenses = Get-MsolAccountSku

# Loop through each license
foreach ($license in $licenses) {
    # Get the license expiration date
    $expirationDate = $license.ActiveUnits | Select-Object -ExpandProperty ExpirationStatus

    # Calculate the number of days until expiration
    $daysUntilExpiration = ($expirationDate - $currentDate).Days

    # Check if the license is expired or will expire within the specified number of days
    if ($daysUntilExpiration -le $daysBeforeExpiration) {
        # Throw an alert
        Write-Host "ALERT: The Microsoft license $($license.AccountSkuId) will expire in $daysUntilExpiration days or less."
        Write-Host "Please renew the license as soon as possible."
    }
}
