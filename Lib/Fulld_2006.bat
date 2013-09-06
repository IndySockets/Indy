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
computil SetupD10
if exist setenv.bat call setenv.bat
if not exist ..\D100\*.* md ..\D100 >nul
if exist ..\D100\*.* call clean.bat ..\D100\

if (%NDD10%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
CD System
%NDD10%\Bin\dcc32.exe IndySystem100.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\D100 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *100.bpl ..\..\D100 >nul
copy *100.dcp ..\..\D100 >nul
copy *.hpp ..\..\D100 >nul
copy ..\..\D100\IndySystem100.bpl %NDWINSYS% >nul
CD ..

ECHO **************
ECHO  Compile Core
ECHO **************
CD Core
%NDD10%\Bin\dcc32.exe IndyCore100.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\D100 /U..\..\D100 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD10%\Bin\dcc32.exe dclIndyCore100.dpk /Oobjs /DBCB /m /h /w /N..\..\D100 /U..\..\D100 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *100.bpl ..\..\D100 >nul
copy *100.dcp ..\..\D100 >nul
copy *.hpp ..\..\D100 >nul
copy ..\..\D100\IndyCore100.bpl %NDWINSYS% >nul
copy ..\..\D100\dclIndyCore100.bpl %NDWINSYS% >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD10%\Bin\dcc32.exe -DBCB -B -M -JPHNE -N..\..\D100 /U..\..\D100 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD10%\Bin\dcc32.exe IndyProtocols100.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\D100 /U..\..\D100 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD10%\Bin\dcc32.exe dclIndyProtocols100.dpk /Oobjs /m /h /w /N..\..\D100 /U..\..\D100 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *100.bpl ..\..\D100 >nul
copy *100.dcp ..\..\D100 >nul
copy *.hpp ..\..\D100 >nul
copy ..\..\D100\IndyProtocols100.bpl %NDWINSYS% >nul
copy ..\..\D100\dclIndyProtocols100.bpl %NDWINSYS% >nul
CD ..

goto endok
:enderror
call clean
echo Error!
:endok
