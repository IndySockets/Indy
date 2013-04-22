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

computil SetupC18
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC18%)==() goto enderror
if not exist %NDC18%\bin\dcc32.exe goto endnocompiler
if not exist ..\C18\*.* md ..\C18 > nul
if not exist ..\C18\ZLib\*.* md ..\C18\ZLib > nul
if not exist ..\C18\ZLib\i386-Win32-ZLib\*.* md ..\C18\ZLib\i386-Win32-ZLib > nul
if not exist ..\C18\ZLib\x86_64-Win64-ZLib\*.* md ..\C18\ZLib\x86_64-Win64-ZLib > nul

if exist ..\C18\*.* call clean.bat ..\C18\

cd System
copy IndySystem180.dpk ..\..\C18 > nul
copy *IndySystem180.cfg1 ..\..\C18 > nul
copy *IndySystem180.cfg2 ..\..\C18 > nul
copy *.res ..\..\C18 > nul
copy *.pas ..\..\C18 > nul
copy *.inc ..\..\C18 > nul

cd ..\..\C18


REM ************************************************************
REM Compile IndySystem180 - Round 1
REM ************************************************************
copy IndySystem180.cfg1 IndySystem180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndySystem180.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile IndySystem180 - Round 2
REM ************************************************************
del IndySystem180.cfg > nul 
copy IndySystem180.cfg2 IndySystem180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndySystem180.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore180.dpk ..\..\C18 > nul
copy *IndyCore180.cfg1 ..\..\C18 > nul
copy *IndyCore180.cfg2 ..\..\C18 > nul
copy *.res ..\..\C18 > nul
copy *.pas ..\..\C18 > nul
copy *.dcr ..\..\C18 > nul
copy *.inc ..\..\C18 > nul


cd ..\..\C18


REM ************************************************************
REM Compile IndyCore180 - Round 1
REM ************************************************************
copy IndyCore180.cfg1 IndyCore180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndyCore180.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore180 - Round 2
REM ************************************************************
del IndyCore180.cfg > nul
copy IndyCore180.cfg2 IndyCore180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndyCore180.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Compile dclIndyCore180 - Round 1
REM ************************************************************
copy dclIndyCore180.cfg1 dclIndyCore180.cfg > nul
%NDC18%\bin\dcc32.exe /B dclIndyCore180.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols

copy zlib\i386-Win32-ZLib\*.obj ..\..\C18\ZLib\i386-Win32-ZLib > nul
copy zlib\x86_64-Win64-ZLib\*.obj ..\..\C18\ZLib\x86_64-Win64-ZLib > nul
copy *IndyProtocols180.dpk ..\..\C18 > nul
copy *IndyProtocols180.cfg1 ..\..\C18 > nul
copy *IndyProtocols180.cfg2 ..\..\C18 > nul
copy *.res ..\..\C18 > nul
copy *.pas ..\..\C18 > nul
copy *.dcr ..\..\C18 > nul
copy *.inc ..\..\C18 > nul

cd ..\..\C18


REM ************************************************************
REM Compile IndyProtocols180 - Round 1
REM ************************************************************
copy IndyProtocols180.cfg1 IndyProtocols180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndyProtocols180.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols180 - Round 2
REM ************************************************************
del IndyProtocols180.cfg > nul
copy IndyProtocols180.cfg2 IndyProtocols180.cfg > nul
%NDC18%\bin\dcc32.exe /B IndyProtocols180.dpk
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols180 - Round 1
REM ************************************************************
copy dclIndyProtocols180.cfg1 dclIndyProtocols180.cfg > nul
%NDC18%\bin\dcc32.exe /B dclIndyProtocols180.dpk
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
attrib +r indysystem180.res
attrib +r indycore180.res
attrib +r indyprotocols180.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem180.res
attrib -r indycore180.res
attrib -r indyprotocols180.res

goto endok

:enderror
echo Error!
goto endok

:endnocompiler
echo C++Builder 18 Compiler Not Present!
goto endok

:endok
cd ..\Lib
