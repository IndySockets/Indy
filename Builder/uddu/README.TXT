DOS2UNIX/UNIX2DOS - Win32 utilities to convert single files from 
		    MS-DOS to Unix format or Unix to MS-DOS format.

Introduction
------------

MS-DOS and Unix systems use different methods to identify end-of-line
information in text files. MS-DOS, including Windows 9x/ME/NT/2000, use a
carriage return/linefeed pair (CR/LF), whilst Unix only uses the LF
character.

DOS2UNIX.EXE and UNIX2DOS.EXE are small Win32 console-mode file conversion
utilities. DOS2UNIX.EXE converts MS-DOS text files to Unix format, by 
stripping any CR or end-of-file (Ctrl-Z) characters from the data. 
UNIX2DOS.EXE inserts a CR character when it encounters an LF character, 
converting the data to MS-DOS format.

The source code for these utilities was obtained via the Internet. The 
original author of the code is unknown. The utilities have been converted to
run on Win32 systems, using Microsoft Visual C/C++ v6.0. The code has been 
modified so that it compiles cleanly and executes as expected. A small amount 
of additional code has been added to aid failure reporting when the utilities 
are used in batch scripts and a small bug in the UNIX2DOS code was fixed in
August 2000. In all other respects the source code is unchanged from its 
original release date, sometime during 1989.


Usage
-----

The programs have been written primarily for use within Windows 9x/ME/NT/2000 
console window sessions (ie: COMMAND.COM/CMD.EXE), but may also be used 
within batch scripts (BAT/CMD files, Perl scripts etc.). 


DOS2UNIX.EXE
------------

To convert a file from MS-DOS to Unix format, DOS2UNIX.EXE is executed using
the syntax:

DOS2UNIX <file to be converted>

for example:

DOS2UNIX dosdata.txt


UNIX2DOS.EXE
------------

To convert a file from Unix to MS-DOS format, UNIX2DOS.EXE is executed using
the syntax:

UNIX2DOS <file to be converted>

for example:

UNIX2DOS unixdata.txt


Messages
--------

During execution, the programs may display any of the following messages.

---> Processing file <file being converted> ...

This message indicates normal progress.

---> Can't stat <file to be converted>.

This message indicates that the file to be converted cannot be found. Check
that the name of the file, including any path/relative path information is
correct, then try again.

---> Problems processing file <file to be converted>.

A problem was encountered during the file conversion process. The resultant
data should be considered suspect.

---> Problems renaming <temporary file> to <file being converted>.
     However, file <temporary file> remains.

During the conversion process, a temporary work file is created containing 
the converted data. The above message indicates that there was a problem 
renaming the temporary file at the end of the conversion process so that it 
has the name of the original file being converted. The converted data should 
however exist in the temporary file left behind at the end of the failed 
conversion.


Points to note
--------------

1) If a file conversion failure occurs, both utilities will return an 
errorlevel of one, allowing the results of the conversion process to be 
examined within a standard Windows 9x/ME/NT/2000 batch script.

2) The programs are not coded to deal with Windows NT/2000 file system 
permissions. Unpredictable results may occur if insufficent permissions exist 
for the utilities to read/write data as required.

3) The programs are intended to process text data files only. Unpredictable 
results will occur if other, non-text, file types are specified for 
conversion.

4) As the utilities preserve the original file name of the converted file, 
the input file is effectively destroyed. It is essential therefore to backup 
any data files to be processed before starting any conversion, in case a 
problem occurs which leaves the original data in an unusable state.


Known problems
--------------

Problems may be experienced when attempting to convert text files 2GB or 
greater in size. The author has received one report of such an issue with 
DOS2UNIX.EXE.


Testing
-------

The programs have been tested on Windows NT 3.51 with service pack #5 
applied, Windows NT4.0 with various service packs applied, Windows 2000 and 
Windows 95 OSR2. The programs should also execute on Windows 98/98SE, but 
this has not been verified.


License/disclaimers
-------------------

See file LICENSE.TXT for further information. All registered trade marks etc. 
are acknowledged.


Author's contact details
------------------------

Clem Dye
clem@bastet.com
