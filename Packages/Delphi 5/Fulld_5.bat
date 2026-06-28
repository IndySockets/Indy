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
"%~dp0..\Computil.exe" SetupD5
if exist setenv.bat call setenv.bat
if not exist ..\..\Output\D5\*.* md ..\..\Output\D5 >nul
if exist ..\..\Output\D5\*.* call "%~dp0..\Clean.bat" ..\..\Output\D5\

if (%NDD5%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndySystem50.dpk /Oobjs /m /h /w /N..\..\Output\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *50.bpl ..\..\Output\D5 >nul
copy *50.dcp ..\..\Output\D5 >nul
if errorlevel 1 goto enderror
copy ..\..\Output\D5\IndySystem50.bpl %NDWINSYS% >nul

ECHO **************
ECHO  Compile Core    
ECHO **************
%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyCore50.dpk /Oobjs /m /h /w /N..\..\Output\D5 /U..\..\Output\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyCore50.dpk /Oobjs /m /h /w /N..\..\Output\D5 /U..\..\Output\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *50.bpl ..\..\Output\D5 >nul
copy *50.dcp ..\..\Output\D5 >nul
copy ..\..\Output\D5\IndyCore50.bpl %NDWINSYS% >nul
copy ..\..\Output\D5\dclIndyCore50.bpl %NDWINSYS% >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib -B -M -N..\..\Output\D5 /U..\..\Output\D5 -H -W -Z ..\..\Lib\Protocols\IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyProtocols50.dpk /Oobjs /m /h /w /N..\..\Output\D5 /U..\..\Output\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD5%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyProtocols50.dpk /Oobjs /m /h /w /N..\..\Output\D5 /U..\..\Output\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *50.bpl ..\..\Output\D5 >nul
copy *50.dcp ..\..\Output\D5 >nul
copy ..\..\Output\D5\IndyProtocols50.bpl %NDWINSYS% >nul
copy ..\..\Output\D5\dclIndyProtocols50.bpl %NDWINSYS% >nul

goto endok
:enderror
call clean
echo Error!
:endok

