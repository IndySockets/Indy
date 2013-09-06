@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Pre-requisites:  \Lib\Protocols\ZLib must contain the ZLIB OBJ files
REM                  \Lib\System contains the project / pas/ res files for IndySystem
REM                  \Lib\Core contains the project / pas/ res files for IndyCore
REM                  \Lib\Protocols contains the project / pas/ res files for IndyProtocols
REM 
REM ****************************************************************************

computil SetupC10
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC10%)==() goto enderror
if not exist %NDC10%\bin\dcc32.exe goto endnocompiler
if not exist ..\C10\*.* md ..\C10 >nul
if exist ..\C10\*.* call clean.bat ..\C10\

cd System
copy IndySystem100.dpk ..\..\C10 > nul
copy *IndySystem100.cfg1 ..\..\C10 > nul
copy *IndySystem100.cfg2 ..\..\C10 > nul
copy *.res ..\..\C10 > nul
copy *.pas ..\..\C10 > nul
copy *.inc ..\..\C10 > nul

cd ..\..\C10


REM ************************************************************
REM Compile IndySystem100 - Round 1
REM ************************************************************
copy IndySystem100.cfg1 IndySystem100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndySystem100.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem100 - Round 2
REM ************************************************************
del IndySystem100.cfg > nul
copy IndySystem100.cfg2 IndySystem100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndySystem100.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore100.dpk ..\..\C10 > nul
copy *IndyCore100.cfg1 ..\..\C10 > nul
copy *IndyCore100.cfg2 ..\..\C10 > nul
copy *.res ..\..\C10 > nul
copy *.pas ..\..\C10 > nul
copy *.dcr ..\..\C10 > nul
copy *.inc ..\..\C10 > nul


cd ..\..\C10


REM ************************************************************
REM Compile IndyCore100 - Round 1
REM ************************************************************
copy IndyCore100.cfg1 IndyCore100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyCore100.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore100 - Round 2
REM ************************************************************
del IndyCore100.cfg > nul
copy IndyCore100.cfg2 IndyCore100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyCore100.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore100 - Round 1
REM ************************************************************
copy dclIndyCore100.cfg1 dclIndyCore100.cfg > nul
%NDC10%\bin\dcc32.exe /B dclIndyCore100.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C10 > nul
copy *IndyProtocols100.dpk ..\..\C10 > nul
copy *IndyProtocols100.cfg1 ..\..\C10 > nul
copy *IndyProtocols100.cfg2 ..\..\C10 > nul
copy *.res ..\..\C10 > nul
copy *.pas ..\..\C10 > nul
copy *.dcr ..\..\C10 > nul
copy *.inc ..\..\C10 > nul

cd ..\..\C10


REM ************************************************************
REM Compile IndyProtocols100 - Round 1
REM ************************************************************
copy IndyProtocols100.cfg1 IndyProtocols100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyProtocols100.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols100 - Round 2
REM ************************************************************
del IndyProtocols100.cfg > nul
copy IndyProtocols100.cfg2 IndyProtocols100.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyProtocols100.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols100 - Round 1
REM ************************************************************
copy dclIndyProtocols100.cfg1 dclIndyProtocols100.cfg > nul
%NDC10%\bin\dcc32.exe /B dclIndyProtocols100.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem100.res
attrib +r indycore100.res
attrib +r indyprotocols100.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem100.res
attrib -r indycore100.res
attrib -r indyprotocols100.res

goto endok

:enderror
echo Error!
goto endok

:endnocompiler
echo C++Builder 10 Compiler Not Present!
goto endok

:endok
cd ..\Lib
