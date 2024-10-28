@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Note: This batch file copies the ZLIB OBJ files from \Lib\Source\ZLib\i386-Win32-ZLib
REM       (Update to \Lib\Source\ZLib\x86_64-Win64-ZLib if required)
REM
REM Pre-requisites:  \Lib\Packages\RADStudio_10_2_Tokyo contains the project / res files
REM                  \Lib\Source contains the pas/ inc files
REM 
REM Command line (optional) parameters:
REM   %1 = Configuration option, the default is "Release"
REM   %2 = Platform option, the default is "Win32"
REM
REM Example: FullC25               -> will build Release, Win32
REM Example: FullC25 Debug         -> will build Debug, Win32
REM Example: FullC25 Release Win64 -> will build Release, Win64 (if available)
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

..\computil SetupC25
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC25%)==() goto enderror

REM Set up the environment
call %NDC25%\bin\rsvars.bat

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
if not exist ..\..\..\C25\*.* md ..\..\..\C25 > nul
if not exist ..\..\..\C25\ZLib\*.* md ..\..\..\C25\ZLib > nul
if not exist ..\..\..\C25\ZLib\i386-Win32-ZLib\*.* md ..\..\..\C25\ZLib\i386-Win32-ZLib > nul
if not exist ..\..\..\C25\ZLib\x86_64-Win64-ZLib\*.* md ..\..\..\C25\ZLib\x86_64-Win64-ZLib > nul
if not exist ..\..\..\C25\%IndyPlatform% md ..\..\..\C25\%IndyPlatform% > nul
if not exist ..\..\..\C25\%IndyPlatform%\%IndyConfig% md ..\..\..\C25\%IndyPlatform%\%IndyConfig% > nul

if exist ..\..\..\C25\*.* call ..\clean.bat ..\..\..\C25\


REM ************************************************************
REM Copy over the Source files
REM ************************************************************

copy IndySystem.dpk ..\..\..\C25 > nul
copy IndySystem.dproj ..\..\..\C25 > nul
copy *IndyCore.dpk ..\..\..\C25 > nul
copy *IndyCore.dproj ..\..\..\C25 > nul
copy *IndyProtocols.dpk ..\..\..\C25 > nul
copy *IndyProtocols.dproj ..\..\..\C25 > nul

cd ..\..\Source
copy zlib\i386-Win32-ZLib\*.obj ..\..\C25\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C25\ZLib\x86_64-Win64-ZLib > nul
copy *.res ..\..\C25 > nul
copy *.pas ..\..\C25 > nul
copy *.dcr ..\..\C25 > nul
copy *.inc ..\..\C25 > nul
copy *.ico ..\..\C25 > nul

cd ..\..\C25


REM ************************************************************
REM Build IndySystem
REM ************************************************************

msbuild IndySystem.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror2


REM ************************************************************
REM Build IndyCore
REM ************************************************************

msbuild IndyCore.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror2

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto indyprotocols

msbuild dclIndyCore.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror2


REM ************************************************************
REM Build IndyProtocols
REM ************************************************************
:indyprotocols

msbuild IndyProtocols.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror2

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto copygenerated

msbuild dclIndyProtocols.dproj /t:Rebuild /p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_Define="BCB"
if errorlevel 1 goto enderror2


REM ************************************************************
REM Copy over all generated files
REM ************************************************************
:copygenerated

copy ..\Output\hpp\%IndyPlatform%\%IndyConfig%\Id*.hpp %IndyPlatform%\%IndyConfig%
copy "%BDSCOMMONDIR%\Bpl\*Indy*.bpl" %IndyPlatform%\%IndyConfig%
copy *Indy*.bpl %IndyPlatform%\%IndyConfig%
copy ..\Output\Bpi\%IndyPlatform%\%IndyConfig%\Indy*.bpi %IndyPlatform%\%IndyConfig%
if "%IndyPlatform%" == "Win32" copy "..\Output\Obj\%IndyPlatform%\%IndyConfig%\Indy*.Lib" %IndyPlatform%\%IndyConfig%
copy indysystem.res %IndyPlatform%\%IndyConfig%
copy indycore.res %IndyPlatform%\%IndyConfig%
copy indyprotocols.res %IndyPlatform%\%IndyConfig%

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

cd ..\Lib\Packages\RADStudio_10_2_Tokyo
goto endok

:enderror2
cd ..\Lib\Packages\RADStudio_10_2_Tokyo

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 25 Compiler Not Present!
goto endok

:endok