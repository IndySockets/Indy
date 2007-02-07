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
if (%NDC6%)==() goto enderror

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
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndySystem60.dpk /O..\Lib\System\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe IndySystem60.dpk /M /DBCB /O..\Lib\System\objs /H /W -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

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
REM Compile Runtime/Designtime Packages IndyCore60
REM ***************************************************
cd ..\Lib\Core
copy *.pas ..\..\C6
copy *.dpk ..\..\C6
copy *.obj ..\..\C6
copy *.inc ..\..\C6
copy *.res ..\..\C6
copy *.dcr ..\..\C6
copy *.rsp ..\..\C6
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndyCore60.dpk /O..\Lib\Core\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe dclIndyCore60.dpk /DBCB /O..\Lib\Core\objs /H /W /N. /LIndyCore60.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

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
REM Compile Runtime/Designtime Packages IndyProtocols60
REM ***************************************************
cd ..\Lib\Protocols
copy *.pas ..\..\C6
copy *.dpk ..\..\C6
copy *.obj ..\..\C6
copy *.inc ..\..\C6
copy *.res ..\..\C6
copy *.dcr ..\..\C6
copy *.rsp ..\..\C6
cd ..\..\C6
%NDC6%\bin\dcc32.exe IndyProtocols60.dpk /O..\Lib\Protocols\objs /DBCB /M /H /W /JPHN -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror
%NDC6%\bin\dcc32.exe dclIndyProtocols60.dpk /DBCB /O..\Lib\Protocols\objs /H /W /N. /LIndyProtocols60.dcp -$d-l-n+p+r-s-t-w-y- %2 %3 %4
if errorlevel 1 goto enderror

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
echo Error!

:endok

