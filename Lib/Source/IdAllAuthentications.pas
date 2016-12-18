unit IdAllAuthentications;

interface

{
Note that this unit is simply for listing ALL Authentications in Indy.
The user could then add this unit to a uses clause in their program and
have all Authentications linked into their program.

ABSOLUTELY NO CODE is permitted in this unit.

}

{$I IdCompilerDefines.inc}

// RLebeau 2/14/09: this forces C++Builder to link to this unit so
// the units can register themselves correctly at program startup...

{$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$HPPEMIT '#pragma link "IdAllAuthentications"'}
{$ENDIF}

implementation

uses
  {$IFNDEF DOTNET}
    {$IFDEF USE_OPENSSL}
  IdAuthenticationNTLM,
    {$ENDIF}
    {$IFDEF USE_SSPI}
  IdAuthenticationSSPI,
    {$ENDIF}
  {$ENDIF}
  IdAuthenticationDigest;

{dee-duh-de-duh, that's all folks.}

end.
