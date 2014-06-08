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

computil SetupC12
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC12%)==() goto enderror
if not exist %NDC12%\bin\dcc32.exe goto endnocompiler
if not exist ..\C12\*.* md ..\C12 >nul
if exist ..\C12\*.* call clean.bat ..\C12\

cd System
copy IndySystem120.dpk ..\..\C12 > nul
copy *IndySystem120.cfg1 ..\..\C12 > nul
copy *IndySystem120.cfg2 ..\..\C12 > nul
copy *.res ..\..\C12 > nul
copy *.pas ..\..\C12 > nul
copy *.inc ..\..\C12 > nul

cd ..\..\C12


REM ************************************************************
REM Compile IndySystem120 - Round 1
REM ************************************************************
copy IndySystem120.cfg1 IndySystem120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndySystem120.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem120 - Round 2
REM ************************************************************
del IndySystem120.cfg > nul
copy IndySystem120.cfg2 IndySystem120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndySystem120.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore120.dpk ..\..\C12 > nul
copy *IndyCore120.cfg1 ..\..\C12 > nul
copy *IndyCore120.cfg2 ..\..\C12 > nul
copy *.res ..\..\C12 > nul
copy *.pas ..\..\C12 > nul
copy *.dcr ..\..\C12 > nul
copy *.inc ..\..\C12 > nul


cd ..\..\C12


REM ************************************************************
REM Compile IndyCore120 - Round 1
REM ************************************************************
copy IndyCore120.cfg1 IndyCore120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyCore120.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore120 - Round 2
REM ************************************************************
del IndyCore120.cfg > nul
copy IndyCore120.cfg2 IndyCore120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyCore120.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore120 - Round 1
REM ************************************************************
copy dclIndyCore120.cfg1 dclIndyCore120.cfg > nul
%NDC12%\bin\dcc32.exe /B dclIndyCore120.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C12 > nul
copy *IndyProtocols120.dpk ..\..\C12 > nul
copy *IndyProtocols120.cfg1 ..\..\C12 > nul
copy *IndyProtocols120.cfg2 ..\..\C12 > nul
copy *.res ..\..\C12 > nul
copy *.pas ..\..\C12 > nul
copy *.dcr ..\..\C12 > nul
copy *.inc ..\..\C12 > nul

cd ..\..\C12


REM ************************************************************
REM Compile IndyProtocols120 - Round 1
REM ************************************************************
copy IndyProtocols120.cfg1 IndyProtocols120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyProtocols120.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols120 - Round 2
REM ************************************************************
del IndyProtocols120.cfg > nul
copy IndyProtocols120.cfg2 IndyProtocols120.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyProtocols120.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols120 - Round 1
REM ************************************************************
copy dclIndyProtocols120.cfg1 dclIndyProtocols120.cfg > nul
%NDC12%\bin\dcc32.exe /B dclIndyProtocols120.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem120.res
attrib +r indycore120.res
attrib +r indyprotocols120.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem120.res
attrib -r indycore120.res
attrib -r indyprotocols120.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 12 Compiler Not Present!
goto endok

:endok
cd ..\Lib
