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
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}

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
var
  LLibCrypto, LLibSSL: TIdLibHandle;
begin                                  //FI:C101
  Result := True;
  FLoadCount.Lock();
  try
    if FLoadCount.Value <= 0 then
    begin
      LLibCrypto := SafeLoadLibrary(FOpenSSLPath + CLibCrypto, SEM_FAILCRITICALERRORS);
      LLibSSL := SafeLoadLibrary(FOpenSSLPath + CLibSSL, SEM_FAILCRITICALERRORS);
      Result := not (LLibCrypto = IdNilHandle) and not (LLibSSL = IdNilHandle);
      if not Result then
        Exit;

      FLoadCount.Value := 1;

      IdOpenSSLHeaders_aes.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1err.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_asn1t.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_async.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_asyncerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_bio.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_bioerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_blowfish.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_bn.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_bnerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_buffer.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_buffererr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_camellia.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cast.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cmac.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cms.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cmserr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_comp.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_comperr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_conf.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_conf_api.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_conferr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_crypto.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cryptoerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_cterr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_dh.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_dherr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_dsa.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_dsaerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ebcdic.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ec.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ecerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_engine.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_engineerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_err.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_evp.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_evperr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_hmac.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_idea.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_kdferr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_objects.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_objectserr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ocsperr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_pem.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_pemerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_pkcs7.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_pkcs7err.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_rand.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_randerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_rsa.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_rsaerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_sha.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_srtp.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_storeerr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ts.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_tserr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_txt_db.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_ui.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_uierr.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_whrlpool.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_x509.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_x509_vfy.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_x509err.Load(LLibCrypto, FFailed);
      IdOpenSSLHeaders_x509v3.Load(LLibCrypto, FFailed);

      IdOpenSSLHeaders_ssl.Load(LLibSSL, FFailed);
      IdOpenSSLHeaders_sslerr.Load(LLibSSL, FFailed);
      IdOpenSSLHeaders_tls1.Load(LLibSSL, FFailed);
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
