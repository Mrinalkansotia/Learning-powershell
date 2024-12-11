$outlookProcesses = Get-Process -Name outlook
foreach ($process in $outlookProcesses)
 {
    $process.PriorityClass = 'High'
}
