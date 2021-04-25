:: Wrapper: Offline Installer
:: Author: octanuary#6596 (narutofan420)
:: License: MIT
title Wrapper: Offline Installer and Updater [Initializing...]

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

title Wrapper: Offline Installer and Updater [Checking for Git...]
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
	title Wrapper: Offline Installer and Updater [Installing Git...]
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
		echo Wrapper: Offline needs to install Git.
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
	set GIT_DETECTED=y
)

:: Alert user to restart the installer without running as Admin
if !ADMINREQUIRED!==y (
	color 20
	cls
	echo:
	echo Wrapper: Offline no longer needs Admin rights,
	echo please restart normally by double-clicking.
	echo:
	pause
	exit
)

:::::::::::::::::::::::::
:: Post-Initialization ::
:::::::::::::::::::::::::

if exist "%tmp%\WOinstDISCyes.txt" (
	goto standard
) else (
	goto disclaimer
)

title Wrapper: Offline Installer and Updater
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
echo This file exists to signal that the disclaimer on the installer/updater was acknowledged.>%tmp%\WOinstDISCyes.txt
PING -n 4 127.0.0.1>nul
echo:

:standard
cls
echo Wrapper: Offline Installer and Updater
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
title Wrapper: Offline Installer and Updater [Cloning repository...]
pushd "%~dp0..\"
echo Cloning the latest version of the repository from GitHub...
echo:
call git clone https://github.com/Zoccorus-GoAnimate/wrapper-offline.git
cls
echo The repository has been cloned.
echo:
if not exist "wrapper-offline\Wrapper Offline.lnk" (
	echo Creating quick shortcut in directory where Wrapper was cloned using NirCMD...
	echo:
	pushd wrapper-offline
	call utilities\nircmd\nircmd.exe shortcut '%windir%\System32\cmd.exe /c START "" "start_wrapper.bat"' "%CD%" "Wrapper Offline" "" "%CD%\wrapper\favicon.ico" "" "" "%CD%\"
	popd
	echo Shortcut created.
	echo:
)
if not exist "%tmp%\startwrapperalreadyran.txt" (
	echo The next step is to run "start_wrapper.bat" as admin to install any
	echo missing dependencies. This will only be required once.
	echo:
	pause
	start "" "%dp0..\wrapper-offline"
	echo The directory where it cloned to has been opened.
	echo:
	echo There is no way to program this so that it automatically opens
	echo "start_wrapper.bat" as admin, so this is the only way to do it.
	echo:
	echo Once you've run "start_wrapper.bat" as admin, you may continue
	echo in this window. An additional question in the setup will be asked.
	echo:
	pause
	echo This .TXT file exists to signal that the user already ran start_wrapper.bat as admin during their first time using this installer/updater.>%tmp%\startwrapperalreadyran.txt
	goto installed
) else (
	goto installed
)
:installed
echo Wrapper: Offline has been installed ^(or updated^)^^! Feel free to move it wherever you want.
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
	copy "%USERPROFILE%\Desktop\Wrapper Offline.lnk" "%Public%\Desktop"
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
