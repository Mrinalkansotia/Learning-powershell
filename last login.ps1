$localUsers = Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true -and $_.Disabled -eq $false -and $_.SID -notlike "*-500" }
$path = "C:\Users"
$currentDate = Get-Date
$usersToRemove = @()

foreach ($user in $localUsers) {
    $lastLogon = Get-WmiObject Win32_UserProfile | Where-Object { $_.LocalPath.EndsWith("\$($user.Name)") } | Select-Object -ExpandProperty LastUseTime

    if ($lastLogon -eq $null -or ($currentDate - $lastLogon).TotalDays -gt 30) {
        $userProfilePath = Join-Path $path $user.Name
        if (Test-Path $userProfilePath) {
            Remove-Item $userProfilePath -Recurse -Force -WhatIf
            Write-Output "User profile folder for $($user.Name) removed."
            $usersToRemove += $user.Name
        }
    }
}

foreach ($userToRemove in $usersToRemove) {
    $userToRemoveObject = $localUsers | Where-Object { $_.Name -eq $userToRemove }
    Remove-WmiObject -InputObject $userToRemoveObject
    Write-Output "User $($userToRemove) removed from local users."
}
