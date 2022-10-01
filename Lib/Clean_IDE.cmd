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
for %%a in ("%BDS%\bin\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\bin\Indy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\bin\dclIndy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\bin\dclIndy*.jdbg") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\debug\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.lib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Vcl.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win32\release\Fmx.Id*.obj") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Windows 64-bit files
for %%a in ("%BDS%\bin64\Indy*.bpl") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Id*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.res") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.a") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Vcl.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Vcl.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\win64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Linux 64-bit files
for %%a in ("%BDS%\binlinux64\bplIndy*.so") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\linux64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing MacOS 64-bit files
for %%a in ("%BDS%\binosx64\bplIndy*.dylib") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osx64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Indy*.bpi") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\osxarm64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing iOS 64-bit files
for %%a in ("%BDS%\lib\iosDevice64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\iosDevice64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Android 32-bit files
for %%a in ("%BDS%\lib\android\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo Removing Android 64-bit files
for %%a in ("%BDS%\lib\android64\debug\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\debug\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Fmx.Id*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Fmx.Id*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Indy*.dcu") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Indy*.dcp") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)
for %%a in ("%BDS%\lib\android64\release\Indy*.o") do (del "%%a") && (if not exist "%%a" echo Deleted "%%a" >> %logfn%)

echo All done! The list of deleted files is in %logfn%

:END