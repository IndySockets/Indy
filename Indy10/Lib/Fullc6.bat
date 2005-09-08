
REM %NDC6%

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
if (%NDWINSYS%)==() goto enderror

CD Lib
CD System
ECHO ****************
ECHO  Compile System 
ECHO ****************
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z IndySystem60.dpk -$d-l-
if errorlevel 1 goto enderror
Copy *60.bpl ..\..\C6 >> null
Copy *60.dcp ..\..\C6 >> null
CD ..
CD Core
ECHO **************
ECHO  Compile Core    
ECHO **************
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z IndyCore60.dpk -$d-l-
if errorlevel 1 goto enderror
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z dclIndyCore60.dpk -$d-l-
if errorlevel 1 goto enderror
Copy *60.bpl ..\..\C6 >> null
Copy *60.dcp ..\..\C6 >> null
CD ..
ECHO *******************
ECHO  Compile Protocols
ECHO *******************
CD Protocols
ECHO ************************
ECHO  IdCompressionIntercept
ECHO ************************
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z IdCompressionIntercept.pas -$d-l-
if errorlevel 1 goto enderror
ECHO *************************
ECHO  Compile IndyProtocols60  
ECHO *************************
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z IndyProtocols60.dpk -$d-l-
if errorlevel 1 goto enderror
ECHO ****************************
ECHO  Compile dclIndyProtocols60 
ECHO ****************************
%NDC6%\Bin\dcc32.exe -B -M -DBCB -N..\..\C6 -U..\..\C6 -H -W -Z dclIndyProtocols60.dpk -$d-l-
if errorlevel 1 goto enderror
Copy *60.bpl ..\..\C6 >> null
Copy *60.dcp ..\..\C6 >> null
CD ..
CD ..
ECHO.
del *.dcu >> null
del *.dcp >> null
goto ok
:ok
ECHO Adding compile_ok file
if exist compile_fail del compile_fail
ECHO Compile_OK > compile_ok
goto end
:enderror
CD ..
CD ..
ECHO Compile_Failed > compile_fail
del compile_run >> null
ECHO ! Error occured 
:end
del compile_run >> null

goto endok
:enderror
call clean
echo Error!
:endok
