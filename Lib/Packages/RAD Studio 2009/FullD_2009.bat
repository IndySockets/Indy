@echo off
pushd "%~dp0"

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Note: This batch file copies the ZLIB OBJ files from \Lib\Source\Protocols\ZLib\i386-Win32-ZLib
REM       (Update to \Lib\Source\Protocols\ZLib\x86_64-Win64-ZLib if required)
REM
REM Pre-requisites:  \Lib\Source\System contains the project / pas/ res files for IndySystem
REM                  \Lib\Source\Core contains the project / pas/ res files for IndyCore
REM                  \Lib\Source\Protocols contains the project / pas/ res files for IndyProtocols
REM 
REM Command line (optional) parameters:
REM   %1 = Configuration option, the default is "Release"
REM   %2 = Platform option, the default is "Win32"
REM
REM Example: FullD12               -> will build Release, Win32
REM Example: FullD12 Debug         -> will build Debug, Win32
REM Example: FullD12 Release Win64 -> will build Release, Win64 (if available)
REM 
REM ****************************************************************************


REM ************************************************************
REM Set up the environment
REM ************************************************************

"%~dp0..\Computil.exe" SetupD12
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDD12%)==() goto enderror

REM Set up the environment
call %NDD12%\bin\rsvars.bat

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
SET IndyBin=%~dp0..\..\..\Output\D12\%IndyPlatform%\%IndyConfig%

if not exist ..\..\..\Output\D12\*.* md ..\..\..\Output\D12 > nul
if not exist ..\..\..\Output\D12\%IndyPlatform% md ..\..\..\Output\D12\%IndyPlatform% > nul
if not exist ..\..\..\Output\D12\%IndyPlatform%\%IndyConfig% md ..\..\..\Output\D12\%IndyPlatform%\%IndyConfig% > nul

if exist ..\..\..\Output\D12\*.* call "%~dp0..\Clean.bat" ..\..\..\Output\D12\


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
echo Delphi 2009 Compiler Not Present!
goto endok

:endok
popd
