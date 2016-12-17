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
computil SetupD5
if exist setenv.bat call setenv.bat
if not exist ..\D5\*.* md ..\D5 >nul
if exist ..\D5\*.* call clean.bat ..\D5\

if (%NDD5%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
CD System
%NDD5%\Bin\dcc32.exe IndySystem50.dpk /Oobjs /m /h /w /N..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *50.bpl ..\..\D5 >nul
copy *50.dcp ..\..\D5 >nul
if errorlevel 1 goto enderror
copy ..\..\D5\IndySystem50.bpl %NDWINSYS% >nul
CD ..

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD5%\Bin\dcc32.exe IndyCore50.dpk /Oobjs /m /h /w /N..\..\D5 /U..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD5%\Bin\dcc32.exe dclIndyCore50.dpk /Oobjs /m /h /w /N..\..\D5 /U..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *50.bpl ..\..\D5 >nul
copy *50.dcp ..\..\D5 >nul
copy ..\..\D5\IndyCore50.bpl %NDWINSYS% >nul
copy ..\..\D5\dclIndyCore50.bpl %NDWINSYS% >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD5%\Bin\dcc32.exe -B -M -N..\..\D5 /U..\..\D5 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD5%\Bin\dcc32.exe IndyProtocols50.dpk /Oobjs /m /h /w /N..\..\D5 /U..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD5%\Bin\dcc32.exe dclIndyProtocols50.dpk /Oobjs /m /h /w /N..\..\D5 /U..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *50.bpl ..\..\D5 >nul
copy *50.dcp ..\..\D5 >nul
copy ..\..\D5\IndyProtocols50.bpl %NDWINSYS% >nul
copy ..\..\D5\dclIndyProtocols50.bpl %NDWINSYS% >nul
CD ..

goto endok
:enderror
call clean
echo Error!
:endok

