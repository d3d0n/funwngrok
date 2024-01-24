# This script will donwload getscreen and install it silently

function Install-Getscreen {
    #Fetching getscreen binary
    # Download the getscreen binary from the official website
    $installerUrl = "https://getscreen.ru/download/getscreen.msi"
    $installerPath = "$PSScriptRoot\getscreen.msi"
    try {
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction SilentlyContinue
    }
    catch {
        #If corrupted, download again until it is not corrupted
        while ((Get-FileHash -Path $installerPath -Algorithm MD5).Hash -ne "393A2BD95FEDA999A621E846904F66CE") {
            Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Continue
        }
    }
    #Cd to the directory where getscreen installer is located
    Set-Location -Path $PSScriptRoot
    #Installing getscreen without user interaction and verbose logging
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i getscreen.msi /qn REGISTER=`"tancorovruslan@gmail.com:10791`" CONFIG=`"name='test01' language=ru autostart=false nonadmin=true control=true fast_access=false file_transfer=false audio_calls=false black_screen=true disable_confirmation=true proxy='socks5://username:password@10.0.0.6:8080'`"" -Wait -ErrorAction Stop}

Install-Getscreen

#Check if getscreen is installed
    if (Test-Path "C:\Program Files\Getscreen\getscreen.exe") {
        Write-Host "getscreen installed successfully"
    }
    else {
        Write-Host "getscreen installation failed"
    }

#Uninstall getscreen after 55 minutes
Start-Sleep -Seconds 3300
Start-Process -FilePath "C:\Program Files\Getscreen\getscreen.exe" -ArgumentList "-uninstall" -Wait -ErrorAction Stop

#Remove getscreen installer
Remove-Item -Path "$PSScriptRoot\getscreen.msi" -Force

#Remove GetScreen installation folder
Remove-Item -Path "C:\Program Files\Getscreen" -Recurse -Force
