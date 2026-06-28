@echo off
set DelphiProd=Delphi XE2
cd /d "%~dp0"

if exist SetEnv.bat del SetEnv.bat
if not exist "%~dp0..\computil.exe" goto NoComputil
"%~dp0..\computil.exe" SetupD16
if defined NDD16 goto RSVARS
if not exist SetEnv.bat goto NoNDD

call SetEnv.bat > nul:
if not defined NDD16 goto NoNDD

:RSVARS
call "%NDD16%bin\rsvars.bat"
if not defined BDS goto NoBDS

set logfn=CleanD16.log

call "%~dp0..\Clean_IDE.cmd"
goto END

:NoCompUtil
echo Computil.exe not found--run this batch script from its version folder under Packages.
goto END

:NoNDD
echo Computil.exe did not create the batch script for setting up the environment for %DelphiProd%. Aborting.
goto END

:NoBDS
echo Calling RSVars did not set up the environment for %DelphiProd%. Aborting.

:END
set logfn=
set DelphiProd=
cd /d "%~dp0"
