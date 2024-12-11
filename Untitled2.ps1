$wordProcesses = Get-Process -Name winword
foreach ($process in $wordProcesses) {
    $process.PriorityClass = 'High'
}