@echo off
pushd "%~dp0"

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
REM Example: FullD19               -> will build Release, Win32
REM Example: FullD19 Debug         -> will build Debug, Win32
REM Example: FullD19 Release Win64 -> will build Release, Win64 (if available)
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

"%~dp0..\Computil.exe" SetupD19
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDD19%)==() goto enderror

REM Set up the environment
call %NDD19%\bin\rsvars.bat

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
SET IndyPkg=%~dp0.
SET IndyBin=%~dp0..\..\Output\D19\%IndyPlatform%\%IndyConfig%

if not exist ..\..\Output\D19\*.* md ..\..\Output\D19 > nul
if not exist ..\..\Output\D19\%IndyPlatform% md ..\..\Output\D19\%IndyPlatform% > nul
if not exist ..\..\Output\D19\%IndyPlatform%\%IndyConfig% md ..\..\Output\D19\%IndyPlatform%\%IndyConfig% > nul

if exist ..\..\Output\D19\*.* call "%~dp0..\Clean.bat" ..\..\Output\D19\


REM ************************************************************
REM Build IndySystem
REM ************************************************************

:indysystem
msbuild "%IndyPkg%\IndySystem.dproj" /t:Rebuild "/p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_BplOutput=%IndyBin%;DCC_DcpOutput=%IndyBin%;DCC_BpiOutput=%IndyBin%;DCC_HppOutput=%IndyBin%;DCC_ObjOutput=%IndyBin%;DCC_DcuOutput=%IndyBin%"
if errorlevel 1 goto enderror


REM ************************************************************
REM Build IndyCore
REM ************************************************************

:indycore
msbuild "%IndyPkg%\IndyCore.dproj" /t:Rebuild "/p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_BplOutput=%IndyBin%;DCC_DcpOutput=%IndyBin%;DCC_BpiOutput=%IndyBin%;DCC_HppOutput=%IndyBin%;DCC_ObjOutput=%IndyBin%;DCC_DcuOutput=%IndyBin%"
if errorlevel 1 goto enderror

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto indyprotocols

msbuild "%IndyPkg%\dclIndyCore.dproj" /t:Rebuild "/p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_BplOutput=%IndyBin%;DCC_DcpOutput=%IndyBin%;DCC_BpiOutput=%IndyBin%;DCC_HppOutput=%IndyBin%;DCC_ObjOutput=%IndyBin%;DCC_DcuOutput=%IndyBin%"
if errorlevel 1 goto enderror


REM ************************************************************
REM Build IndyProtocols
REM ************************************************************

:indyprotocols
msbuild "%IndyPkg%\IndyProtocols.dproj" /t:Rebuild "/p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_BplOutput=%IndyBin%;DCC_DcpOutput=%IndyBin%;DCC_BpiOutput=%IndyBin%;DCC_HppOutput=%IndyBin%;DCC_ObjOutput=%IndyBin%;DCC_DcuOutput=%IndyBin%"
if errorlevel 1 goto enderror

REM design time is for Win32 only
if not "%IndyPlatform%" == "Win32" goto copygenerated

msbuild "%IndyPkg%\dclIndyProtocols.dproj" /t:Rebuild "/p:Config=%IndyConfig%;Platform=%IndyPlatform%;DCC_BplOutput=%IndyBin%;DCC_DcpOutput=%IndyBin%;DCC_BpiOutput=%IndyBin%;DCC_HppOutput=%IndyBin%;DCC_ObjOutput=%IndyBin%;DCC_DcuOutput=%IndyBin%"
if errorlevel 1 goto enderror


:copygenerated

REM ************************************************************
REM Copy over the package resource files
REM ************************************************************
copy "%IndyPkg%\IndySystem.res" "%IndyBin%" > nul
copy "%IndyPkg%\IndyCore.res" "%IndyBin%" > nul
copy "%IndyPkg%\IndyProtocols.res" "%IndyBin%" > nul

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo Delphi XE5 Compiler Not Present!
goto endok

:endok
popd
