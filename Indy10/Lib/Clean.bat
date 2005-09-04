@echo off
if exist %1*.dcu del %1*.dcu
if exist %1*.dpl del %1*.dpl
if exist %1*.bpl del %1*.bpl
if exist %1*.bpi del %1*.bpi
if exist %1*.lsp del %1*.lsp
if exist %1*.dcp del %1*.dcp
if exist %1*.dpc del %1*.dpc
if exist %1*.bak del %1*.bak
if exist %1Id*.obj del %1*.obj
if exist %1Id*.hpp del %1*.hpp
if exist %1*.lib del %1*.lib
if exist %1*.~*  del %1*.~*
if exist %1setenv.bat del %1setenv.bat

