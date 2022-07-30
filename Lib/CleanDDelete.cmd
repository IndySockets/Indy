@echo off
REM enable variable name expansion (see "MyBDS" below)
setlocal EnableDelayedExpansion

REM allow this to be run as administrator using right+click/run-as-admin (without opening command prompt)
pushd "%~dp0"

REM check command-line parameters
if (%1)==() goto NoParams
if (%2)==() goto NoParams

REM set nicer variable for product description
set DelphiProd=%2

REM extract compiler version from command arg
set CompilerScript=%1
set CompilerVr=%CompilerScript:~6,2%

REM call CompUtil to create batch file to set environment variable of Delphi directory
if defined NDD%CompilerVr% set NDD%CompilerVr%=
if not exist computil.exe goto NoComputil
if exist SetEnv.bat del SetEnv.bat
computil SetupD%CompilerVr%
if not exist SetEnv.bat goto NoNDD

REM set up environment variable to point to Delphi directory
call SetEnv.bat > nul:
if not defined NDD%CompilerVr% goto NoNDD
set MyNDD=NDD%CompilerVr%
for %%n in (%MyNDD%) do set MyBDS=!%%n!

REM set logfile
set logfn="%~dp0CleanD%CompilerVr%.log"

echo.
echo =====================================================================================
echo WARNING! This batch file deletes files from your Delphi installation using wildcards.
echo You should read and understand this batch file before running it.
echo =====================================================================================
echo This will remove the default Indy libraries that come with %DelphiProd%
echo from the "bin" and "lib" folders in the Delphi installation and must be run as 
echo Administrator. A log file of the files deleted will be created.
echo =====================================================================================
echo NOTE 1: Run this as Administrator to delete files from "Program files (x86)".
echo NOTE 2: If Delphi is currently open, some of the files may not be able to be deleted.
echo NOTE 3: Once Delphi is re-started, you may see errors loading some of the libraries; 
echo this is to be expected until Indy is re-installed.
echo =====================================================================================
echo.
pause

echo.
echo Removing Indy files from %DelphiProd%... > %logfn%
echo Cleaning default Indy from %MyBDS%

echo Removing Windows 32-bit files
for %%a in ("%MyBDS%\bin\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\bin\Indy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\bin\dclIndy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\bin\dclIndy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\debug\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win32\release\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

if not exist %MyBDS%\bin64\ if not exist %MyBDS%\lib\win64\ goto Linux64
echo Removing Windows 64-bit files
for %%a in ("%MyBDS%\bin64\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\win64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:Linux64
if not exist %MyBDS%\binlinux64\ if not exist %MyBDS%\lib\linux64\ goto MacOS64
echo Removing Linux 64-bit files
for %%a in ("%MyBDS%\binlinux64\bplIndy*.so") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\linux64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:MacOS64
if not exist %MyBDS%\binosx64\ if not exist %MyBDS%\lib\osx64\ if not exist %MyBDS%\lib\osxarm64\ goto iOS64
echo Removing MacOS 64-bit files
for %%a in ("%MyBDS%\binosx64\bplIndy*.dylib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osx64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\osxarm64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:iOS64
if not exist %MyBDS%\lib\iosDevice64\ goto Android32
echo Removing iOS 64-bit files
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\iosDevice64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:Android32
if not exist %MyBDS%\lib\android\ goto Android64
echo Removing Android 32-bit files
for %%a in ("%MyBDS%\lib\android\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:Android64
if not exist %MyBDS%\lib\android64\ goto AllDone
echo Removing Android 64-bit files
for %%a in ("%MyBDS%\lib\android64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%MyBDS%\lib\android64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

:AllDone
echo.
echo All done. The list of deleted files is in %logfn%
goto END

:NoParams
echo Do NOT run this script directly--use one of the CleanDXX.cmd scripts
goto END

:NoCompUtil
echo Computil.exe not found--run this batch script from the "Lib" folder of the Indy repository, recently pulled from GitHub.
goto END

:NoNDD
echo Computil.exe did not create the batch script for setting up the environment for %DelphiProd%. Aborting.
goto END

:END
popd
pause