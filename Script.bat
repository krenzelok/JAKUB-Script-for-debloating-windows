@echo off
cls
goto menu

:menu
echo.
echo     JJ AAAAAA KK  KK UU  UU BBBBBB
echo     JJ AA  AA KKKK   UU  UU BB  BB
echo     JJ AAAAAA KK  KK UU  UU BBBBBB
echo JJJJJJ AA  AA KK  KK UUUUUU BBBBBB
echo.
echo                Script             
echo   This will go to the readme file
echo.
set /p eyn=Enter y/n :
if "%eyn%"=="y" (
    goto readme
) else if "%eyn%"=="n" (
    cls
    echo Exiting.
    timeout /t 1 >nul
    exit
) else (
    cls
    echo You typed something wrong
    timeout /t 1 >nul
    cls
    goto menu
)

:readme
cls
echo This will
echo 1. Uninstall Edge
echo 2. Remove Telemetry
echo 3. Set services to Manual
echo 4. Remove AI,Brave Telemetry and a bunch of stuff
echo 5. Remove Microsoft store or only bloat
echo 6. Install essential programs like 7zip
echo.
set /p cyn=Do you wish to continue y/n :
if "%cyn%"=="y" (
    cls
    goto processyes
) else if "%cyn%"=="n" (
    cls
    echo Exiting.
    timeout /t 1 >nul
    exit
) else (
    cls
    echo You typed something wrong
    timeout /t 1 >nul
    goto readme
)

:processyes
echo Uninstalling Edge

set URL=https://raw.githubusercontent.com/ShadowWhisperer/Remove-MS-Edge/main/Batch/Edge.bat
set OUT=Edge.bat

powershell -NoProfile -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%OUT%'"
call "%OUT%"

echo Finished.
echo Removing Telemetry

set OWNER=EXLOUD
set REPO=Windows-Telemetry-Disabler
set ZIP_URL=https://github.com/%OWNER%/%REPO%/archive/refs/heads/main.zip
set OUT_ZIP=%REPO%-main.zip

powershell -NoProfile -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%OUT_ZIP%'"
powershell -NoProfile -Command "Expand-Archive -Path '%OUT_ZIP%' -DestinationPath '.' -Force"

call ".\%REPO%-main\launcher.bat"

echo Finished.
echo Setting services to Manual
echo.

echo Setting only essential Windows services to Automatic...
REM === CRITICAL SERVICES ===
sc config RpcSs start= auto
sc config DcomLaunch start= auto
sc config EventLog start= auto
sc config PlugPlay start= auto
sc config Power start= auto
sc config LSM start= auto
sc config SamSs start= auto
sc config Winmgmt start= auto
sc config Dhcp start= auto
sc config nsi start= auto
sc config NlaSvc start= auto
sc config MpsSvc start= auto
sc config WinDefend start= auto
sc config CryptSvc start= auto
sc config LanmanWorkstation start= auto
sc config W32Time start= auto
sc config Dnscache start= auto
sc config Themes start= auto
sc config EventSystem start= auto
sc config ShellHWDetection start= auto
sc config Schedule start= auto

echo Setting non-critical services to Manual startup...
REM === NON-ESSENTIAL SERVICES ===
sc config DiagTrack start= demand
sc config WSearch start= demand
sc config Fax start= demand
sc config TrkWks start= demand
sc config MapsBroker start= demand
sc config PcaSvc start= demand
sc config RemoteRegistry start= demand
sc config RetailDemo start= demand
sc config seclogon start= demand
sc config TabletInputService start= demand
sc config WerSvc start= demand
sc config stisvc start= demand
sc config wisvc start= demand
sc config XblAuthManager start= demand
sc config XblGameSave start= demand
sc config icssvc start= demand
sc config CertPropSvc start= demand
sc config WMPNetworkSvc start= demand
sc config TokenBroker start= demand
sc config workfolderssvc start= demand
sc config VacSvc start= demand
sc config WalletService start= demand
sc config WarpJITSvc start= demand
sc config Wcmsvc start= demand
sc config WaaSMedicSvc start= demand
sc config UsoSvc start= demand
sc config SSDPSRV start= demand
sc config PhoneSvc start= demand
sc config NgcSvc start= demand
sc config WPDBusEnum start= demand
sc config WpnService start= demand
sc config WpnUserService start= demand

rem credits to brrrezy

echo Finished.
echo Disabling AI (like copilot,etc)
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((irm 'https://debloat.raphi.re/'))) -DisableTelemetry -DisableBing -DisableSuggestions -DisableBraveBloat -HideChat -DisableFastStartup -DisablePaintAI -DisableNotepadAI -RevertContextMenu -DisableSearchHistory -DisableFindMyDevice -DisableDesktopSpotlight -DisableLockscreenTips -DisableSettings365Ads -DisableStoreSearchSuggestions -DisableSearchHighlights -DisableCopilot -DisableRecall -DisableClickToDo -DisableAISvcAutoStart -DisableDeliveryOptimization -DisableStorageSense -DisableLocationServices -ShowHiddenFolders -DisableStartPhoneLink -DisableGameBarIntegration -DisableDVR -DisableTelemetry -HideTaskview -DisableSuggestions -DisableWidgets -HideOnedrive -Silent"
echo Finished.
echo Removing bloat
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((irm 'https://debloat.raphi.re/'))) -RunDefaults -Silent"
echo Finished.
echo.

goto store

:store
cls
echo Do you want to Uninstall Microsoft store
echo.

set /p syn=Enter y/n :

if "%syn%"=="y" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage Microsoft.WindowsStore | Remove-AppxPackage"
    goto next
) else if "%syn%"=="n" (
    goto next
) else (
   cls
   echo You typed something wrong
   timeout /t 1 >nul
   goto store 
)

:next
echo Finished.
echo Installing essential programs

where choco >nul 2>&1
if %errorlevel%==0 (
  echo Chocolatey found.
) else (
  echo Installing Chocolatey...
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; " ^
    "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
)

"%ALLUSERSPROFILE%\chocolatey\bin\choco.exe" install 7zip -y
goto finale

:finale
cls
echo.
echo Do you have already a browser
echo.

set /p byn=Enter y/n :

if "%byn%"=="n" (
    echo Installing Firefox
    "%ALLUSERSPROFILE%\chocolatey\bin\choco.exe" install firefox -y
)

cls
echo.
echo Want to make some tweaks yourself?
echo.

set /p tyn=Enter y/n :

if "%tyn%"=="y" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm 'https://christitus.com/win')"
)

goto end

:end
cls
echo It seems like everything is done 
echo Thank you for using Jakub script
echo.
echo Credits : Chris titus = Tweaks
echo           brrrezy = Services 
echo           EXLOUD = Telemetry
echo           ShadowWhisperer = Edge
echo           Krenzralok = Script
echo.
echo "Freedom is always better!!!"
echo Made by Krenzralok on Linux 
echo.
echo Press any key to quit
pause >nul
