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
computil SetupD6
if exist setenv.bat call setenv.bat
if not exist ..\D6\*.* md ..\D6 >nul
if exist ..\D6\*.* call clean.bat ..\D6\

if (%NDD6%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
CD System
%NDD6%\Bin\dcc32.exe IndySystem60.dpk /Oobjs /m /h /w /N..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *60.bpl ..\..\D6 >nul
copy *60.dcp ..\..\D6 >nul
if errorlevel 1 goto enderror
copy ..\..\D6\IndySystem60.bpl %NDWINSYS% >nul
CD ..

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD6%\Bin\dcc32.exe IndyCore60.dpk /Oobjs /m /h /w /N..\..\D6 /U..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD6%\Bin\dcc32.exe dclIndyCore60.dpk /Oobjs /m /h /w /N..\..\D6 /U..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *60.bpl ..\..\D6 >nul
copy *60.dcp ..\..\D6 >nul
copy ..\..\D6\IndyCore60.bpl %NDWINSYS% >nul
copy ..\..\D6\dclIndyCore60.bpl %NDWINSYS% >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD6%\Bin\dcc32.exe -B -M -N..\..\D6 /U..\..\D6 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD6%\Bin\dcc32.exe IndyProtocols60.dpk /Oobjs /m /h /w /N..\..\D6 /U..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD6%\Bin\dcc32.exe dclIndyProtocols60.dpk /Oobjs /m /h /w /N..\..\D6 /U..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *60.bpl ..\..\D6 >nul
copy *60.dcp ..\..\D6 >nul
copy ..\..\D6\IndyProtocols60.bpl %NDWINSYS% >nul
copy ..\..\D6\dclIndyProtocols60.bpl %NDWINSYS% >nul
CD ..

goto endok
:enderror
call clean
echo Error!
:endok

