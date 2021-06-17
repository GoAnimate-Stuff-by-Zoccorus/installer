:: Wrapper: Offline Installer
:: Author: octanuary#6596
:: i mean benson made most of it since a lot of this was taken from start_wrapper.bat
:: License: MIT
title Wrapper: Offline Installer [Initializing...]

::::::::::::::::::::
:: Initialization ::
::::::::::::::::::::

:: Stop commands from spamming stuff, cleans up the screen
@echo off && cls

:: Lets variables work or something idk im not a nerd
SETLOCAL ENABLEDELAYEDEXPANSION

:: Make sure we're starting in the correct folder, and that it worked (otherwise things would go horribly wrong)
pushd "%~dp0"

:: Check *again* because it seems like sometimes it doesn't go into dp0 the first time???
pushd "%~dp0"

::::::::::::::::::::::
:: Dependency Check ::
::::::::::::::::::::::

title Wrapper: Offline Installer [Checking for Git...]
echo Checking for Git installation...

:: Preload variables
set GIT_DETECTED=n

:: Git check
for /f "delims=" %%i in ('git --version 2^>nul') do set output=%%i
IF "!output!" EQU "" (
	echo Git could not be found.
) else (
	echo Git is installed.
	echo:
	set GIT_DETECTED=y
)
popd

::::::::::::::::::::::::
:: Dependency Install ::
::::::::::::::::::::::::

if !GIT_DETECTED!==n (
	title Wrapper: Offline Installer [Installing Git...]
	echo:
	echo Installing Git...
	echo:
	fsutil dirty query !systemdrive! >NUL 2>&1
	if /i not !ERRORLEVEL!==0 (
		color cf
		cls
		echo:
		echo ERROR
		echo:
		echo Wrapper: Offline needs to install Git and launch the launcher as admin later.
		echo To do this, the installer must be started with Admin rights.
		echo:
		echo Press any key to restart this window and accept any admin prompts that pop up.
		pause
		echo Set UAC = CreateObject^("Shell.Application"^)>> %tmp%\requestAdmin.vbs
		set params= %*
		echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1>> %tmp%\requestAdmin.vbs
		start "" %tmp%\requestAdmin.vbs
		exit /B
		)
	)
)
:postadmincheck
if exist "%tmp%\requestAdmin.vbs" ( del "%tmp%\requestAdmin.vbs">nul )

if !GIT_DETECTED!==n (
	:: Install Git
	if not exist "git_installer.exe" (
		echo We have a problem. The Git installer doesn't exist.
		echo A normal copy of the Wrapper: Offline installer should come with one.
		echo You should be able to find a copy on this website:
		echo https://git-scm.com/downloads
		pause & exit
	)
	echo Proper Git installation doesn't seem possible to do automatically.
	echo You can just keep clicking next until it finishes,
	echo and the W:O installer will continue once it closes.
	start "" "git_installer.exe"
	goto git_installed
	
	:git_installed
	echo Git has been installed.
	echo:
	echo You may now restart the installer.
	echo Make sure to start it as admin still.
	echo:
	pause & exit
)

:::::::::::::::::::::::::
:: Post-Initialization ::
:::::::::::::::::::::::::

title Wrapper: Offline Installer
:cls
cls

:disclaimer
echo Wrapper: Offline is a project to preserve the original GoAnimate flash-based themes.
echo We believe they should be archived for others to use and learn about in the future.
echo All business themes have been removed, please use Vyond Studio if you wish to get those.
echo This is still unlawful use of copyrighted material, but ^(in our opinion^) morally justifiable use.
echo:
echo We are not affiliated in any form with Vyond or GoAnimate Inc. We generate no profit from this.
echo We do not wish to promote piracy, and we avoid distributing content that is still in use by GoAnimate Inc.
echo We have tried to reduce any harm we could do to GoAnimate Inc while making this project.
echo:
echo Excluding Adobe Flash and GoAnimate Inc's assets, Wrapper: Offline is free/libre software.
echo You are free to redistribute and/or modify it under the terms of the MIT ^(aka Expat^) license,
echo except for some dependencies which have different licenses with slightly different rights.
echo Read the LICENSE file in Offline's base folder and the licenses in utilities/sourcecode for more info.
echo:
echo By continuing to use Wrapper: Offline, you acknowledge the nature of this project, and your right to use it.
echo If you object to any of this, feel free to close the Wrapper: Offline installer now.
echo You will be allowed to accept 15 seconds after this message has appeared.
echo: 
PING -n 16 127.0.0.1>nul
echo If you still want to install and use Wrapper: Offline, press Y. If you no longer want to, press N.
:disclaimacceptretry
set /p ACCEPTCHOICE= Response:
echo:
if not '!acceptchoice!'=='' set acceptchoice=%acceptchoice:~0,1%
if /i "!acceptchoice!"=="y" goto disclaimaccepted
if /i "!acceptchoice!"=="n" exit
goto disclaimacceptretry
:disclaimaccepted
echo: 
echo Sorry for all the legalese, let's get back on track.
echo You've accepted the disclaimer. To reread it, remove this file.>%tmp%\WOdisclaimer.txt
PING -n 4 127.0.0.1>nul
echo:

:standard
cls
echo Wrapper: Offline Installer
echo A project from VisualPlugin adapted by Benson and the Wrapper: Offline Team
echo:
echo Enter 1 to install Wrapper: Offline
echo Enter 0 to close the installer
:wrapperidle
echo:

:::::::::::::
:: Choices ::
:::::::::::::

set /p CHOICE=Choice:
if "!choice!"=="0" goto exit
if "!choice!"=="1" goto downloadoptions
:: funni options
if "!choice!"=="43" echo OH MY GOD. FOURTY THREE CHARS. NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO & goto wrapperidle
if "!choice!"=="69" echo nice & goto wrapperidle
if /i "!choice!"=="benson" echo watch benson on youtube & goto wrapperidle
if /i "!choice!"=="ford" echo what up son & goto wrapperidle
if /i "!choice!"=="no" echo stahp & goto wrapperidle
if /i "!choice!"=="yes" echo Alright. & goto wrapperidle
if /i "!choice!"=="fuck you" echo No, fuck you. & goto wrapperidle
if /i "!choice!"=="sex" echo that's fake & goto wrapperidle
if /i "!choice!"=="watch benson on youtube" goto w_a_t_c_h
if /i "!choice!"=="narutofan420" echo i am narutofan420 i am a naruto fan i watch naruto i watched all 3 series and still watch it & goto wrapperidle
if /i "!choice!"=="die" echo die please & goto wrapperidle
if /i "!choice!"=="spark" echo WHY DID SOMEONE FUCK UP THE LAUNCHER? & goto wrapperidle
if /i "!choice!"=="l33t" echo nice l33t video & goto wrapperidle
echo Time to choose. && goto wrapperidle

:downloadoptions
cls
echo Press 1 if you would like to install the latest build of 1.3.x. ^(Default^)
echo Press 2 if you would like to install 1.3.0 Build 72. ^(LTS, no updates^)
echo:
:dlchoiceretry
set /p DLCHOICE=Choice: 
if "!dlchoice!"=="1" ( goto download13x )
if "!dlchoice!"=="2" ( goto download13072 )

:download13x
cls
title Wrapper: Offline Installer [Cloning repository...]
pushd "%~dp0..\"
echo Cloning the latest version of the repository from GitHub...
echo:
call git clone https://github.com/Wrapper-Offline/wrapper-offline.git --recursive
set WOPATH=wrapper-offline
goto manualreset

:download13072
cls
title Wrapper: Offline Installer [Downloading repository...]
echo Downloading the repository for 1.3.0 Build 72 through PowerShell...
echo ^(NOTE: DO NOT CLOSE POWERSHELL OR IT WILL FAIL^!^)
echo:
start powershell -Command "Invoke-WebRequest https://github.com/Wrapper-Offline/wrapper-offline/archive/refs/tags/1.2.3-Final-Build.zip -OutFile %~dp0..\wrapper-offline.zip"
tasklist /FI "IMAGENAME eq powershell.exe" 2>NUL | find /I /N "powershell.exe">NUL
if "%ERRORLEVEL%"=="0" (
	echo:>nul
) else (
	wmic datafile where Name="%~dp0..\wrapper-offline.zip"
	if "%ERRORLEVEL%"=="0" (
		set WOPATH=wrapper-offline\wrapper-offline
		title Wrapper: Offline Installer [Extracting repository...]
		echo Extracting the repository to the directory where the .ZIP was downloaded...
		call 7za.exe e "%~dp0..\wrapper-offline.zip" -o"%dp0..\wrapper-offline"
		pushd "%~dp0..\"
		goto manualreset
	) else (
		echo ERROR: Installation failed!
		echo:
		set /p CLOSEOUTOFTHE=Close out of the window, or press Enter to restart.
		start "" "%0"
		exit /B
	)
)


:: I'm doing this to get around the .gitignore problem but this is only for first-time users
:manualreset
echo Resetting config.bat...
del !wopath!\utilities\config.bat
echo :: Wrapper: Offline Config>> !wopath!\utilities\config.bat
echo :: This file is modified by settings.bat. It is not organized, but comments for each setting have been added.>> !wopath!\utilities\config.bat
echo :: You should be using settings.bat, and not touching this. Offline relies on this file remaining consistent, and it's easy to mess that up.>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Opens this file in Notepad when run>> !wopath!\utilities\config.bat
echo setlocal>> !wopath!\utilities\config.bat
echo if "%%SUBSCRIPT%%"=="" ( start notepad.exe "%%CD%%\%%~nx0" ^& exit )>> !wopath!\utilities\config.bat
echo endlocal>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Shows exactly Offline is doing, and never clears the screen. Useful for development and troubleshooting. Default: n>> !wopath!\utilities\config.bat
echo set VERBOSEWRAPPER=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Won't check for dependencies (flash, node, etc) and goes straight to launching. Useful for speedy launching post-install. Default: n>> !wopath!\utilities\config.bat
echo set SKIPCHECKDEPENDS=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Won't install dependencies, regardless of check results. Overridden by SKIPCHECKDEPENDS. Mostly useless, why did I add this again? Default: n>> !wopath!\utilities\config.bat
echo set SKIPDEPENDINSTALL=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Opens Offline in an included copy of ungoogled-chromium. Allows continued use of Flash as modern browsers disable it. Default: y>> !wopath!\utilities\config.bat
echo set INCLUDEDCHROMIUM=y>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Opens INCLUDEDCHROMIUM in headless mode. Looks pretty nice. Overrides CUSTOMBROWSER and BROWSER_TYPE. Default: y>> !wopath!\utilities\config.bat
echo set APPCHROMIUM=y>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Opens Offline in a browser of the user's choice. Needs to be a path to a browser executable in quotes. Default: n>> !wopath!\utilities\config.bat
echo set CUSTOMBROWSER=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Lets the launcher know what browser framework is being used. Mostly used by the Flash installer. Accepts "chrome", "firefox", and "n". Default: n>> !wopath!\utilities\config.bat
echo set BROWSER_TYPE=chrome>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Runs through all of the scripts code, while never launching or installing anything. Useful for development. Default: n>> !wopath!\utilities\config.bat
echo set DRYRUN=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Makes it so it uses the Cepstral website instead of VFProxy. Default: n>> !wopath!\utilities\config.bat
echo set CEPSTRAL=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Opens Offline in an included copy of Basilisk, sourced from BlueMaxima's Flashpoint.>> !wopath!\utilities\config.bat
echo :: Allows continued use of Flash as modern browsers disable it. Default: n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo set INCLUDEDBASILISK=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Makes it so both the settings and the Wrapper launcher shows developer options. Default: n>> !wopath!\utilities\config.bat
echo set DEVMODE=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Tells settings.bat which port the frontend is hosted on. ^(If changed manually, you MUST also change the value of "SERVER_PORT" to the same value in wrapper\env.json^) Default: 4343>> !wopath!\utilities\config.bat
echo set PORT=4343>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo :: Enables configure_wrapper.bat. Useful for investigating things like problems with Node.js or http-server. Default: n>> !wopath!\utilities\config.bat
echo set CONFIGURE=n>> !wopath!\utilities\config.bat
echo:>> !wopath!\utilities\config.bat
echo Resetting imported assets...
pushd !wopath!\server\store\3a981f5cb2739137
rd /q /s import
md import
pushd import
echo ^<?xml version="1.0" encoding="utf-8"?^> >>theme.xml
echo ^<theme id="import" name="Imported Assets" cc_theme_id="import"^> >>theme.xml
echo 	^<char id="327068788" name="the benson apparition" cc_theme_id="family" thumbnail_url="char-default.png" copyable="Y"^> >>theme.xml
echo 	^<tags^>family,every,copy,of,wrapper,offline,is,_free,software,but,is,also,_cat:personalized^</tags^> >>theme.xml
echo 	^</char^> >>theme.xml
echo:>>theme.xml
echo ^</theme^> >>theme.xml
popd
call !wopath!\utilities\7za.exe a "!wopath!\server\store\3a981f5cb2739137\import\import.zip" "!wopath!\server\store\3a981f5cb2739137\import\theme.xml" >nul
del /q /s !wopath!\utilities\import_these
md !wopath!\utilities\import_these
copy "!wopath!\server\store\3a981f5cb2739137\import\theme.xml" "!wopath!\wrapper\_THEMES\import.xml" /y
echo Moving "disclaimer accepted" text file from temporary system directory to utilities\checks folder...
copy "%tmp%\WOdisclaimer.txt" "!wopath!\utilities\checks\disclaimer.txt" /y
del "%tmp%\WOdisclaimer.txt"
echo Creating quick shortcut in directory where Wrapper was cloned using NirCMD...
if exist "!wopath!\Wrapper Offline.lnk" ( del "!wopath!\Wrapper Offline.lnk" )
echo:
pushd wrapper-offline
call utilities\nircmd\nircmd.exe shortcut "%windir%\System32\cmd.exe /c START '' 'start_wrapper.bat'" "%CD%" "Wrapper Offline" "" "%CD%\wrapper\favicon.ico" "" "" "%CD%\"
popd
echo Shortcut created.
echo:
cls
echo The repository has been cloned.
echo:
echo The next step is to run "start_wrapper.bat" as admin
echo to install any extra dependencies that might be missing.
echo:
fsutil dirty query !systemdrive! >NUL 2>&1
if /i not !ERRORLEVEL!==0 (
	echo However, it appears that for some reason you aren't
	echo still running this installer as admin, so you will
	echo need to do it manually.
	echo:
	pause
	start "" "%~dp0..\wrapper-offline"
	echo The directory where it cloned to has been opened.
	echo:
	echo Right click "start_wrapper.bat" and run it as admin.
	echo When finished, press any key for further instructions.
	echo:
	pause
) else (
	pause
	start "" "%~dp0..\!wopath!\start_wrapper.bat"
	echo:
	echo The rest of the installer has been launched.
	echo:
	echo When finished with this step, press any key for further instructions.
	echo:
	pause
)
echo Wrapper: Offline has been installed^^! Feel free to move it wherever you want.
echo:
echo Would you like to add a shortcut on your desktop?
echo:
echo Press 1 if you'd like to.
echo Otherwise, hit enter.
echo:
set /p SHORTCUT= Option: 
if "!shortcut!"=="1" (
	echo Running Wrapper's included NirCMD...
	PING -n 4 127.0.0.1>nul
	echo:
	pushd wrapper-offline
	call utilities\nircmd\nircmd.exe shortcut "%CD%\start_wrapper.bat" "~$folder.desktop$" "Wrapper Offline" "" "%CD%\wrapper\favicon.ico"
	popd
	if exist "%ONEDRIVE%\Desktop" (
		copy "%ONEDRIVE%\Desktop\Wrapper Offline.lnk" "%Public%\Desktop"
	) else (
		copy "%USERPROFILE%\Desktop\Wrapper Offline.lnk" "%Public%\Desktop"
	)
	echo Shortcut created on Desktop.
	echo:
)
start "" "%~dp0..\wrapper-offline"
pause & exit

:w_a_t_c_h
echo watch benson on youtube
echo watch benson on youtube
echo watch benson on youtube
echo watch benson on youtube
echo watch benson on youtube
echo wa
goto wrapperidle

:exit
pause & exit
