unit IdSASLDigest;

interface
uses
  Classes,
   IdSASL, IdSASLUserPass, IdUserPassProvider, IdException;

type
  TIdSASLDigest = class(TIdSASLUserPass)
  protected
    Fauthzid : String;
  public
    function StartAuthenticate(const AChallenge, AHost, AProtocolName:string) : String; override;
    class function ServiceName: TIdSASLServiceName; override;
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
uses IdGlobal, IdHash, IdHashMessageDigest, IdResourceStringsProtocols, SysUtils;

const
  SASL_DIGEST_METHOD = 'AUTHENTICATE:';  {do not localize}

function RemoveQuote(const aStr:string):string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if (Length(aStr)>=2) and (aStr[1]='"') and (astr[Length(aStr)]='"') then begin
    Result := Copy(aStr, 2, Length(astr)-2)
  end else begin
    Result := aStr;
  end;
end;

function HashResult(const AStr : String): TIdBytes;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
   with TIdHashMessageDigest5.Create do
   try
     Result := HashString(AStr);
   finally
     Free;
   end;
end;

function HashResultAsHex(const ABytes : TIdBytes) : String; overload;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  with TIdHashMessageDigest5.Create do
  try

    Result := HashBytesAsHex(ABytes);
  finally
    Free;
  end;
end;

function HashResultAsHex(const AStr : String) : String; overload;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  with TIdHashMessageDigest5.Create do
  try

    Result := LowerCase(HashStringAsHex(AStr));
  finally
    Free;
  end;
end;

function NCToStr(const ANC : Integer): String;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  Result := IntToHex(ANC, 8);
end;

function CalcDigestResponse(const AUserName, APassword, ARealm, ANonce, ACNonce : String;
  const ANC : Integer;
  const  AQop, ADigestURI : String; const AAuthzid : String = '') : String;
var
  LA1, LA2, LH_A1, LH_A2, LNC : String;
begin
  LNC := NCToStr(ANC);

//
//   If authzid is specified, then A1 is
//
//
//      A1 = { H( { username-value, ":", realm-value, ":", passwd } ),
//           ":", nonce-value, ":", cnonce-value, ":", authzid-value }
//
//   If authzid is not specified, then A1 is
//
//
//      A1 = { H( { username-value, ":", realm-value, ":", passwd } ),
//           ":", nonce-value, ":", cnonce-value }
//
//   where
//
//         passwd   = *OCTET

    LA1 := BytesToString(HashResult(AUserName + ':' + ARealm + ':' + APassword));
    LA1 := LA1 + ':' + ANonce + ':'+ ACNonce;
    if AAuthzid<>'' then begin
      LA1 := LA1 + ':'+AAuthzid;
    end;
    LH_A1 := HashResultAsHex(LA1);
//   If the "qop" directive's value is "auth", then A2 is:
//
//      A2       = { "AUTHENTICATE:", digest-uri-value }
//
//   If the "qop" value is "auth-int" or "auth-conf" then A2 is:
//
//      A2       = { "AUTHENTICATE:", digest-uri-value,
//               ":00000000000000000000000000000000" }
    LA2 := SASL_DIGEST_METHOD + ADigestURI;
    if AQop = 'auth-int' then begin
      LA2 := Result +':00000000000000000000000000000000';
    end;
    LH_A2 := HashResultAsHex(LA2);
//RFC 2831
//     response-value  =
//
//         HEX( KD ( HEX(H(A1)),
//                 { nonce-value, ":" nc-value, ":",
//                   cnonce-value, ":", qop-value, ":", HEX(H(A2)) }))
//
//    //result
    Result := HashResultAsHex( LH_A1 + ':' + ANonce + ':'+LNC+':'+ACNonce+':'+AQop+':'+LH_A2);

//    if LQopOptions.IndexOf('auth-conf') > -1 then begin
//      EIdSASLDigestAuthConfNotSupported.IfFalse(LQopOptions.IndexOf('auth')>-1,RSSASLDigestAuthConfNotSupported);
//    end;
end;

{ TIdSASLDigest }

class function TIdSASLDigest.ServiceName: TIdSASLServiceName;

begin
  Result := 'DIGEST-MD5';
end;

function TIdSASLDigest.StartAuthenticate(const AChallenge, AHost, AProtocolName: string): String;
var LBuf : String;
  LChallange: TStringList;
  LReply : TStringList;
  Lqop : String;
  LstrCNonce : String;
  i : Integer;
  LstrResponse : String;
  LURL : String;
  LCharset : String;
  LQopOptions: TStrings;
  LAlgorithm : String;
  LNonce : String;
  LRealm: String;

begin
  LURL := AProtocolName+'/'+AHost;
  LReply := TStringList.Create;
  LChallange := TStringList.Create;
  LQopOptions:= TStringList.Create;
  try
    LBuf := AChallenge;
    repeat
      if Length(LBuf)=0 then
      begin
        break;
      end;
      LChallange.Add(Fetch(LBuf,','));
    until False;
    for i := LChallange.Count-1 downto 0 do
    begin
      LChallange.Values[LChallange.Names[i]] :=
        RemoveQuote(LChallange.Values[LChallange.Names[i]]);
    end;
    LQopOptions.CommaText := LChallange.Values['qop'];
    Lqop := 'auth';
    if LQopOptions.IndexOf('auth-int') > -1 then
    begin
      Lqop := 'auth-int';
    end;
    if LQopOptions.IndexOf('auth-conf') > -1 then begin
      EIdSASLDigestAuthConfNotSupported.IfFalse(LQopOptions.IndexOf('auth')>-1,RSSASLDigestAuthConfNotSupported);
    end;
    LNonce := LChallange.Values['nonce'];
    LRealm :=  LChallange.Values['realm'];
    LAlgorithm :=  LChallange.Values['algorithm'];
    EIdSASLDigestChallNoAlgorithm.IfFalse(LAlgorithm<>'',RSSASLDigestMissingAlgorithm);
//    EIdSASLDigestChallInvalidAlg.IfFalse(LAlgorithm = 'md5-sess',RSSASLDigestInvalidAlgorithm);

    //Commented out for case test mentioned in RFC 2831
    LstrCNonce := HashResultAsHex(DateTimeToStr(Now));

    LCharset :=  LChallange.Values['charset'];

    LstrResponse := CalcDigestResponse(GetUserName,Self.GetPassword,LRealm,LNonce,LstrCNonce,
     1, Lqop, LURL,Fauthzid);


//    if LQopOptions.IndexOf('auth-conf') > -1 then begin
//      EIdSASLDigestAuthConfNotSupported.IfFalse(LQopOptions.IndexOf('auth')>-1,RSSASLDigestAuthConfNotSupported);
//    end;

   if LCharset='' then
   begin
     Result := '';
   end
   else
   begin
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
