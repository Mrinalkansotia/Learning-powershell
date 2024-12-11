if ($Message -eq "") { $Message = read-host "Hello how are you" }
    $Time = "16:05"
	$Task = New-ScheduledTaskAction -Execute msg -Argument "* $Message"
	$Trigger = New-ScheduledTaskTrigger -Once -At $Time
	$Random = (Get-Random)
	Register-ScheduledTask -Action $Task -Trigger $Trigger -TaskName "Reminder_$Random" -Description "Reminder"
	exit 0