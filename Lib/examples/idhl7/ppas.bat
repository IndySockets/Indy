@echo off
SET THEFILE=C:\Dev\Github\Indy\Indy\Lib\examples\idhl7\hl7_usage_sample.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\Dev\Github\Indy\Indy\Lib\examples\idhl7\hl7_usage_sample.exe C:\Dev\Github\Indy\Indy\Lib\examples\idhl7\link6224.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
