$processes = Get-Process
$process = $processes | Where-Object {$_.Name -eq "Firefox"} 
if($process){
  Stop-Process -Name "Firefox"
}  
Start-process -FilePath 'C:\Program Files (x86)\Mozilla Maintenance Service\maintenanceservice.exe'