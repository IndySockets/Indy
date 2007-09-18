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
if not exist ..\C5\*.* md ..\C5 > nul
if exist ..\C5\*.* call clean.bat ..\C5\
if (%NDC5%)==() goto enderrmsg

REM ***************************************************
REM Compile Runtime Package IndySystem50
REM ***************************************************
cd System
copy *.pas ..\..\C5 > nul
copy *.dpk ..\..\C5 > nul
copy *.obj ..\..\C5 > nul
copy *.inc ..\..\C5 > nul
copy *.res ..\..\C5 > nul
copy *.dcr ..\..\C5 > nul
copy *.rsp ..\..\C5 > nul
if not exist .\objs\*.* md .\objs > nul
cd ..\..\C5
%NDC5%\bin\dcc32.exe IndySystem50.dpk /O..\Lib\System\objs /DBCB /M /H /W /JPHNE /N. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe IndySystem50.dpk /O..\Lib\System\objs /DBCB /M /H /W /N. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix IndySystem50.lsp
if errorlevel 1 goto enderror
%NDC5%\bin\tlib.exe IndySystem50.lib @IndySystem50.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndySystem50
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
REM Compile Runtime Package IndyCore50
REM ***************************************************
cd ..\Lib\Core
copy *.pas ..\..\C5 > nul
copy *.dpk ..\..\C5 > nul
copy *.obj ..\..\C5 > nul
copy *.inc ..\..\C5 > nul
copy *.res ..\..\C5 > nul
copy *.dcr ..\..\C5 > nul
copy *.rsp ..\..\C5 > nul
if not exist .\objs\*.* md .\objs > nul
cd ..\..\C5
%NDC5%\bin\dcc32.exe IndyCore50.dpk /O..\Lib\Core\objs /DBCB /M /H /W /JPHNE /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe IndyCore50.dpk /O..\Lib\Core\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix IndyCore50.lsp
if errorlevel 1 goto enderror
%NDC5%\bin\tlib.exe IndyCore50.lib @IndyCore50.lsp /P64 > nul
del *.obj > nul

REM ***************************************************
REM Compile Designtime Package dclIndyCore50
REM ***************************************************
%NDC5%\bin\dcc32.exe dclIndyCore50.dpk /O..\Lib\Core\objs /DBCB /M /H /W /Z /JPHNE /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe dclIndyCore50.dpk /O..\Lib\Core\objs /DBCB /M /H /W /Z /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix dclIndyCore50.lsp
if errorlevel 1 goto enderror
%NDC5%\bin\tlib.exe dclIndyCore50.lib @dclIndyCore50.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndyCore50
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
REM Compile Runtime Package IndyProtocols50
REM ***************************************************
cd ..\Lib\Protocols
copy *.pas ..\..\C5 > nul
copy *.dpk ..\..\C5 > nul
copy *.obj ..\..\C5 > nul
copy *.inc ..\..\C5 > nul
copy *.res ..\..\C5 > nul
copy *.dcr ..\..\C5 > nul
copy *.rsp ..\..\C5 > nul
if not exist .\objs\*.* md .\objs > nul
cd ..\..\C5
%NDC5%\bin\dcc32.exe IndyProtocols50.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /JPHNE /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe IndyProtocols50.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
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

..\Lib\lspFix IndyProtocols50.lsp
if errorlevel 1 goto enderror
%NDC5%\bin\tlib.exe IndyProtocols50.lib @IndyProtocols50.lsp /P64 > nul
del *.obj > nul

REM ***************************************************
REM Compile Designtime Package dclIndyProtocols50
REM ***************************************************
%NDC5%\bin\dcc32.exe dclIndyProtocols50.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /JPHNE /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC5%\bin\dcc32.exe dclIndyProtocols50.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /N. /U. -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
..\Lib\lspFix dclIndyProtocols50.lsp
if errorlevel 1 goto enderror
%NDC5%\bin\tlib.exe dclIndyProtocols50.lib @dclIndyProtocols50.lsp /P64 > nul

REM ***************************************************
REM Clean-up IndyProtocols50
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

