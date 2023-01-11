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
echo Start
call ..\clean.bat
..\computil SetupD11
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat >nul

if not exist ..\..\..\D11\*.* md ..\..\..\D11 >nul
if exist ..\..\..\D11\*.* call ..\clean.bat ..\..\..\D11\

if (%NDD11%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
%NDD11%\Bin\dcc32.exe IndySystem.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\..\D11 -$d-l-n+p+r-s-t-w- %2 %3 %4
copy *110.bpl ..\..\..\D11 >nul
copy *.dcp ..\..\..\D11 >nul
copy *.hpp ..\..\..\D11 >nul
if errorlevel 1 goto enderror
copy ..\..\..\D11\IndySystem110.bpl %NDWINSYS% >nul

ECHO **************
ECHO  Compile Core    
ECHO **************
%NDD11%\Bin\dcc32.exe IndyCore.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\..\D11 /U..\..\D11 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD11%\Bin\dcc32.exe dclIndyCore.dpk /Oobjs /DBCB /m /h /w /N..\..\..\D11 /U..\..\D11 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy *110.bpl ..\..\..\D11 >nul
copy *.dcp ..\..\..\D11 >nul
copy *.hpp ..\..\..\D11 >nul
copy ..\..\..\D11\IndyCore110.bpl %NDWINSYS% >nul
copy ..\..\..\D11\dclIndyCore110.bpl %NDWINSYS% >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDD11%\Bin\dcc32.exe -DBCB -B -M -JPHNE -N..\..\..\D11 /U..\..\..\D11 -H -W -Z ..\..\Source\IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror

%NDD11%\Bin\dcc32.exe IndyProtocols.dpk /Oobjs /DBCB /m /h /w /JPHNE /N..\..\..\D11 /U..\..\..\D11 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
%NDD11%\Bin\dcc32.exe dclIndyProtocols.dpk /Oobjs /DBCB /m /h /w /N..\..\..\D11 /U..\..\..\D11 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

copy *110.bpl ..\..\..\D11 >nul
copy *.dcp ..\..\..\D11 >nul
copy *.hpp ..\..\..\D11 >nul
copy ..\..\..\D11\IndyProtocols110.bpl %NDWINSYS% >nul
copy ..\..\..\D11\dclIndyProtocols110.bpl %NDWINSYS% >nul

goto endok

:enderror
call ..\clean
echo Error!

:endok
