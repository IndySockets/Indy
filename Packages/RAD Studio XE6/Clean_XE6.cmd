@echo off
set DelphiProd=Delphi XE6

cd "%~dp0"

if exist SetEnv.bat del SetEnv.bat
if not exist "..\Computil.exe" goto NoComputil
"..\Computil.exe" SetupD20
if defined NDD20 goto RSVARS
if not exist SetEnv.bat goto NoNDD

call SetEnv.bat > nul:
if not defined NDD20 goto NoNDD

:RSVARS
call "%NDD20%bin\rsvars.bat"
if not defined BDS goto NoBDS

set logfn=CleanD20.log

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
