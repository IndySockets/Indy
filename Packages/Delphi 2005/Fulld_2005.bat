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
"%~dp0..\Computil.exe" SetupD9
if exist setenv.bat call setenv.bat
if not exist ..\..\Output\D9\*.* md ..\..\Output\D9 >nul
if exist ..\..\Output\D9\*.* call "%~dp0..\Clean.bat" ..\..\Output\D9\

if (%NDD9%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndySystem.dpk /Oobjs /m /h /w /N..\..\Output\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *90.bpl ..\..\Output\D9 >nul
copy *90.dcp ..\..\Output\D9 >nul
if errorlevel 1 goto enderror
copy ..\..\Output\D9\IndySystem90.bpl %NDWINSYS% >nul

ECHO **************
ECHO  Compile Core    
ECHO **************
%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyCore.dpk /Oobjs /m /h /w /N..\..\Output\D9 /U..\..\Output\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyCore.dpk /Oobjs /m /h /w /N..\..\Output\D9 /U..\..\Output\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *90.bpl ..\..\Output\D9 >nul
copy *90.dcp ..\..\Output\D9 >nul
copy ..\..\Output\D9\IndyCore90.bpl %NDWINSYS% >nul
copy ..\..\Output\D9\dclIndyCore90.bpl %NDWINSYS% >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib -B -M -N..\..\Output\D9 /U..\..\Output\D9 -H -W -Z ..\..\Lib\Protocols\IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib IndyProtocols.dpk /Oobjs /m /h /w /N..\..\Output\D9 /U..\..\Output\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD9%\Bin\dcc32.exe /U..\..\Lib /I..\..\Lib dclIndyProtocols.dpk /Oobjs /m /h /w /N..\..\Output\D9 /U..\..\Output\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *90.bpl ..\..\Output\D9 >nul
copy *90.dcp ..\..\Output\D9 >nul
copy ..\..\Output\D9\IndyProtocols90.bpl %NDWINSYS% >nul
copy ..\..\Output\D9\dclIndyProtocols90.bpl %NDWINSYS% >nul

goto endok
:enderror
call clean
echo Error!
:endok

