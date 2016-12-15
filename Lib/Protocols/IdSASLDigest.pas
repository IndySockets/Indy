unit IdSASLDigest;

interface
{$i IdCompilerDefines.inc}
uses
  Classes,
  SysUtils, //here to facilitate inline expansion
  IdSASL, IdSASLUserPass, IdUserPassProvider, IdException;

type
  TIdSASLDigest = class(TIdSASLUserPass)
  protected
    Fauthzid : String;
  public
    function StartAuthenticate(const AChallenge, AHost, AProtocolName:string) : String; override;
    function ContinueAuthenticate(const ALastResponse, AHost, AProtocolName : string): string; override;
    class function ServiceName: TIdSASLServiceName; override;
    function IsReadyToStart: Boolean; override;
  published
    property authzid : String read Fauthzid write Fauthzid;
  end;

  EIdSASLDigestException = class(EIdException);
  EIdSASLDigestChallException = class(EIdSASLDigestException);
  EIdSASLDigestChallNoAlgorithm = class(EIdSASLDigestChallException);
  EIdSASLDigestChallInvalidAlg  = class(EIdSASLDigestChallException);
  EIdSASLDigestAuthConfNotSupported = class(EIdSASLDigestException);

//done this way so we can use testboxes

function CalcDigestResponse(const AUserName, APassword, ARealm, ANonce, ACNonce : String;
  const ANC : Integer;
  const  AQop, ADigestURI : String; const AAuthzid : String = '') : String;

implementation

uses
  IdFIPS, IdGlobal, IdGlobalProtocols, IdHash, IdHashMessageDigest, IdResourceStringsProtocols;

function NCToStr(const AValue : Integer):String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IntToHex(AValue,8);
end;

function Unquote(var S: String): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
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
end;

//
function HashResult(const AStr : String): TIdBytes;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LMD5: TIdHashMessageDigest5;
begin
  LMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LMD5.HashString(AStr);
  finally
    LMD5.Free;
  end;
end;

function HashResultAsHex(const ABytes : TIdBytes) : String;  overload;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LMD5: TIdHashMessageDigest5;
begin
  LMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(LMD5.HashBytesAsHex(ABytes));
  finally
    LMD5.Free;
  end;
end;

function HashResultAsHex(const AStr : String) : String; overload;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LMD5: TIdHashMessageDigest5;
begin
  LMD5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(LMD5.HashStringAsHex(AStr));
  finally
    LMD5.Free;
  end;
end;

function CalcDigestResponse(const AUserName, APassword, ARealm, ANonce, ACNonce : String;
  const ANC : Integer; const  AQop, ADigestURI : String; const AAuthzid : String = '') : String;
var
  LA1 : TIdBytes;
   LA2: TIdBytes;
  LA1_P : TIdBytes;
begin
  LA1_P := IdGlobal.ToBytes(':' + ANonce + ':' + ACNonce);
  LA1 :=  HashResult(AUserName + ':' + ARealm + ':' +
    APassword);
  IdGlobal.AppendBytes(LA1,LA1_P);
  If AAuthzid <> '' then begin
    IdGlobal.AppendBytes(LA1,IdGlobal.ToBytes(AAuthzid));
  end;
  if AQop = 'auth' then begin
     LA2 := ToBytes('AUTHENTICATE:' + ADigestURI);
  end
  else if (AQop = 'auth-int') or (AQop = 'auth-conf') then begin
    LA2 := ToBytes('AUTHENTICATE:' + ADigestURI + ':00000000000000000000000000000000');
  end else begin
   SetLength(LA2,0);
  end;
  Result := HashResultAsHex(HashResultAsHex(LA1) + ':' + ANonce + ':' +
     NCToStr(ANC) + ':' + ACNonce + ':' + AQop +':' + HashResultAsHex(LA2));
end;
//

{ TIdSASLDigest }

function TIdSASLDigest.ContinueAuthenticate(const ALastResponse, AHost,
  AProtocolName: string): string;
begin
  Result := '';
end;

function TIdSASLDigest.IsReadyToStart: Boolean;
begin
  Result := not GetFIPSMode;
end;

class function TIdSASLDigest.ServiceName: TIdSASLServiceName;

begin
  Result := 'DIGEST-MD5';
end;

function TIdSASLDigest.StartAuthenticate(const AChallenge, AHost, AProtocolName: string): String;
var
  LBuf : String;
  LChallange: TStringList;
  LReply : TStringList;
  Lqop : String;
  LstrCNonce : String;
  LstrResponse : String;
  LURL : String;
  LCharset : String;
  LQopOptions: TStrings;
  LAlgorithm : String;
  LNonce : String;
  LRealm: String;
  LName, LValue: String;
begin
  LURL := AProtocolName+'/'+AHost;
  LReply := TStringList.Create;
  LChallange := TStringList.Create;
  LQopOptions:= TStringList.Create;
  try
    LBuf := AChallenge;
    while Length(LBuf) > 0 do begin
      LName := Trim(Fetch(LBuf, '=')); {do not localize}
      LBuf := TrimLeft(LBuf);
      if TextStartsWith(LBuf, '"') then begin {do not localize}
        LValue := Unquote(LBuf); {do not localize}
        Fetch(LBuf, ','); {do not localize}
      end else begin
        LValue := Trim(Fetch(LBuf, ','));
      end;
      IndyAddPair(LChallange, LName, LValue);
      LBuf := TrimLeft(LBuf);
    end;
    LQopOptions.CommaText := LChallange.Values['qop'];
    if LQopOptions.IndexOf('auth-int') > -1 then begin
      Lqop := 'auth-int';
    end else begin
      Lqop := 'auth';
    end;
    if LQopOptions.IndexOf('auth-conf') > -1 then begin
      if LQopOptions.IndexOf('auth') = -1 then begin
        raise EIdSASLDigestAuthConfNotSupported.Create(RSSASLDigestAuthConfNotSupported);
      end;
    end;
    LNonce := LChallange.Values['nonce'];
    LRealm :=  LChallange.Values['realm'];
    LAlgorithm :=  LChallange.Values['algorithm'];
    if LAlgorithm = '' then begin
      raise EIdSASLDigestChallNoAlgorithm.Create(RSSASLDigestMissingAlgorithm);
    end;
    {
    if LAlgorithm <> 'md5-sess' then begin
      raise EIdSASLDigestChallInvalidAlg.Create(RSSASLDigestInvalidAlgorithm);
    end;
    }

    //Commented out for case test mentioned in RFC 2831
    LstrCNonce := HashResultAsHex(DateTimeToStr(Now));

    LCharset :=  LChallange.Values['charset'];

    LstrResponse := CalcDigestResponse(GetUserName,Self.GetPassword,LRealm,LNonce,LstrCNonce,
     1, Lqop, LURL,Fauthzid);


//    if LQopOptions.IndexOf('auth-conf') > -1 then begin
//      if LQopOptions.IndexOf('auth') = -1 then begin
//        raise EIdSASLDigestAuthConfNotSupported.Create(RSSASLDigestAuthConfNotSupported);
//      end;
//    end;

   if LCharset = '' then begin
     Result := '';
   end else begin
     Result := 'charset='+LCharset+',';
   end;
{
#( username | realm | nonce | cnonce |
    nonce-count | qop | digest-uri | response |
    maxbuf | charset | cipher | authzid |
    auth-param )
}
    Result := Result + 'username="'+GetUsername+'"'+
     ',realm="'+LRealm+'"'+ {Do not localize}
      ',nonce="'+ LNonce+'"'+
      ',nc='+NCToStr(1)+
      ',cnonce="'+LstrCNonce+'"'+
      ',digest-uri="'+LURL+'"'+
      ',response='+LstrResponse+
      ',qop='+Lqop;
  finally
    FreeAndNil(LQopOptions);
    FreeAndNil(LChallange);
    FreeAndNil(LReply);
  end;
end;

end.
