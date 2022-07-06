@echo off

echo off
@C:\Windows\System32\taskkill /f /im "adskflex.exe"
@C:\Windows\System32\taskkill /f /im "AdskLicensingService.exe"
@C:\Windows\System32\taskkill /f /im "ApplicationFrameHost.exe"
@C:\Windows\System32\taskkill /f /im "ADPClientService.exe"
@C:\Windows\System32\taskkill /f /im "AdskLicensingService.exe"
@C:\Windows\System32\taskkill /f /im "AdSSO.exe"
@C:\Windows\System32\taskkill /f /im "AdskLicensingAgent.exe"
@C:\Windows\System32\taskkill /f /im "AdskLicensingService.exe"

w32tm /query /peers
sc config w32time start= auto
w32tm /config /syncfromflags:manual /manualpeerlist:"0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org"
w32tm /config /reliable:yes
net stop w32time
net start w32time
w32tm /resync /nowait

