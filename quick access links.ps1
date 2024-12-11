$currentUsername = $env:USERNAME
 
$path = "C:\Users\$currentUsername\AppData\Roaming\Microsoft\Windows\Recent"
 
 
Get-ChildItem -Path "C:\Users\$currentUsername\AppData\Roaming\Microsoft\Windows\Recent"  | foreach { Remove-Item  -Path $_.FullName -WhatIf}