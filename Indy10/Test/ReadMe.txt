UnitTests for Indy

---------------------------------
Priorities:

1) Keep It Simple

2) Do not couple to any specific unit test framework.
   - use appropriate IdTest.pas units to plug into required framework.

Units are named IdTest*, so they can be easily searched/listed.
eg using UnitExpert (http://www.epocalipse.com/downloads.htm) ctrl-u, "idtest", lists all available test units.

---------------------------------
Guidelines for writing unit tests:

1) Assert() should not contain function calls. turning off assertions in compile options should not alter the functionality.

  bad:
  Assert(ReadLn='');

  good:
  aStr=ReadLn;
  ASsert(aStr='');

2) test procedures should be have 'published' visibility (so win32 RTTI can be used to enumerate them) and be named starting with 'Test'.

  public
    //bad, won't be called
    procedure WriteTest; 
  published
    //good
    procedure TestRead;

3) additional debug code should not be left in for 'release'. 
   (by default) data should not be written to the test pc, eg log files.

---------------------------------
ToDo:

add another layer to the component heirachy that defines the interface, eg virtual methods etc.
add Setup/TearDown virtuals.
add a mechanism for recording additional debug output.
add a mechanism for supplying tests with configuration settings, eg address/user/password for a live email server to test against. suggest just a name=value stringlist and a DoConfig(TStringList);virtual method.
