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
computil SetupC5
if exist setenv.bat call setenv.bat
if not exist ..\C5\*.* md ..\C5 >nul
if exist ..\C5\*.* call clean.bat ..\C5\

if (%NDC5%)==() goto enderror
if (%NDWINSYS%)==() goto enderror


copy Core\*.pas ..\C5
copy Core\*.dpk ..\C5
copy Core\*.obj ..\C5
copy Core\*.inc ..\C5
copy Core\*.res ..\C5
copy Core\*.dcr ..\C5
copy *.pas ..\C5
copy *.dpk ..\C5
copy *.obj ..\C5
copy *.inc ..\C5
copy *.res ..\C5
copy *.dcr ..\C5

if (%NDC5%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

cd ..\C5

REM ***************************************************
REM Compile Runtime Core Package Indy50
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.
%NDC5%\bin\dcc32.exe IdCompressionIntercept.pas /M /DBCB /O..\Source\objs /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
%NDC5%\bin\dcc32.exe IndyCore50.dpk /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe IndyCore50.dpk /O..\Source\objs /DBCB /M /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
REM ***************************************************
REM Create .LIB file
REM ***************************************************
echo Creating IndyCore50.LIB file, please wait...
..\Source\LspFix IndyCore50.lsp
%NDC5%\bin\tlib.exe IndyCore50.lib /P32 @IndyCore50.lsp >nul
if exist ..\C5\IndyCore50.bak del ..\C5\IndyCore50.bak >nul

REM ***************************************************
REM Compile Design Time Package Indy50
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.

%NDC5%\bin\dcc32.exe dclIndyCore50.dpk /DBCB /O..\Source\objs /H /W /N..\C5 /LIndy50.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Compile Runtime Package Indy50
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.
%NDC5%\bin\dcc32.exe IdCompressionIntercept.pas /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4

%NDC5%\bin\dcc32.exe Indy50.dpk /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe Indy50.dpk /O..\Source\objs /DBCB /M /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe IdDummyUnit.pas /LIndy50.dcp /DBCB /O..\Source\objs /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
del IdDummyUnit.dcu >nul
del IdDummyUnit.hpp >nul
del IdDummyUnit.obj >nul

%NDC5%\bin\dcc32.exe Indy50.dpk /M /DBCB /O..\Source\objs /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
copy Indy50.bpl %NDWINSYS% >nul
del Indy50.bpl > nul

REM ***************************************************
REM Create .LIB file
REM ***************************************************
echo Creating Indy50.LIB file, please wait...
..\Source\LspFix Indy50.lsp
%NDC5%\bin\tlib.exe Indy50.lib /P32 @Indy50.lsp >nul
if exist ..\C5\Indy50.bak del ..\C5\Indy50.bak >nul

REM ***************************************************
REM Compile Design-time Package dclIndy50
REM ***************************************************
%NDC5%\bin\dcc32.exe dclIndy50.dpk /DBCB /O..\Source\objs /H /W /N..\C5 /LIndy50.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Clean-up
REM ***************************************************
del *.pas > nul
del *.dpk > nul
del *.inc > nul
del *.dcr > nul

REM ***************************************************
REM Design-time only unit .DCU's are not needed.
REM ***************************************************
if exist dclIndy50.dcu del dclIndy50.dcu >nul 
if exist dclIndy50.dcp del dclIndy50.dcp >nul 
if exist Indy50.dcu del Indy50.dcu >nul 
if exist Indy50.bpl del Indy50.bpl >nul 
if exist IndyCore50.dcu del IndyCore50.dcu >nul 
if exist IndyCore50.bpl del IndyCore50.bpl >nul 
if exist dclIndyCore50.dcu del dclIndyCore50.dcu >nul 
if exist dclIndyCore50.dcp del dclIndyCore50.dcp >nul
if exist IdAbout.dcu del IdAbout.dcu >nul
if exist IdDsnPropEdBinding.dcu del IdDsnPropEdBinding.dcu >nul
if exist IdDsnCoreResourceStrings.dcu del IdDsnCoreResourceStrings.dcu >nul
if exist IdDsnBaseCmpEdt.dcu del IdDsnBaseCmpEdt.dcu >nul
if exist IdDsnSASLListEditorForm.dcu del IdDsnSASLListEditorForm.dcu >nul
if exist IdDsnSASLListEditor.dcu del IdDsnSASLListEditor.dcu > nul
if exist IdDsnRegister.dcu del IdDsnRegister.dcu >nul
if exist IdRegister.dcu del IdRegister.dcu >nul

goto endok
:enderror
call clean
echo Error!
:endok
cd ..\Source

