@echo off
set DelphiProd=Delphi XE7

if exist SetEnv.bat del SetEnv.bat
if not exist computil.exe goto NoComputil
computil SetupD21
if defined NDD21 goto RSVARS
if not exist SetEnv.bat goto NoNDD

call SetEnv.bat > nul:
if not defined NDD21 goto NoNDD

:RSVARS
call "%NDD21%bin\rsvars.bat"
if not defined BDS goto NoBDS

set logfn=CleanD21.log

call Clean_IDE.cmd
goto END

:NoCompUtil
echo Computil.exe not found--run this batch script from the "Lib" folder of the Indy repository, recently pulled from GitHub.
goto END

:NoNDD
echo Computil.exe did not create the batch script for setting up the environment for %DelphiProd%. Aborting.
goto END

:NoBDS
echo Calling RSVars did not set up the environment for %DelphiProd%. Aborting.

:END
set logfn=
set DelphiProd=
