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
REM Example: FullC16               -> will build Release, Win32
REM Example: FullC16 Debug         -> will build Debug, Win32
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

computil SetupC16
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC16%)==() goto enderror

REM Set up the environment
call %NDC16%\bin\rsvars.bat

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
if not exist ..\C16\*.* md ..\C16 > nul
if not exist ..\C16\ZLib\*.* md ..\C16\ZLib > nul
if not exist ..\C16\ZLib\i386-Win32-ZLib\*.* md ..\C16\ZLib\i386-Win32-ZLib > nul
if not exist ..\C16\ZLib\x86_64-Win64-ZLib\*.* md ..\C16\ZLib\x86_64-Win64-ZLib > nul
if not exist ..\C16\%IndyPlatform% md ..\C16\%IndyPlatform% > nul
if not exist ..\C16\%IndyPlatform%\%IndyConfig% md ..\C16\%IndyPlatform%\%IndyConfig% > nul

if exist ..\C16\*.* call clean.bat ..\C16\


REM ************************************************************
REM Copy over the IndySystem files
REM ************************************************************

:indysystem
cd System
copy IndySystem160.dpk ..\..\C16 > nul
copy IndySystem160.dproj ..\..\C16 > nul
copy *.res ..\..\C16 > nul
copy *.pas ..\..\C16 > nul
copy *.inc ..\..\C16 > nul
copy *.ico ..\..\C16 > nul

cd ..\..\C16

REM ************************************************************
REM Build IndySystem
REM ************************************************************

msbuild IndySystem160.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyCore files
REM ************************************************************

:indycore
cd ..\Lib\Core

copy *IndyCore160.dpk ..\..\C16 > nul
copy *IndyCore160.dproj ..\..\C16 > nul
copy *.res ..\..\C16 > nul
copy *.pas ..\..\C16 > nul
copy *.dcr ..\..\C16 > nul
copy *.inc ..\..\C16 > nul
copy *.ico ..\..\C16 > nul

cd ..\..\C16

REM ************************************************************
REM Build IndyCore
REM ************************************************************

msbuild IndyCore160.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

msbuild dclIndyCore160.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyProtocols files
REM ************************************************************

:indyprotocols
cd ..\Lib\Protocols

copy zlib\i386-Win32-ZLib\*.obj ..\..\C16\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C16\ZLib\x86_64-Win64-ZLib > nul
copy *IndyProtocols160.dpk ..\..\C16 > nul
copy *IndyProtocols160.dproj ..\..\C16 > nul
copy *.res ..\..\C16 > nul
copy *.pas ..\..\C16 > nul
copy *.dcr ..\..\C16 > nul
copy *.inc ..\..\C16 > nul
copy *.ico ..\..\C16 > nul

cd ..\..\C16

REM ************************************************************
REM Build IndyProtocols
REM ************************************************************

msbuild IndyProtocols160.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

msbuild dclIndyProtocols160.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over all generated files
REM ************************************************************
copy "%BDSCOMMONDIR%\hpp\Id*.hpp" %IndyPlatform%\%IndyConfig%
copy "%BDSCOMMONDIR%\Bpl\*Indy*.bpl" %IndyPlatform%\%IndyConfig%
copy "%BDSCOMMONDIR%\Dcp\Indy*.bpi" %IndyPlatform%\%IndyConfig%
copy "%BDSCOMMONDIR%\Dcp\Indy*.Lib" %IndyPlatform%\%IndyConfig%
copy indysystem160.res %IndyPlatform%\%IndyConfig%
copy indycore160.res %IndyPlatform%\%IndyConfig%
copy indyprotocols160.res %IndyPlatform%\%IndyConfig%


REM ************************************************************
REM Delete all other files / directories no longer required 
REM ************************************************************
del "%BDSCOMMONDIR%\hpp\Id*.hpp" > nul
del "%BDSCOMMONDIR%\hpp\Indy*.hpp" > nul
del "%BDSCOMMONDIR%\Bpl\*Indy*.bpl" > nul
del "%BDSCOMMONDIR%\Dcp\Indy*.bpi" > nul
del "%BDSCOMMONDIR%\Dcp\Indy*.Lib" > nul
del "%BDSCOMMONDIR%\Dcp\*Indy*.dcp" > nul
del /Q ZLib\i386-Win32-ZLib\*.*
del /Q ZLib\x86_64-Win64-ZLib\*.*
del /Q *.*

rd ZLib\i386-Win32-ZLib
rd ZLib\x86_64-Win64-ZLib
rd ZLib

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 16 Compiler Not Present!
goto endok

:endok
cd ..\Lib
