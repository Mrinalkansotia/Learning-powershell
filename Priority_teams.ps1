$teamsProcesses = Get-Process -Name Teams
foreach ($process in $teamsProcesses)
 {
    $process.PriorityClass = 'High'
}
