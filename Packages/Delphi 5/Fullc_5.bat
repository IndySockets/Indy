@echo off

REM ****************************************************************************
REM  C++Builder 5 build for Indy (packages relocated; source resolves via ..\..\Lib).
REM  Build runs in the Output\C5 temp dir so the dpk's ..\..\Lib paths resolve.
REM ****************************************************************************

cd /d "%~dp0"
"%~dp0..\Computil.exe" SetupC5
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC5%)==() goto enderror
if not exist %NDC5%\bin\dcc32.exe goto endnocompiler
if not exist ..\..\Output\C5\*.* md ..\..\Output\C5 >nul
if exist ..\..\Output\C5\*.* call "%~dp0..\Clean.bat" ..\..\Output\C5\

REM stage package + config + resource files into the temp build dir
copy *.dpk ..\..\Output\C5 > nul
copy *.cfg1 ..\..\Output\C5 > nul
copy *.cfg2 ..\..\Output\C5 > nul
copy *.res ..\..\Output\C5 > nul
copy ..\..\Lib\Protocols\zlib\*.obj ..\..\Output\C5 > nul
cd ..\..\Output\C5

REM ----- IndySystem -----
copy IndySystem50.cfg1 IndySystem50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndySystem50.dpk
if errorlevel 1 goto enderror
del IndySystem50.cfg > nul
copy IndySystem50.cfg2 IndySystem50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndySystem50.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndySystem50.lsp
%NDC5%\bin\tlib.exe IndySystem50.lib @IndySystem50.lsp /P64
if errorlevel 1 goto enderror

REM ----- IndyCore -----
copy IndyCore50.cfg1 IndyCore50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndyCore50.dpk
if errorlevel 1 goto enderror
del IndyCore50.cfg > nul
copy IndyCore50.cfg2 IndyCore50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndyCore50.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyCore50.lsp
%NDC5%\bin\tlib.exe IndyCore50.lib @IndyCore50.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyCore -----
copy dclIndyCore50.cfg1 dclIndyCore50.cfg > nul
%NDC5%\bin\dcc32.exe /B dclIndyCore50.dpk
if errorlevel 1 goto enderror

REM ----- IndyProtocols -----
copy IndyProtocols50.cfg1 IndyProtocols50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndyProtocols50.dpk
if errorlevel 1 goto enderror
del IndyProtocols50.cfg > nul
copy IndyProtocols50.cfg2 IndyProtocols50.cfg > nul
%NDC5%\bin\dcc32.exe /B IndyProtocols50.dpk
if errorlevel 1 goto enderror
..\..\Lib\LspFix.exe IndyProtocols50.lsp
%NDC5%\bin\tlib.exe IndyProtocols50.lib @IndyProtocols50.lsp /P64
if errorlevel 1 goto enderror

REM ----- dclIndyProtocols -----
copy dclIndyProtocols50.cfg1 dclIndyProtocols50.cfg > nul
%NDC5%\bin\dcc32.exe /B dclIndyProtocols50.dpk
if errorlevel 1 goto enderror

REM ----- keep generated outputs, delete the rest -----
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem50.res
attrib +r indycore50.res
attrib +r indyprotocols50.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem50.res
attrib -r indycore50.res
attrib -r indyprotocols50.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 5 Compiler Not Present!
goto endok

:endok
