$currentUsername = $env:USERNAME
$processes = Get-Process
$process = $processes | Where-Object {$_.Name -eq "teams"} 
if($process){
  Stop-Process -Name "teams"
}  

    if (Get-WmiObject -Class Win32_Product -Filter "Name='{Microsoft Teams}'") {


$cacheFolders = @(
    "C:\Users\$currentUsername\AppData\Local\Microsoft\TeamsMeetingAddin",
    "C:\Users\$currentUsername\AppData\Local\Microsoft\TeamsPresenceAddin",
    "C:\Users\$currentUsername\AppData\Roaming\Microsoft\Teams"
)
 
foreach ($folderPath in $cacheFolders) {
    if (Test-Path $folderPath) {
        Remove-Item -Path $folderPath\* -Force -Recurse -Whatif 
        Write-Host "Files deleted from $folderPath"
    } else {
        Write-Host "Folder $folderPath does not exist."
    }
}
Start-Process -File $env:LOCALAPPDATA\Microsoft\Teams\Update.exe -ArgumentList '--processStart "Teams.exe"'
}