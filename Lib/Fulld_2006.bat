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
call clean.bat
echo on
rem this generates setenv.bat, containing  the environment variables used for compiling
rem e.g.:
rem SET NDD10=\path\to\delphi2006
rem SET NDWINSYS=\path\to\system32
computil SetupD10
if exist setenv.bat call setenv.bat

if (%NDD10%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

set DCC32=%NDD10%\Bin\dcc32.exe
if not exist %DCC32% goto enderror

rem all output for Delphi 2006 goes into D10 (that's the number 1 not a lower case L)
set DOUT=..\D10

if not exist %DOUT%\*.* md %DOUT% >nul
if not exist %DOUT%\dcu\*.* md %DOUT%\dcu >nul

if exist %DOUT%\*.* call clean.bat %DOUT%

rem /B = Build
rem /O = object directories
rem /D = conditionals
rem /JL = generate files for C++
rem /H = output hints
rem /W = output warnings
set OPTIONS=/B /Oobjs /DBCB /JL /H /W

rem /LN = output for .bpl file
rem /LE = output for .dcp file
set EXEOUTPUTDIRS=/LN..\%DOUT% /LE..\%DOUT%

rem /N0 = output for dcu files (that's a zero, not an upper case o)
rem /NH = output for hpp files (these do not go into the dcu subdir
rem /NO = output for obj files
rem /NB = output for bpi files
rem note the additional '..\' here: We descend into subdirs later on
set OTHEROUTPUTDIRS=/N0..\%DOUT%\dcu /NH..\%DOUT% /NO..\%DOUT%\dcu /NB..\%DOUT%\dcu

rem D- = no debug information
rem L- = no local debug symbols
rem N+ = ??
rem P+ = open string parameters
rem R- = no range checking
rem S- = ??
rem T- = no typed @ parameter
rem W- = no stack frames
set SWITCHES=D-L-n+p+r-s-t-w-

ECHO ****************
ECHO  Compile System
ECHO ****************
pushd System
%DCC32% IndySystem100.dpk %OPTIONS% %EXEOUTPUTDIRS% %OTHEROUTPUTDIRS% /$%SWITCHES% %2 %3 %4
if errorlevel 1 goto enderror
rem copy ..\..\D100\IndySystem100.bpl %NDWINSYS% >nul
popd

ECHO **************
ECHO  Compile Core
ECHO **************
pushd Core
%DCC32% IndyCore100.dpk %OPTIONS% %EXEOUTPUTDIRS% %OTHEROUTPUTDIRS% /$%SWITCHES% %2 %3 %4
if errorlevel 1 goto enderror
%DCC32% dclIndyCore100.dpk %OPTIONS% %EXEOUTPUTDIRS% %OTHEROUTPUTDIRS% /$%SWITCHES% %2 %3 %4
if errorlevel 1 goto enderror
rem copy ..\..\D100\IndyCore100.bpl %NDWINSYS% >nul
rem copy ..\..\D100\dclIndyCore100.bpl %NDWINSYS% >nul
popd

ECHO *******************
ECHO  Compile Protocols
ECHO *******************
pushd Protocols

ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
rem %NDD10%\Bin\dcc32.exe -DBCB -B -M -JPHNE -N..\..\D100 /U..\..\D100 -H -W -Z IdCompressionIntercept.pas -$d-l-
rem if errorlevel 1 goto enderror

%DCC32% IndyProtocols100.dpk %OPTIONS% %EXEOUTPUTDIRS% %OTHEROUTPUTDIRS% /$%SWITCHES% %2 %3 %4
if errorlevel 1 goto enderror
%DCC32% dclIndyProtocols100.dpk %OPTIONS% %EXEOUTPUTDIRS% %OTHEROUTPUTDIRS% /$%SWITCHES% %2 %3 %4
if errorlevel 1 goto enderror

rem copy ..\..\D100\IndyProtocols100.bpl %NDWINSYS% >nul
rem copy ..\..\D100\dclIndyProtocols100.bpl %NDWINSYS% >nul
popd

goto endok
:enderror
popd
call clean.bat
echo Error!
:endok
