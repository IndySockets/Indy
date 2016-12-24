REM echo off

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
REM call ..\clean.bat
REM ..\computil SetupD12
set BUILDROOT=%CD%
pushd lib
REM SET NDD12=C:\Builds\TP
SET NDD12=D:\work\tp.3p
SET NDWINSYS=%BUILDROOT%\system32
set D12DCC=%NDD12%\bin\dcc32.exe
set BINOUTDIR=%BUILDROOT%\D120\bin
set DCUOUTDIR=%BUILDROOT%\D120\intermediate\release\lib
set DCPOUTDIR=%BUILDROOT%\D120\intermediate\release\dcp
set LIBOUTDIR=%BUILDROOT%\D120\lib\release
set HPPOUTDIR=%BUILDROOT%\D120\include\vcl
set DCCSWTS=-B -N0%DCUOUTDIR% -NH%HPPOUTDIR% -NO%LIBOUTDIR%  -NB%LIBOUTDIR% -U%NDD12%\intermediate\release\lib -Ic%NDD12%\intermediate\release\lib -LN%NDD12%\intermediate\release\dcp
set BCBSWTS=-JPHNE -JL
REM set DCCDWTS=-I%NDD12%\intermediate\release\lib -U%NDD12%\intermediate\release\dcp -LU%NDD12%\intermediate\release\dcp
REM SET DCCSWTS=-U%NDD12%\intermediate\release\lib -I%NDD12%\intermediate\release\lib -LN%NDD12%\intermediate\release\dcp
if exist setenv.bat call setenv.bat
if not exist %BINOUTDIR% md %BINOUTDIR% >nul
if not exist %DCUOUTDIR% md %DCUOUTDIR% >nul
if not exist %LIBOUTDIR% md %LIBOUTDIR% >nul
if not exist %HPPOUTDIR% md %HPPOUTDIR% >nul
if not exist %DCPOUTDIR% md %DCPOUTDIR% >nul
del /s /f /q %BUILDROOT%\D120
if (%NDD12%)==() goto enderror

ECHO ****************
ECHO  Compile System
ECHO ****************
call %BUILDROOT%\clean.bat
%NDD12%\Tools\brcc32.exe IndySystem.rc
echo ready to compile System
%D12DCC% IndySystem.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
REM %D12DCC% -B IndySystem.dpk /Oobjs /m /h /w /N..\..\..\D120 -$d-l-n+p+r-s-t-w- -U%NDD12%\intermediate\release\lib -I%NDD12%\intermediate\release\lib -LN%NDD12%\intermediate\release\dcp
if errorlevel 1 goto enderror
REM copy *120.bpl ..\..\..\D120 >nul
REM copy *.dcp ..\..\..\D120 >nul
REM copy ..\..\..\D120\IndySystem120.bpl %NDWINSYS% >nul
move /y IndySystem120.bpl %BINOUTDIR% 

ECHO **************
ECHO  Compile Core
ECHO **************
call %BUILDROOT%\clean.bat
%NDD12%\Tools\brcc32.exe IndyCore.rc
%NDD12%\Tools\brcc32.exe dclIndyCore.rc
%D12DCC% IndyCore.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
%D12DCC% dclIndyCore.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
move /y *120.bpl %BINOUTDIR% >nul
REM copy *.dcp ..\..\..\D120 >nul

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
call %BUILDROOT%\clean.bat

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%D12DCC% -B -M -N%BUILDROOT%\D120 /U%DCUOUTDIR% -H -W -Z ..\..\Source\IdCompressionIntercept.pas -$d-l- %DCCSWTS% 
if errorlevel 1 goto enderror

%NDD12%\Tools\brcc32.exe IndyProtocols.rc
%NDD12%\Tools\brcc32.exe dclIndyProtocols.rc
%D12DCC% IndyProtocols.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- -I..\D120 %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
%D12DCC% dclIndyProtocols.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror

move /y *120.bpl %BINOUTDIR% >nul
REM copy *.dcp ..\..\..\D120 
copy %NDD12%\intermediate\release\dcp\*indy*.dcp %DCPOUTDIR% 

goto endok

:enderror
call ..\clean.bat
echo Error!

:endok
popd