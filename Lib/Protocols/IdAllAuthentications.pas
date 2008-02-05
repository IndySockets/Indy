unit IdAllAuthentications;

interface

{$i IdCompilerDefines.inc}

{
Note that this unit is simply for listing ALL Authentications in Indy.
The user could then add this unit to a uses clause in their program and
have all Authentications linked into their program.

ABSOLUTELY NO CODE is permitted in this unit.

}

implementation
{$i IdCompilerDefines.inc}
uses
  {$IFNDEF DOTNET}
    {$IFNDEF WINCE}
  IdAuthenticationNTLM,
    {$ENDIF}
  {$ENDIF}
  IdAuthenticationDigest;

{dee-duh-de-duh, that's all folks.}

end.
