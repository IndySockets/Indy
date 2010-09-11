echo off
set OLDPATH=%PATH%
rem path c:\Progra~1\Borland\BDS\3.0\bin
path C:\Borland\BCC55\bin
echo %PATH%
rem c:\Progra~1\Borland\BDS\3.0\bin
make -f zlibd32.mak
path %OLDPATH%
copy *.obj ..