UnitTests for Indy

Priorities:

1) Keep It Simple

2) Do not couple to any specific unit test framework.
   - use appropriate IdTest.pas units to plug into specific framework.

Units are named IdTest*, so they can be easily searched/listed.
eg using UnitExpert (http://www.epocalipse.com/downloads.htm) ctrl-u, "idtest", lists all available test units.

ToDo:
probably add Setup/TearDown virtuals.
possibly add another layer to the component heirachy that defines the interface, eg virtual methods etc.