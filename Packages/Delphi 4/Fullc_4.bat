@echo off

REM ****************************************************************************
REM  C++Builder 4 build for Indy (packages relocated; source resolves via ..\..\Lib).
REM  Build runs in the Output\C4 temp dir so the dpk's ..\..\Lib paths resolve.
REM ****************************************************************************

cd /d "%~dp0"
"%~dp0..\Computil.exe" SetupC4
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC4%)==() goto enderror
if not exist %NDC4%\bin\dcc32.exe goto endnocompiler
if not exist ..\..\Output\C4\*.* md ..\..\Output\C4 >nul
if exist ..\..\Output\C4\*.* call "%~dp0..\Clean.bat" ..\..\Output\C4\

REM stage package + config + resource files into the temp build dir
copy *.dpk ..\..\Output\C4 > nul
copy *.cfg1 ..\..\Output\C4 > nul
copy *.cfg2 ..\..\Output\C4 > nul
copy *.res ..\..\Output\C4 > nul
copy ..\..\Lib\Protocols\zlib\*.obj ..\..\Output\C4 > nul
cd ..\..\Output\C4

REM ----- IndySystem -----
copy IndySystem40.cfg1 IndySystem40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndySystem40.dpk
if errorlevel 1 goto enderror
del IndySystem40.cfg > nul
copy IndySystem40.cfg2 IndySystem40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndySystem40.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndySystem40.lsp
%NDC4%\bin\tlib.exe IndySystem40.lib @IndySystem40.lsp /P64
if errorlevel 1 goto enderror

REM ----- IndyCore -----
copy IndyCore40.cfg1 IndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyCore40.dpk
if errorlevel 1 goto enderror
del IndyCore40.cfg > nul
copy IndyCore40.cfg2 IndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyCore40.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyCore40.lsp
%NDC4%\bin\tlib.exe IndyCore40.lib @IndyCore40.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyCore -----
copy dclIndyCore40.cfg1 dclIndyCore40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyCore40.dpk
if errorlevel 1 goto enderror

REM ----- IndyProtocols -----
copy IndyProtocols40.cfg1 IndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyProtocols40.dpk
if errorlevel 1 goto enderror
del IndyProtocols40.cfg > nul
copy IndyProtocols40.cfg2 IndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B IndyProtocols40.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyProtocols40.lsp
%NDC4%\bin\tlib.exe IndyProtocols40.lib @IndyProtocols40.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyProtocols -----
copy dclIndyProtocols40.cfg1 dclIndyProtocols40.cfg > nul
%NDC4%\bin\dcc32.exe /B dclIndyProtocols40.dpk
if errorlevel 1 goto enderror

REM ----- keep generated outputs, delete the rest -----
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

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 4 Compiler Not Present!
goto endok

:endok
