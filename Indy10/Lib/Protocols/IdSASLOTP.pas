{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14510: IdSASLOTP.pas
{
{   Rev 1.4    2004.02.03 5:45:12 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/21/2004 4:03:16 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.2    10/19/2003 5:57:18 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    5/10/2003 10:10:44 PM  JPMugaas
{ Bug fixes.
}
{
{   Rev 1.0    12/16/2002 03:27:22 AM  JPMugaas
{ Initial version of IdSASLOTP.  This is the OTP (One-Time-only password) SASL
{ mechanism.
}
{This is based on RFC2444}

unit IdSASLOTP;

interface
uses
  IdException,
  IdSASL,
  IdSASLUserPass;

type
  TIdSASLOTP = class(TIdSASLUserPass)
  protected
    function GenerateOTP(const AResponse:string; const APassword:string):string;
    procedure InitComponent; override;
  public
    class function ServiceName: TIdSASLServiceName; override;

    function StartAuthenticate(const AChallenge:string) : String; override;
    function ContinueAuthenticate(const ALastResponse: String): String;
      override;

  end;

  EIdOTPSASLException = class(EIdException);
  EIdOTPSASLUnknownOTPMethodException = class(EIdOTPSASLException);

implementation

uses
  IdBaseComponent, IdGlobal, IdOTPCalculator,  IdSys, IdUserPassProvider;

{ TIdSASLOTP }

function TIdSASLOTP.ContinueAuthenticate(
  const ALastResponse: String): String;
begin
  Result := GenerateOTP(ALastResponse, GetPassword);
end;

procedure TIdSASLOTP.InitComponent;
begin
  inherited;
  FSecurityLevel := 1000;
end;

class function TIdSASLOTP.ServiceName: TIdSASLServiceName;
begin
  Result := 'OTP'; {Do not translate}
end;

function TIdSASLOTP.StartAuthenticate(const AChallenge: string): String;
begin
  Result := GetUsername;
end;

function TIdSASLOTP.GenerateOTP(const AResponse:string; const APassword:string):string;
var LChallenge:string;
    LChallengeStartPos:integer;
    LMethod:string;
    LSeed:string;
    LCount:integer;
begin
  LChallengeStartPos:=pos('otp-', AResponse); {do not localize}
  if LChallengeStartPos>0 then begin
    inc(LChallengeStartPos, 4); // to remove "otp-"
    LChallenge:=copy(AResponse, LChallengeStartPos, $FFFF);
    LMethod:=Fetch(LChallenge);
    LCount:=Sys.StrToInt(Fetch(LChallenge));
    LSeed:=Fetch(LChallenge);
    if LMethod='md5' then {do not localize} // methods are case sensitive
    begin
      Result := 'word:' + TIdOTPCalculator.ToSixWordFormat(TIdOTPCalculator.GenerateKeyMD5(lseed, APassword, LCount)) {do not localize}
    end
    else
    begin
      if LMethod = 'md4' then {do not localize}
      begin
        Result := 'word:' + TIdOTPCalculator.ToSixWordFormat(TIdOTPCalculator.GenerateKeyMD4(lseed, APassword, LCount)) {do not localize}
      end
      else
      begin
        if LMethod = 'sha1' then  {do not localize}
        begin
           Result := 'word:' + TIdOTPCalculator.ToSixWordFormat(TIdOTPCalculator.GenerateKeySHA1(lseed, APassword, LCount)) {do not localize}
        end
        else
        begin
          raise EIdOTPSASLUnknownOTPMethodException.Create('Unknown OTP method'); //rs  {do not localize}
        end;
      end;
    end;
  end;
end;

end.
