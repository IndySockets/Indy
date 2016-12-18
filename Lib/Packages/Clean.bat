@echo off
if exist %1*.dcu del %1*.dcu >nul
if exist %1*.dpl del %1*.dpl >nul
if exist %1*.bpl del %1*.bpl >nul
if exist %1*.bpi del %1*.bpi >nul
if exist %1*.lsp del %1*.lsp >nul
if exist %1*.dcp del %1*.dcp >nul
if exist %1*.dpc del %1*.dpc >nul
if exist %1*.bak del %1*.bak >nul
if exist %1Id*.obj del %1*.obj >nul
if exist %1Id*.hpp del %1*.hpp >nul
if exist %1*.lib del %1*.lib >nul
if exist %1*.dcuil del %1*.dcuil >nul
if exist %1*.dll del %1*.dll >nul
if exist %1*.dcpil del %1*.dcpil >nul
if exist %1*.dcuosx del %1.dcuosx > nul
if exist %1*.lst del %1*.lst > nul
if exist %1.ppu del %1.ppu > nul
if exist %1.o del %1.o > nul
if exist %1.rst del %1.rst > nul
if exist %1*.identcache del %1*.identcache >nul
if exist %1*.local del %1*.local >nul
if exist %1*.pdb del %1*.pdb >nul
if exist %1Id*.o del %1Id*.o >nul
if exist %1Id*.ppu del %1Id*.ppu >nul
if exist %1*.~*  del %1*.~* >nul
if exist %1setenv.bat del %1setenv.bat >nul
if exist %1lib rmdir /S /Q %1lib > nul
if exist %1Debug\Win32 rmdir /S /Q %1Debug\Win32 > nul
if exist %1Release\Win32 rmdir /S /Q %1Release\Win32 > nul
if exist %1Debug\Win64 rmdir /S /Q %1Debug\Win64 > nul
if exist %1Release\Win64 rmdir /S /Q %1Release\Win64 > nul
if exist %1Debug\OSX32 rmdir /S /Q %1Debug\OSX32 > nul
if exist %1Release\OSX32 rmdir /S /Q %1Release\OSX32 > nul
if exist %1Debug\iOS rmdir /S /Q %1Debug\iOS > nul
if exist %1Release\iOS rmdir /S /Q %1Release\iOS > nul
if exist %1Debug\Android rmdir /S /Q %1Debug\Android > nul
if exist %1Release\Android rmdir /S /Q %1Release\Android > nul
