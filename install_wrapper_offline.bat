:: Wrapper: Offline Installer
:: Author: octanuary#6596 (narutofan420)
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
		echo Close this window and re-open the installer as an Admin.
		echo ^(right-click install_wrapper_offline.bat and click "Run as Administrator"^)
		pause
		exit
		)
	)
)
:postadmincheck

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
if "!choice!"=="1" goto download
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

:download
cls
title Wrapper: Offline Installer [Cloning repository...]
pushd "%~dp0..\"
echo Cloning the latest version of the repository from GitHub...
echo:
call git clone https://github.com/Zoccorus-GoAnimate/wrapper-offline.git
:: I'm doing this to get around the .gitignore problem but this is only for first-time users
echo Resetting config.bat...
del wrapper-offline\utilities\config.bat
echo :: Wrapper: Offline Config>> wrapper-offline\utilities\config.bat
echo :: This file is modified by settings.bat. It is not organized, but comments for each setting have been added.>> wrapper-offline\utilities\config.bat
echo :: You should be using settings.bat, and not touching this. Offline relies on this file remaining consistent, and it's easy to mess that up.>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Opens this file in Notepad when run>> wrapper-offline\utilities\config.bat
echo setlocal>> wrapper-offline\utilities\config.bat
echo if "%%SUBSCRIPT%%"=="" ( start notepad.exe "%%CD%%\%%~nx0" ^& exit )>> wrapper-offline\utilities\config.bat
echo endlocal>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Shows exactly Offline is doing, and never clears the screen. Useful for development and troubleshooting. Default: n>> wrapper-offline\utilities\config.bat
echo set VERBOSEWRAPPER=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Won't check for dependencies (flash, node, etc) and goes straight to launching. Useful for speedy launching post-install. Default: n>> wrapper-offline\utilities\config.bat
echo set SKIPCHECKDEPENDS=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Won't install dependencies, regardless of check results. Overridden by SKIPCHECKDEPENDS. Mostly useless, why did I add this again? Default: n>> wrapper-offline\utilities\config.bat
echo set SKIPDEPENDINSTALL=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Opens Offline in an included copy of ungoogled-chromium. Allows continued use of Flash as modern browsers disable it. Default: y>> wrapper-offline\utilities\config.bat
echo set INCLUDEDCHROMIUM=y>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Opens INCLUDEDCHROMIUM in headless mode. Looks pretty nice. Overrides CUSTOMBROWSER and BROWSER_TYPE. Default: y>> wrapper-offline\utilities\config.bat
echo set APPCHROMIUM=y>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Opens Offline in a browser of the user's choice. Needs to be a path to a browser executable in quotes. Default: n>> wrapper-offline\utilities\config.bat
echo set CUSTOMBROWSER=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Lets the launcher know what browser framework is being used. Mostly used by the Flash installer. Accepts "chrome", "firefox", and "n". Default: n>> wrapper-offline\utilities\config.bat
echo set BROWSER_TYPE=chrome>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Runs through all of the scripts code, while never launching or installing anything. Useful for development. Default: n>> wrapper-offline\utilities\config.bat
echo set DRYRUN=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Makes it so it uses the Cepstral website instead of VFProxy. Default: n>> wrapper-offline\utilities\config.bat
echo set CEPSTRAL=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Opens Offline in an included copy of Basilisk, sourced from BlueMaxima's Flashpoint.>> wrapper-offline\utilities\config.bat
echo :: Allows continued use of Flash as modern browsers disable it. Default: n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo set INCLUDEDBASILISK=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Makes it so both the settings and the Wrapper launcher shows developer options. Default: n>> wrapper-offline\utilities\config.bat
echo set DEVMODE=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Tells settings.bat which port the frontend is hosted on. ^(If changed manually, you MUST also change the value of "SERVER_PORT" to the same value in wrapper\env.json^) Default: 4343>> wrapper-offline\utilities\config.bat
echo set PORT=4343>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo :: Enables configure_wrapper.bat. Useful for investigating things like problems with Node.js or http-server. Default: n>> wrapper-offline\utilities\config.bat
echo set CONFIGURE=n>> wrapper-offline\utilities\config.bat
echo:>> wrapper-offline\utilities\config.bat
echo Resetting imported assets...
pushd wrapper-offline\server\store\3a981f5cb2739137
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
call wrapper-offline\utilities\7za.exe a "wrapper-offline\server\store\3a981f5cb2739137\import\import.zip" "wrapper-offline\server\store\3a981f5cb2739137\import\theme.xml" >nul
del /q /s wrapper-offline\utilities\import_these
md wrapper-offline\utilities\import_these
copy "wrapper-offline\server\store\3a981f5cb2739137\import\theme.xml" "wrapper-offline\wrapper\_THEMES\import.xml" /y
echo Moving "disclaimer accepted" text file from temporary system directory to utilities\checks folder...
copy "%tmp%\WOdisclaimer.txt" "wrapper-offline\utilities\checks\disclaimer.txt" /y
del "%tmp%\WOdisclaimer.txt"
echo Creating quick shortcut in directory where Wrapper was cloned using NirCMD...
del "wrapper-offline\Wrapper Offline.lnk"
echo:
pushd wrapper-offline
call utilities\nircmd\nircmd.exe shortcut '%windir%\System32\cmd.exe /c START "" "start_wrapper.bat"' "%CD%" "Wrapper Offline" "" "%CD%\wrapper\favicon.ico" "" "" "%CD%\"
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
	start "" "%~dp0..\wrapper-offline\start_wrapper.bat"
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
