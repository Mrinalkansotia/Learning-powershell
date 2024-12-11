
 New-Item -Path 'C:\Windows\Temp\High_CPU_usage.txt' -ErrorAction Ignore
Get-Process | Sort-Object -Property CPU -Descending |Format-Table -Property CPU, ID, Processname  | Select-Object -First 20 |Out-File -FilePath 'C:\Windows\Temp\High_CPU_usage.txt'
Start-Process 'C:\Windows\Temp\High_CPU_usage.txt'