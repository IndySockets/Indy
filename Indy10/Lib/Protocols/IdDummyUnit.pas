{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13812: IdDummyUnit.pas 
{
{   Rev 1.14    9/18/2003 10:44:00 AM  JPMugaas
{ Moved IdThread to Core.
}
{
{   Rev 1.0    7/24/2003 12:13:58 PM  JPMugaas
{ Test compile template and the IdDummyUnit template for managing run-time
{ units we put into the design-time package and force to be statically linked
{ into the program.
}
unit IdDummyUnit;
{

This unit is really not a part of Indy.  This unit's purpose is to trick the DCC32
compiler into generating .HPP and .OBJ files for run-time units that will not be
in the run-time package but will be on the palette.

Contributed by John Doe

}

interface
uses
    IdAntiFreeze;


implementation

{de-de-de-de, that's all folks.}

end.
