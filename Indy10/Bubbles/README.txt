This file may not be completely up to date, but Ive updated it a bit.

Quick Start:

1) You need KBMMemTable, its free.

2) Install the bubelen package.

See URI for example.



Old below - may need revised:




Here's a short intro to the new boxster directory layout and test writing.

GlobalParams.dat
----------------

This file contains settings that are user specific but required for testing, but cannot be the same for all users. Things such as SMTP servers, etc... It needs to be created and reside in the project directory.

You need to edit this file and enter parameters by using the global params tab, or using notepad. The entries are a simple string list:

param=value

Here are the entries you need to define.

Added 2002.12.07:
dns server=

Added 2002.12.07:
dns domain=

Added 2002.12.07:
email address=

Added 2002.12.07:
ftp server=

Added 2002.12.07:
ftp username=

Added 2002.12.07:
ftp password=

Added 2002.12.07:
smtp server=

Added 2002.12.07:
ntp server=

Added 2002.12.07:
datadir=boxdata
Contains the name of the data subdir relative to project. BoxData is the norm and will match the VCS.

Added 2002.12.07:
tempdir=C:\temp\


Directories
-----------

boxtests -> .pas files for all the boxster tests,
            one for each test, should be named after the test.
boxdata  -> contains a directory for each boxster test
            that needs data files.
BoxsterLib -> base boxster test files. I added TestFramework form DUnit 5.0.2 here,
              to save everyone to download the whole DUnit package.

Playground -> See readme in this dir.
 
   Coders -> contains a project for the decoders. Can be used to emit
                     the files needed to verify message parsing.



Notes on writing boxster tests
------------------------------

Please descend all boxster tests from TIndyBox contained in IndyBox.pas.
If its easier for you, simply copy one of the more simple tests and start from there.

Your box test should be named T***Box, where *** is the name of
a) your box test class (doh)
b) the directory in the boxdata directory (please honour case for Linux!)
c) the box filename (***.pas)

This will ensure that you can call GetDataDir() and it will return the correct directory. Ideally, your boxster test shouldn't be writing to that directory, if it needs to save temporary files you should use GetTempDir. Both GetDataDir and GetTempDir are functions that your boxster test inherited from TIndyBox.

If you created a box test, and it works (*1), upload it to the correct directory. Then check out the boxster project file (IndyBoxster.dpr). Add your box test to the uses section (You can use a text editor!). Make sure you don't have absolute paths in there. If you use Delphi, double-check that the path is relative.
Then create a directory below boxdata (if necessary) and put any required files in there.
If you don't have write access to the Indy source, please send your boxster test with all required files in a zip (or similar) to someone who has.



(*1) Meaning that it compiles and runs as expected, it doesn't need to pass of course if you wrote it to demonstrate a problem!


History
-------

Johannes Berg (2002-08-13) <johannes@sipsolutions.de>

Ammended by Kudzu, 2002.12.07
