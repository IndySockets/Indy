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
"%~dp0..\Computil.exe" SetupD6
if exist setenv.bat call setenv.bat
if not exist ..\..\Output\D6\*.* md ..\..\Output\D6 >nul
if exist ..\..\Output\D6\*.* call "%~dp0..\Clean.bat" ..\..\Output\D6\

if (%NDD6%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndySystem.dpk /Oobjs /m /h /w /N..\..\Output\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *60.bpl ..\..\Output\D6 >nul
copy *60.dcp ..\..\Output\D6 >nul
if errorlevel 1 goto enderror
copy ..\..\Output\D6\IndySystem60.bpl %NDWINSYS% >nul

ECHO **************
ECHO  Compile Core    
ECHO **************
%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyCore.dpk /Oobjs /m /h /w /N..\..\Output\D6 /U..\..\Output\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyCore.dpk /Oobjs /m /h /w /N..\..\Output\D6 /U..\..\Output\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *60.bpl ..\..\Output\D6 >nul
copy *60.dcp ..\..\Output\D6 >nul
copy ..\..\Output\D6\IndyCore60.bpl %NDWINSYS% >nul
copy ..\..\Output\D6\dclIndyCore60.bpl %NDWINSYS% >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib -B -M -N..\..\Output\D6 /U..\..\Output\D6 -H -W -Z ..\..\Lib\Protocols\IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyProtocols.dpk /Oobjs /m /h /w /N..\..\Output\D6 /U..\..\Output\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD6%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyProtocols.dpk /Oobjs /m /h /w /N..\..\Output\D6 /U..\..\Output\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *60.bpl ..\..\Output\D6 >nul
copy *60.dcp ..\..\Output\D6 >nul
copy ..\..\Output\D6\IndyProtocols60.bpl %NDWINSYS% >nul
copy ..\..\Output\D6\dclIndyProtocols60.bpl %NDWINSYS% >nul

goto endok
:enderror
call clean
echo Error!
:endok

