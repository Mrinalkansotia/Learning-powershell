$bluetooth = Await ([Windows.Devices.Radios.Radio]::GetRadiosAsync()) ([System.Collections.Generic.IReadOnlyList[Windows.Devices.Radios.Radio]])
$bluetooth = $bluetooth | Where-Object { $_.Kind -eq 'Bluetooth' }
 
if ($bluetooth.State -eq 'On') {
    $NewBluetoothStatus = 'Off'   
} else {
    $NewBluetoothStatus = 'On'
}
Await ($bluetooth.SetStateAsync($NewBluetoothStatus)) ([Windows.Devices.Radios.RadioAccessStatus]) | Out-Null