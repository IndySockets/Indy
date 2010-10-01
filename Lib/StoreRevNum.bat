@ECHO OFF

REM *************************************************************
REM * Batch-File to store the revision number in source files.  *
REM *                                                           *
REM * SubWCRev (located in tortoisesvn\bin) does the work:      *
REM *   Param1 is the Path to the working copy                  *
REM *   Param2 is the Template file                             *
REM *   Param3 is the name of the Output file                   *
REM *************************************************************

REM *** Enable Command Extensions in order to use "FOR /R" syntax.
REM *** Send invalid command to initialize ERRORLEVEL to non-zero.
REM *** Send output to nul to avoid screen echo.

VERIFY OTHER 2 > nul
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 0 GOTO DoIt

ECHO Command Extensions are not available!
EXIT /B 1
GOTO End

:DoIt
REM *** Set the Indy Lib path
SET IndyLib="C:\Development\Projects\Indy\Indy 10\Source\Lib"

REM *** Generate the files. Using "%%~dpnsI.tmpl" for the second
REM *** parameter of SubWCRev.exe because "%%~fsI" erroneously
REM *** produces "filename.tmplpl" instead of "filename.tmpl"
REM *** as expected!

IF (%2)==() GOTO UseIndyLib

ECHO Scanning for Update Templates in %2
FOR /R %2 %%I IN (*.tmpl) DO SubWCRev %IndyLib% %%~dpnsI.tmpl %%~dpnsI
GOTO Done

:UseIndyLib
ECHO Scanning for Update Templates in %IndyLib%
FOR /R %IndyLib% %%I IN (*.tmpl) DO SubWCRev %IndyLib% %%~dpnsI.tmpl %%~dpnsI

:Done
REM *** This Line re-compiles .res files from updated .rc files
ECHO Rebuilding .RES files
CALL %IndyLib%\buildres.bat

:End
