unit IdSASL_NTLM;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdSASL,
  IdSASLUserPass;

const
  DEF_LMCompatibility = 0;

type
  TIdSASLNTLM = class(TIdSASLUserPass)
  protected
    FDomain : String;
    FLMCompatibility : UInt32;
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;
    function TryStartAuthenticate(const AHost, AProtocolName: string; var VInitialResponse: string): Boolean; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName:string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName: String): string; override;
    function IsReadyToStart: Boolean; override;

    property Domain : String read FDomain write FDomain;
{
The LMCompatibility property is designed to work directly with the "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\LMCompatibilityLevel"
and will act as this key is documented.  This effects how NTLM authentication
is done on the server.  We do not pull the value from the registry because other systems
don't have a registry and you may want to set this to a value that's different from
your registry.

http://davenport.sourceforge.net/ntlm.html describes these like this:

=======================================================================
Level        |	Sent by Client               |	Accepted by Server
=======================================================================
0            | LM NTLM                       | LM NTLM /LMv2 NTLMv2
1            | LM NTLM                       | LM NTLM /LMv2 NTLMv2
2            | NTLM (is sent in both feilds) | LM NTLM /LMv2 NTLMv2
3            | LMv2 NTLMv2                   | LM NTLM /LMv2 NTLMv2
4            | LMv2 NTLMv2                   | NTLM /LMv2 NTLMv2
5            | LMv2 NTLMv2                   | LMv2 NTLMv2

}
    property LMCompatibility : UInt32 read FLMCompatibility write FLMCompatibility default DEF_LMCompatibility;
  end;

implementation

uses
  IdFIPS, IdNTLMv2;
  
//uses IdNTLM;

{ TIdSASLNTLM }

function TIdSASLNTLM.ContinueAuthenticate(const ALastResponse, AHost,
  AProtocolName: String): string;
var
  LMsg : TIdBytes;
  LNonce : TIdBytes; //this is also called the challange
  LTargetName, LTargetInfo : TIdBytes;
  LFlags : UInt32;
  LDomain, LUserName : String;
  LEncoding: IIdTextEncoding;
begin
  LEncoding := IndyTextEncoding_8Bit;
  LMsg := ToBytes(ALastResponse, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  IdNTLMv2.ReadType2Msg(LMsg, LFlags, LTargetName, LTargetInfo, LNonce);
  IdGlobal.DebugOutput('Type 2 Flags = '+ DumpFlags(LFlags));
  GetDomain(GetUsername, LUsername, LDomain);
  Result := BytesToStringRaw( BuildType3Msg(LDomain, LDomain, GetUsername, GetPassword,
    LFlags, LNonce, LTargetName, LTargetInfo, FLMCompatibility) );
end;

procedure TIdSASLNTLM.InitComponent;
begin
  inherited InitComponent;
  Self.FLMCompatibility := DEF_LMCompatibility;
end;

function TIdSASLNTLM.IsReadyToStart: Boolean;
begin
  Result := (not GetFIPSMode) and (inherited IsReadyToStart) and
     NTLMFunctionsLoaded;
end;

class function TIdSASLNTLM.ServiceName: TIdSASLServiceName;
begin
  Result := 'NTLM';   {Do not localize}
end;

function TIdSASLNTLM.TryStartAuthenticate(const AHost, AProtocolName: string;
  var VInitialResponse: string): Boolean;
var
  LDomain, LUsername : String;
begin
  GetDomain(GetUsername, LUsername, LDomain);
  if LDomain = '' then begin
    LDomain := FDomain;
  end;
  VInitialResponse := BytesToStringRaw(IdNTLMv2.BuildType1Msg(LDomain, LDomain, FLMCompatibility));
  Result := True;
end;

function TIdSASLNTLM.StartAuthenticate(const AChallenge, AHost, AProtocolName: string): String;
begin
  TryStartAuthenticate(AHost, AProtocolName, Result);
end;

end.
