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
computil SetupC6
if exist setenv.bat call setenv.bat
if not exist ..\C6\*.* md ..\C6 >nul
if exist ..\C6\*.* call clean.bat ..\C6\
if (%NDC6%)==() goto enderrmsg

REM ***************************************************
REM Compile Runtime Package IndySystem60
REM ***************************************************
cd System
copy *.pas ..\..\C6
copy *.dpk ..\..\C6
copy *.obj ..\..\C6
copy *.inc ..\..\C6
copy *.res ..\..\C6
copy *.dcr ..\..\C6
copy *.rsp ..\..\C6
if not exist .\objs\*.* md .\objs >nul
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndySystem60.dpk /O..\Lib\System\objs /DBCB /M /H /W /JPHN /N. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe IndySystem60.dpk /O..\Lib\System\objs /DBCB /M /H /W /N. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix IndySystem60.lsp
if errorlevel 1 goto enderror
%NDC6%\bin\tlib.exe IndySystem60.lib @IndySystem60.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndySystem60
REM ***************************************************
del *.dcu > nul
del *.pas > nul
del *.dpk > nul
del *.obj > nul
del *.inc > nul
del *.res > nul
del *.dcr > nul
del *.rsp > nul

REM ***************************************************
REM Compile Runtime Package IndyCore60
REM ***************************************************
cd ..\Lib\Core
copy *.pas ..\..\C6
copy *.dpk ..\..\C6
copy *.obj ..\..\C6
copy *.inc ..\..\C6
copy *.res ..\..\C6
copy *.dcr ..\..\C6
copy *.rsp ..\..\C6
if not exist .\objs\*.* md .\objs >nul
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndyCore60.dpk /O..\Lib\Core\objs /DBCB /M /H /W /JPHN /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe IndyCore60.dpk /O..\Lib\Core\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix IndyCore60.lsp
if errorlevel 1 goto enderror
%NDC6%\bin\tlib.exe IndyCore60.lib @IndyCore60.lsp /P64 > nul
del *.obj > nul

REM ***************************************************
REM Compile Designtime Package dclIndyCore60
REM ***************************************************
%NDC6%\bin\dcc32.exe dclIndyCore60.dpk /O..\Lib\Core\objs /DBCB /M /H /W /Z /JPHN /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe dclIndyCore60.dpk /O..\Lib\Core\objs /DBCB /M /H /W /Z /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix dclIndyCore60.lsp
if errorlevel 1 goto enderror
%NDC6%\bin\tlib.exe dclIndyCore60.lib @dclIndyCore60.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndyCore60
REM ***************************************************
del *.dcu > nul
del *.pas > nul
del *.dpk > nul
del *.obj > nul
del *.inc > nul
del *.res > nul
del *.dcr > nul
del *.rsp > nul

REM ***************************************************
REM Compile Runtime Package IndyProtocols60
REM ***************************************************
cd ..\Lib\Protocols
copy *.pas ..\..\C6
copy *.dpk ..\..\C6
copy *.obj ..\..\C6
copy *.inc ..\..\C6
copy *.res ..\..\C6
copy *.dcr ..\..\C6
copy *.rsp ..\..\C6
if not exist .\objs\*.* md .\objs >nul
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndyProtocols60.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /JPHN /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe IndyProtocols60.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

REM ***************************************************
REM Delete third-party .obj files
REM before compiling the .lib file
REM ***************************************************
del adler32.obj > nul
del compress.obj > nul
del crc32.obj > nul
del deflate.obj > nul
del example.obj > nul
del gzio.obj > nul
del infback.obj > nul
del inffast.obj > nul
del inflate.obj > nul
del inftrees.obj > nul
del minigzip.obj > nul
del trees.obj > nul
del uncompr.obj > nul
del zutil.obj > nul

..\Lib\lspFix IndyProtocols60.lsp
if errorlevel 1 goto enderror
%NDC6%\bin\tlib.exe IndyProtocols60.lib @IndyProtocols60.lsp /P64 > nul
del *.obj > nul

REM ***************************************************
REM Compile Designtime Package dclIndyProtocols60
REM ***************************************************
%NDC6%\bin\dcc32.exe dclIndyProtocols60.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /JPHN /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe dclIndyProtocols60.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix dclIndyProtocols60.lsp
if errorlevel 1 goto enderror
%NDC6%\bin\tlib.exe dclIndyProtocols60.lib @dclIndyProtocols60.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndyProtocols60
REM ***************************************************
del *.dcu > nul
del *.pas > nul
del *.dpk > nul
del *.obj > nul
del *.inc > nul
del *.res > nul
del *.dcr > nul
del *.rsp > nul
cd ..\Lib
goto endok

:enderror
call ..\Lib\clean.bat
cd ..\Lib

:enderrmsg
echo Error!

:endok

