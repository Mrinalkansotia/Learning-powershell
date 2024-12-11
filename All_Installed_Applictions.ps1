$FILE = "C:\Windows\Temp\InstalledSoftware.txt"

If (Test-Path $FILE) { Clear-Content -Path $FILE -Force }

Function Write-LineToFile {
    param([Parameter(Mandatory=$true)][string]$Path,[Parameter(Mandatory=$true)][string]$Line)
    If (-not (Test-Path $Path)) {
        Try { New-Item -Path $Path -ItemType File -Force | Out-Null }
        Catch { Write-Error $_.Exception.Message }
    }
    Try { Add-Content -Path $Path -Value $Line }
    Catch { Write-Error $_.Exception.Message }
}

Function Test-ItemProperty {
    param([Parameter(Mandatory=$true)][string]$Path,[Parameter(Mandatory=$true)][string]$Name)
    Try {
        $test = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue
        If (($test -eq $null) -or ($test.Length -eq 0)) { Return $false } Else { Return $true }
    }
    Catch { Return $false }
}

Function Get-ItemPropertyInfo {
    param([Parameter(Mandatory=$true)][string]$Path,[Parameter(Mandatory=$true)][string]$Name)
    If (Test-ItemProperty -Path $Path -Name $Name) {
        $retval = Get-ItemPropertyValue -Path $Path -Name $Name
        $retval = $retval -replace ",", " "

        Switch ($Name) {
            "EstimatedSize" {
                $size = [int]$retval
                $size = [Math]::Ceiling($size / 1024)
                $retval = [string]$size
            }
            "InstallDate" {
                $origRetval = $retval
                Switch -regex ($retval) {
                    '^\d{8}$' { $formatstring = 'yyyyMMdd' }
                    '^\d{1,2}\\\d{1,2}\\\d{4}$' { $formatstring = 'MM\dd\yyyy' }
                    '^\d{4}\\\d{1,2}\\\d{1,2}$' { $formatstring = 'yyyy\MM\dd' }
                    Default { $formatstring = $null }
                }
                Try {
                    If ($formatstring -eq $null) {
                        $date = [datetime]$retval
                    } Else {
                        $date = [datetime]::ParseExact($retval, $formatstring, $null)
                    }
                    $retval = $date.ToString('yyyy-MM-dd')
                }
                Catch { Write-Error $_.Exception.Message; $retval = $origRetval }
            }
            Default {}
        }
    }
    Else { $retval = "" }

    Return $retval
}

Write-LineToFile -Path $FILE -Line "Name,Publisher,Version,InstallDate,EstimatedSize(MB),UninstallString,ModifyPath"

ForEach ($item in $(Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')) {
    $DisplayName = Get-ItemPropertyInfo -Path $item.PSPath -Name DisplayName
    $DisplayVersion = Get-ItemPropertyInfo -Path $item.PSPath -Name DisplayVersion
    $EstimatedSize = Get-ItemPropertyInfo -Path $item.PSPath -Name EstimatedSize
    $InstallDate = Get-ItemPropertyInfo -Path $item.PSPath -Name InstallDate
    $Publisher = Get-ItemPropertyInfo -Path $item.PSPath -Name Publisher
    $UninstallString = Get-ItemPropertyInfo -Path $item.PSPath -Name UninstallString
    $ModifyPath = Get-ItemPropertyInfo -Path $item.PSPath -Name ModifyPath
    If (-not (($DisplayName -eq "") -and ($UninstallString -eq "") -and ($Publisher -eq ""))) {
        $Line = "Name: $DisplayName`r`nPublisher: $Publisher`r`nVersion: $DisplayVersion`r`nInstall Date: $InstallDate`r`nEstimated Size (MB): $EstimatedSize`r`nUninstall String: $UninstallString`r`nModify Path: $ModifyPath`r`n"
        Write-LineToFile -Path $FILE -Line $Line
    }
}

Invoke-Item $FILE
