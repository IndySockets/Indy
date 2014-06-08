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

computil SetupC14
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC14%)==() goto enderror
if not exist %NDC14%\bin\dcc32.exe goto endnocompiler
if not exist ..\C14\*.* md ..\C14 >nul
if exist ..\C14\*.* call clean.bat ..\C14\

cd System
copy IndySystem140.dpk ..\..\C14 > nul
copy *IndySystem140.cfg1 ..\..\C14 > nul
copy *IndySystem140.cfg2 ..\..\C14 > nul
copy *.res ..\..\C14 > nul
copy *.pas ..\..\C14 > nul
copy *.inc ..\..\C14 > nul

cd ..\..\C14


REM ************************************************************
REM Compile IndySystem140 - Round 1
REM ************************************************************
copy IndySystem140.cfg1 IndySystem140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndySystem140.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem140 - Round 2
REM ************************************************************
del IndySystem140.cfg > nul
copy IndySystem140.cfg2 IndySystem140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndySystem140.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore140.dpk ..\..\C14 > nul
copy *IndyCore140.cfg1 ..\..\C14 > nul
copy *IndyCore140.cfg2 ..\..\C14 > nul
copy *.res ..\..\C14 > nul
copy *.pas ..\..\C14 > nul
copy *.dcr ..\..\C14 > nul
copy *.inc ..\..\C14 > nul


cd ..\..\C14


REM ************************************************************
REM Compile IndyCore140 - Round 1
REM ************************************************************
copy IndyCore140.cfg1 IndyCore140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndyCore140.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore140 - Round 2
REM ************************************************************
del IndyCore140.cfg > nul
copy IndyCore140.cfg2 IndyCore140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndyCore140.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore140 - Round 1
REM ************************************************************
copy dclIndyCore140.cfg1 dclIndyCore140.cfg > nul
%NDC14%\bin\dcc32.exe /B dclIndyCore140.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C14 > nul
copy *IndyProtocols140.dpk ..\..\C14 > nul
copy *IndyProtocols140.cfg1 ..\..\C14 > nul
copy *IndyProtocols140.cfg2 ..\..\C14 > nul
copy *.res ..\..\C14 > nul
copy *.pas ..\..\C14 > nul
copy *.dcr ..\..\C14 > nul
copy *.inc ..\..\C14 > nul

cd ..\..\C14


REM ************************************************************
REM Compile IndyProtocols140 - Round 1
REM ************************************************************
copy IndyProtocols140.cfg1 IndyProtocols140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndyProtocols140.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols140 - Round 2
REM ************************************************************
del IndyProtocols140.cfg > nul
copy IndyProtocols140.cfg2 IndyProtocols140.cfg > nul
%NDC14%\bin\dcc32.exe /B IndyProtocols140.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols140 - Round 1
REM ************************************************************
copy dclIndyProtocols140.cfg1 dclIndyProtocols140.cfg > nul
%NDC14%\bin\dcc32.exe /B dclIndyProtocols140.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem140.res
attrib +r indycore140.res
attrib +r indyprotocols140.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem140.res
attrib -r indycore140.res
attrib -r indyprotocols140.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 14 Compiler Not Present!
goto endok

:endok
cd ..\Lib
