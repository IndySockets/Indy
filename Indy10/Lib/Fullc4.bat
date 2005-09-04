@echo off

if (%1)==() goto test_command
if (%1)==(start) goto start
goto endok

:test_command
if (%COMSPEC%)==() goto no_command
%COMSPEC% /E:9214 /C %0 start %1 %2 %3
goto endok

:no_command
echo No Command Interpreter found
goto endok

:start
call clean.bat
computil SetupC4
if exist setenv.bat call setenv.bat
if not exist ..\C4\*.* md ..\C4 >nul
if exist ..\C4\*.* call clean.bat ..\C4\

if (%NDC4%)==() goto enderror
if (%NDWINSYS%)==() goto enderror


copy Core\*.pas ..\C4
copy Core\*.dpk ..\C4
copy Core\*.obj ..\C4
copy Core\*.inc ..\C4
copy Core\*.res ..\C4
copy Core\*.dcr ..\C4
copy *.pas ..\C4
copy *.dpk ..\C4
copy *.obj ..\C4
copy *.inc ..\C4
copy *.res ..\C4
copy *.dcr ..\C4

if (%NDC4%)==() goto enderror
if (%NDWINSYS%)==() goto enderror

cd ..\C4

REM ***************************************************
REM Compile Runtime Core Package Indy40
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.
%NDC4%\bin\dcc32.exe IdCompressionIntercept.pas /M /DBCB /O..\Source\objs /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
%NDC4%\bin\dcc32.exe IndyCore40.dpk /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC4%\bin\dcc32.exe IndyCore40.dpk /O..\Source\objs /DBCB /M /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
REM ***************************************************
REM Create .LIB file
REM ***************************************************
echo Creating IndyCore40.LIB file, please wait...
..\Source\LspFix IndyCore40.lsp
%NDC4%\bin\tlib.exe IndyCore40.lib /P32 @IndyCore40.lsp >nul
if exist ..\C4\IndyCore40.bak del ..\C4\IndyCore40.bak >nul

REM ***************************************************
REM Compile Design Time Package Indy40
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.

%NDC4%\bin\dcc32.exe dclIndyCore40.dpk /DBCB /O..\Source\objs /H /W /N..\C4 /LIndy40.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Compile Runtime Package Indy40
REM ***************************************************
REM IdCompressionIntercept can never be built as part of a package.  It has to be compileed separately
REM due to a DCC32 bug.
%NDC4%\bin\dcc32.exe IdCompressionIntercept.pas /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4

%NDC4%\bin\dcc32.exe Indy40.dpk /O..\Source\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC4%\bin\dcc32.exe Indy40.dpk /O..\Source\objs /DBCB /M /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC4%\bin\dcc32.exe IdDummyUnit.pas /LIndy40.dcp /DBCB /O..\Source\objs /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
del IdDummyUnit.dcu >nul
del IdDummyUnit.hpp >nul
del IdDummyUnit.obj >nul

%NDC4%\bin\dcc32.exe Indy40.dpk /M /DBCB /O..\Source\objs /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
copy Indy40.bpl %NDWINSYS% >nul
del Indy40.bpl > nul

REM ***************************************************
REM Create .LIB file
REM ***************************************************
echo Creating Indy40.LIB file, please wait...
..\Source\LspFix Indy40.lsp
%NDC4%\bin\tlib.exe Indy40.lib /P32 @Indy40.lsp >nul
if exist ..\C4\Indy40.bak del ..\C4\Indy40.bak >nul

REM ***************************************************
REM Compile Design-time Package dclIndy40
REM ***************************************************
%NDC4%\bin\dcc32.exe dclIndy40.dpk /DBCB /O..\Source\objs /H /W /N..\C4 /LIndy40.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
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
if exist dclIndy40.dcu del dclIndy40.dcu >nul 
if exist dclIndy40.dcp del dclIndy40.dcp >nul 
if exist Indy40.dcu del Indy40.dcu >nul 
if exist Indy40.bpl del Indy40.bpl >nul 
if exist IndyCore40.dcu del IndyCore40.dcu >nul 
if exist IndyCore40.bpl del IndyCore40.bpl >nul 
if exist dclIndyCore40.dcu del dclIndyCore40.dcu >nul 
if exist dclIndyCore40.dcp del dclIndyCore40.dcp >nul
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

