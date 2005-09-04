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

ECHO **************
ECHO  Compile Core    
ECHO **************
CD Core
%NDD5%\Bin\dcc32.exe IndyCore50.dpk /Oobjs /m /h /w /N..\..\D5 /LE..\..\D5 /LN..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\..\D5\IndyCore50.bpl %NDWINSYS% >nul
%NDD5%\Bin\dcc32.exe dclIndyCore50.dpk /Oobjs /m /h /w /N..\..\D5 /L..\..\D5\IndyCore50.dcp /U..\..\D5 /LE..\..\D5 /LN..\..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\D5\dclIndyCore50.bpl %NDWINSYS% >nul
CD ..

REM ***************************************************
REM Compile Runtime Package Indy50
REM ***************************************************
REM IdCompressionIntercept.pas has to be compiled separately from Indy50 because of a DCC32 bug.  The bug
REM also appears when doing a full build.
%NDD5%\bin\dcc32.exe IdCompressionIntercept.pas /Oobjs /m /h /w /N..\D5 /LE..\D5 /LN..\D5 /U..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4

%NDD5%\bin\dcc32.exe Indy50.dpk /Oobjs /m /h /w /N..\D5 /LE..\D5 /LN..\D5 /U..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror
copy ..\D5\Indy50.bpl %NDWINSYS% >nul

REM ***************************************************
REM Compile Design-time Package dclIndy50
REM ***************************************************
%NDD5%\bin\dcc32.exe dclIndy50.dpk /Oobjs /m /h /w /N..\D5 /LE..\D5 /LN..\D5 /L..\D5\Indy50.dcp /U..\D5 -$d-l-n+p+r-s-t-w- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Clean-up
REM ***************************************************
del ..\D5\dclIndy50.dcu >nul
del ..\D5\dclIndy50.dcp >nul
del ..\D5\Indy50.dcu >nul
del ..\D5\Indy50.bpl >nul
del ..\D5\IndyCore50.dcu >nul
del ..\D5\IndyCore50.bpl >nul
del ..\D5\dclIndyCore50.dcu >nul
del ..\D5\dclIndyCore50.dcp >nul
del ..\D5\IdAbout.dcu >nul
del ..\D5\IdDsnPropEdBinding.dcu >nul
del ..\D5\IdDsnCoreResourceStrings.dcu >nul
del ..\D5\IdDsnBaseCmpEdt.dcu >nul
del ..\D5\IdDsnSASLListEditorForm.dcu >nul
del ..\D5\IdDsnSASLListEditor.dcu > nul
del ..\D5\IdDsnRegister.dcu >nul
del ..\D5\IdRegister.dcu >nul
goto endok
:enderror
call clean
echo Error!
:endok

