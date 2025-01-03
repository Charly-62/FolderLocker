@ECHO OFF
cls
title Folder Locker

:: Set folder name only once
set folderName=TestFolder
set lockerName=%folderName%_Locker
set passwordFile=hidden_password.txt

:: Load password from file or set default if it doesn't exist
if NOT EXIST "%passwordFile%" (
    set /p="password" > "%passwordFile%"
    attrib +h +s "%passwordFile%"
)

set /p password=< "%passwordFile%"

if EXIST "%lockerName%" goto UNLOCK
if NOT EXIST "%folderName%" goto CREATE_FOLDER

echo Are you sure you want to lock the folder "%folderName%" (Y/N/S)? (Yes, No, Set new password)
set /p "choice=-> "
if /I "%choice%"=="Y" goto LOCK
if /I "%choice%"=="N" goto END
if /I "%choice%"=="S" goto SET_PASSWORD
echo Invalid choice.
goto END



:SET_PASSWORD
echo Set a password to lock/unlock the folder:
set /p password="-> "

if password == "" (
    echo Password cannot be empty.
    goto SET_PASSWORD
)

:: Save new password to file
attrib -h -s "%passwordFile%"
set /p="%password%" > "%passwordFile%"
attrib +h +s "%passwordFile%"

goto LOCK

:LOCK
echo Folder will be locked with password: "%password%"
ren "%folderName%" "%lockerName%"
attrib +h +s "%lockerName%"
echo Folder "%folderName%" locked successfully.
goto END

:UNLOCK
:: Load password from file
set /p password=< "%passwordFile%"

set attempt=1
:TRY_UNLOCK
echo Enter the password to unlock the folder:
set /p "userPass=-> "
if "%userPass%"=="%password%" (
    attrib -h -s "%lockerName%"
    ren "%lockerName%" "%folderName%"
    echo Folder "%folderName%" unlocked successfully.
    goto END
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
) else (
    echo Folder creation cancelled.
)
goto END

:END
ping -n 2 127.0.0.1 >nul
exit
