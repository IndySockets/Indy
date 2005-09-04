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

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD6%\Bin\dcc32.exe IndyCore60.dpk /Oobjs /m /h /w /N..\..\D6 /LE..\..\D6 /LN..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\..\D6\IndyCore60.bpl %NDWINSYS% >nul
%NDD6%\Bin\dcc32.exe dclIndyCore60.dpk /Oobjs /m /h /w /N..\..\D6 /L..\..\D6\IndyCore60.dcp /U..\..\D6 /LE..\..\D6 /LN..\..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\D6\dclIndyCore60.bpl %NDWINSYS% >nul
CD ..

REM ***************************************************
REM Compile Runtime Package Indy60
REM ***************************************************
REM IdCompressionIntercept.pas has to be compiled separately from Indy60 because of a DCC32 bug.  The bug
REM also appears when doing a full build.
%NDD6%\bin\dcc32.exe IdCompressionIntercept.pas /Oobjs /m /h /w /N..\D6 /LE..\D6 /LN..\D6 /U..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4

%NDD6%\bin\dcc32.exe Indy60.dpk /Oobjs /m /h /w /N..\D6 /LE..\D6 /LN..\D6 /U..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\D6\Indy60.bpl %NDWINSYS% >nul

REM ***************************************************
REM Compile Design-time Package dclIndy60
REM ***************************************************
%NDD6%\bin\dcc32.exe dclIndy60.dpk /Oobjs /m /h /w /N..\D6 /LE..\D6 /LN..\D6 /L..\D6\Indy60.dcp /U..\D6 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Clean-up
REM ***************************************************
del ..\D6\dclIndy60.dcu >nul
del ..\D6\dclIndy60.dcp >nul
del ..\D6\Indy60.dcu >nul
del ..\D6\Indy60.bpl >nul
del ..\D6\IndyCore60.dcu >nul
del ..\D6\IndyCore60.bpl >nul
del ..\D6\dclIndyCore60.dcu >nul
del ..\D6\dclIndyCore60.dcp >nul
del ..\D6\IdAbout.dcu >nul
del ..\D6\IdDsnPropEdBinding.dcu >nul
del ..\D6\IdDsnCoreResourceStrings.dcu >nul
del ..\D6\IdDsnBaseCmpEdt.dcu >nul
del ..\D6\IdDsnSASLListEditorForm.dcu >nul
del ..\D6\IdDsnSASLListEditor.dcu > nul
del ..\D6\IdDsnRegister.dcu >nul
del ..\D6\IdRegister.dcu >nul
goto endok
:enderror
call clean
echo Error!
:endok

