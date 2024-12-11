$currentUsername = $env:USERNAME
$limit = (Get-Date).AddDays(-2)
$path = "C:\Users\$currentUsername\Downloads"


Get-ChildItem -Path $path -Recurse -Force | Where-Object {!$_.PSIsContainer -and $_.Extension -notin ' .docx','.xlsx','.pptx','.rtf','accdb','.csv '-and $_.CreationTime -lt $limit } | Remove-Item -Force -WhatIf