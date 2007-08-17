unit IdAllHeaderCoders;

interface

{$i IdCompilerDefines.inc}

{
Note that is unit is simply for listing ALL Header coders in Indy.
The user could then add this unit to a uses clause in their program and
have all Header coders linked into their program.

ABSOLUTELY NO CODE is permitted in this unit.

}

uses
  IdHeaderCoderPlain,
  IdHeaderCoder2022JP,
  {$IFDEF DOTNET}IdHeaderCoderDotNet,{$ENDIF}
  IdHeaderCoderUTF8;

implementation

{dee-duh-de-duh, that's all folks.}

end.
