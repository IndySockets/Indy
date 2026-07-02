@echo off
set DelphiProd=Delphi 10.3 Rio

cd "%~dp0"

if exist SetEnv.bat del SetEnv.bat
if not exist "..\Computil.exe" goto NoComputil
"..\Computil.exe" SetupD26
if defined NDD26 goto RSVARS
if not exist SetEnv.bat goto NoNDD

call SetEnv.bat > nul:
if not defined NDD26 goto NoNDD

:RSVARS
call "%NDD26%bin\rsvars.bat"
if not defined BDS goto NoBDS

set logfn=CleanD26.log

call "..\Clean_IDE.cmd"
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
