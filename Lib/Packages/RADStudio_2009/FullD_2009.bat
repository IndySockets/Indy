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
REM call clean.bat
REM computil SetupD12
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
CD System
call %BUILDROOT%\clean.bat
%NDD12%\Tools\brcc32.exe IndySystem120.rc
echo ready to compile System
%D12DCC% IndySystem120.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
REM %D12DCC% -B IndySystem120.dpk /Oobjs /m /h /w /N..\..\D120 -$d-l-n+p+r-s-t-w- -U%NDD12%\intermediate\release\lib -I%NDD12%\intermediate\release\lib -LN%NDD12%\intermediate\release\dcp
if errorlevel 1 goto enderror
REM copy *120.bpl ..\..\D120 >nul
REM copy *120.dcp ..\..\D120 >nul
REM copy ..\..\D120\IndySystem120.bpl %NDWINSYS% >nul
move /y IndySystem120.bpl %BINOUTDIR% 
CD ..

ECHO **************
ECHO  Compile Core
ECHO **************
CD Core
call %BUILDROOT%\clean.bat
%NDD12%\Tools\brcc32.exe IndyCore120.rc
%NDD12%\Tools\brcc32.exe dclIndyCore120.rc
%D12DCC% IndyCore120.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
%D12DCC% dclIndyCore120.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
move /y *120.bpl %BINOUTDIR% >nul
REM copy *120.dcp ..\..\D120 >nul
CD ..

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols
call %BUILDROOT%\clean.bat

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%D12DCC% -B -M -N%BUILDROOT%\D120 /U%DCUOUTDIR% -H -W -Z IdCompressionIntercept.pas -$d-l- %DCCSWTS% 
if errorlevel 1 goto enderror

%NDD12%\Tools\brcc32.exe IndyProtocols120.rc
%NDD12%\Tools\brcc32.exe dclIndyProtocols120.rc
%D12DCC% IndyProtocols120.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- -I..\D120 %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror
%D12DCC% dclIndyProtocols120.dpk /Oobjs /m /h /w /N%BUILDROOT%\D120 /U%DCUOUTDIR% -$d-l-n+p+r-s-t-w- %DCCSWTS% %BCBSWTS% %2 %3 %4
if errorlevel 1 goto enderror

move /y *120.bpl %BINOUTDIR% >nul
REM copy *120.dcp ..\..\D120 
copy %NDD12%\intermediate\release\dcp\*indy*120.dcp %DCPOUTDIR% 
CD ..

goto endok
:enderror
call ..\clean.bat
echo Error!
:endok
popd