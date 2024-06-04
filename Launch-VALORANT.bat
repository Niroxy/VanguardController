@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    
@ECHO OFF

TASKKILL  /f /im RiotClientServices.exe
kernelloader -l vgk.sys vgk
sc.exe create vgc binPath= "C:\Program Files\Riot Vanguard\vgc.exe"
sc config vgc start= demand
net start vgc
START "" "C:\Program Files\Riot Vanguard\VGTRAY.EXE"
START "" "<RIOT CLIENT PATH>" --launch-product=valorant --launch-patchline=live

:LOOP
tasklist | find /i "RiotClientServices" >nul 2>&1
IF ERRORLEVEL 1 (
  GOTO CONTINUE
) ELSE (
  ECHO VALORANT is still running
  Timeout /T 5 /Nobreak
  GOTO LOOP
)

:CONTINUE
kernelloader -u vgk
net stop vgc
taskkill /f /im vgtray.exe
sc config vgc start= disabled
sc delete vgc