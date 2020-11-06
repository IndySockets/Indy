unit IdOpenSSLLoader;

interface

uses
  Classes;

type
  IOpenSSLLoader = interface
    ['{BBB0F670-CC26-42BC-A9E0-33647361941A}']

    function GetOpenSSLPath: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;

    function Load: Boolean;
    procedure Unload;

    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

function GetOpenSSLLoader: IOpenSSLLoader;

implementation

{$IFNDEF STATICLOAD_OPENSSL}
uses
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  {$IFDEF UNIX}{$IFDEF FPC}dynlibs,{$ENDIF}{$ENDIF}

  IdOpenSSLHeaders_aes,
  IdOpenSSLHeaders_asn1,
  IdOpenSSLHeaders_asn1err,
  IdOpenSSLHeaders_asn1t,
  IdOpenSSLHeaders_async,
  IdOpenSSLHeaders_asyncerr,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_bioerr,
  IdOpenSSLHeaders_blowfish,
  IdOpenSSLHeaders_bn,
  IdOpenSSLHeaders_bnerr,
  IdOpenSSLHeaders_buffer,
  IdOpenSSLHeaders_buffererr,
  IdOpenSSLHeaders_camellia,
  IdOpenSSLHeaders_cast,
  IdOpenSSLHeaders_cmac,
  IdOpenSSLHeaders_cms,
  IdOpenSSLHeaders_cmserr,
  IdOpenSSLHeaders_comp,
  IdOpenSSLHeaders_comperr,
  IdOpenSSLHeaders_conf,
  IdOpenSSLHeaders_conf_api,
  IdOpenSSLHeaders_conferr,
  IdOpenSSLHeaders_crypto,
  IdOpenSSLHeaders_cryptoerr,
  IdOpenSSLHeaders_cterr,
  IdOpenSSLHeaders_dh,
  IdOpenSSLHeaders_dherr,
  IdOpenSSLHeaders_dsa,
  IdOpenSSLHeaders_dsaerr,
  IdOpenSSLHeaders_ebcdic,
  IdOpenSSLHeaders_ec,
  IdOpenSSLHeaders_ecerr,
  IdOpenSSLHeaders_engine,
  IdOpenSSLHeaders_engineerr,
  IdOpenSSLHeaders_err,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_evperr,
  IdOpenSSLHeaders_hmac,
  IdOpenSSLHeaders_idea,
  IdOpenSSLHeaders_kdferr,
  IdOpenSSLHeaders_objects,
  IdOpenSSLHeaders_objectserr,
  IdOpenSSLHeaders_ocsperr,
  IdOpenSSLHeaders_pem,
  IdOpenSSLHeaders_pemerr,
  IdOpenSSLHeaders_pkcs7,
  IdOpenSSLHeaders_pkcs7err,
  IdOpenSSLHeaders_rand,
  IdOpenSSLHeaders_randerr,
  IdOpenSSLHeaders_rsa,
  IdOpenSSLHeaders_rsaerr,
  IdOpenSSLHeaders_sha,
  IdOpenSSLHeaders_srtp,
  IdOpenSSLHeaders_storeerr,
  IdOpenSSLHeaders_ts,
  IdOpenSSLHeaders_tserr,
  IdOpenSSLHeaders_txt_db,
  IdOpenSSLHeaders_ui,
  IdOpenSSLHeaders_uierr,
  IdOpenSSLHeaders_whrlpool,
  IdOpenSSLHeaders_x509,
  IdOpenSSLHeaders_x509_vfy,
  IdOpenSSLHeaders_x509err,
  IdOpenSSLHeaders_x509v3,

  IdOpenSSLHeaders_ssl,
  IdOpenSSLHeaders_sslerr,
  IdOpenSSLHeaders_tls1,

  IdGlobal,
  IdOpenSSLConsts,
  IdThreadSafe,
  SysUtils;
{$ENDIF}

var
  GOpenSSLLoader: IOpenSSLLoader;

function GetOpenSSLLoader: IOpenSSLLoader;
begin
  Result := GOpenSSLLoader;
end;

{$IFNDEF STATICLOAD_OPENSSL}
type
  TOpenSSLLoader = class(TInterfacedObject, IOpenSSLLoader)
  private
    FLibCrypto: TIdLibHandle;
    FLibSSL: TIdLibHandle;
    FOpenSSLPath: string;
    FFailed: TStringList;
    FLoadCount: TIdThreadSafeInteger;
    function GetOpenSSLPath: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    function Load: Boolean;
    procedure Unload;

    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

{ TOpenSSLLoader }

constructor TOpenSSLLoader.Create;
begin
  inherited;
  FFailed := TStringList.Create();
  FLoadCount := TIdThreadSafeInteger.Create();
end;

destructor TOpenSSLLoader.Destroy;
begin
  FLoadCount.Free();
  FFailed.Free();
  inherited;
end;

function TOpenSSLLoader.GetFailedToLoad: TStringList;
begin
  Result := FFailed;
end;

function TOpenSSLLoader.GetOpenSSLPath: string;
begin
  Result := FOpenSSLPath;
end;

function TOpenSSLLoader.Load: Boolean;
begin                                  //FI:C101
  Result := True;
  FLoadCount.Lock();
  try
    if FLoadCount.Value <= 0 then
    begin
      {$IFDEF MSWINDOWS}
      FLibCrypto := SafeLoadLibrary(FOpenSSLPath + CLibCrypto, SEM_FAILCRITICALERRORS);
      FLibSSL := SafeLoadLibrary(FOpenSSLPath + CLibSSL, SEM_FAILCRITICALERRORS);
      {$ELSE}
      FLibCrypto := HMODULE(HackLoad(FOpenSSLPath + CLibCryptoRaw, SSLDLLVers));
      FLibSSL := HMODULE(HackLoad(FOpenSSLPath + CLibSSLRaw, SSLDLLVers));
      {$ENDIF}
      Result := not (FLibCrypto = IdNilHandle) and not (FLibSSL = IdNilHandle);
      if not Result then
        Exit;

      FLoadCount.Value := 1;

      IdOpenSSLHeaders_aes.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1err.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1t.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_async.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_asyncerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_bio.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_bioerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_blowfish.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_bn.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_bnerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_buffer.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_buffererr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_camellia.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cast.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cmac.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cms.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cmserr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_comp.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_comperr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_conf.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_conf_api.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_conferr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_crypto.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cryptoerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_cterr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_dh.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_dherr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_dsa.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_dsaerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ebcdic.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ec.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ecerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_engine.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_engineerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_err.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_evp.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_evperr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_hmac.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_idea.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_kdferr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_objects.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_objectserr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ocsperr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_pem.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_pemerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_pkcs7.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_pkcs7err.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_rand.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_randerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_rsa.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_rsaerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_sha.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_srtp.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_storeerr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ts.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_tserr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_txt_db.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_ui.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_uierr.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_whrlpool.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_x509.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_x509_vfy.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_x509err.Load(FLibCrypto, FFailed);
      IdOpenSSLHeaders_x509v3.Load(FLibCrypto, FFailed);

      IdOpenSSLHeaders_ssl.Load(FLibSSL, FFailed);
      IdOpenSSLHeaders_sslerr.Load(FLibSSL, FFailed);
      IdOpenSSLHeaders_tls1.Load(FLibSSL, FFailed);
    end;
  finally
    FLoadCount.Unlock();
  end;
end;

procedure TOpenSSLLoader.SetOpenSSLPath(const Value: string);
begin
  FOpenSSLPath := IncludeTrailingPathDelimiter(Value);
end;

procedure TOpenSSLLoader.Unload;
begin                            //FI:C101
  FLoadCount.Lock();
  try
    FLoadCount.Decrement();
    if FLoadCount.Value = 0 then
    begin
      IdOpenSSLHeaders_aes.Unload();
      IdOpenSSLHeaders_asn1.Unload();
      IdOpenSSLHeaders_asn1err.Unload();
      IdOpenSSLHeaders_asn1t.Unload();
      IdOpenSSLHeaders_async.Unload();
      IdOpenSSLHeaders_asyncerr.Unload();
      IdOpenSSLHeaders_bio.Unload();
      IdOpenSSLHeaders_bioerr.Unload();
      IdOpenSSLHeaders_blowfish.Unload();
      IdOpenSSLHeaders_bn.Unload();
      IdOpenSSLHeaders_bnerr.Unload();
      IdOpenSSLHeaders_buffer.Unload();
      IdOpenSSLHeaders_buffererr.Unload();
      IdOpenSSLHeaders_camellia.Unload();
      IdOpenSSLHeaders_cast.Unload();
      IdOpenSSLHeaders_cmac.Unload();
      IdOpenSSLHeaders_cms.Unload();
      IdOpenSSLHeaders_cmserr.Unload();
      IdOpenSSLHeaders_comp.Unload();
      IdOpenSSLHeaders_comperr.Unload();
      IdOpenSSLHeaders_conf.Unload();
      IdOpenSSLHeaders_conf_api.Unload();
      IdOpenSSLHeaders_conferr.Unload();
      IdOpenSSLHeaders_crypto.Unload();
      IdOpenSSLHeaders_cryptoerr.Unload();
      IdOpenSSLHeaders_cterr.Unload();
      IdOpenSSLHeaders_dh.Unload();
      IdOpenSSLHeaders_dherr.Unload();
      IdOpenSSLHeaders_dsa.Unload();
      IdOpenSSLHeaders_dsaerr.Unload();
      IdOpenSSLHeaders_ebcdic.Unload();
      IdOpenSSLHeaders_ec.Unload();
      IdOpenSSLHeaders_ecerr.Unload();
      IdOpenSSLHeaders_engine.Unload();
      IdOpenSSLHeaders_engineerr.Unload();
      IdOpenSSLHeaders_err.Unload();
      IdOpenSSLHeaders_evp.Unload();
      IdOpenSSLHeaders_evperr.Unload();
      IdOpenSSLHeaders_hmac.Unload();
      IdOpenSSLHeaders_idea.Unload();
      IdOpenSSLHeaders_kdferr.Unload();
      IdOpenSSLHeaders_objects.Unload();
      IdOpenSSLHeaders_objectserr.Unload();
      IdOpenSSLHeaders_ocsperr.Unload();
      IdOpenSSLHeaders_pem.Unload();
      IdOpenSSLHeaders_pemerr.Unload();
      IdOpenSSLHeaders_pkcs7.Unload();
      IdOpenSSLHeaders_pkcs7err.Unload();
      IdOpenSSLHeaders_rand.Unload();
      IdOpenSSLHeaders_randerr.Unload();
      IdOpenSSLHeaders_rsa.Unload();
      IdOpenSSLHeaders_rsaerr.Unload();
      IdOpenSSLHeaders_sha.Unload();
      IdOpenSSLHeaders_srtp.Unload();
      IdOpenSSLHeaders_storeerr.Unload();
      IdOpenSSLHeaders_ts.Unload();
      IdOpenSSLHeaders_tserr.Unload();
      IdOpenSSLHeaders_txt_db.Unload();
      IdOpenSSLHeaders_ui.Unload();
      IdOpenSSLHeaders_uierr.Unload();
      IdOpenSSLHeaders_whrlpool.Unload();
      IdOpenSSLHeaders_x509.Unload();
      IdOpenSSLHeaders_x509_vfy.Unload();
      IdOpenSSLHeaders_x509err.Unload();
      IdOpenSSLHeaders_x509v3.Unload();

      IdOpenSSLHeaders_ssl.Unload();
      IdOpenSSLHeaders_sslerr.Unload();
      IdOpenSSLHeaders_tls1.Unload();

      FFailed.Clear();

      FreeLibrary(FLibSSL);
      FreeLibrary(FLibCrypto);
    end;
  finally
    FLoadCount.Unlock();
  end;
end;
{$ENDIF}

initialization
  GOpenSSLLoader := nil;
{$IFNDEF STATICLOAD_OPENSSL}
  GOpenSSLLoader := TOpenSSLLoader.Create();
{$ENDIF}

end.
