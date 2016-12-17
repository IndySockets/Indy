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
REM Example: FullC17               -> will build Release, Win32
REM Example: FullC17 Debug         -> will build Debug, Win32
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

computil SetupC17
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC17%)==() goto enderror

REM Set up the environment
call %NDC17%\bin\rsvars.bat

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
if not exist ..\C17\*.* md ..\C17 > nul
if not exist ..\C17\ZLib\*.* md ..\C17\ZLib > nul
if not exist ..\C17\ZLib\i386-Win32-ZLib\*.* md ..\C17\ZLib\i386-Win32-ZLib > nul
if not exist ..\C17\ZLib\x86_64-Win64-ZLib\*.* md ..\C17\ZLib\x86_64-Win64-ZLib > nul
if not exist ..\C17\%IndyPlatform% md ..\C17\%IndyPlatform% > nul
if not exist ..\C17\%IndyPlatform%\%IndyConfig% md ..\C17\%IndyPlatform%\%IndyConfig% > nul

if exist ..\C17\*.* call clean.bat ..\C17\


REM ************************************************************
REM Copy over the IndySystem files
REM ************************************************************

:indysystem
cd System
copy IndySystem170.dpk ..\..\C17 > nul
copy IndySystem170.dproj ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.inc ..\..\C17 > nul
copy *.ico ..\..\C17 > nul

cd ..\..\C17

REM ************************************************************
REM Build IndySystem
REM ************************************************************

msbuild IndySystem170.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyCore files
REM ************************************************************

:indycore
cd ..\Lib\Core

copy *IndyCore170.dpk ..\..\C17 > nul
copy *IndyCore170.dproj ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.dcr ..\..\C17 > nul
copy *.inc ..\..\C17 > nul
copy *.ico ..\..\C17 > nul

cd ..\..\C17

REM ************************************************************
REM Build IndyCore
REM ************************************************************

msbuild IndyCore170.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

msbuild dclIndyCore170.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over the IndyProtocols files
REM ************************************************************

:indyprotocols
cd ..\Lib\Protocols

copy zlib\i386-Win32-ZLib\*.obj ..\..\C17\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C17\ZLib\x86_64-Win64-ZLib > nul
copy *IndyProtocols170.dpk ..\..\C17 > nul
copy *IndyProtocols170.dproj ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.dcr ..\..\C17 > nul
copy *.inc ..\..\C17 > nul
copy *.ico ..\..\C17 > nul

cd ..\..\C17

REM ************************************************************
REM Build IndyProtocols
REM ************************************************************

msbuild IndyProtocols170.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror

msbuild dclIndyProtocols170.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror


REM ************************************************************
REM Copy over all generated files
REM ************************************************************
copy "%BDSCOMMONDIR%\hpp\Id*.hpp" %IndyPlatform%\%IndyConfig%
copy "..\Bpi\*Indy*.bpl" %IndyPlatform%\%IndyConfig%
copy "..\Dcp\Indy*.bpi" %IndyPlatform%\%IndyConfig%
copy "..\Dcp\Indy*.Lib" %IndyPlatform%\%IndyConfig%
copy indysystem170.res %IndyPlatform%\%IndyConfig%
copy indycore170.res %IndyPlatform%\%IndyConfig%
copy indyprotocols170.res %IndyPlatform%\%IndyConfig%

REM ************************************************************
REM Delete all other files / directories no longer required 
REM ************************************************************
del "%BDSCOMMONDIR%\hpp\Id*.hpp"
del "%BDSCOMMONDIR%\hpp\Indy*.hpp"
del /Q ..\Bpi\*.*
del /Q ..\Dcp\*.*
del /Q ZLib\i386-Win32-ZLib\*.*
del /Q ZLib\x86_64-Win64-ZLib\*.*
del /Q *.*

rd ZLib\i386-Win32-ZLib
rd ZLib\x86_64-Win64-ZLib
rd ZLib
rd ..\Bpi
rd ..\Dcp

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 17 Compiler Not Present!
goto endok

:endok
cd ..\Lib
