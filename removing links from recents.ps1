$currentUsername = $env:USERNAME
$path = "C:\Users\$currentUsername\AppData\Roaming\Microsoft\Windows\Recent"

Get-ChildItem -Path $path -Filter *.lnk | ForEach-Object {
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($_.FullName)
    $extension = [System.IO.Path]::GetExtension($shortcut.TargetPath)

    if ($extension -match '\.(docx|pdf|txt|ppt|xlsx)$') {
        Remove-Item -Path $_.FullName -Force
        Write-Host "Removed shortcut: $($_.Name) pointing to $extension file."
    }
}