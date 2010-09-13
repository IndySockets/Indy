echo off
set OLDPATH=%PATH%
path C:\Borland\BCC55\bin
make -f zlibd32.mak %1 %2 %3
path %OLDPATH%
copy *.obj ..