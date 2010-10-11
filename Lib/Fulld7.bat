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
computil SetupD7
if exist setenv.bat call setenv.bat
if not exist ..\D7\*.* md ..\D7 >nul
if exist ..\D7\*.* call clean.bat ..\D7\

if (%NDD7%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
CD System
%NDD7%\Bin\dcc32.exe IndySystem70.dpk /Oobjs /m /h /w /N..\..\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *70.bpl ..\..\D7 >nul
copy *70.dcp ..\..\D7 >nul
if errorlevel 1 goto enderror
copy ..\..\D7\IndySystem70.bpl %NDWINSYS% >nul
CD ..

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD7%\Bin\dcc32.exe IndyCore70.dpk /Oobjs /m /h /w /N..\..\D7 /U..\..\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD7%\Bin\dcc32.exe dclIndyCore70.dpk /Oobjs /m /h /w /N..\..\D7 /U..\..\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *70.bpl ..\..\D7 >nul
copy *70.dcp ..\..\D7 >nul
copy ..\..\D7\IndyCore70.bpl %NDWINSYS% >nul
copy ..\..\D7\dclIndyCore70.bpl %NDWINSYS% >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD7%\Bin\dcc32.exe -B -M -N..\..\D7 /U..\..\D7 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD7%\Bin\dcc32.exe IndyProtocols70.dpk /Oobjs /m /h /w /N..\..\D7 /U..\..\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD7%\Bin\dcc32.exe dclIndyProtocols70.dpk /Oobjs /m /h /w /N..\..\D7 /U..\..\D7 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *70.bpl ..\..\D7 >nul
copy *70.dcp ..\..\D7 >nul
copy ..\..\D7\IndyProtocols70.bpl %NDWINSYS% >nul
copy ..\..\D7\dclIndyProtocols70.bpl %NDWINSYS% >nul
CD ..

goto endok
:enderror
call clean
echo Error!
:endok

