unit IdAllHeaderCoders;

interface

{$i IdCompilerDefines.inc}

{
Note that this unit is simply for listing ALL Header coders in Indy.
The user could then add this unit to a uses clause in their program and
have all Header coders linked into their program.

ABSOLUTELY NO CODE is permitted in this unit.

}

// RLebeau 2/14/09: this forces C++Builder to link to this unit so
// the units can register themselves correctly at program startup...
(*$HPPEMIT '#pragma link "IdAllHeaderCoders"'*)

implementation

uses
  IdHeaderCoderPlain,
  IdHeaderCoder2022JP,
  {$IFNDEF DOTNET}
  IdHeaderCoderUTF,
  {$ENDIF}
  IdHeaderCoderIndy;

{dee-duh-de-duh, that's all folks.}

end.
