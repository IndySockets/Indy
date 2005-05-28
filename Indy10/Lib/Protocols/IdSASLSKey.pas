{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18890: IdSASLSKey.pas
{
{   Rev 1.4    2004.02.03 5:45:42 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/25/2004 2:17:54 PM  JPMugaas
{ Should work better.  Removed one GPF in S/Key.
}
{
{   Rev 1.2    1/21/2004 4:03:18 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.1    10/19/2003 5:57:20 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.0    5/10/2003 10:08:14 PM  JPMugaas
{ SKEY SASL mechanism as defined in RFC 2222.  Note that this is obsolete and
{ you should use RFC 2444 for new designs.  This is only provided for backwards
{ compatibility.
}
unit IdSASLSKey;

interface
uses IdSASLUserPass, IdSASL;
{
S/KEY SASL mechanism based on RFC 2222.

NOte that this is depreciated and S/Key is a trademark of BelCore.  This unit
is only provided for backwards compatiability with some older systems.

New designs should use IdSASLOTP (RFC 2444) which is more flexible and uses a better hash
(MD5 and SHA1).
}
type
  TIdSASLSKey = class(TIdSASLUserPass)
  protected
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;

    function StartAuthenticate(const AChallenge:string) : String; override;
    function ContinueAuthenticate(const ALastResponse: String): String;
      override;
  end;

implementation

uses
  IdBaseComponent, IdGlobal, IdOTPCalculator,  IdUserPassProvider, IdSys;

const SKEYSERVICENAME = 'SKEY'; {do not localize}

{ TIdSASLSKey }

function TIdSASLSKey.ContinueAuthenticate(
  const ALastResponse: String): String;
var LBuf, LSeed : String;
  LCount : Cardinal;
begin
  LBuf := Sys.Trim(ALastResponse);
  LCount := Sys.StrToInt(Fetch(LBuf),0);
  LSeed := Fetch(LBuf);
  Result := TIdOTPCalculator.ToSixWordFormat(TIdOTPCalculator.GenerateKeyMD4(lseed, GetPassword, LCount));
end;

procedure TIdSASLSKey.InitComponent;
begin
  inherited;
  //less than 1000 because MD4 is broken and this is depreciated
  FSecurityLevel := 900;
end;

class function TIdSASLSKey.ServiceName: TIdSASLServiceName;
begin
  Result := SKEYSERVICENAME;
end;

function TIdSASLSKey.StartAuthenticate(const AChallenge: string): String;
begin
  Result := GetUsername;
end;

end.

