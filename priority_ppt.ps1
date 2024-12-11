$powerpointProcesses = Get-Process -Name powerpnt
foreach ($process in $powerpointProcesses) 
{
    $process.PriorityClass = 'High'
}
