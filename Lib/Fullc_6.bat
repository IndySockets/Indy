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

computil SetupC6
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC6%)==() goto enderror
if not exist %NDC6%\bin\dcc32.exe goto endnocompiler
if not exist ..\C6\*.* md ..\C6 
if exist ..\C6\*.* call clean.bat ..\C6\

cd System
copy IndySystem60.dpk ..\..\C6 > nul
copy *IndySystem60.cfg1 ..\..\C6 > nul
copy *IndySystem60.cfg2 ..\..\C6 > nul
copy *.res ..\..\C6 > nul
copy *.pas ..\..\C6 > nul
copy *.inc ..\..\C6 > nul

cd ..\..\C6


REM ************************************************************
REM Compile IndySystem60 - Round 1
REM ************************************************************
copy IndySystem60.cfg1 IndySystem60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndySystem60 - Round 2
REM ************************************************************
del IndySystem60.cfg > nul
copy IndySystem60.cfg2 IndySystem60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Correct the LSP file (quote everything)
REM ************************************************************
..\Lib\LspFix.exe IndySystem60.lsp
%NDC6%\bin\tlib.exe IndySystem60.lib @IndySystem60.lsp /P64
if errorlevel 1 goto enderror



REM ************************************************************
REM Prepare to copy all CORE related files
REM ************************************************************

cd ..\Lib\Core

copy *IndyCore60.dpk ..\..\C6 > nul
copy *IndyCore60.cfg1 ..\..\C6 > nul
copy *IndyCore60.cfg2 ..\..\C6 > nul
copy *.res ..\..\C6 > nul
copy *.pas ..\..\C6 > nul
copy *.dcr ..\..\C6 > nul
copy *.inc ..\..\C6 > nul


cd ..\..\C6


REM ************************************************************
REM Compile IndyCore60 - Round 1
REM ************************************************************
copy IndyCore60.cfg1 IndyCore60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyCore60 - Round 2
REM ************************************************************
del IndyCore60.cfg > nul
copy IndyCore60.cfg2 IndyCore60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore60.dpk
if errorlevel 1 goto enderror


..\Lib\LspFix.exe IndyCore60.lsp
%NDC6%\bin\tlib.exe IndyCore60.lib @IndyCore60.lsp /P64
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyCore60 - Round 1
REM ************************************************************
copy dclIndyCore60.cfg1 dclIndyCore60.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyCore60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile dclIndyCore60 - Round 2
REM ************************************************************
del dclIndyCore60.cfg > nul
copy dclIndyCore60.cfg2 dclIndyCore60.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyCore60.dpk
if errorlevel 1 goto enderror


rem ..\Lib\LspFix.exe dclIndyCore60.lsp
rem %NDC6%\bin\tlib.exe dclIndyCore60.lib @dclIndyCore60.lsp /P64
rem if errorlevel 1 goto enderror


REM ************************************************************
REM Prepare to copy all PROTOCOLS related files
REM ************************************************************

cd ..\Lib\Protocols


copy zlib\*.obj ..\..\C6 > nul
copy *IndyProtocols60.dpk ..\..\C6 > nul
copy *IndyProtocols60.cfg1 ..\..\C6 > nul
copy *IndyProtocols60.cfg2 ..\..\C6 > nul
copy *.res ..\..\C6 > nul
copy *.pas ..\..\C6 > nul
copy *.dcr ..\..\C6 > nul
copy *.inc ..\..\C6 > nul

cd ..\..\C6


REM ************************************************************
REM Compile IndyProtocols60 - Round 1
REM ************************************************************
copy IndyProtocols60.cfg1 IndyProtocols60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile IndyProtocols60 - Round 2
REM ************************************************************
del IndyProtocols60.cfg > nul
copy IndyProtocols60.cfg2 IndyProtocols60.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols60.dpk
if errorlevel 1 goto enderror


..\Lib\LspFix.exe IndyProtocols60.lsp
%NDC6%\bin\tlib.exe IndyProtocols60.lib @IndyProtocols60.lsp /P64
if errorlevel 1 goto enderror



REM ************************************************************
REM Compile dclIndyProtocols60 - Round 1
REM ************************************************************
copy dclIndyProtocols60.cfg1 dclIndyProtocols60.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyProtocols60.dpk
if errorlevel 1 goto enderror


REM ************************************************************
REM Compile dclIndyProtocols60 - Round 2
REM ************************************************************
del dclIndyProtocols60.cfg > nul
copy dclIndyProtocols60.cfg2 dclIndyProtocols60.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyProtocols60.dpk
if errorlevel 1 goto enderror




REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem60.res
attrib +r indycore60.res
attrib +r indyprotocols60.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem60.res
attrib -r indycore60.res
attrib -r indyprotocols60.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 6 Compiler Not Present!
goto endok

:endok
rem call clean
cd ..\Lib
