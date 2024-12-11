
# Retrieve a list of local users

$localUsers = Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true }
 
# Get the current date

$currentDate = Get-Date
 
# Iterate through each local user

foreach ($user in $localUsers) {

    # Retrieve the last logon time for the user

    $lastLogon = Get-WmiObject Win32_UserProfile | Where-Object { $_.LocalPath.EndsWith("\$($user.Name)") } | Select-Object -ExpandProperty LastUseTime
 
    # Convert lastLogon to DateTime

    if ($lastLogon -ne $null) {

        $lastLogon = [Management.ManagementDateTimeConverter]::ToDateTime($lastLogon)

    }
 
    # Check if the user has never logged in or has not logged in for more than 2 days

    if ($lastLogon -eq $null -or ($currentDate - $lastLogon).TotalDays -gt 2) {

        if ($lastLogon -eq $null) {

            Write-Output "Local user $($user.Name) has never logged in."

        } else {

            Write-Output "Local user $($user.Name) has not logged in for more than 2 days."

        }

    }

}