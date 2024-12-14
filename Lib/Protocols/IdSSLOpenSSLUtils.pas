unit IdSSLOpenSSLUtils;

interface

{$I IdCompilerDefines.inc}

uses
  IdCTypes,
  IdSSLOpenSSLHeaders,
  Classes;

type
  TIdSSLULong = packed record
    case Byte of
      0: (B1, B2, B3, B4: Byte);
      1: (W1, W2: Word);
      2: (L1: Longint);
      3: (C1: LongWord);
  end;

  TIdSSLEVP_MD = record
    Length: TIdC_UINT;
    MD: Array [0 .. EVP_MAX_MD_SIZE - 1] of AnsiChar;
  end;

  TIdSSLByteArray = record
    Length: TIdC_INT;
    Data: PAnsiChar;
  End;

function LoadOpenSSLLibrary: Boolean;
procedure UnLoadOpenSSLLibrary;
  // locking callback stuff
procedure LockPasswordCB_Enter;
procedure LockPasswordCB_Leave;
procedure LockInfoCB_Enter;
procedure LockInfoCB_Leave;
procedure LockVerifyCB_Enter;
procedure LockVerifyCB_Leave;
//
function AddMins(const DT: TDateTime; const Mins: Extended): TDateTime;
function AddHrs(const DT: TDateTime; const Hrs: Extended): TDateTime;
function GetLocalTime(const DT: TDateTime): TDateTime; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use IdGlobal.UTCTimeToLocalTime()'{$ENDIF};{$ENDIF}

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME;
function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): Boolean;
function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): Boolean;
function IndyX509_STORE_load_locations(ctx: PX509_STORE;
  const AFileName, APathName: String): TIdC_INT;
function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT;
procedure DumpCert(AOut: TStrings; AX509: PX509);
procedure SslLockingCallback(mode, n: TIdC_INT; Afile: PAnsiChar;
  line: TIdC_INT)cdecl;
procedure PrepareOpenSSLLocking;
{$IFNDEF WIN32_OR_WIN64}
function _GetThreadID: TIdC_ULONG; cdecl;
{$ENDIF}
// Note that I define UCTTime as  PASN1_STRING
function UTCTime2DateTime(UCTTime: PASN1_UTCTIME): TDateTime;

{ function RSACallback(sslSocket: PSSL; e: Integer; KeyLength: Integer):PRSA; cdecl;
}
function LogicalAnd(A, B: Integer): Boolean;
function BytesToHexString(APtr: Pointer; ALen: Integer): String;
function MDAsString(const AMD: TIdSSLEVP_MD): String;
procedure GetStateVars(const sslSocket: PSSL; AWhere, Aret: TIdC_INT; var VTypeStr, VMsg : String);

{$IFDEF STRING_IS_UNICODE}
  {$IFDEF WINDOWS}
{
  This is for some file lookup definitions for a LOOKUP method that
  uses Unicode filesnames instead of ASCII or UTF8.  It is not meant to be portable
  at all.
}
function by_Indy_unicode_file_ctrl(ctx: PX509_LOOKUP; cmd: TIdC_INT;
  const argc: PAnsiChar; argl: TIdC_LONG; out ret: PAnsiChar): TIdC_INT;
  cdecl; forward;

const
  Indy_x509_unicode_file_lookup: X509_LOOKUP_METHOD =
    (name: PAnsiChar('Load file into cache'); new_item: nil; // * new */
    free: nil; // * free */
    init: nil; // * init */
    shutdown: nil; // * shutdown */
    ctrl: by_Indy_unicode_file_ctrl; // * ctrl */
    get_by_subject: nil; // * get_by_subject */
    get_by_issuer_serial: nil; // * get_by_issuer_serial */
    get_by_fingerprint: nil; // * get_by_fingerprint */
    get_by_alias: nil // * get_by_alias */
    );

  {$ENDIF}
{$ENDIF}

implementation

uses
{$IFDEF WIN32_OR_WIN64}
  Windows,
{$ENDIF}
{$IFDEF USE_VCL_POSIX}
  Posix.Glue,
  Posix.SysTime,
  Posix.Time,
  Posix.Unistd,
{$ENDIF}
  IdGlobal,
  IdGlobalProtocols,
  IdResourceStrings,
  IdResourceStringsCore,
  IdResourceStringsProtocols,
  IdThreadSafe,
  SyncObjs,
  SysUtils;

var
  SSLIsLoaded: TIdThreadSafeBoolean = nil;
  LockInfoCB: TIdCriticalSection = nil;
  LockPassCB: TIdCriticalSection = nil;
  LockVerifyCB: TIdCriticalSection = nil;
  CallbackLockList: TThreadList = nil;

procedure LockPasswordCB_Enter;
begin
  LockPassCB.Enter;
end;

procedure LockPasswordCB_Leave;
begin
  LockPassCB.Leave;
end;

procedure LockInfoCB_Enter;
begin
  LockInfoCB.Enter;
end;

procedure LockInfoCB_Leave;
begin
  LockInfoCB.Leave;
end;

procedure LockVerifyCB_Enter;
begin
  LockVerifyCB.Enter;
end;

procedure LockVerifyCB_Leave;
begin
  LockVerifyCB.Leave;
end;

{
  IMPORTANT!!!

  OpenSSL can not handle Unicode file names at all.  On Posix systems, UTF8 File
  names can be used with OpenSSL.  The Windows operating system does not accept
  UTF8 file names at all so we have our own routines that will handle Unicode
  filenames.   Most of this section of code is based on code in the OpenSSL .DLL
  which is copyrighted by the OpenSSL developers.  Come of it is translated into
  Pascal and made some modifications so that it will handle Unicode filenames.
}

{$IFDEF STRING_IS_UNICODE}

  {$IFDEF WINDOWS}

function Indy_unicode_X509_load_cert_crl_file(ctx: PX509_LOOKUP; const AFileName: String;
  const _type: TIdC_INT): TIdC_INT; forward;
function Indy_unicode_X509_load_cert_file(ctx: PX509_LOOKUP; const AFileName: String;
  _type: TIdC_INT): TIdC_INT; forward;

function Indy_Unicode_X509_LOOKUP_file(): PX509_LOOKUP_METHOD cdecl;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := @Indy_x509_unicode_file_lookup;
end;

function by_Indy_unicode_file_ctrl(ctx: PX509_LOOKUP; cmd: TIdC_INT;
  const argc: PAnsiChar; argl: TIdC_LONG; out ret: PAnsiChar): TIdC_INT; cdecl;
var
  LOk: TIdC_INT;
  LFileName: String;

begin
  LOk := 0;
  case cmd of
    X509_L_FILE_LOAD:
      begin
        case argl of
          X509_FILETYPE_DEFAULT:
            begin
              LFileName := GetEnvironmentVariable
                (String(X509_get_default_cert_file_env));
              if LFileName <> '' then begin
                Result := Indy_unicode_X509_load_cert_crl_file(ctx, LFileName,
                  X509_FILETYPE_PEM);
              end else begin
                Result := Indy_unicode_X509_load_cert_crl_file(ctx,
                  String(X509_get_default_cert_file), X509_FILETYPE_PEM);
              end;
              if Result = 0 then begin
                X509err(X509_F_BY_FILE_CTRL, X509_R_LOADING_DEFAULTS);
              end;
            end;
          X509_FILETYPE_PEM:
            begin
              // Note that typecasting an AnsiChar as a WideChar is normally a crazy
              // thing to do.  The thing is that the OpenSSL API is based on ASCII or
              // UTF8, not Unicode and we are writing this just for Unicode filenames.
              LFileName := PWideChar(argc);
              LOk := Indy_unicode_X509_load_cert_crl_file(ctx, LFileName,
                X509_FILETYPE_PEM);
            end;
        else
          LFileName := PWideChar(argc);
          LOk := Indy_unicode_X509_load_cert_file(ctx, LFileName, TIdC_INT(argl));
        end;
      end;
  end;
  {Do it this way because 1 must be returned for success and unfortunately, some
  routines return the number of certificates that were loaded which could be
  more than 1}
  if LOk > 0 then begin

    Result := 1;
  end else begin
    Result := 0;
  end;
end;

function Indy_unicode_X509_load_cert_file(ctx: PX509_LOOKUP; const AFileName: String;
  _type: TIdC_INT): TIdC_INT;
var
  LM: TMemoryStream;
  Lin: PBIO;
  LX: PX509;
  i: Integer;
begin
  Result := 0;
  Lin := nil;
  LM := TMemoryStream.Create;
  try
    LM.LoadFromFile(AFileName);
    Lin := BIO_new_mem_buf(LM.Memory, LM.Size);
    if Assigned(Lin) then begin
      case _type of
        X509_FILETYPE_PEM:
          begin
            repeat
              LX := PEM_read_bio_X509_AUX(Lin, nil, nil, nil);
              if not Assigned(LX) then begin
                if ((ERR_GET_REASON(ERR_peek_last_error())
                      = PEM_R_NO_START_LINE) and (Result > 0)) then begin
                  ERR_clear_error();
                  Break;
                end else begin
                  X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_PEM_LIB);
                  // goto err;
                end;
              end;
            until False;
          end;
        X509_FILETYPE_ASN1:
          begin
            LX := d2i_X509_bio(Lin, nil);
            if not Assigned(LX) then begin
              X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_ASN1_LIB);
              // goto err;
            end else begin
              i := X509_STORE_add_cert(ctx^.store_ctx, LX);
              if i <> 0 then begin
                Result := i;
              end;
            end;
          end;
      else
        X509err(X509_F_X509_LOAD_CERT_FILE, X509_R_BAD_X509_FILETYPE);
        // goto err;
      end;
    end else begin
      X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_SYS_LIB);
      // goto err;
    end;
  finally
    BIO_free(Lin);
    FreeAndNil(LM);
  end;

end;

function Indy_unicode_X509_load_cert_crl_file(ctx: PX509_LOOKUP; const AFileName: String;
  const _type: TIdC_INT): TIdC_INT;
var
  LM: TMemoryStream;
  Linf: PSTACK_OF_X509_INFO;
  Litmp: PX509_INFO;
  Lin: PBIO;
  i: Integer;
begin
  Result := 0;
  Linf := nil;
  Lin := nil;
  if _type <> X509_FILETYPE_PEM then begin
    Result := Indy_unicode_X509_load_cert_file(ctx, AFileName, _type);
    exit;
  end;
  LM := TMemoryStream.Create;
  try
    LM.LoadFromFile(AFileName);
    Lin := BIO_new_mem_buf(LM.Memory, LM.Size);
    if Assigned(Lin) then begin
      Linf := PEM_X509_INFO_read_bio(Lin, nil, nil, nil);
    end else begin
      X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_SYS_LIB);
    end;
    BIO_free(Lin);
    FreeAndNil(LM);
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
  except
    X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_SYS_LIB);
    BIO_free(Lin);
    FreeAndNil(LM);
    exit;
  end;
  if not Assigned(Linf) then begin
    X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_PEM_LIB);
    exit;
  end;
  try
    for i := 0 to sk_X509_INFO_num(Linf) - 1 do begin
      Litmp := sk_X509_INFO_value(Linf, i);
      if Assigned(Litmp^.x509) then begin
        X509_STORE_add_cert(ctx^.store_ctx, Litmp^.x509);
        Inc(Result);
      end;
      if Assigned(Litmp^.crl) then begin
        X509_STORE_add_crl(ctx^.store_ctx, Litmp^.crl);
        Inc(Result);
      end;
    end;
  finally
    sk_X509_INFO_pop_free(Linf, @X509_INFO_free);
  end;
end;

procedure IndySSL_load_client_CA_file_err(var VRes: PSTACK_OF_X509_NAME);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if Assigned(VRes) then begin
    sk_X509_NAME_pop_free(VRes, @X509_NAME_free);
    VRes := nil;
  end;
end;

function IndySSL_load_client_CA_file(const AFileName: String): PSTACK_OF_X509_NAME;
var
  LM: TMemoryStream;
  LB: PBIO;
  Lsk: PSTACK_OF_X509_NAME;
  LX: PX509;
  LXN, LXNDup: PX509_NAME;
begin
  Result := nil;
  LX := nil;
  Lsk := sk_X509_NAME_new(nil); // (xname_cmp);
  if Assigned(Lsk) then begin
    try
      LM := TMemoryStream.Create;
      try
        LM.LoadFromFile(AFileName);
        LB := BIO_new_mem_buf(LM.Memory, LM.Size);
        if Assigned(LB) then begin
          try
            while (PEM_read_bio_X509(LB, @LX, nil, nil) <> nil) do begin
              try
                if not Assigned(Result) then begin
                  Result := sk_X509_NAME_new_null;
                  // RLebeau: exit here if not Assigned??
                  if not Assigned(Result) then begin
                    SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
                  end;
                end;
                LXN := X509_get_subject_name(LX);
                if not Assigned(LXN) then begin
                  // error
                  IndySSL_load_client_CA_file_err(Result);
                  // RLebeau: exit here??
                  // goto err;
                end;
                // * check for duplicates */
                LXNDup := X509_NAME_dup(LXN);
                if not Assigned(LXNDup) then begin
                  // error
                  IndySSL_load_client_CA_file_err(Result);
                  // RLebeau: exit here??
                  // goto err;
                end;
                if (sk_X509_NAME_find(Lsk, LXNDup) >= 0) then begin
                  X509_NAME_free(LXNDup);
                end else begin
                  sk_X509_NAME_push(Result, LXNDup);
                end;
              finally
                X509_free(LX);
              end;
            end;
          finally
            BIO_free(LB);
          end;
        end else begin
          SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
        end;
      finally
        FreeAndNil(LM);
      end;
    finally
      sk_X509_NAME_free(Lsk);
    end;
  end else begin
    SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
  end;
  if Assigned(Result) then begin
    ERR_clear_error;
  end;
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): Boolean;
var
  LM: TMemoryStream;
  B: PBIO;
  LKey: PEVP_PKEY;
  j: TIdC_INT;
begin
  Result := False;
  LM := TMemoryStream.Create;
  try
    LM.LoadFromFile(AFileName);
    B := BIO_new_mem_buf(LM.Memory, LM.Size);
    if Assigned(B) then begin
      try
        LKey := nil;
        case AType of
          SSL_FILETYPE_PEM:
            begin
              j := ERR_R_PEM_LIB;
              LKey := PEM_read_bio_PrivateKey(B, nil,
                ctx^.default_passwd_callback,
                ctx^.default_passwd_callback_userdata);
            end;
          SSL_FILETYPE_ASN1:
            begin
              j := ERR_R_ASN1_LIB;
              LKey := d2i_PrivateKey_bio(B, nil);
            end;
        else
          j := SSL_R_BAD_SSL_FILETYPE;
        end;
        if Assigned(LKey) then begin
          Result := SSL_CTX_use_PrivateKey(ctx, LKey) > 0;
          EVP_PKEY_free(LKey);
        end else begin
          SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, j);
        end;
      finally
        if Assigned(B) then begin
          BIO_free(B);
        end;
      end;
    end else begin
      SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, ERR_R_BUF_LIB);
    end;
  finally
    FreeAndNil(LM);
  end;
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): Boolean;
var
  LM: TMemoryStream;
  B: PBIO;
  LX: PX509;
  j: TIdC_INT;
begin
  Result := False;
  LM := TMemoryStream.Create;
  try
    LM.LoadFromFile(AFileName);
    B := BIO_new_mem_buf(LM.Memory, LM.Size);
    if Assigned(B) then begin
      try
        LX := nil;
        case AType of
          SSL_FILETYPE_ASN1:
            begin
              j := ERR_R_ASN1_LIB;
              LX := d2i_X509_bio(B, nil);
            end;
          SSL_FILETYPE_PEM:
            begin
              j := ERR_R_PEM_LIB;
              LX := PEM_read_bio_X509(B, nil, ctx^.default_passwd_callback,
                ctx^.default_passwd_callback_userdata);
            end
          else
            j := SSL_R_BAD_SSL_FILETYPE;
        end;
        if Assigned(LX) then begin
          Result := SSL_CTX_use_certificate(ctx, LX) > 0;
          X509_free(LX);
        end else begin
          SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, j);
        end;
      finally
        BIO_free(B);
      end;
    end else begin
      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_BUF_LIB);
    end;
  finally
    FreeAndNil(LM);
  end;
end;

function IndyX509_STORE_load_locations(ctx: PX509_STORE;
  const AFileName, APathName: String): TIdC_INT;
var
  lookup: PX509_LOOKUP;
begin
  Result := 0;
  if AFileName <> '' then begin
    lookup := X509_STORE_add_lookup(ctx, Indy_Unicode_X509_LOOKUP_file);
    if Assigned(lookup) then begin
      if (X509_LOOKUP_load_file(lookup, PAnsiChar(@AFileName[1]),
          X509_FILETYPE_PEM) <> 1) then begin
        exit;
      end;
      Result := 1;
    end else begin
      exit;
    end;
  end;
  { To do:  Figure out how to do the hash dir lookup with Unicode. }
  if APathName <> '' then begin
    Result := X509_STORE_load_locations(ctx, nil, PAnsiChar(AnsiString(APathName)));
  end;
end;

function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IndyX509_STORE_load_locations(ctx^.cert_store, ACAFile, ACAPath);
end;

  {$ENDIF} // WINDOWS

  {$IFDEF UNIX}

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME;
begin
  Result := SSL_load_client_CA_file(PAnsiChar(UTF8String(AFileName)));
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_PrivateKey_file(ctx, PAnsiChar(UTF8String(AFileName)),
    AType) > 0;
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_certificate_file(ctx, PAnsiChar(UTF8String(AFileName)),
    AType) > 0;
end;

function IndyX509_STORE_load_locations(ctx: PX509_STORE;
  const AFileName, APathName: String): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // RLebeau 4/18/2010: X509_STORE_load_locations() expects nil pointers
  // for unused values, but casting a string directly to a PAnsiChar
  // always produces a non-nil pointer, which causes X509_STORE_load_locations()
  // to fail. Need to cast the string to an intermediate Pointer so the
  // PAnsiChar cast is applied to the raw data and thus can be nil...
  //
  Result := X509_STORE_load_locations(ctx,
    PAnsiChar(Pointer(UTF8String(AFileName))),
    PAnsiChar(Pointer(UTF8String(APathName))));
end;

function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IndyX509_STORE_load_locations(ctx^.cert_store, ACAFile, ACAPath);
end;

  {$ENDIF} // UNIX

{$ELSE} // STRING_IS_UNICODE

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_load_client_CA_file(PAnsiChar(AFileName));
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_PrivateKey_file(ctx, PAnsiChar(AFileName), AType) > 0;
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_certificate_file(ctx, PAnsiChar(AFileName), AType) > 0;
end;

function IndyX509_STORE_load_locations(ctx: PX509_STORE;
  const AFileName, APathName: String): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // RLebeau 4/18/2010: X509_STORE_load_locations() expects nil pointers
  // for unused values, but casting a string directly to a PAnsiChar
  // always produces a non-nil pointer, which causes X509_STORE_load_locations()
  // to fail. Need to cast the string to an intermediate Pointer so the
  // PAnsiChar cast is applied to the raw data and thus can be nil...
  //
  Result := X509_STORE_load_locations(ctx,
    PAnsiChar(Pointer(AFileName)),
    PAnsiChar(Pointer(APathName)));
end;

function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT;
begin
  // RLebeau 4/18/2010: X509_STORE_load_locations() expects nil pointers
  // for unused values, but casting a string directly to a PAnsiChar
  // always produces a non-nil pointer, which causes X509_STORE_load_locations()
  // to fail. Need to cast the string to an intermediate Pointer so the
  // PAnsiChar cast is applied to the raw data and thus can be nil...
  //
  Result := SSL_CTX_load_verify_locations(ctx,
    PAnsiChar(Pointer(ACAFile)),
    PAnsiChar(Pointer(ACAPath)));
end;

{$ENDIF}

function AddMins(const DT: TDateTime; const Mins: Extended): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := DT + Mins / (60 * 24)
end;

function AddHrs(const DT: TDateTime; const Hrs: Extended): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := DT + Hrs / 24.0;
end;

{$I IdDeprecatedImplBugOff.inc}
function GetLocalTime(const DT: TDateTime): TDateTime;
{$I IdDeprecatedImplBugOn.inc}
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := UTCTimeToLocalTime(DT);
end;

{$IFDEF OPENSSL_SET_MEMORY_FUNCS}

function IdMalloc(num: Cardinal): Pointer cdecl;
begin
  Result := AllocMem(num);
end;

function IdRealloc(addr: Pointer; num: Cardinal): Pointer cdecl;
begin
  Result := addr;
  ReallocMem(Result, num);
end;

procedure IdFree(addr: Pointer)cdecl;
begin
  FreeMem(addr);
end;

procedure IdSslCryptoMallocInit;
// replaces the actual alloc routines
// this is useful if you are using a memory manager that can report on leaks
// at shutdown time.
var
  r: Integer;
begin
  r := CRYPTO_set_mem_functions(@IdMalloc, @IdRealloc, @IdFree);
  Assert(r <> 0);
end;
{$ENDIF}

{$IFNDEF OPENSSL_NO_BIO}
procedure DumpCert(AOut: TStrings; AX509: PX509);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LMem: PBIO;
  LLen : TIdC_INT;
  LBufPtr : Pointer;
begin
  if Assigned(X509_print) then begin
    LMem := BIO_new(BIO_s_mem);
    try
      X509_print(LMem, AX509);
      LLen := BIO_get_mem_data( LMem, LBufPtr);
      if (LLen > 0) and Assigned(LBufPtr) then begin
        {
        We could have used RawToBytes() but that would have made a copy of the
        output buffer.
        }
        AOut.Text := TIdTextEncoding.UTF8.GetString( TIdBytes(LBufPtr^), 0, LLen);
      end;
    finally
      if Assigned(LMem) then begin
        BIO_free(LMem);
      end;
    end;
  end;
end;

{$ELSE}

procedure DumpCert(AOut: TStrings; AX509: PX509);
begin
end;

{$ENDIF}

{$IFNDEF WIN32_OR_WIN64}
procedure _threadid_func(id : PCRYPTO_THREADID) cdecl;
begin
  if Assigned(CRYPTO_THREADID_set_numeric) then begin
    CRYPTO_THREADID_set_numeric(id, TIdC_ULONG(CurrentThreadId));
  end;
end;

function _GetThreadID: TIdC_ULONG; cdecl;
begin
  // TODO: Verify how well this will work with fibers potentially running from
  // thread to thread or many on the same thread.
  Result := TIdC_ULONG(CurrentThreadId);
end;
{$ENDIF}

function LoadOpenSSLLibrary: Boolean;
begin
  Assert(SSLIsLoaded <> nil);
  SSLIsLoaded.Lock;
  try
    if SSLIsLoaded.Value then begin
      Result := True;
      exit;
    end;
    Result := IdSSLOpenSSLHeaders.Load;
    if not Result then begin
      exit;
    end;
{$IFDEF OPENSSL_SET_MEMORY_FUNCS}
    // has to be done before anything that uses memory
    IdSslCryptoMallocInit;
{$ENDIF}
    // required eg to encrypt a private key when writing
    OpenSSL_add_all_ciphers;
    OpenSSL_add_all_digests;
    InitializeRandom;
    // IdSslRandScreen;
    SSL_load_error_strings;
    // Successful loading if true
    Result := SSLeay_add_ssl_algorithms > 0;
    if not Result then begin
      exit;
    end;
    // Create locking structures, we need them for callback routines
    Assert(LockInfoCB = nil);
    LockInfoCB := TIdCriticalSection.Create;
    LockPassCB := TIdCriticalSection.Create;
    LockVerifyCB := TIdCriticalSection.Create;
    // Handle internal OpenSSL locking
    CallbackLockList := TThreadList.Create;
    PrepareOpenSSLLocking;
    CRYPTO_set_locking_callback(SslLockingCallback);
{$IFNDEF WIN32_OR_WIN64}
    if Assigned(CRYPTO_THREADID_set_callback) then begin
      CRYPTO_THREADID_set_callback( _threadid_func );
    end else begin
      CRYPTO_set_id_callback(_GetThreadID);
    end;
{$ENDIF}
    SSLIsLoaded.Value := True;
    Result := True;
  finally
    SSLIsLoaded.Unlock;
  end;
end;

procedure UnLoadOpenSSLLibrary;
// allow the user to call unload directly?
// will then need to implement reference count
var
  i: Integer;
begin
  // ssl was never loaded
  if LockInfoCB = nil then begin
    exit;
  end;
  CRYPTO_set_locking_callback(nil);
  IdSSLOpenSSLHeaders.Unload;
  FreeAndNil(LockInfoCB);
  FreeAndNil(LockPassCB);
  FreeAndNil(LockVerifyCB);
  if Assigned(CallbackLockList) then begin
    with CallbackLockList.LockList do
      try
        for i := 0 to Count - 1 do begin
          TObject(Items[i]).free;
        end;
        Clear;
      finally
        CallbackLockList.UnlockList;
      end;
    FreeAndNil(CallbackLockList);
  end;
  SSLIsLoaded.Value := False;
end;

procedure SslLockingCallback(mode, n: TIdC_INT; Afile: PAnsiChar;
  line: TIdC_INT)cdecl;
var
  Lock: TIdCriticalSection;
begin
  Assert(CallbackLockList <> nil);
  Lock := nil;

  with CallbackLockList.LockList do
    try
      if n < Count then begin
        Lock := TIdCriticalSection(Items[n]);
      end;
    finally
      CallbackLockList.UnlockList;
    end;
  Assert(Lock <> nil);
  if (mode and CRYPTO_LOCK) = CRYPTO_LOCK then begin
    Lock.Acquire;
  end else begin
    Lock.Release;
  end;
end;

procedure PrepareOpenSSLLocking;
var
  i, cnt: Integer;
  Lock: TIdCriticalSection;
begin
  with CallbackLockList.LockList do
    try
      cnt := _CRYPTO_num_locks;
      for i := 0 to cnt - 1 do begin
        Lock := TIdCriticalSection.Create;
        try
          Add(Lock);
        except
          Lock.free;
          raise ;
        end;
      end;
    finally
      CallbackLockList.UnlockList;
    end;
end;



// Note that I define UCTTime as  PASN1_STRING
function UTCTime2DateTime(UCTTime: PASN1_UTCTIME): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  year: Word;
  month: Word;
  day: Word;
  hour: Word;
  min: Word;
  sec: Word;
  tz_h: Integer;
  tz_m: Integer;
begin
  Result := 0;
  if UTC_Time_Decode(UCTTime, year, month, day, hour, min, sec, tz_h, tz_m) > 0 then begin
    Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, 0);
    AddMins(Result, tz_m);
    AddHrs(Result, tz_h);
    Result := GetLocalTime(Result);
  end;
end;

{
function RSACallback(sslSocket: PSSL; e: Integer; KeyLength: Integer):PRSA; cdecl;
const
  RSA: PRSA = nil;
var
  SSLSocket: TSSLWSocket;
  IdSSLSocket: TIdSSLSocket;
begin
  IdSSLSocket := TIdSSLSocket(IdSslGetAppData(sslSocket));

  if Assigned(IdSSLSocket) then begin
    IdSSLSocket.TriggerSSLRSACallback(KeyLength);
  end;

  Result := RSA_generate_key(KeyLength, RSA_F4, @RSAProgressCallback, ssl);
end;
}

function LogicalAnd(A, B: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (A and B) = B;
end;

function BytesToHexString(APtr: Pointer; ALen: Integer): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: PtrInt;
  LPtr: PByte;
begin
  Result := '';
  LPtr := PByte(APtr);
  for i := 0 to (ALen - 1) do begin
    if i <> 0 then begin
      Result := Result + ':'; { Do not Localize }
    end;
    Result := Result + IndyFormat('%.2x', [LPtr^]);
    Inc(LPtr);
  end;
end;

function MDAsString(const AMD: TIdSSLEVP_MD): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AMD.Length - 1 do begin
    if i <> 0 then begin
      Result := Result + ':'; { Do not Localize }
    end;
    Result := Result + IndyFormat('%.2x', [Byte(AMD.MD[i])]);
    { do not localize }
  end;
end;


procedure GetStateVars(const sslSocket: PSSL; AWhere, Aret: TIdC_INT; var VTypeStr, VMsg : String);
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  case AWhere of
    SSL_CB_ALERT :
    begin
      VTypeStr := IndyFormat( RSOSSLAlert,[SSL_alert_type_string_long(Aret)]);
      VMsg := String(SSL_alert_type_string_long(Aret));
    end;
    SSL_CB_READ_ALERT :
    begin
      VTypeStr := IndyFormat(RSOSSLReadAlert,[SSL_alert_type_string_long(Aret)]);
      VMsg := String( SSL_alert_desc_string_long(Aret));
    end;
    SSL_CB_WRITE_ALERT :
    begin
      VTypeStr := IndyFormat(RSOSSLWriteAlert,[SSL_alert_type_string_long(Aret)]);
      VMsg := String( SSL_alert_desc_string_long(Aret));
    end;
    SSL_CB_ACCEPT_LOOP :
    begin
      VTypeStr :=  RSOSSLAcceptLoop;
      VMsg := String( SSL_state_string_long(sslSocket));
    end;
    SSL_CB_ACCEPT_EXIT :
    begin
      if ARet < 0  then begin
        VTypeStr := RSOSSLAcceptError;
      end else begin
        if ARet = 0 then begin
          VTypeStr := RSOSSLAcceptFailed;
        end else begin
          VTypeStr := RSOSSLAcceptExit;
        end;
      end;
      VMsg := String( SSL_state_string_long(sslSocket) );
    end;
    SSL_CB_CONNECT_LOOP :
    begin
      VTypeStr := RSOSSLConnectLoop;
      VMsg := String( SSL_state_string_long(sslSocket) );
    end;
  SSL_CB_CONNECT_EXIT :
    begin
      if ARet < 0  then begin
        VTypeStr := RSOSSLConnectError;
      end else begin
        if ARet = 0 then begin
          VTypeStr := RSOSSLConnectFailed
        end else begin
          VTypeStr := RSOSSLConnectExit;
        end;
      end;
      VMsg := String( SSL_state_string_long(sslSocket) );
    end;
  SSL_CB_HANDSHAKE_START :
    begin
      VTypeStr :=  RSOSSLHandshakeStart;
      VMsg := String( SSL_state_string_long(sslSocket) );
    end;
  SSL_CB_HANDSHAKE_DONE :
    begin
      VTypeStr := RSOSSLHandshakeDone;
      VMsg := String( SSL_state_string_long(sslSocket) );
    end;
  end;
{var LW : TIdC_INT;
begin
  VMsg := '';
  LW := Awhere and (not SSL_ST_MASK);
  if (LW and SSL_ST_CONNECT) > 0 then begin
    VWhereStr :=   'SSL_connect:';
  end else begin
    if (LW and SSL_ST_ACCEPT) > 0 then begin
      VWhereStr := ' SSL_accept:';
    end else begin
      VWhereStr := '  undefined:';
    end;
  end;
//  IdSslStateStringLong
  if (Awhere and SSL_CB_LOOP) > 0 then begin
       VMsg := IdSslStateStringLong(sslSocket);
  end else begin
    if (Awhere and SSL_CB_ALERT) > 0 then begin
       if (Awhere and SSL_CB_READ > 0) then begin
         VWhereStr := VWhereStr + ' read:'+ IdSslAlertTypeStringLong(Aret);
       end else begin
         VWhereStr := VWhereStr + 'write:'+ IdSslAlertTypeStringLong(Aret);
       end;;
       VMsg := IdSslAlertDescStringLong(Aret);
    end else begin
       if (Awhere and SSL_CB_EXIT) > 0 then begin
         if ARet = 0 then begin

          VWhereStr := VWhereStr +'failed';
          VMsg := IdSslStateStringLong(sslSocket);
         end else begin
           if ARet < 0  then  begin
               VWhereStr := VWhereStr +'error';
               VMsg := IdSslStateStringLong(sslSocket);
           end;
         end;
       end;
    end;
  end;          }
end;

initialization
  Assert(SSLIsLoaded=nil);
  SSLIsLoaded := TIdThreadSafeBoolean.Create;
finalization
  UnLoadOpenSSLLibrary;
  //free the lock last as unload makes calls that use it
  FreeAndNil(SSLIsLoaded);
end.
