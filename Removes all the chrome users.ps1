$ChromeDir = "$env:LOCALAPPDATA\Google\Chrome\User Data"

if (Test-Path "$ChromeDir\Default") {
    Set-ItemProperty -Path "$ChromeDir\Default" -Name Attributes -Value ([IO.FileAttributes]::ReadOnly -bor [IO.FileAttributes]::Hidden -bor [IO.FileAttributes]::System) -ErrorAction SilentlyContinue
    
    Get-ChildItem -Path $ChromeDir\Default\ -Include *Bookmarks*, *Preferences* | ForEach-Object {
        $_ | Set-ItemProperty -Name Attributes -Value ([IO.FileAttributes]::ReadOnly -bor [IO.FileAttributes]::Hidden -bor [IO.FileAttributes]::System) -ErrorAction SilentlyContinue
    }

    if (Test-Path "$ChromeDir\Default\Extensions") {
        Get-ChildItem -Path "$ChromeDir\Default\Extensions" -Recurse | ForEach-Object {
            $_ | Set-ItemProperty -Name Attributes -Value ([IO.FileAttributes]::ReadOnly -bor [IO.FileAttributes]::Hidden -bor [IO.FileAttributes]::System) -ErrorAction SilentlyContinue
        }
    }

    Remove-Item -Path $ChromeDir\* -Recurse -Force -ErrorAction SilentlyContinue

    Set-ItemProperty -Path "$ChromeDir\Default" -Name Attributes -Value 0 -ErrorAction SilentlyContinue
    Get-ChildItem -Path $ChromeDir\Default\ -Include *Bookmarks*, *Preferences* | ForEach-Object {
        $_ | Set-ItemProperty -Name Attributes -Value 0 -ErrorAction SilentlyContinue
    }

    if (Test-Path "$ChromeDir\Default\Extensions") {
        Get-ChildItem -Path "$ChromeDir\Default\Extensions" -Recurse | ForEach-Object {
            $_ | Set-ItemProperty -Name Attributes -Value 0 -ErrorAction SilentlyContinue
        }
    }
}
