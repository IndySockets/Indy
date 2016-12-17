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

computil SetupC11
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC11%)==() goto enderror
if not exist %NDC11%\bin\dcc32.exe goto endnocompiler
if not exist ..\C11\*.* md ..\C11 >nul
if exist ..\C11\*.* call clean.bat ..\C11\

cd System
copy IndySystem110.dpk ..\..\C11 > nul 
copy *IndySystem110.cfg1 ..\..\C11 > nul
copy *IndySystem110.cfg2 ..\..\C11 > nul
copy *.res ..\..\C11 > nul
copy *.pas ..\..\C11 > nul
copy *.inc ..\..\C11 > nul

cd ..\..\C11


REM ************************************************************
REM Compile IndySystem110 - Round 1
REM ************************************************************
copy IndySystem110.cfg1 IndySystem110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndySystem110.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem110 - Round 2
REM ************************************************************
del IndySystem110.cfg > nul
copy IndySystem110.cfg2 IndySystem110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndySystem110.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore110.dpk ..\..\C11 > nul
copy *IndyCore110.cfg1 ..\..\C11 > nul
copy *IndyCore110.cfg2 ..\..\C11 > nul
copy *.res ..\..\C11 > nul
copy *.pas ..\..\C11 > nul
copy *.dcr ..\..\C11 > nul
copy *.inc ..\..\C11 > nul


cd ..\..\C11


REM ************************************************************
REM Compile IndyCore110 - Round 1
REM ************************************************************
copy IndyCore110.cfg1 IndyCore110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndyCore110.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore110 - Round 2
REM ************************************************************
del IndyCore110.cfg > nul
copy IndyCore110.cfg2 IndyCore110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndyCore110.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore110 - Round 1
REM ************************************************************
copy dclIndyCore110.cfg1 dclIndyCore110.cfg > nul
%NDC11%\bin\dcc32.exe /B dclIndyCore110.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C11 > nul
copy *IndyProtocols110.dpk ..\..\C11 > nul
copy *IndyProtocols110.cfg1 ..\..\C11 > nul
copy *IndyProtocols110.cfg2 ..\..\C11 > nul
copy *.res ..\..\C11 > nul
copy *.pas ..\..\C11 > nul
copy *.dcr ..\..\C11 > nul
copy *.inc ..\..\C11 > nul

cd ..\..\C11


REM ************************************************************
REM Compile IndyProtocols110 - Round 1
REM ************************************************************
copy IndyProtocols110.cfg1 IndyProtocols110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndyProtocols110.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols110 - Round 2
REM ************************************************************
del IndyProtocols110.cfg > nul
copy IndyProtocols110.cfg2 IndyProtocols110.cfg > nul
%NDC11%\bin\dcc32.exe /B IndyProtocols110.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols110 - Round 1
REM ************************************************************
copy dclIndyProtocols110.cfg1 dclIndyProtocols110.cfg > nul
%NDC11%\bin\dcc32.exe /B dclIndyProtocols110.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem110.res
attrib +r indycore110.res
attrib +r indyprotocols110.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem110.res
attrib -r indycore110.res
attrib -r indyprotocols110.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 11 Compiler Not Present!
goto endok

:endok
cd ..\Lib
