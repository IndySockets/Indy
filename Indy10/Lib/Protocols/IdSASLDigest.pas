unit IdSASLDigest;

interface
uses
  Classes,
   IdSASL, IdSASLUserPass, IdUserPassProvider, IdException;

type
  TIdSASLDigest = class(TIdSASLUserPass)
  protected
    Fauthzid : String;
    FDebugCNonce : String;
  public
    function StartAuthenticate(const AChallenge, AHost, AProtocolName:string) : String; override;
    class function ServiceName: TIdSASLServiceName; override;
    //temp property until I finish debugging this.
    property DebugCNonce : string read FDebugCNonce write FDebugCNonce;
  published
    property authzid : String read Fauthzid write Fauthzid;
  end;
  EIdSASLDigestException = class(EIdException);
  EIdSASLDigestChallException = class(EIdSASLDigestException);
  EIdSASLDigestChallNoAlgorithm = class(EIdSASLDigestChallException);
  EIdSASLDigestChallInvalidAlg  = class(EIdSASLDigestChallException);
  EIdSASLDigestAuthConfNotSupported = class(EIdSASLDigestException);

implementation
uses IdGlobal, IdHash, IdHashMessageDigest, IdResourceStringsProtocols, SysUtils;

const
  //NC should eventually be made into a var (probalby an integer
  NC='00000001';  {do not localize}
  SASL_DIGEST_METHOD = 'AUTHENTICATE:';  {do not localize}
  //specified by RFC 2831
  A2_HASHSUM = '00000000000000000000000000000000';  {do not localize}

function RemoveQuote(const aStr:string):string;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  if (Length(aStr)>=2) and (aStr[1]='"') and (astr[Length(aStr)]='"') then begin
    Result := Copy(aStr, 2, Length(astr)-2)
  end else begin
    Result := aStr;
  end;
end;

function HashResultAsHex(const AStr : String) : String;
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  with TIdHashMessageDigest5.Create do
  try
    Result := LowerCase(HashStringAsHex(AStr));
  finally
    Free;
  end;
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
  LA1, LA2 : String;
  LH_A1, LH_A2 : String;
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
    EIdSASLDigestChallInvalidAlg.IfFalse(LAlgorithm = 'md5-sess',RSSASLDigestInvalidAlgorithm);

    //Commented out for case test mentioned in RFC 2831
    if FDebugCNonce<>'' then
    begin
      LstrCNonce := FDebugCNonce;
    end
    else
    begin
      LstrCNonce := HashResultAsHex(DateTimeToStr(Now));
    end;
    LCharset :=  LChallange.Values['charset'];
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

    LA1 := GetUsername + ':' + LRealm + ':' + GetPassword;
    if TextIsSame(LAlgorithm, 'MD5-sess') then begin
      if Fauthzid='' then begin
        LA1 := LA1 + ':' + LNonce + ':' + LstrCNonce;
      end else begin
        LA1 := LA1 + ':' + LNonce + ':' + LstrCNonce+':'+Fauthzid;
      end;
    end;
    LH_A1 := HashResultAsHex(LA1);
    if LQop = 'auth-int' then begin
      LA2 := SASL_DIGEST_METHOD + ':' + LUrl + ':'+A2_HASHSUM;
    end else begin
      LA2 := SASL_DIGEST_METHOD + ':' + LUrl;
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
    LstrResponse := HashResultAsHex( LH_A1 + ':' + LNonce + ':'+NC+':'+LstrCNonce+':'+LQop+':'+LH_A2);

//    if LQopOptions.IndexOf('auth-conf') > -1 then begin
//      EIdSASLDigestAuthConfNotSupported.IfFalse(LQopOptions.IndexOf('auth')>-1,RSSASLDigestAuthConfNotSupported);
//    end;

{
#( username | realm | nonce | cnonce |
    nonce-count | qop | digest-uri | response |
    maxbuf | charset | cipher | authzid |
    auth-param )
}

   if LCharset='' then
   begin
     Result := '';
   end
   else
   begin
     Result := 'charset='+LCharset+',';
   end;
    Result := Result + 'username="'+GetUsername+'"'+
     ',realm="'+LRealm+'"'+ {Do not localize}
      ',nonce="'+ LNonce+'"'+
      ',nc='+NC+
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
