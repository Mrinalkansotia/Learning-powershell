Morethan100{


$process = Get-Process|Get-Unique| where-object {$_.WorkingSet -GT 100000*1024}|select processname,@{l="Used RAM(MB)"; e={$_.workingset / 1mb}} |sort "Used RAM(MB)" –Descending 
}
Stop-Process -InputObject $process -WhatIf