 New-Item -Path 'C:\Windows\Temp\Startup_App.txt' -ErrorAction Ignore
Get-CimInstance Win32_StartupCommand |Select-Object Name, command, Location, User |Format-Table -Property Name, command, Location, User  | Select-Object -First 20 |Out-File -FilePath 'C:\Windows\Temp\Startup_App.txt'
Invoke-Item -Path 'C:\Windows\Temp\Startup_App.txt'


