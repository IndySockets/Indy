@echo off

REM ****************************************************************************
REM  C++Builder 15 build for Indy (packages relocated; source resolves via ..\..\Source).
REM  Build runs in the Output\C15 temp dir so the dpk's ..\..\Source paths resolve.
REM ****************************************************************************

cd /d "%~dp0"
"%~dp0..\Computil.exe" SetupC15
if exist setenv.bat call setenv.bat
if exist setenv.bat del setenv.bat > nul

if (%NDC15%)==() goto enderror
if not exist %NDC15%\bin\dcc32.exe goto endnocompiler
if not exist ..\..\Output\C15\*.* md ..\..\Output\C15 >nul
if exist ..\..\Output\C15\*.* call "%~dp0..\Clean.bat" ..\..\Output\C15\

REM stage package + config + resource files into the temp build dir
copy *.dpk ..\..\Output\C15 > nul
copy *.cfg1 ..\..\Output\C15 > nul
copy *.cfg2 ..\..\Output\C15 > nul
copy *.res ..\..\Output\C15 > nul
copy ..\..\Source\Protocols\ZLib\*.obj ..\..\Output\C15 > nul
cd ..\..\Output\C15

REM ----- IndySystem -----
copy IndySystem.cfg1 IndySystem.cfg > nul
%NDC15%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror
del IndySystem.cfg > nul
copy IndySystem.cfg2 IndySystem.cfg > nul
%NDC15%\bin\dcc32.exe /B IndySystem.dpk
if errorlevel 1 goto enderror

REM ----- IndyCore -----
copy IndyCore.cfg1 IndyCore.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror
del IndyCore.cfg > nul
copy IndyCore.cfg2 IndyCore.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyCore.dpk
if errorlevel 1 goto enderror

REM ----- dclIndyCore -----
copy dclIndyCore.cfg1 dclIndyCore.cfg > nul
%NDC15%\bin\dcc32.exe /B dclIndyCore.dpk
if errorlevel 1 goto enderror

REM ----- IndyProtocols -----
copy IndyProtocols.cfg1 IndyProtocols.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror
del IndyProtocols.cfg > nul
copy IndyProtocols.cfg2 IndyProtocols.cfg > nul
%NDC15%\bin\dcc32.exe /B IndyProtocols.dpk
if errorlevel 1 goto enderror

REM ----- dclIndyProtocols -----
copy dclIndyProtocols.cfg1 dclIndyProtocols.cfg > nul
%NDC15%\bin\dcc32.exe /B dclIndyProtocols.dpk
if errorlevel 1 goto enderror

REM ----- keep generated outputs, delete the rest -----
attrib +r Id*.hpp
attrib +r *.bpl
attrib +r Indy*.bpi
attrib +r Indy*.lib
attrib +r indysystem150.res
attrib +r indycore150.res
attrib +r indyprotocols150.res
del /Q /A:-R *.* > nul
attrib -r Id*.hpp
attrib -r *.bpl
attrib -r Indy*.bpi
attrib -r Indy*.lib
attrib -r indysystem150.res
attrib -r indycore150.res
attrib -r indyprotocols150.res

REM ----- relocate finished artifacts up to the repo-root Output\C15 build folder -----
if not exist ..\..\..\Output\C15\*.* md ..\..\..\Output\C15 >nul
move /Y *.* ..\..\..\Output\C15\ >nul

goto endok

:enderror
echo Error!
pause
goto endok

:endnocompiler
echo C++Builder 15 Compiler Not Present!
goto endok

:endok
