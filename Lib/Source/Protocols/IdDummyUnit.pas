{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$


    Rev 1.14    9/18/2003 10:44:00 AM  JPMugaas
  Moved IdThread to Core.


    Rev 1.0    7/24/2003 12:13:58 PM  JPMugaas
  Test compile template and the IdDummyUnit template for managing run-time
  units we put into the design-time package and force to be statically linked
  into the program.
}

unit IdDummyUnit;
{

  This unit is really not a part of Indy.  This unit's purpose is to trick the DCC32
compiler into generating .HPP and .OBJ files for run-time units that will not be
in the run-time package but will be on the palette.

Contributed by John Doe

}

interface
{$i IdCompilerDefines.inc}
uses
    IdAntiFreeze;

implementation

{ de-de-de-de, that's all folks. }

end.
