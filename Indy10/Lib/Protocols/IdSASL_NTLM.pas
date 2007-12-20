unit IdSASL_NTLM;

interface
uses
  IdSASL,
  IdSASLUserPass;
  
type
  TIdSASLNTLM = class(TIdSASLUserPass)
  public
    class function ServiceName: TIdSASLServiceName; override;
    function StartAuthenticate(const AChallenge, AHost, AProtocolName:string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName: String): string; override;
  end;

implementation
uses IdNTLM;

procedure GetDomain(const AUserName : String; var VUserName, VDomain : String);
{$IFDEF USEINLINE} inline; {$ENDIF}
var i : Integer;
begin
   i := Pos('\', AUsername);
   if i > -1 then
   begin
     VDomain := Copy(AUsername, 1, i - 1);
     VUserName := Copy(AUsername, i + 1, Length(AUserName));
   end
   else
   begin
     VDomain := ' ';         {do not localize}
     VUserName := AUserName;
   end;
end;

{ TIdSASLNTLM }

function TIdSASLNTLM.ContinueAuthenticate(const ALastResponse, AHost,
  AProtocolName: String): string;
var
  LType2: type_2_message_header;
  s : String;
  LDomain, LUserName : String;
begin
  s := ALastResponse;
  Move(S[1], Ltype2, SizeOf(Ltype2));
  Delete(S, 1, SizeOf(Ltype2));
  GetDomain(GetUsername,LDomain,LUsername);
//  S := LType2.Nonce;
  Result := 'NTLM ' + BuildType3Message(LDomain, AHost,LUserName, GetPassword, LType2.Nonce);
//  Result := 'NTLM ' + S;    {do not localize}
end;

class function TIdSASLNTLM.ServiceName: TIdSASLServiceName;
begin
  Result := 'NTLM';   {Do not localize}
end;

function TIdSASLNTLM.StartAuthenticate(const AChallenge, AHost,
  AProtocolName: string): String;
var LDomain,LUsername : String;
begin
  GetDomain(GetUsername,LDomain,LUsername);
  Result := BuildType1Message(LDomain,AHost);
end;

end.
