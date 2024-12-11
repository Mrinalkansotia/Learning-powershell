$processes = Get-Process
$process = $processes | Where-Object {$_.Name -eq "Chrome"} 
if($process){
  Stop-Process -Name "Chrome"
}  
Start-process -FilePath 'C:\Program Files (x86)\Google\Update\GoogleUpdate.exe'