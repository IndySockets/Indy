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

computil SetupC15
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC15%)==() goto enderror
if not exist %NDC15%\bin\dcc32.exe goto endnocompiler
if not exist ..\C15\*.* md ..\C15 >nul
if exist ..\C15\*.* call clean.bat ..\C15\

cd System
copy IndySystem150.dpk ..\..\C15 > nul
copy *IndySystem150.cfg1 ..\..\C15 > nul
copy *IndySystem150.cfg2 ..\..\C15 > nul
copy *.res ..\..\C15 > nul
copy *.pas ..\..\C15 > nul
copy *.inc ..\..\C15 > nul

cd ..\..\C15


REM ************************************************************
REM Compile IndySystem150 - Round 1
REM ************************************************************
copy IndySystem150.cfg1 IndySystem150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndySystem150.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem150 - Round 2
REM ************************************************************
del IndySystem150.cfg > nul 
copy IndySystem150.cfg2 IndySystem150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndySystem150.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore150.dpk ..\..\C15 > nul
copy *IndyCore150.cfg1 ..\..\C15 > nul
copy *IndyCore150.cfg2 ..\..\C15 > nul
copy *.res ..\..\C15 > nul
copy *.pas ..\..\C15 > nul
copy *.dcr ..\..\C15 > nul
copy *.inc ..\..\C15 > nul


cd ..\..\C15


REM ************************************************************
REM Compile IndyCore150 - Round 1
REM ************************************************************
copy IndyCore150.cfg1 IndyCore150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyCore150.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore150 - Round 2
REM ************************************************************
del IndyCore150.cfg > nul
copy IndyCore150.cfg2 IndyCore150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyCore150.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore150 - Round 1
REM ************************************************************
copy dclIndyCore150.cfg1 dclIndyCore150.cfg > nul
%NDC15%\bin\dcc32.exe /B dclIndyCore150.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C15 > nul
copy *IndyProtocols150.dpk ..\..\C15 > nul
copy *IndyProtocols150.cfg1 ..\..\C15 > nul
copy *IndyProtocols150.cfg2 ..\..\C15 > nul
copy *.res ..\..\C15 > nul
copy *.pas ..\..\C15 > nul
copy *.dcr ..\..\C15 > nul
copy *.inc ..\..\C15 > nul

cd ..\..\C15


REM ************************************************************
REM Compile IndyProtocols150 - Round 1
REM ************************************************************
copy IndyProtocols150.cfg1 IndyProtocols150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyProtocols150.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols150 - Round 2
REM ************************************************************
del IndyProtocols150.cfg > nul
copy IndyProtocols150.cfg2 IndyProtocols150.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyProtocols150.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols150 - Round 1
REM ************************************************************
copy dclIndyProtocols150.cfg1 dclIndyProtocols150.cfg > nul
%NDC15%\bin\dcc32.exe /B dclIndyProtocols150.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem150.res
attrib +r indycore150.res
attrib +r indyprotocols150.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem150.res
attrib -r indycore150.res
attrib -r indyprotocols150.res

goto endok

:enderror
echo Error!
goto endok

:endnocompiler
echo C++Builder 15 Compiler Not Present!
goto endok

:endok
cd ..\Lib
