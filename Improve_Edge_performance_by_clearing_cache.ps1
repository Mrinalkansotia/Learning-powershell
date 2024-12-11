$currentUsername = $env:USERNAME
$processes = Get-Process
$process = $processes | Where-Object {$_.Name -eq "Edge"} 
if($process){
  Stop-Process -Name "Edge"
 }
$cacheFolders = @(
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data",
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Edge\User Data\Default\Service Worker\CacheStorage",
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Edge\User Data\Default\Shared Dictionary\cache",
    "C:\Users\$currentUsername\AppData\Local\Microsoft\Edge\User Data\Default\Code Cache"
)
 
foreach ($folderPath in $cacheFolders) {
    if (Test-Path $folderPath) {
        Remove-Item -Path $folderPath\* -Force -Recurse
        Write-Host "Files deleted from $folderPath"
    } else {
        Write-Host "Folder $folderPath does not exist."
    }
}