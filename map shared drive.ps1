$localmachine = hostname
New-PSDrive -Name "DRIVER-LETTER" -PSProvider "FileSystem" -Root "\\$localmachine\SHARED-FOLDER" -Persist