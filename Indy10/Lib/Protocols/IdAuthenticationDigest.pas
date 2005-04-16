{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13736: IdAuthenticationDigest.pas 
{
{   Rev 1.6    1/3/05 4:48:24 PM  RLebeau
{ Removed reference to StrUtils unit, not being used.
}
{
{   Rev 1.5    12/1/2004 1:57:50 PM  JPMugaas
{ Updated with some code posted by:
{ 
{ Interpulse Systeemontwikkeling
{ Interpulse Automatisering B.V.
{ http://www.interpulse.nl
}
{
{   Rev 1.1    2004.11.25 06:17:00 PM  EDMeester 
}
{
{   Rev 1.0    2002.11.12 10:30:44 PM  czhower
}

{
  Implementation of the digest authentication as specified in
  RFC2617

  rev 1.1: Edwin Meester (systeemontwikkeling@interpulse.nl)
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

}

unit IdAuthenticationDigest;

interface

Uses
  Classes,
  SysUtils,
  IdException,
  IdGlobal,
  
  IdAuthentication,
  IdHashMessageDigest,
  IdHeaderList,
  IdTStrings;

Type
  EIdInvalidAlgorithm = class(EIdException);

  TIdDigestAuthentication = class(TIDAuthentication)
  protected
    FRealm: String;
    FStale: Boolean;
    FOpaque: String;
    FDomain: TIdStringList;
    Fnonce: String;
    FNoncecount: integer;
    FAlgorithm: String;
    FMethod, FUri: string; //needed for digest, Somebody make this nice :D
    FPostbody: TIdStringList; //needed voor auth-int, Somebody make this nice :D
    FQopOptions: TIdStringList;
    FOther: TIdStringList;
    function DoNext: TIdAuthWhatsNext; override;
  public
    destructor Destroy; override;
    function Authentication: String; override;
    property Method: String read FMethod write FMethod;
    property Uri: String read FUri write FUri;
    property Postbody: TIdStringList read FPostbody write FPostbody;
  end;

implementation

uses
  IdHash, IdResourceStrings, IdResourceStringsProtocols;

{ TIdDigestAuthentication }

destructor TIdDigestAuthentication.Destroy;
begin
  if Assigned(FDomain) then
  begin
    FreeAndNil( FDomain );
  end;
  if Assigned(FQopOptions) then
  begin
    FreeAndNil(FQopOptions);
  end;
  inherited Destroy;
end;

function TIdDigestAuthentication.Authentication: String;

  function ResultString(s: String): String;
  Var
    MDValue: T4x4LongWordRecord;
    LHash : TIdBytes;
    i: Integer;
    S1: String;
  begin
    with TIdHashMessageDigest5.Create do begin
      MDValue := HashValue(S);
      Free;
    end;
    LHash := ToBytes(MDValue[0]);
    AppendBytes(LHash,ToBytes(MDValue[1]));
    AppendBytes(LHash,ToBytes(MDValue[2]));
    AppendBytes(LHash,ToBytes(MDValue[3]));
    for i := 0 to 15 do begin
      S1 := S1 + Format('%02x', [LHash[i]]);
    end;
    while Pos(' ', S1) > 0 do 
    begin
      S1[Pos(' ', S1)] := '0';
    end;
    result := IndyLowerCase(S1); //Stupid uppercase, cost me a whole day to figure this one out
  end;

var LstrA1, LstrA2, LstrCNonce, LstrResponse: string;

begin
  result := '';    {do not localize}
  case FCurrentStep of
    0:
      begin
        result := 'Digest'; //Just be save with this one
      end;
    1:
      begin
        //Build request

        LstrCNonce := ResultString(DateTimeToStr(Now));

        LstrA1 := ResultString(Username + ':' + FRealm + ':' + Password);
        if TextIsSame(FAlgorithm, 'MD5-sess') then
        begin
          LstrA1 := ResultString(LstrA1 + ':' + Fnonce + ':' + LstrCNonce);
        end;
        if FQopOptions.IndexOf('auth-int') > -1 then
        begin
          LstrA2 := ResultString(FMethod + ':' + FUri + ':' + ResultString(FPostbody.CommaText))
        end
        else
        begin
          LstrA2 := ResultString(FMethod + ':' + FUri);
        end;
        LstrResponse := LstrA1 + ':' + Fnonce + ':';
        if (FQopOptions.IndexOf('auth-int') > -1) or (FQopOptions.IndexOf('auth') > -1) then //Qop header present
        begin
          LstrResponse := LstrResponse + IntToHex(FNoncecount, 8) + ':' + LstrCNonce + ':';
          if FQopOptions.IndexOf('auth-int') > -1 then
          begin
            LstrResponse := LstrResponse + 'auth-int:';
          end
          else
          begin
            LstrResponse := LstrResponse + 'auth:';
          end;
        end;
        LstrResponse := LstrResponse + LstrA2;
        LstrResponse := ResultString(LStrResponse);

        result := result + 'Digest ' + {do not localize}
          'username="' + Username + '", ' + {do not localize}
          'realm="' + FRealm + '", ' +  {do not localize}
          'nonce="' + FNonce + '", ' + {do not localize}
          'algorithm="' + FAlgorithm + '", ' + {do not localize}
          'uri="' + Furi + '", ';
        if (FQopOptions.IndexOf('auth-int') > -1) or (FQopOptions.IndexOf('auth') > -1) then //Qop header present
        begin
          if FQopOptions.IndexOf('auth-int') > -1 then
          begin
            result := result + 'qop="auth-int", '
          end
          else
          begin
            result := result + 'qop="auth", ';
          end;
          result := result + 'nc=' + IntToHex(FNoncecount, 8) + ', ' +
            'cnonce="' + LstrCNonce + '", ';
        end;
        result := result + 'response="' + LstrResponse + '", ' +
          'opaque="' + FOpaque + '"';
        Inc(FNoncecount);
        FCurrentStep := 0;
      end;
  end;
end;

function TIdDigestAuthentication.DoNext: TIdAuthWhatsNext;
var S, LstrTempNonce: String;
    LParams: TIdStringList;
begin
  result := wnDoRequest;

  case FCurrentStep of
    0:
      begin
        //gather info
        if not Assigned(FDomain) then begin
          FDomain := TIdStringList.Create;
        end
        else
        begin
          FDomain.Clear;
        end;
        if not Assigned(FQopOptions) then begin
          FQopOptions := TIdStringList.Create;
        end
        else
        begin
          FQopOptions.Clear;
        end;
        S := ReadAuthInfo('Digest');

        Fetch(S);

        LParams := TIdStringList.Create;

        while Length(S) > 0 do begin
          Params.Add(Fetch(S, ', '));
        end;

        FRealm := Copy(LParams.Values['realm'], 2, Length(Params.Values['realm']) - 2);
        LStrTempnonce := Copy(LParams.Values['nonce'], 2, Length(Params.Values['nonce']) - 2);
        if not (FNonce = LstrTempNonce) then
        begin
          FnonceCount := 1;
          FNonce := LstrTempNonce;
        end;
        S := Copy(LParams.Values['domain'], 2, Length(LParams.Values['domain']) - 2);
        while Length(S) > 0 do
        begin
          FDomain.Add(Fetch(S));
        end;
        Fopaque := Copy(LParams.Values['opaque'], 2, Length(LParams.Values['opaque']) - 2);
        FStale := (Copy(LParams.Values['stale'], 2, Length(LParams.Values['stale']) - 2) = 'true');
        FAlgorithm := Copy(LParams.Values['algorithm'], 2, Length(LParams.Values['algorithm']) - 2);
        FQopOptions.CommaText := Copy(Params.Values['qop'], 2, Length(LParams.Values['qop']) - 2);

        if not TextIsSame(FAlgorithm, 'MD5') then begin
          raise EIdInvalidAlgorithm.Create(RSHTTPAuthInvalidHash);
        end;

        Params.Free;

        FCurrentStep := 1;

        if (Length(Username) > 0) then
        begin
          result := wnDoRequest;
        end
        else begin
          result := wnAskTheProgram;
        end;
      end;
  end;
end;

initialization
  RegisterAuthenticationMethod('Digest', TIdDigestAuthentication);
end.

