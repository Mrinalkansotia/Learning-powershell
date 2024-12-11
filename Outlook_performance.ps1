$currentUsername = $env:USERNAME
 $processes = Get-Process
$process = $processes | Where-Object {$_.Name -eq "Outlook"} 
if($process){
  Stop-Process -Name "Outlook"
 }
$cacheFolders = @(
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Olk\cache",
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Olk\logs"
 
)
 
foreach ($folderPath in $cacheFolders) {
    if (Test-Path $folderPath) {
        Remove-Item -Path $folderPath\* -Force -Recurse -Whatif
    
    } 
}