@ECHO OFF

REM *************************************************************
REM * Batch-File to store the revision number in source files.  *
REM * Called by Post-Commit and Post-Update hook scripts.       *
REM *                                                           *
REM * SubWCRev (located in tortoisesvn\bin) does the work:      *
REM *   Param1 is the Path to the working copy                  *
REM *   Param2 is the Template file                             *
REM *   Param3 is the name of the Output file                   *
REM *************************************************************

IF (%1)==(start) GOTO DoIt
IF NOT (%6)==() GOTO PostCommit
IF NOT (%5)==() GOTO PostUpdate

ECHO Invalid arguments
EXIT /B 1
GOTO End

:PostCommit
ECHO Post Commit Hook Called
CALL %0 start %6
GOTO End

:PostUpdate
ECHO Post Update Hook Called
CALL %0 start %5
GOTO End

:DoIt
SET IndyLib="C:\Development\Projects\Indy\Indy 10\Source\Lib"
CALL %IndyLib%\StoreRevNum.bat %2

:End
