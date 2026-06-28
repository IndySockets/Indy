@echo off

REM ****************************************************************************
REM  C++Builder 6 build for Indy (packages relocated; source resolves via ..\..\Lib).
REM  Build runs in the Output\C6 temp dir so the dpk's ..\..\Lib paths resolve.
REM ****************************************************************************

cd /d "%~dp0"
"%~dp0..\Computil.exe" SetupC6
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC6%)==() goto enderror
if not exist %NDC6%\bin\dcc32.exe goto endnocompiler
if not exist ..\..\Output\C6\*.* md ..\..\Output\C6 >nul
if exist ..\..\Output\C6\*.* call "%~dp0..\Clean.bat" ..\..\Output\C6\

REM stage package + config + resource files into the temp build dir
copy *.dpk ..\..\Output\C6 > nul
copy *.cfg1 ..\..\Output\C6 > nul
copy *.cfg2 ..\..\Output\C6 > nul
copy *.res ..\..\Output\C6 > nul
copy ..\..\Lib\Protocols\zlib\*.obj ..\..\Output\C6 > nul
cd ..\..\Output\C6

REM ----- IndySystem -----
copy IndySystem.cfg1 IndySystem.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror
del IndySystem.cfg > nul
copy IndySystem.cfg2 IndySystem.cfg > nul
%NDC6%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndySystem60.lsp
%NDC6%\bin\tlib.exe IndySystem60.lib @IndySystem60.lsp /P64
if errorlevel 1 goto enderror

REM ----- IndyCore -----
copy IndyCore.cfg1 IndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror
del IndyCore.cfg > nul
copy IndyCore.cfg2 IndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyCore60.lsp
%NDC6%\bin\tlib.exe IndyCore60.lib @IndyCore60.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyCore -----
copy dclIndyCore.cfg1 dclIndyCore.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror

REM ----- IndyProtocols -----
copy IndyProtocols.cfg1 IndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror
del IndyProtocols.cfg > nul
copy IndyProtocols.cfg2 IndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyProtocols60.lsp
%NDC6%\bin\tlib.exe IndyProtocols60.lib @IndyProtocols60.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyProtocols -----
copy dclIndyProtocols.cfg1 dclIndyProtocols.cfg > nul
%NDC6%\bin\dcc32.exe /B dclIndyProtocols.dpk
if errorlevel 1 goto enderror

REM ----- keep generated outputs, delete the rest -----
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
