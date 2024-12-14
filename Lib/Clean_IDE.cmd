@echo off
REM DO NOT RUN THIS BATCH SCRIPT DIRECTLY!
REM This is called from the CleanDXX.cmd scripts and expects certain variables to be present
if not defined DelphiProd goto END
if not defined logfn goto END
if not defined BDS goto END

echo =====================================================================================
echo WARNING! This batch file deletes files from your Delphi installation using wildcards.
echo You should read and understand this batch file before running it.
echo =====================================================================================
echo This will remove the default Indy libraries that come with %DelphiProd%
echo from the "bin" and "lib" folders in the Delphi installation and must be run as 
echo Administrator. A log file of the files deleted will be created.
echo =====================================================================================
echo NOTE 1: If Delphi is currently open, some of the files may not be able to be deleted.
echo NOTE 2: Once Delphi is re-started, you may see errors loading some of the libraries; 
echo this is to be expected until Indy is re-installed.
echo =====================================================================================
pause

echo Removing Indy files from %DelphiProd%... > %logfn%

echo Cleaning default Indy from %DelphiProd%

echo Removing Windows 32-bit files

set BDSworkdir=%BDS%\bin
for %%a in ("%BDSworkdir%\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\dclIndy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\dclIndy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\win32\debug
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\win32\release
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Windows 64-bit files (Legacy)

set BDSworkdir=%BDS%\bin64
for %%a in ("%BDSworkdir%\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\win64\debug
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\win64\release
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Windows 64-bit files (Modern)

set BDSworkdir=%BDS%\lib\win64x\debug
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\win64x\release
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.dcu" (
    ren "%BDSworkdir%\%%a.dcu" "%%a.bak"
    if exist "%BDSworkdir%\%%a.dcu" echo Cannot backup "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in (idoc,idispids) do (
  if exist "%BDSworkdir%\%%a.bak" (
    ren "%BDSworkdir%\%%a.bak" "%%a.dcu"
    if exist "%BDSworkdir%\%%a.bak" echo Cannot restore "%BDSworkdir%\%%a.dcu"!
  )
)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Linux 64-bit files

set BDSworkdir=%BDS%\binlinux64
for %%a in ("%BDSworkdir%\bplIndy*.so") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\linux64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\linux64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing MacOS 64-bit files

set BDSworkdir=%BDS%\binosx64
for %%a in ("%BDSworkdir%\bplIndy*.dylib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\osx64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\osx64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\osxarm64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\osxarm64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing iOS Device 64-bit files

set BDSworkdir=%BDS%\lib\iosDevice64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\iosDevice64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing iOS Simulator 64-bit files

set BDSworkdir=%BDS%\lib\iossimarm64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\iossimarm64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Android 32-bit files

set BDSworkdir=%BDS%\lib\android\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\android\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Android 64-bit files

set BDSworkdir=%BDS%\lib\android64\debug
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=%BDS%\lib\android64\release
for %%a in ("%BDSworkdir%\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDSworkdir%\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

set BDSworkdir=

echo All done! The list of deleted files is in "%logfn%"

:END