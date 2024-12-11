$localUsers = Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true -and $_.Disabled -eq $false -and $_.SID -notlike "S-1-5-21-*-*-*-500" }

$currentDate = Get-Date

foreach ($user in $localUsers) {
    $lastLogon = Get-WmiObject Win32_UserProfile | Where-Object { $_.LocalPath.EndsWith("\$($user.Name)") } | Select-Object -ExpandProperty LastUseTime

    if ($lastLogon -ne $null) {
        $lastLogon = [Management.ManagementDateTimeConverter]::ToDateTime($lastLogon)
    }

    $daysSinceLastLogon = -1
    if ($lastLogon -ne $null) {
        $daysSinceLastLogon = ($currentDate - $lastLogon).TotalDays
    }

    if ($daysSinceLastLogon -eq -1) {
        Write-Output "Local user $($user.Name) has never logged in."
    } elseif ($daysSinceLastLogon -gt 60) {
        Write-Output "Local user $($user.Name) has not logged in for more than 60 days."
    }
}