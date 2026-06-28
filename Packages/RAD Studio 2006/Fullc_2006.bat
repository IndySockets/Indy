@echo off

REM ****************************************************************************
REM  C++Builder 10 build for Indy (packages relocated; source resolves via ..\..\Lib).
REM  Build runs in the Output\C10 temp dir so the dpk's ..\..\Lib paths resolve.
REM ****************************************************************************

cd /d "%~dp0"
"%~dp0..\Computil.exe" SetupC10
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC10%)==() goto enderror
if not exist %NDC10%\bin\dcc32.exe goto endnocompiler
if not exist ..\..\Output\C10\*.* md ..\..\Output\C10 >nul
if exist ..\..\Output\C10\*.* call "%~dp0..\Clean.bat" ..\..\Output\C10\

REM stage package + config + resource files into the temp build dir
copy *.dpk ..\..\Output\C10 > nul
copy *.cfg1 ..\..\Output\C10 > nul
copy *.cfg2 ..\..\Output\C10 > nul
copy *.res ..\..\Output\C10 > nul
copy ..\..\Lib\Protocols\zlib\*.obj ..\..\Output\C10 > nul
cd ..\..\Output\C10

REM ----- IndySystem -----
copy IndySystem.cfg1 IndySystem.cfg > nul
%NDC10%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror
del IndySystem.cfg > nul
copy IndySystem.cfg2 IndySystem.cfg > nul
%NDC10%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror

REM ----- IndyCore -----
copy IndyCore.cfg1 IndyCore.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror
del IndyCore.cfg > nul
copy IndyCore.cfg2 IndyCore.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror

REM ----- dclIndyCore -----
copy dclIndyCore.cfg1 dclIndyCore.cfg > nul
%NDC10%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror

REM ----- IndyProtocols -----
copy IndyProtocols.cfg1 IndyProtocols.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror
del IndyProtocols.cfg > nul
copy IndyProtocols.cfg2 IndyProtocols.cfg > nul
%NDC10%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror

REM ----- dclIndyProtocols -----
copy dclIndyProtocols.cfg1 dclIndyProtocols.cfg > nul
%NDC10%\bin\dcc32.exe /B dclIndyProtocols.dpk
if errorlevel 1 goto enderror

REM ----- keep generated outputs, delete the rest -----
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem100.res
attrib +r indycore100.res
attrib +r indyprotocols100.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem100.res
attrib -r indycore100.res
attrib -r indyprotocols100.res

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 10 Compiler Not Present!
goto endok

:endok
