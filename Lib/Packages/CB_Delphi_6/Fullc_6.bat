@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Pre-requisites:  \Lib\Source\ZLib must contain the ZLIB OBJ files
REM                  \Lib\Packages\CB_Delphi_6 contains the project / res files
REM                  \Lib\Source contains the pas / inc files
REM 
REM ****************************************************************************

..\computil SetupC6
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC6%)==() goto enderror
if not exist %NDC6%\bin\dcc32.exe goto endnocompiler

if not exist ..\..\..\C6\*.* md ..\..\..\C6 
if exist ..\..\..\C6\*.* call ..\clean.bat ..\..\..\C6\

copy IndySystem.dpk ..\..\..\C6 > nul
copy *IndySystem.cfg1 ..\..\..\C6 > nul
copy *IndySystem.cfg2 ..\..\..\C6 > nul
copy *IndyCore.dpk ..\..\..\C6 > nul
copy *IndyCore.cfg1 ..\..\..\C6 > nul
copy *IndyCore.cfg2 ..\..\..\C6 > nul
copy *IndyProtocols.dpk ..\..\..\C6 > nul
copy *IndyProtocols.cfg1* ..\..\..\C6 > nul
copy *IndyProtocols.cfg2 ..\..\..\C6 > nul

cd ..\..\Source
copy zlib\*.obj ..\..\C6 > nul
copy *.res ..\..\C6 > nul
copy *.pas ..\..\C6 > nul
copy *.dcr ..\..\C6 > nul
copy *.inc ..\..\C6 > nul

cd ..\..\C6

REM ************************************************************
REM Compile IndySystem - Round 1
REM ************************************************************
copy IndySystem.cfg1 IndySystem.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndySystem - Round 2
REM ************************************************************
del IndySystem.cfg > nul
copy IndySystem.cfg2 IndySystem.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Correct the LSP file (quote everything)
REM ************************************************************
..\Lib\Packages\LspFix.exe IndySystem.lsp
%NDC6%\bin\tlib.exe IndySystem.lib @IndySystem.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore - Round 1
REM ************************************************************
copy IndyCore.cfg1 IndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore - Round 2
REM ************************************************************
del IndyCore.cfg > nul
copy IndyCore.cfg2 IndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror2

..\Lib\Packages\LspFix.exe IndyCore.lsp
%NDC6%\bin\tlib.exe IndyCore.lib @IndyCore.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyCore - Round 1
REM ************************************************************
copy dclIndyCore.cfg1 dclIndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyCore - Round 2
REM ************************************************************
del dclIndyCore.cfg > nul
copy dclIndyCore.cfg2 dclIndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror2

rem ..\Lib\Packages\LspFix.exe dclIndyCore.lsp
rem %NDC6%\bin\tlib.exe dclIndyCore.lib @dclIndyCore.lsp /P64
rem if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols - Round 1
REM ************************************************************
copy IndyProtocols.cfg1 IndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols - Round 2
REM ************************************************************
del IndyProtocols.cfg > nul
copy IndyProtocols.cfg2 IndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror2

..\Lib\Packages\LspFix.exe IndyProtocols.lsp
%NDC6%\bin\tlib.exe IndyProtocols.lib @IndyProtocols.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyProtocols - Round 1
REM ************************************************************
copy dclIndyProtocols.cfg1 dclIndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyProtocols.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyProtocols - Round 2
REM ************************************************************
del dclIndyProtocols.cfg > nul
copy dclIndyProtocols.cfg2 dclIndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyProtocols.dpk
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

cd ..\Lib\Packages\CB_Delphi_6
goto endok

:enderror2
cd ..\Lib\Packages\CB_Delphi_6

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 6 Compiler Not Present!
goto endok

:endok
