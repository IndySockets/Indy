@echo off

REM ****************************************************************************
REM 
REM Author : Malcolm Smith, MJ freelancing
REM          http://www.mjfreelancing.com
REM 
REM Pre-requisites:  \Lib\Source\ZLib must contain the ZLIB OBJ files
REM                  \Lib\Packages\CB_Delphi_4 contains the project / res files
REM                  \Lib\Source contains the pas / inc files
REM 
REM ****************************************************************************

..\computil SetupC4
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC4%)==() goto enderror
if not exist %NDC4%\bin\dcc32.exe goto endnocompiler

if not exist ..\..\..\C4\*.* md ..\..\..\C4 
if exist ..\..\..\C4\*.* call ..\clean.bat ..\..\..\C4\

copy IndySystem40.dpk ..\..\..\C4 > nul
copy *IndySystem40.cfg1 ..\..\..\C4 > nul
copy *IndySystem40.cfg2 ..\..\..\C4 > nul
copy *IndyCore40.dpk ..\..\..\C4 > nul
copy *IndyCore40.cfg1 ..\..\..\C4 > nul
copy *IndyCore40.cfg2 ..\..\..\C4 > nul
copy *IndyProtocols40.dpk ..\..\..\C4 > nul
copy *IndyProtocols40.cfg1* ..\..\..\C4 > nul
copy *IndyProtocols40.cfg2 ..\..\..\C4 > nul

cd ..\..\Source
copy zlib\*.obj ..\..\C4 > nul
copy *.res ..\..\C4 > nul
copy *.pas ..\..\C4 > nul
copy *.dcr ..\..\C4 > nul
copy *.inc ..\..\C4 > nul

cd ..\..\C4

REM ************************************************************
REM Compile IndySystem40 - Round 1
REM ************************************************************
copy IndySystem40.cfg1 IndySystem40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndySystem40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndySystem40 - Round 2
REM ************************************************************
del IndySystem40.cfg > nul
copy IndySystem40.cfg2 IndySystem40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndySystem40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Correct the LSP file (quote everything)
REM ************************************************************
..\Lib\Packages\LspFix.exe IndySystem40.lsp
%NDC4%\bin\tlib.exe IndySystem40.lib @IndySystem40.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore40 - Round 1
REM ************************************************************
copy IndyCore40.cfg1 IndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyCore40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyCore40 - Round 2
REM ************************************************************
del IndyCore40.cfg > nul
copy IndyCore40.cfg2 IndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyCore40.dpk
if errorlevel 1 goto enderror2

..\Lib\Packages\LspFix.exe IndyCore40.lsp
%NDC4%\bin\tlib.exe IndyCore40.lib @IndyCore40.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyCore40 - Round 1
REM ************************************************************
copy dclIndyCore40.cfg1 dclIndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyCore40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyCore40 - Round 2
REM ************************************************************
del dclIndyCore40.cfg > nul
copy dclIndyCore40.cfg2 dclIndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyCore40.dpk
if errorlevel 1 goto enderror2

rem ..\Lib\Packages\LspFix.exe dclIndyCore40.lsp
rem %NDC4%\bin\tlib.exe dclIndyCore40.lib @dclIndyCore40.lsp /P64
rem if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols40 - Round 1a (dummy build to get headers)
REM ************************************************************
copy IndyProtocols40.cfg1a IndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyProtocols40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols40 - Round 1b (dummy build to get headers)
REM ************************************************************
del IndyProtocols40.cfg > nul
copy IndyProtocols40.cfg1b IndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyProtocols40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile IndyProtocols40 - Round 2
REM ************************************************************
del IndyProtocols40.cfg > nul
copy IndyProtocols40.cfg2 IndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyProtocols40.dpk
if errorlevel 1 goto enderror2

..\Lib\Packages\LspFix.exe IndyProtocols40.lsp
%NDC4%\bin\tlib.exe IndyProtocols40.lib @IndyProtocols40.lsp /P64
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyProtocols40 - Round 1
REM ************************************************************
copy dclIndyProtocols40.cfg1 dclIndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyProtocols40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Compile dclIndyProtocols40 - Round 2
REM ************************************************************
del dclIndyProtocols40.cfg > nul 
copy dclIndyProtocols40.cfg2 dclIndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyProtocols40.dpk
if errorlevel 1 goto enderror2


REM ************************************************************
REM Set all files we want to keep with the R attribute then 
REM delete the rest before restoring the attribute
REM ************************************************************
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem40.res
attrib +r indycore40.res
attrib +r indyprotocols40.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem40.res
attrib -r indycore40.res
attrib -r indyprotocols40.res

cd ..\Lib\Packages\CB_Delphi_4
goto endok

:enderror2
cd ..\Lib\Packages\CB_Delphi_4

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 4 Compiler Not Present!
goto endok

:endok
