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
    FNonce: String;
    FNonceCount: integer;
    FAlgorithm: String;
    FMethod, FUri: string; //needed for digest
    FEntityBody: String; //needed for auth-int, Somebody make this nice :D
    FQopOptions: TStringList;
    FOther: TStringList;
    function DoNext: TIdAuthWhatsNext; override;
    function GetSteps: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Authentication: String; override;
    procedure SetRequest(const AMethod, AUri: String); override;
    property Method: String read FMethod write FMethod;
    property Uri: String read FUri write FUri;
    property EntityBody: String read FEntityBody write FEntityBody;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterAuthenticationMethod can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdAuthenticationDigest"'}
  {$ENDIF}

implementation

uses
  IdGlobalProtocols, IdFIPS, IdHash, IdResourceStrings, IdResourceStringsProtocols,
  SysUtils;

{ TIdDigestAuthentication }

constructor TIdDigestAuthentication.Create;
begin
  inherited Create;
  CheckMD5Permitted;
end;

destructor TIdDigestAuthentication.Destroy;
begin
  FreeAndNil(FDomain);
  FreeAndNil(FQopOptions);
  inherited Destroy;
end;

procedure TIdDigestAuthentication.SetRequest(const AMethod, AUri: String);
begin
  FMethod := AMethod;
  FUri := AUri;
end;

function TIdDigestAuthentication.Authentication: String;

  function Hash(const S: String): String;
  var
    LMD5: TIdHashMessageDigest5;
  begin
    LMD5 := TIdHashMessageDigest5.Create;
    try
      Result := LowerCase(LMD5.HashStringAsHex(S));
    finally
      LMD5.Free;
    end;
  end;

var
  LA1, LA2, LCNonce, LResponse, LQop: string;
begin
  Result := '';    {do not localize}

  case FCurrentStep of
    0:
      begin
        //Just be safe with this one
        Result := 'Digest'; {do not localize}
      end;
    1:
      begin
        //Build request

        LCNonce := Hash(DateTimeToStr(Now));

        LA1 := Username + ':' + FRealm + ':' + Password; {do not localize}
        if TextIsSame(FAlgorithm, 'MD5-sess') then begin {do not localize}
          LA1 := Hash(LA1) + ':' + FNonce + ':' + LCNonce; {do not localize}
        end;

        LA2 := FMethod + ':' + FUri; {do not localize}
        //Qop header present
        if FQopOptions.IndexOf('auth-int') > -1 then begin {do not localize}
          LQop := 'auth-int'; {do not localize}
          LA2 := LA2 + ':' + Hash(FEntityBody); {do not localize}
        end
        else if FQopOptions.IndexOf('auth') > -1 then begin {do not localize}
          LQop := 'auth'; {do not localize}
        end;

        if LQop <> '' then begin
          LResponse := IntToHex(FNonceCount, 8) + ':' + LCNonce + ':' + LQop + ':'; {do not localize}
        end;
        LResponse := Hash( Hash(LA1) + ':' + FNonce + ':' + LResponse + Hash(LA2) ); {do not localize}

        Result := 'Digest ' + {do not localize}
          'username="' + Username + '", ' + {do not localize}
          'realm="' + FRealm + '", ' +  {do not localize}
          'nonce="' + FNonce + '", ' + {do not localize}
          'algorithm="' + FAlgorithm + '", ' + {do not localize}
          'uri="' + FUri + '", ';

        //Qop header present
        if LQop <> '' then begin {do not localize}
          Result := Result +
            'qop="' + LQop + '", ' + {do not localize}
            'nc=' + IntToHex(FNonceCount, 8) + ', ' + {do not localize}
            'cnonce="' + LCNonce + '", '; {do not localize}
        end;

        Result := Result + 'response="' + LResponse + '"'; {do not localize}

        if FOpaque <> '' then begin
          Result := Result + ', opaque="' + FOpaque + '"'; {do not localize}
        end;

        Inc(FNonceCount);
        FCurrentStep := 0;
      end;
  end;
end;

// TODO: move this to the IdAuthentication unit, or maybe the IdGlobalProtocols unit...
function Unquote(var S: String): String;
var
  I, Len: Integer;
begin
  Len := Length(S);
  I := 2; // skip first quote
  while I <= Len do
  begin
    if S[I] = '"' then begin
      Break;
    end;
    if S[I] = '\' then begin
      Inc(I);
    end;
    Inc(I);
  end;
  Result := Copy(S, 2, I-2);
  S := Copy(S, I+1, MaxInt);

  // TODO: use a PosEx() loop instead
  {
  I := Pos('\', Result);
  while I <> 0 do
  begin
    IdDelete(Result, I, 1);
    I := PosEx('\', Result, I+1);
  end;
  }
  Len := Length(Result);
  I := 1;
  while I <= Len do
  begin
    if Result[I] = '\' then begin
      IdDelete(Result, I, 1);
    end;
    Inc(I);
  end;
end;

function TIdDigestAuthentication.DoNext: TIdAuthWhatsNext;
var
  S, LName, LValue, LTempNonce: String;
  LParams: TStringList;
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

        S := ReadAuthInfo('Digest'); {do not localize}
        Fetch(S);

        LParams := TStringList.Create;
        try
          {$IFDEF HAS_TStringList_CaseSensitive}
          LParams.CaseSensitive := False;
          {$ENDIF}

          while Length(S) > 0 do begin
            // RLebeau: Apache sends a space after each comma, but IIS does not!
            LName := Trim(Fetch(S, '=')); {do not localize}
            S := TrimLeft(S);
            if TextStartsWith(S, '"') then begin {do not localize}
              LValue := Unquote(S); {do not localize}
              Fetch(S, ','); {do not localize}
            end else begin
              LValue := Trim(Fetch(S, ','));
            end;
            IndyAddPair(LParams, LName, LValue);
            S := TrimLeft(S);
          end;

          FRealm := LParams.Values['realm']; {do not localize}

          LTempNonce := LParams.Values['nonce']; {do not localize}
          if FNonce <> LTempNonce then
          begin
            FNonceCount := 1;
            FNonce := LTempNonce;
          end;

          S := LParams.Values['domain']; {do not localize}
          while Length(S) > 0 do begin
            FDomain.Add(Fetch(S));
          end;

          FOpaque := LParams.Values['opaque']; {do not localize}
          FStale := TextIsSame(LParams.Values['stale'], 'True'); {do not localize}
          FAlgorithm := LParams.Values['algorithm']; {do not localize}
          FQopOptions.CommaText := LParams.Values['qop']; {do not localize}

          if FAlgorithm = '' then begin
            FAlgorithm := 'MD5'; {do not localize}
          end
          else if PosInStrArray(FAlgorithm, ['MD5', 'MD5-sess'], False) = -1 then begin {do not localize}
            raise EIdInvalidAlgorithm.Create(RSHTTPAuthInvalidHash);
          end;

        finally
          FreeAndNil(LParams);
        end;

        if Length(Username) > 0 then begin
          FCurrentStep := 1;
          Result := wnDoRequest;
        end else begin
          Result := wnAskTheProgram;
        end;
      end;
  end;
end;

function TIdDigestAuthentication.GetSteps: Integer;
begin
  Result := 1;
end;

initialization
  RegisterAuthenticationMethod('Digest', TIdDigestAuthentication); {do not localize}
finalization
  UnregisterAuthenticationMethod('Digest');                        {do not localize}
end.

