$currentUsername = $env:USERNAME
$path = "C:\Users\$currentUsername\AppData\Roaming\Microsoft\Windows\Recent"
 
Get-ChildItem -Path $path -Filter *.lnk | ForEach-Object {
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($_.FullName)
    [PSCustomObject]@{
        Name = $_.Name
        Extension = [System.IO.Path]::GetExtension($shortcut.TargetPath)
    }
}