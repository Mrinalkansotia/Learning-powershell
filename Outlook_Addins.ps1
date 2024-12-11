$searchScopes = "HKCU:\SOFTWARE\Microsoft\Office\Outlook\Addins","HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins"

$results = $searchScopes | ForEach-Object {
    Get-ChildItem -Path $_ | ForEach-Object {
        Get-ItemProperty -Path $_.PSPath
    } | Select-Object @{n="Name";e={Split-Path $_.PSPath -leaf}}, FriendlyName, Description
} | Sort-Object -Unique -Property Name

$results | Format-Table -AutoSize | Out-File -FilePath "C:\Windows\Temp\OutlookAddins.txt"

Invoke-Item -Path "C:\Windows\Temp\OutlookAddins.txt"
