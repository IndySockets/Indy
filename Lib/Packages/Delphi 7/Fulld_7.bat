@echo off

if (%1)==() goto test_command
if (%1)==(start) goto start
goto endok

:test_command
if (%COMSPEC%)==() goto no_command
%COMSPEC% /E:9216 /C %0 start %1 %2 %3
goto endok

:no_command
echo No Command Interpreter found
goto endok

:start
cd /d "%~dp0"
call "%~dp0..\Clean.bat"
"%~dp0..\Computil.exe" SetupD7
if exist setenv.bat call setenv.bat
if not exist ..\..\..\Output\D7\*.* md ..\..\..\Output\D7 >nul
if exist ..\..\..\Output\D7\*.* call "%~dp0..\Clean.bat" ..\..\..\Output\D7\

if (%NDD7%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes IndySystem.dpk /Oobjs /m /h /w /N..\..\..\Output\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *70.bpl ..\..\..\Output\D7 >nul
copy *70.dcp ..\..\..\Output\D7 >nul
if errorlevel 1 goto enderror
copy ..\..\..\Output\D7\IndySystem70.bpl %NDWINSYS% >nul

ECHO **************
ECHO  Compile Core    
ECHO **************
%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes IndyCore.dpk /Oobjs /m /h /w /N..\..\..\Output\D7 /U..\..\..\Output\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes dclIndyCore.dpk /Oobjs /m /h /w /N..\..\..\Output\D7 /U..\..\..\Output\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *70.bpl ..\..\..\Output\D7 >nul
copy *70.dcp ..\..\..\Output\D7 >nul
copy ..\..\..\Output\D7\IndyCore70.bpl %NDWINSYS% >nul
copy ..\..\..\Output\D7\dclIndyCore70.bpl %NDWINSYS% >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes -B -M -N..\..\..\Output\D7 /U..\..\..\Output\D7 -H -W -Z ..\..\Source\Protocols\IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes IndyProtocols.dpk /Oobjs /m /h /w /N..\..\..\Output\D7 /U..\..\..\Output\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD7%\Bin\dcc32.exe /U..\..\Source /I..\..\Source\Includes dclIndyProtocols.dpk /Oobjs /m /h /w /N..\..\..\Output\D7 /U..\..\..\Output\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *70.bpl ..\..\..\Output\D7 >nul
copy *70.dcp ..\..\..\Output\D7 >nul
copy ..\..\..\Output\D7\IndyProtocols70.bpl %NDWINSYS% >nul
copy ..\..\..\Output\D7\dclIndyProtocols70.bpl %NDWINSYS% >nul

goto endok
:enderror
call clean
echo Error!
:endok

