@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Note: This batch file copies the ZLIB OBJ files from \Lib\Protocols\ZLib\i386-Win32-ZLib
REM       (Update to \Lib\Protocols\ZLib\x86_64-Win64-ZLib if required)
REM
REM Pre-requisites:  \Lib\System contains the project / pas/ res files for IndySystem
REM                  \Lib\Core contains the project / pas/ res files for IndyCore
REM                  \Lib\Protocols contains the project / pas/ res files for IndyProtocols
REM 
REM ****************************************************************************

computil SetupC17
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC17%)==() goto enderror
if not exist %NDC17%\bin\dcc32.exe goto endnocompiler
if not exist ..\C17\*.* md ..\C17 > nul
if not exist ..\C17\ZLib\*.* md ..\C17\ZLib > nul
if not exist ..\C17\ZLib\i386-Win32-ZLib\*.* md ..\C17\ZLib\i386-Win32-ZLib > nul
if not exist ..\C17\ZLib\x86_64-Win64-ZLib\*.* md ..\C17\ZLib\x86_64-Win64-ZLib > nul

if exist ..\C17\*.* call clean.bat ..\C17\

cd System
copy IndySystem170.dpk ..\..\C17 > nul
copy *IndySystem170.cfg1 ..\..\C17 > nul
copy *IndySystem170.cfg2 ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.inc ..\..\C17 > nul

cd ..\..\C17


REM ************************************************************
REM Compile IndySystem170 - Round 1
REM ************************************************************
copy IndySystem170.cfg1 IndySystem170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndySystem170.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem170 - Round 2
REM ************************************************************
del IndySystem170.cfg > nul 
copy IndySystem170.cfg2 IndySystem170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndySystem170.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore170.dpk ..\..\C17 > nul
copy *IndyCore170.cfg1 ..\..\C17 > nul
copy *IndyCore170.cfg2 ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.dcr ..\..\C17 > nul
copy *.inc ..\..\C17 > nul


cd ..\..\C17


REM ************************************************************
REM Compile IndyCore170 - Round 1
REM ************************************************************
copy IndyCore170.cfg1 IndyCore170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndyCore170.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore170 - Round 2
REM ************************************************************
del IndyCore170.cfg > nul
copy IndyCore170.cfg2 IndyCore170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndyCore170.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore170 - Round 1
REM ************************************************************
copy dclIndyCore170.cfg1 dclIndyCore170.cfg > nul
%NDC17%\bin\dcc32.exe /B dclIndyCore170.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols

copy zlib\i386-Win32-ZLib\*.obj ..\..\C17\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C17\ZLib\x86_64-Win64-ZLib > nul
copy *IndyProtocols170.dpk ..\..\C17 > nul
copy *IndyProtocols170.cfg1 ..\..\C17 > nul
copy *IndyProtocols170.cfg2 ..\..\C17 > nul
copy *.res ..\..\C17 > nul
copy *.pas ..\..\C17 > nul
copy *.dcr ..\..\C17 > nul
copy *.inc ..\..\C17 > nul

cd ..\..\C17


REM ************************************************************
REM Compile IndyProtocols170 - Round 1
REM ************************************************************
copy IndyProtocols170.cfg1 IndyProtocols170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndyProtocols170.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols170 - Round 2
REM ************************************************************
del IndyProtocols170.cfg > nul
copy IndyProtocols170.cfg2 IndyProtocols170.cfg > nul
%NDC17%\bin\dcc32.exe /B IndyProtocols170.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols170 - Round 1
REM ************************************************************
copy dclIndyProtocols170.cfg1 dclIndyProtocols170.cfg > nul
%NDC17%\bin\dcc32.exe /B dclIndyProtocols170.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
cd ZLib\i386-Win32-ZLib
del /Q *.* > nul
cd..
rd i386-Win32-ZLib
cd x86_64-Win64-ZLib
del /Q *.* > nul
cd..
rd x86_64-Win64-ZLib
cd..
rd ZLib
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem170.res
attrib +r indycore170.res
attrib +r indyprotocols170.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem170.res
attrib -r indycore170.res
attrib -r indyprotocols170.res

goto endok

:enderror
echo Error!
goto endok

:endnocompiler
echo C++Builder 17 Compiler Not Present!
goto endok

:endok
cd ..\Lib
