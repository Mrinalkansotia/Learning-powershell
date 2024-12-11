(Get-WmiObject Win32_Pagefile) –eq $null

$sys = Get-WmiObject Win32_Computersystem –EnableAllPrivileges
$sys.AutomaticManagedPagefile = $false
$sys.put()