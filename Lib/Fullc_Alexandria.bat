@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Note: This batch file copies the ZLIB OBJ files from \Lib\Protocols\ZLib\i386-Win32-ZLib
REM       (Update to \Lib\Protocols\ZLib\x86_64-Win64-ZLib if required)
REM
REM Pre-requisites:  \Lib\System contains the project / pas/ res files for IndySystem
REM                  \Lib\Core contains the project / pas/ res files for IndyCore
REM                  \Lib\Protocols contains the project / pas/ res files for IndyProtocols
REM 
REM Command line (optional) parameters:
REM   %1 = Configuration option, the default is "Release"
REM   %2 = Platform option, the default is "Win32"
REM
REM Example: FullC28               -> will build Release, Win32
REM Example: FullC28 Debug         -> will build Debug, Win32
REM Example: FullC28 Release Win64 -> will build Release, Win64 (if available)
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

computil SetupC28
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC28%)==() goto enderror

REM Set up the environment
call %NDC28%\bin\rsvars.bat

REM Check for configuration options
SET IndyConfig=Release
SET IndyPlatform=Win32

:setconfig
if [%1]==[] goto setplatform
SET IndyConfig=%1

:setplatform
if [%2]==[] goto preparefolders
SET IndyPlatform=%2


REM ************************************************************
REM Prepare the folder structure
REM ************************************************************

:preparefolders
if not exist ..\C28\*.* md ..\C28 > nul
if not exist ..\C28\ZLib\*.* md ..\C28\ZLib > nul
if not exist ..\C28\ZLib\i386-Win32-ZLib\*.* md ..\C28\ZLib\i386-Win32-ZLib > nul
if not exist ..\C28\ZLib\x86_64-Win64-ZLib\*.* md ..\C28\ZLib\x86_64-Win64-ZLib > nul
if not exist ..\C28\%IndyPlatform% md ..\C28\%IndyPlatform% > nul
if not exist ..\C28\%IndyPlatform%\%IndyConfig% md ..\C28\%IndyPlatform%\%IndyConfig% > nul

if exist ..\C28\*.* call clean.bat ..\C28\


REM ************************************************************
REM Copy over the IndySystem files
REM ************************************************************

:indysystem
cd System
copy IndySystem280.dpk ..\..\C28 > nul
copy IndySystem280.dproj ..\..\C28 > nul
copy *.res ..\..\C28 > nul
copy *.pas ..\..\C28 > nul
copy *.inc ..\..\C28 > nul
copy *.ico ..\..\C28 > nul

cd ..\..\C28

REM ************************************************************
REM Build IndySystem
REM ************************************************************

msbuild IndySystem280.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyCore files
REM ************************************************************

:indycore
cd ..\Lib\Core

copy *IndyCore280.dpk ..\..\C28 > nul
copy *IndyCore280.dproj ..\..\C28 > nul
copy *.res ..\..\C28 > nul
copy *.pas ..\..\C28 > nul
copy *.dcr ..\..\C28 > nul
copy *.inc ..\..\C28 > nul
copy *.ico ..\..\C28 > nul

cd ..\..\C28

REM ************************************************************
REM Build IndyCore
REM ************************************************************

msbuild IndyCore280.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto indyprotocols

msbuild dclIndyCore280.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyProtocols files
REM ************************************************************

:indyprotocols
cd ..\Lib\Protocols

copy zlib\i386-Win32-ZLib\*.obj ..\..\C28\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C28\ZLib\x86_64-Win64-ZLib > nul
copy *IndyProtocols280.dpk ..\..\C28 > nul
copy *IndyProtocols280.dproj ..\..\C28 > nul
copy *.res ..\..\C28 > nul
copy *.pas ..\..\C28 > nul
copy *.dcr ..\..\C28 > nul
copy *.inc ..\..\C28 > nul
copy *.ico ..\..\C28 > nul

cd ..\..\C28

REM ************************************************************
REM Build IndyProtocols
REM ************************************************************

msbuild IndyProtocols280.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto copygenerated

msbuild dclIndyProtocols280.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


:copygenerated

REM ************************************************************
REM Copy over all generated files
REM ************************************************************
copy ..\Output\hpp\%IndyPlatform%\%IndyConfig%\Id*.hpp %IndyPlatform%\%IndyConfig%
copy "%BDSCOMMONDIR%\Bpl\*Indy*.bpl" %IndyPlatform%\%IndyConfig%
copy *Indy*.bpl %IndyPlatform%\%IndyConfig%
copy ..\Output\Bpi\%IndyPlatform%\%IndyConfig%\Indy*.bpi %IndyPlatform%\%IndyConfig%
if "%IndyPlatform%" == "Win32" copy "..\Output\Obj\%IndyPlatform%\%IndyConfig%\Indy*.Lib" %IndyPlatform%\%IndyConfig%
copy indysystem280.res %IndyPlatform%\%IndyConfig%
copy indycore280.res %IndyPlatform%\%IndyConfig%
copy indyprotocols280.res %IndyPlatform%\%IndyConfig%

REM ************************************************************
REM Delete all other files / directories no longer required 
REM ************************************************************
del /Q ..\Output\hpp\%IndyPlatform%\%IndyConfig%\*.*
del /Q ..\Output\Bpi\%IndyPlatform%\%IndyConfig%\*.*
if "%IndyPlatform%" == "Win32" del /Q ..\Output\Obj\%IndyPlatform%\%IndyConfig%\*.*
del /Q "%BDSCOMMONDIR%\Bpl\*Indy*.bpl"
del /Q "%BDSCOMMONDIR%\Dcp\*.*"
del /Q ZLib\i386-Win32-ZLib\*.*
del /Q ZLib\x86_64-Win64-ZLib\*.*
del /Q *.*

rd ZLib\i386-Win32-ZLib
rd ZLib\x86_64-Win64-ZLib
rd ZLib
rd ..\Output\hpp\%IndyPlatform%\%IndyConfig%
rd ..\Output\hpp\%IndyPlatform%
rd ..\Output\hpp
rd ..\Output\Bpi\%IndyPlatform%\%IndyConfig%
rd ..\Output\Bpi\%IndyPlatform%
rd ..\Output\Bpi
if "%IndyPlatform%" == "Win32" rd ..\Output\Obj\%IndyPlatform%\%IndyConfig%
if "%IndyPlatform%" == "Win32" rd ..\Output\Obj\%IndyPlatform%
if "%IndyPlatform%" == "Win32" rd ..\Output\Obj
rd ..\Output

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 28 Compiler Not Present!
goto endok

:endok
cd ..\Lib