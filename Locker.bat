@ECHO OFF
cls
title Folder Locker

:: Set folder name
set folderName=LockedFolder
set lockerName=%folderName%_Locker
set passwordFile=hidden_password.txt

:: Set default password if file does not exist
if NOT EXIST "%passwordFile%" (
    echo password>"%passwordFile%"
    attrib +h +s "%passwordFile%"
)

:: Check if folder is locked
if EXIST "%lockerName%" goto UNLOCK

:: Crate folder if it does not exist
if NOT EXIST "%folderName%" goto CREATE_FOLDER



:MENU
echo Do you want to lock the folder "%folderName%" (Y/N/S)? (Yes, No, Set new password)
set /p "choice=-> "
if /I "%choice%"=="Y" goto LOCK
if /I "%choice%"=="N" goto END
if /I "%choice%"=="S" goto SET_PASSWORD
echo Invalid choice.
goto END



:SET_PASSWORD
set password=
echo Set a password to lock/unlock the folder:
set /p password="-> "

if "%password%"=="" (
    echo Password cannot be empty.
    goto SET_PASSWORD
)

:: Save new password to file
attrib -h -s "%passwordFile%"
echo %password%>"%passwordFile%"
attrib +h +s "%passwordFile%"

goto LOCK



:LOCK
set /p password=< "%passwordFile%"
echo Folder will be locked with password: "%password%"
ren "%folderName%" "%lockerName%"
attrib +h +s "%lockerName%"
echo Folder "%folderName%" locked successfully.
goto END



:UNLOCK
set /p password=< "%passwordFile%"
set attempt=1

goto TRY_UNLOCK

:TRY_UNLOCK
echo Enter the password to unlock the folder:
set /p "userPass=-> "
if "%userPass%"=="%password%" (
    attrib -h -s "%lockerName%"
    ren "%lockerName%" "%folderName%"
    echo Folder "%folderName%" unlocked successfully.
) else (
    echo Invalid password. Attempt %attempt% of 3.
    set /a attempt=attempt+1
    if %attempt% lss 3 goto TRY_UNLOCK
    echo Too many incorrect attempts. Access denied.
)
goto END



:CREATE_FOLDER
echo Folder "%folderName%" does not exist. Do you want to create it? (Y/N)
set /p "createChoice=-> "
if /I "%createChoice%"=="Y" (
    md "%folderName%"
    echo Folder "%folderName%" created successfully.
    goto MENU
) else (
    echo Folder creation cancelled.
    goto END
)



:END
ping -n 3 127.0.0.1 >nul
exit
