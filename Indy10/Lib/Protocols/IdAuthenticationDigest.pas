{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  2005-04-22 BTaylor
  Fixed AV from incorrect object being freed
  Fixed memory leak
  Improved parsing

  Rev 1.6    1/3/05 4:48:24 PM  RLebeau
  Removed reference to StrUtils unit, not being used.

  Rev 1.5    12/1/2004 1:57:50 PM  JPMugaas
  Updated with some code posted by:

  Interpulse Systeemontwikkeling
  Interpulse Automatisering B.V.
  http://www.interpulse.nl

  Rev 1.1    2004.11.25 06:17:00 PM  EDMeester

  Rev 1.0    2002.11.12 10:30:44 PM  czhower
}

unit IdAuthenticationDigest;

{
  Implementation of the digest authentication as specified in RFC2617
  rev 1.1: Edwin Meester (systeemontwikkeling@interpulse.nl)
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAuthentication,
  IdException,
  IdGlobal,
  IdHashMessageDigest,
  IdHeaderList;

type
  EIdInvalidAlgorithm = class(EIdException);

  TIdDigestAuthentication = class(TIdAuthentication)
  protected
    FRealm: String;
    FStale: Boolean;
    FOpaque: String;
    FDomain: TStringList;
    Fnonce: String;
    FNoncecount: integer;
    FAlgorithm: String;
    FMethod, FUri: string; //needed for digest, Somebody make this nice :D
    FPostbody: TStringList; //needed voor auth-int, Somebody make this nice :D
    FQopOptions: TStringList;
    FOther: TStringList;
    function DoNext: TIdAuthWhatsNext; override;
  public
    destructor Destroy; override;
    function Authentication: String; override;
    property Method: String read FMethod write FMethod;
    property Uri: String read FUri write FUri;
    property Postbody: TStringList read FPostbody write FPostbody;
  end;

implementation

uses
  IdHash, IdResourceStrings, IdResourceStringsProtocols, SysUtils;

{ TIdDigestAuthentication }

destructor TIdDigestAuthentication.Destroy;
begin
  FreeAndNil(FDomain);
  FreeAndNil(FQopOptions);
  inherited Destroy;
end;

function TIdDigestAuthentication.Authentication: String;

  function ResultString(const S: String): String;
  begin
    with TIdHashMessageDigest5.Create do try
      Result := LowerCase(HashStringAsHex(S));
    finally Free end;
    // RLebeau: how can spaces get into the Hex output?
    Result := StringReplace(Result, ' ', '0', [rfReplaceAll]); //Stupid uppercase, cost me a whole day to figure this one out
  end;

var
  LstrA1, LstrA2, LstrCNonce, LstrResponse: string;
begin
  Result := '';    {do not localize}
  case FCurrentStep of
    0:
      begin
        Result := 'Digest'; //Just be save with this one
      end;
    1:
      begin
        //Build request

        LstrCNonce := ResultString(DateTimeToStr(Now));

        LstrA1 := ResultString(Username + ':' + FRealm + ':' + Password);
        if TextIsSame(FAlgorithm, 'MD5-sess') then begin
          LstrA1 := ResultString(LstrA1 + ':' + Fnonce + ':' + LstrCNonce);
        end;
        if FQopOptions.IndexOf('auth-int') > -1 then begin
          LstrA2 := ResultString(FMethod + ':' + FUri + ':' + ResultString(FPostbody.CommaText))
        end else begin
          LstrA2 := ResultString(FMethod + ':' + FUri);
        end;
        LstrResponse := LstrA1 + ':' + Fnonce + ':';
        if (FQopOptions.IndexOf('auth-int') > -1) or (FQopOptions.IndexOf('auth') > -1) then begin //Qop header present
          LstrResponse := LstrResponse + IntToHex(FNoncecount, 8) + ':' + LstrCNonce + ':';
          if FQopOptions.IndexOf('auth-int') > -1 then begin
            LstrResponse := LstrResponse + 'auth-int:';
          end else begin
            LstrResponse := LstrResponse + 'auth:';
          end;
        end;
        LstrResponse := LstrResponse + LstrA2;
        LstrResponse := ResultString(LStrResponse);

        Result := Result + 'Digest ' + {do not localize}
          'username="' + Username + '", ' + {do not localize}
          'realm="' + FRealm + '", ' +  {do not localize}
          'nonce="' + FNonce + '", ' + {do not localize}
          'algorithm="' + FAlgorithm + '", ' + {do not localize}
          'uri="' + Furi + '", ';
        if (FQopOptions.IndexOf('auth-int') > -1) or (FQopOptions.IndexOf('auth') > -1) then begin //Qop header present
          if FQopOptions.IndexOf('auth-int') > -1 then begin
            Result := Result + 'qop="auth-int", '
          end else begin
            Result := Result + 'qop="auth", ';
          end;
          Result := Result + 'nc=' + IntToHex(FNoncecount, 8) + ', ' +
            'cnonce="' + LstrCNonce + '", ';
        end;
        Result := Result + 'response="' + LstrResponse + '"';
        if FOpaque <> '' then begin
          Result := Result + ', opaque="' + FOpaque + '"';
        end;
        Inc(FNoncecount);
        FCurrentStep := 0;
      end;
  end;
end;

function RemoveQuote(const aStr:string):string;
begin
  if (Length(aStr)>=2) and (aStr[1]='"') and (astr[Length(aStr)]='"') then begin
    Result := Copy(aStr, 2, Length(astr)-2)
  end else begin
    Result := aStr;
  end;
end;

function TIdDigestAuthentication.DoNext: TIdAuthWhatsNext;
var
  S, LstrTempNonce: String;
  LParams: TStringList;
  i: Integer;
begin
  Result := wnDoRequest;

  case FCurrentStep of
    0:
      begin
        //gather info
        if not Assigned(FDomain) then begin
          FDomain := TStringList.Create;
        end else begin
          FDomain.Clear;
        end;
        if not Assigned(FQopOptions) then begin
          FQopOptions := TStringList.Create;
        end else begin
          FQopOptions.Clear;
        end;

        S := ReadAuthInfo('Digest');
        Fetch(S);

        LParams := TStringList.Create;
        try
          while Length(S) > 0 do begin
            LParams.Add(Fetch(S, ', '));
          end;

          for i := LParams.Count-1 downto 0 do
          begin
            LParams.Values[LParams.Names[i]] := RemoveQuote(LParams.Values[LParams.Names[i]]);
          end;

          FRealm := LParams.Values['realm'];
          LStrTempnonce := LParams.Values['nonce'];
          if FNonce <> LstrTempNonce then
          begin
            FnonceCount := 1;
            FNonce := LstrTempNonce;
          end;

          S := LParams.Values['domain'];
          while Length(S) > 0 do begin
            FDomain.Add(Fetch(S));
          end;

          FOpaque := LParams.Values['opaque'];
          FStale := TextIsSame(LParams.Values['stale'], 'True');
          FAlgorithm := LParams.Values['algorithm'];
          FQopOptions.CommaText := LParams.Values['qop'];

          if not TextIsSame(FAlgorithm, 'MD5') then begin
            //FAlgorithm:='MD5';
            raise EIdInvalidAlgorithm.Create(RSHTTPAuthInvalidHash);
          end;

        finally
          FreeAndNil(LParams);
        end;

        FCurrentStep := 1;

        if Length(Username) > 0 then begin
          Result := wnDoRequest;
        end else begin
          Result := wnAskTheProgram;
        end;
      end;
  end;
end;

initialization
  RegisterAuthenticationMethod('Digest', TIdDigestAuthentication);
end.

