$fileDirectory = "c:\program files\mcafee\x86\"

$command = "$fileDirectory\frminst.exe /forceuninstall"

Invoke-Expression $command
