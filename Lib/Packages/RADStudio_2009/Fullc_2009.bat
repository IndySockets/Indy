@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Pre-requisites:  \Lib\Source\ZLib must contain the ZLIB OBJ files
REM                  \Lib\Packages\RADStudio_2009 contains the project / res files
REM                  \Lib\Source contains the pas / inc files
REM 
REM ****************************************************************************

..\computil SetupC12
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC12%)==() goto enderror
if not exist %NDC12%\bin\dcc32.exe goto endnocompiler

if not exist ..\..\..\C12\*.* md ..\..\..\C12 >nul
if exist ..\..\..\C12\*.* call ..\clean.bat ..\..\..\C12\

copy IndySystem.dpk ..\..\..\C12 > nul
copy *IndySystem.cfg1 ..\..\..\C12 > nul
copy *IndySystem.cfg2 ..\..\..\C12 > nul
copy *IndyCore.dpk ..\..\..\C12 > nul
copy *IndyCore.cfg1 ..\..\..\C12 > nul
copy *IndyCore.cfg2 ..\..\..\C12 > nul
copy *IndyProtocols.dpk ..\..\..\C12 > nul
copy *IndyProtocols.cfg1 ..\..\..\C12 > nul
copy *IndyProtocols.cfg2 ..\..\..\C12 > nul

cd ..\..\Source
copy zlib\*.obj ..\..\C12 > nul
copy *.res ..\..\C12 > nul
copy *.pas ..\..\C12 > nul
copy *.dcr ..\..\C12 > nul
copy *.inc ..\..\C12 > nul

cd ..\..\C12


REM ************************************************************
REM Compile IndySystem - Round 1
REM ************************************************************
copy IndySystem.cfg1 IndySystem.cfg > nul
%NDC12%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndySystem - Round 2
REM ************************************************************
del IndySystem.cfg > nul
copy IndySystem.cfg2 IndySystem.cfg > nul
%NDC12%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore - Round 1
REM ************************************************************
copy IndyCore.cfg1 IndyCore.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore - Round 2
REM ************************************************************
del IndyCore.cfg > nul
copy IndyCore.cfg2 IndyCore.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyCore - Round 1
REM ************************************************************
copy dclIndyCore.cfg1 dclIndyCore.cfg > nul
%NDC12%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols - Round 1
REM ************************************************************
copy IndyProtocols.cfg1 IndyProtocols.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols - Round 2
REM ************************************************************
del IndyProtocols.cfg > nul
copy IndyProtocols.cfg2 IndyProtocols.cfg > nul
%NDC12%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyProtocols - Round 1
REM ************************************************************
copy dclIndyProtocols.cfg1 dclIndyProtocols.cfg > nul
%NDC12%\bin\dcc32.exe /B dclIndyProtocols.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem.res
attrib +r indycore.res
attrib +r indyprotocols.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem.res
attrib -r indycore.res
attrib -r indyprotocols.res

cd ..\Lib\Packages\RADStudio_2009
goto endok

:enderror2
cd ..\Lib\Packages\RADStudio_2009

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 12 Compiler Not Present!
goto endok

:endok
