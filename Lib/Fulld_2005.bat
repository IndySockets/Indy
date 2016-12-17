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
call clean.bat
computil SetupD9
if exist setenv.bat call setenv.bat
if not exist ..\D9\*.* md ..\D9 >nul
if exist ..\D9\*.* call clean.bat ..\D9\

if (%NDD9%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
CD System
%NDD9%\Bin\dcc32.exe IndySystem90.dpk /Oobjs /m /h /w /N..\..\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *90.bpl ..\..\D9 >nul
copy *90.dcp ..\..\D9 >nul
if errorlevel 1 goto enderror
copy ..\..\D9\IndySystem90.bpl %NDWINSYS% >nul
CD ..

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD9%\Bin\dcc32.exe IndyCore90.dpk /Oobjs /m /h /w /N..\..\D9 /U..\..\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD9%\Bin\dcc32.exe dclIndyCore90.dpk /Oobjs /m /h /w /N..\..\D9 /U..\..\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *90.bpl ..\..\D9 >nul
copy *90.dcp ..\..\D9 >nul
copy ..\..\D9\IndyCore90.bpl %NDWINSYS% >nul
copy ..\..\D9\dclIndyCore90.bpl %NDWINSYS% >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD9%\Bin\dcc32.exe -B -M -N..\..\D9 /U..\..\D9 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD9%\Bin\dcc32.exe IndyProtocols90.dpk /Oobjs /m /h /w /N..\..\D9 /U..\..\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD9%\Bin\dcc32.exe dclIndyProtocols90.dpk /Oobjs /m /h /w /N..\..\D9 /U..\..\D9 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *90.bpl ..\..\D9 >nul
copy *90.dcp ..\..\D9 >nul
copy ..\..\D9\IndyProtocols90.bpl %NDWINSYS% >nul
copy ..\..\D9\dclIndyProtocols90.bpl %NDWINSYS% >nul
CD ..

goto endok
:enderror
call clean
echo Error!
:endok

