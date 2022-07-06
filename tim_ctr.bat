@echo off
setlocal EnableDelayedExpansion
set "DateToJDN(Date)=( a=1Date, y=a%%10000, a/=10000, m=a%%100, d=a/100-100, a=(m-14)/12, (1461*(y+4800+a))/4+(367*(m-2-12*a))/12-(3*((y+4900+a)/100))/4+d-32075 )"

rem Enter two timestamps in "DD/MM/YYYY HH:MM:SS" format
::czas aktuany dla Inventora23
::date 9-05-2022
::time 8:14
rem critical time and date
set stamp1=25/06/2022 16:50:00 
set datecrit=%stamp1:~0,2%-%stamp1:~3,2%-%stamp1:~6,4%
set timecrit=%stamp1:~11,5%
set stamp2=%date:~0,2%/%date:~3,2%/%date:~6,4% %time:~0,8%


@C:\WINDOWS\system32\netsh interface set interface name="Wi-Fi" admin=DISABLED
@C:\WINDOWS\system32\netsh interface set interface name="Wi-Fi" admin=ENABLED

@C:\WINDOWS\system32\reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters /v Type /d NoSync /f


date %datecrit%
time %timecrit%


for /L %%i in (1,1,1000) do (echo %%i 
								
							 call :timecorect) 
						


						
:timecorect
	@C:\WINDOWS\system32\ping 127.0.0.1 -n 60 -w 1000 > nul
	set stamp2=%date:~0,2%/%date:~3,2%/%date:~6,4% %time:~0,8%

echo datecrit %datecrit%
echo timecrit %timecrit%

echo stamp1 %stamp1%
echo stamp2 %stamp2%

for /F "tokens=1-4" %%a in ("%stamp1% %stamp2%") do set "date1=%%a" & set "time1=%%b" & set "date2=%%c" & set "time2=%%d"

set /A "days=!DateToJDN(Date):Date=%date2:/=%! - !DateToJDN(Date):Date=%date1:/=%!"
set /A "ss=(((1%time2::=-100)*60+1%-100) - (((1%time1::=-100)*60+1%-100)"
if %ss% lss 0 set /A "ss+=60*60*24, days-=1"
set /A "hh=ss/3600+100, ss%%=3600, mm=ss/60+100, ss=ss%%60+100"

echo/
echo Duration: %days% days and %hh:~1%:%mm:~1%:%ss:~1%

	if %days% GTR 1 (goto :proc1) else (goto :proc2)
		goto :eop
		: proc1
			date %date_main%
			time %time_main%
			echo po jabkach
			echo time_main z ifa %time_main% >> CzasPrzelaczenia.txt
			echo date_main z ifa %date_main% >> DataPrzelaczenia.txt  
			echo time_main z ifa %time_main%
			echo date_main z ifa %date_main%  
			
		goto :eop
		: proc2
			echo na czas 
		:eop

set time_main=%time%
set date_main=%date%

echo time_main %time_main%
echo date_main %date_main%

echo time_main %time_main% >> logTimeCtr.txt
echo date_main %date_main% >> logTimeCtr.txt
