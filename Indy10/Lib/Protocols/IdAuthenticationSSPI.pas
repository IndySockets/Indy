{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13742: IdAuthenticationSSPI.pas
{
    Rev 1.3    6/11/2004 9:33:58 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.2    13.1.2004 ã. 17:26:06  DBondzhev
{ Added Domain property
}
{
{   Rev 1.1    4/12/2003 10:24:04 PM  GGrieve
{ Fix to Compile
}
{
{   Rev 1.0    11/14/2002 02:13:50 PM  JPMugaas
}
{

  Implementation of the NTLM authentication with SSPI

  Author: Alex Brainman
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

}

unit IdAuthenticationSSPI;
{$DEFINE SET_ENCRYPT_IN_FT_WITH_GETPROCADDRESS_FUDGE}

interface

uses
  IdAuthentication,
  Windows,
  SysUtils,
  IdSys,
  IdSSPI;

const
  SEC_E_OK                         = 0;
  SEC_E_INSUFFICIENT_MEMORY        = HRESULT($80090300);
  SEC_E_INVALID_HANDLE             = HRESULT($80090301);
  SEC_E_UNSUPPORTED_FUNCTION       = HRESULT($80090302);
  SEC_E_TARGET_UNKNOWN             = HRESULT($80090303);
  SEC_E_INTERNAL_ERROR             = HRESULT($80090304);
  SEC_E_SECPKG_NOT_FOUND           = HRESULT($80090305);
  SEC_E_NOT_OWNER                  = HRESULT($80090306);
  SEC_E_CANNOT_INSTALL             = HRESULT($80090307);
  SEC_E_INVALID_TOKEN              = HRESULT($80090308);
  SEC_E_CANNOT_PACK                = HRESULT($80090309);
  SEC_E_QOP_NOT_SUPPORTED          = HRESULT($8009030A);
  SEC_E_NO_IMPERSONATION           = HRESULT($8009030B);
  SEC_E_LOGON_DENIED               = HRESULT($8009030C);
  SEC_E_UNKNOWN_CREDENTIALS        = HRESULT($8009030D);
  SEC_E_NO_CREDENTIALS             = HRESULT($8009030E);
  SEC_E_MESSAGE_ALTERED            = HRESULT($8009030F);
  SEC_E_OUT_OF_SEQUENCE            = HRESULT($80090310);
  SEC_E_NO_AUTHENTICATING_AUTHORITY = HRESULT($80090311);
  SEC_I_CONTINUE_NEEDED            = HRESULT($00090312);
  SEC_I_COMPLETE_NEEDED            = HRESULT($00090313);
  SEC_I_COMPLETE_AND_CONTINUE      = HRESULT($00090314);
  SEC_I_LOCAL_LOGON                = HRESULT($00090315);
  SEC_E_BAD_PKGID                  = HRESULT($80090316);
  SEC_E_CONTEXT_EXPIRED            = HRESULT($80090317);
  SEC_E_INCOMPLETE_MESSAGE         = HRESULT($80090318);
  SEC_E_INCOMPLETE_CREDENTIALS     = HRESULT($80090320);
  SEC_E_BUFFER_TOO_SMALL           = HRESULT($80090321);
  SEC_I_INCOMPLETE_CREDENTIALS     = HRESULT($00090320);
  SEC_I_RENEGOTIATE                = HRESULT($00090321);
  SEC_E_WRONG_PRINCIPAL            = HRESULT($80090322);
  SEC_I_NO_LSA_CONTEXT             = HRESULT($00090323);
  SEC_E_TIME_SKEW                  = HRESULT($80090324);
  SEC_E_UNTRUSTED_ROOT             = HRESULT($80090325);
  SEC_E_ILLEGAL_MESSAGE            = HRESULT($80090326);
  SEC_E_CERT_UNKNOWN               = HRESULT($80090327);
  SEC_E_CERT_EXPIRED               = HRESULT($80090328);
  SEC_E_ENCRYPT_FAILURE            = HRESULT($80090329);
  SEC_E_DECRYPT_FAILURE            = HRESULT($80090330);
  SEC_E_ALGORITHM_MISMATCH         = HRESULT($80090331);
  SEC_E_SECURITY_QOS_FAILED        = HRESULT($80090332);

type

  ESSPIException = class(Exception)
  public
    class function GetErrorMessageByNo(aErrorNo: LongWord): string;
  public
    constructor CreateError(
      aFailedFuncName: string; anErrorNo: Longint = SEC_E_OK);
  end;

  ESSPIInterfaceInitFailed = class(ESSPIException);

  TSSPIInterface = class(TObject)
  private
    fLoadPending, fIsAvailable: Boolean;
    fPFunctionTable: PSecurityFunctionTableA;
    fDLLHandle: THandle;
    procedure releaseFunctionTable;
    procedure checkAvailable;
    function getFunctionTable: SecurityFunctionTableA;
  public
    class procedure RaiseIfError(
      aStatus: SECURITY_STATUS; aFunctionName: string);
    function IsAvailable: Boolean;
    property FunctionTable: SecurityFunctionTableA read getFunctionTable;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TSSPIPackage = class(TObject)
  private
    fPSecPkginfo: PSecPkgInfo;
    function getPSecPkgInfo: PSecPkgInfo;
    function getMaxToken: ULONG;
    function getName: string;
  public
    property MaxToken: ULONG read getMaxToken;
    property Name: string read getName;
  public
    constructor Create(aPSecPkginfo: PSecPkgInfo);
  end;

  TCustomSSPIPackage = class(TSSPIPackage)
  private
    fInfo: PSecPkgInfo;
  public
    constructor Create(aPkgName: string);
    destructor Destroy; override;
  end;

  TSSPINTLMPackage = class(TCustomSSPIPackage)
  public
    constructor Create;
  end;

  TSSPICredentialsUse = (scuInBound, scuOutBound, scuBoth);

  TSSPICredentials = class(TObject)
  private
    fPackage: TSSPIPackage;
    fHandle: CredHandle;
    fUse: TSSPICredentialsUse;
    fAcquired: Boolean;
    fExpiry: TimeStamp;
    function getHandle: PCredHandle;
    procedure setUse(aValue: TSSPICredentialsUse);
  protected
    procedure CheckAcquired;
    procedure CheckNotAcquired;
    procedure DoAcquire(pszPrincipal: PSEC_CHAR; pvLogonId, pAuthData: PVOID);
    procedure DoRelease; virtual;
  public
    procedure Release;
    property Package: TSSPIPackage read fPackage;
    property Handle: PCredHandle read getHandle;
    property Use: TSSPICredentialsUse read fUse write setUse;
    property Acquired: Boolean read fAcquired;
  public
    constructor Create(aPackage: TSSPIPackage);
    destructor Destroy; override;
  end;

  TSSPIWinNTCredentials = class(TSSPICredentials)
  protected
  public
    procedure Acquire(
      aUse: TSSPICredentialsUse); overload;
    procedure Acquire(
      aUse: TSSPICredentialsUse; aDomain,
      aUserName, aPassword: string); overload;
  end;

  TSSPIContext = class(TObject)
  private
    fCredentials: TSSPICredentials;
    fHandle: CtxtHandle;
    fHasHandle: Boolean;
    fExpiry: TimeStamp;
    function getHandle: PCtxtHandle;
    function getExpiry: TimeStamp;
    procedure updateHasContextAndCheckForError(
      const aFuncResult: SECURITY_STATUS; const aFuncName: string;
      const aErrorsToIgnore: array of SECURITY_STATUS);
  protected
    procedure CheckHasHandle;
    procedure CheckCredentials;
    function DoInitialize(
      aTokenSourceName: PChar;
      var aIn, aOut: SecBufferDesc;
      const errorsToIgnore: array of SECURITY_STATUS): SECURITY_STATUS;
    procedure DoRelease; virtual;
    function GetRequestedFlags: ULONG; virtual; abstract;
    procedure SetEstablishedFlags(aFlags: ULONG); virtual; abstract;
    function GetAuthenticated: Boolean; virtual; abstract;
    property HasHandle: Boolean read fHasHandle;
  public
    procedure Release;
    property Credentials: TSSPICredentials read fCredentials;
    property Handle: PCtxtHandle read getHandle;
    property Authenticated: Boolean read GetAuthenticated;
    property Expiry: TimeStamp read getExpiry;
  public
    constructor Create(aCredentials: TSSPICredentials);
    destructor Destroy; override;
  end;

  TCustomSSPIConnectionContext = class(TSSPIContext)
  private
    fStatus: SECURITY_STATUS;
    fOutBuffDesc, fInBuffDesc: SecBufferDesc;
    fInBuff: SecBuffer;
  protected
    procedure DoRelease; override;
    function GetAuthenticated: Boolean; override;
    function DoUpdateAndGenerateReply(
      var aIn, aOut: SecBufferDesc;
      const aErrorsToIgnore: array of SECURITY_STATUS
      ): SECURITY_STATUS; virtual; abstract;
  public
    function UpdateAndGenerateReply(
      const aFromPeerToken: string; var aToPeerToken: string): Boolean;
  public
    constructor Create(aCredentials: TSSPICredentials);
  end;

  TSSPIClientConnectionContext = class(TCustomSSPIConnectionContext)
  private
    fTargetName: string;
    fReqReguested, fReqEstablished: ULONG;
  protected
    function GetRequestedFlags: ULONG; override;
    procedure SetEstablishedFlags(aFlags: ULONG); override;
    function DoUpdateAndGenerateReply(
      var aIn, aOut: SecBufferDesc;
      const aErrorsToIgnore: array of SECURITY_STATUS
      ): SECURITY_STATUS; override;
  public
    function GenerateInitialChalenge(
      const aTargetName: string; var aToPeerToken: string): Boolean;
  public
    constructor Create(aCredentials: TSSPICredentials);
  end;

  TIndySSPINTLMClient = class(TObject)
  protected
    fNTLMPackage: TSSPINTLMPackage;
    fCredentials: TSSPIWinNTCredentials;
    fContext: TSSPIClientConnectionContext;
  public
    procedure SetCredentials(aDomain, aUserName, aPassword: string);
    procedure SetCredentialsAsCurrentUser;
    function InitAndBuildType1Message: string;
    function UpdateAndBuildType3Message(aServerType2Message: string): string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TIdSSPINTLMAuthentication = class(TIdAuthentication)
  protected
    FNTLMInfo: string;
    FSSPIClient: TIndySSPINTLMClient;
    procedure SetDomain(const Value: String);
    function GetDomain: String;
    procedure SetUserName(const Value: String); override;
    function GetSteps: Integer; override;
    function DoNext: TIdAuthWhatsNext; override;
  public
    constructor Create; override;
    destructor Destroy;override;
    function Authentication: string; override;
    function KeepAlive: Boolean; override;
    procedure Reset; override;
    property Domain: String read GetDomain write SetDomain;
  end;

implementation

uses
  IdGlobalCore,
  IdGlobal,
  IdGlobalProtocols,
  IdException,
  IdCoderMIME,
  IdResourceStringsProtocols,
  IdHeaderList;

var
  g: TSSPIInterface;

{ ESSPIException }

class function ESSPIException.GetErrorMessageByNo
  (aErrorNo: LongWord): string;
begin
  case HRESULT(aErrorNo) of
    SEC_E_OK: Result := RSHTTPSSPISuccess;
    SEC_E_INSUFFICIENT_MEMORY:
      Result := RSHTTPSSPINotEnoughMem;
    SEC_E_INVALID_HANDLE:
      Result := RSHTTPSSPIInvalidHandle;
    SEC_E_UNSUPPORTED_FUNCTION:
      Result := RSHTTPSSPIFuncNotSupported;
    SEC_E_TARGET_UNKNOWN:
      Result := RSHTTPSSPIUnknownTarget;
    SEC_E_INTERNAL_ERROR:
      Result := RSHTTPSSPIInternalError;
    SEC_E_SECPKG_NOT_FOUND:
      Result :=  RSHTTPSSPISecPackageNotFound;
    SEC_E_NOT_OWNER:
      Result := RSHTTPSSPINotOwner;
    SEC_E_CANNOT_INSTALL:
      Result := RSHTTPSSPIPackageCannotBeInstalled;
    SEC_E_INVALID_TOKEN:
      Result := RSHTTPSSPIInvalidToken;
    SEC_E_CANNOT_PACK:
      Result := RSHTTPSSPICannotPack;
    SEC_E_QOP_NOT_SUPPORTED:
      Result := RSHTTPSSPIQOPNotSupported;
    SEC_E_NO_IMPERSONATION:
      Result := RSHTTPSSPINoImpersonation;
    SEC_E_LOGON_DENIED:
      Result := RSHTTPSSPILoginDenied;
    SEC_E_UNKNOWN_CREDENTIALS:
      Result := RSHTTPSSPIUnknownCredentials;
    SEC_E_NO_CREDENTIALS:
      Result := RSHTTPSSPINoCredentials;
    SEC_E_MESSAGE_ALTERED:
      Result := RSHTTPSSPIMessageAltered;
    SEC_E_OUT_OF_SEQUENCE:
      Result := RSHTTPSSPIOutOfSequence;
    SEC_E_NO_AUTHENTICATING_AUTHORITY:
      Result := RSHTTPSSPINoAuthAuthority;
    SEC_I_CONTINUE_NEEDED:
      Result := RSHTTPSSPIContinueNeeded;
    SEC_I_COMPLETE_NEEDED:
      Result := RSHTTPSSPICompleteNeeded;
    SEC_I_COMPLETE_AND_CONTINUE:
      Result :=RSHTTPSSPICompleteContinueNeeded;
    SEC_I_LOCAL_LOGON:
      Result := RSHTTPSSPILocalLogin;
    SEC_E_BAD_PKGID:
      Result := RSHTTPSSPIBadPackageID;
    SEC_E_CONTEXT_EXPIRED:
      Result := RSHTTPSSPIContextExpired;
    SEC_E_INCOMPLETE_MESSAGE:
      Result := RSHTTPSSPIIncompleteMessage;
    SEC_E_INCOMPLETE_CREDENTIALS:
      Result := RSHTTPSSPIIncompleteCredentialNotInit;
    SEC_E_BUFFER_TOO_SMALL:
      Result := RSHTTPSSPIBufferTooSmall;

    SEC_I_INCOMPLETE_CREDENTIALS:
      Result := RSHTTPSSPIIncompleteCredentialsInit;
    SEC_I_RENEGOTIATE:
      Result := RSHTTPSSPIRengotiate;
    SEC_E_WRONG_PRINCIPAL:
      Result := RSHTTPSSPIWrongPrincipal;
    SEC_I_NO_LSA_CONTEXT:
      Result := RSHTTPSSPINoLSACode;
    SEC_E_TIME_SKEW:
      Result := RSHTTPSSPITimeScew;
    SEC_E_UNTRUSTED_ROOT:
      Result := RSHTTPSSPIUntrustedRoot;
    SEC_E_ILLEGAL_MESSAGE:
      Result := RSHTTPSSPIIllegalMessage;
    SEC_E_CERT_UNKNOWN:
      Result := RSHTTPSSPICertUnknown;
    SEC_E_CERT_EXPIRED:
      Result := RSHTTPSSPICertExpired;
    SEC_E_ENCRYPT_FAILURE:
      Result := RSHTTPSSPIEncryptionFailure;
    SEC_E_DECRYPT_FAILURE:
      Result := RSHTTPSSPIDecryptionFailure;
    SEC_E_ALGORITHM_MISMATCH:
      Result := RSHTTPSSPIAlgorithmMismatch;
    SEC_E_SECURITY_QOS_FAILED:
      Result := RSHTTPSSPISecurityQOSFailure;
  else
    Result := RSHTTPSSPIUnknwonError;
  end;
end;

constructor ESSPIException.CreateError
  (aFailedFuncName: string; anErrorNo: Longint = SEC_E_OK);
begin
  if anErrorNo = SEC_E_OK then
    inherited Create(aFailedFuncName)
  else
    inherited CreateFmt(
      RSHTTPSSPIErrorMsg,
      [aFailedFuncName, anErrorNo, anErrorNo, GetErrorMessageByNo(anErrorNo)]);
end;

{ TSSPIInterface }

procedure TSSPIInterface.releaseFunctionTable;
begin
  if fPFunctionTable <> nil then begin
    fPFunctionTable := nil;
  end;
end;

procedure TSSPIInterface.checkAvailable;
begin
  if not IsAvailable then
    raise ESSPIInterfaceInitFailed.Create(
      RSHTTPSSPIInterfaceInitFailed);
end;

function TSSPIInterface.getFunctionTable: SecurityFunctionTableA;
begin
  checkAvailable;
  Result := fPFunctionTable^;
end;

class procedure TSSPIInterface.RaiseIfError
  (aStatus: SECURITY_STATUS; aFunctionName: string);
begin
  if not SEC_SUCCESS(aStatus) then
    raise ESSPIException.CreateError(aFunctionName, aStatus);
end;

function TSSPIInterface.IsAvailable: Boolean;

  procedure loadDLL;
  const
    SECURITY_DLL_NT = 'security.dll';    {Do not translate}
    SECURITY_DLL_95 = 'secur32.dll';   {Do not translate}
    ENCRYPT_MESSAGE = 'EncryptMessage';   {Do not translate}
    DECRYPT_MESSAGE = 'DecryptMessage';    {Do not translate}
  var
    dllName: string;
    entrypoint: INIT_SECURITY_INTERFACE_A;
  begin
    fIsAvailable := False;
    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      { Windows95 SSPI dll }
      dllName := SECURITY_DLL_95
    else
      { WindowsNT & Windows2000 SSPI dll }
      dllName := SECURITY_DLL_NT;
    { load SSPI dll }
    fDLLHandle := LoadLibrary(@dllName[1]);
    if fDLLHandle > 0 then begin
      { get InitSecurityInterface entry point
        and call it to fetch SPPI function table}
      entrypoint := GetProcAddress(fDLLHandle, SECURITY_ENTRYPOINTA);
      fPFunctionTable := entrypoint;
      { let's see what SSPI functions are available
        and if we can continue on with the set }
      with fPFunctionTable^ do begin
        fIsAvailable :=
          Assigned(QuerySecurityPackageInfoA) and
          Assigned(FreeContextBuffer) and
          Assigned(DeleteSecurityContext) and
          Assigned(FreeCredentialHandle) and
          Assigned(AcquireCredentialsHandleA) and
          Assigned(InitializeSecurityContextA) and
        Assigned(AcceptSecurityContext) and
          Assigned(ImpersonateSecurityContext) and
          Assigned(RevertSecurityContext) and
          Assigned(QueryContextAttributesA) and
          Assigned(MakeSignature) and
          Assigned(VerifySignature);
{$IFDEF SET_ENCRYPT_IN_FT_WITH_GETPROCADDRESS_FUDGE}
        { fudge for Encrypt/DecryptMessage }
        if (not Assigned(EncryptMessage)) and (GetProcAddress(fDLLHandle, ENCRYPT_MESSAGE) <> nil) then
          EncryptMessage := GetProcAddress(fDLLHandle, ENCRYPT_MESSAGE);
        if (not Assigned(DecryptMessage)) and (GetProcAddress(fDLLHandle, DECRYPT_MESSAGE) <> nil) then
          DecryptMessage := GetProcAddress(fDLLHandle, DECRYPT_MESSAGE);
{$ENDIF}
      end;
    end;
  end;

begin
  if fIsAvailable then
    Result := True
  else begin
    if fLoadPending then begin
      releaseFunctionTable;
      loadDLL;
      fLoadPending := False;
    end;
    Result := fIsAvailable;
  end;
end;

constructor TSSPIInterface.Create;
begin
  inherited Create;
  fLoadPending := True;
  fIsAvailable := False;
  fPFunctionTable := nil;
end;

destructor TSSPIInterface.Destroy;
begin
  releaseFunctionTable;
  FreeLibrary(fDLLHandle);
  inherited Destroy;
end;

{ TSSPIPackage }

function TSSPIPackage.getPSecPkgInfo: PSecPkgInfo;
begin
  if fPSecPkginfo = nil then
    raise ESSPIException.Create(RSHTTPSSPINoPkgInfoSpecified);
  Result := fPSecPkginfo;
end;

function TSSPIPackage.getMaxToken: ULONG;
begin
  Result := getPSecPkgInfo^.cbMaxToken;
end;

function TSSPIPackage.getName: string;
begin
  Result := StrPas(getPSecPkgInfo^.Name);
end;

constructor TSSPIPackage.Create(aPSecPkginfo: PSecPkgInfo);
begin
  inherited Create;
  fPSecPkginfo := aPSecPkginfo;
end;

{ TCustomSSPIPackage }

constructor TCustomSSPIPackage.Create(aPkgName: string);
begin
  g.RaiseIfError(
    g.FunctionTable.QuerySecurityPackageInfoA(PChar(aPkgName), @fInfo),
    'QuerySecurityPackageInfoA');   {Do not translate}
  inherited Create(fInfo);
end;

destructor TCustomSSPIPackage.Destroy;
begin
  if fInfo <> nil then
    g.RaiseIfError(
      g.FunctionTable.FreeContextBuffer(fInfo), 'FreeContextBuffer');  {Do not translate}
  inherited Destroy;
end;

{ TSSPINTLMPackage }

constructor TSSPINTLMPackage.Create;
begin
  inherited Create(NTLMSP_NAME);
end;

{ TSSPICredentials }

procedure TSSPICredentials.CheckAcquired;
begin
  if not fAcquired then
    raise ESSPIException.Create(RSHTTPSSPINoCredentialHandle);
end;

procedure TSSPICredentials.CheckNotAcquired;
begin
  if fAcquired then
    raise ESSPIException.Create(
     RSHTTPSSPICanNotChangeCredentials);
end;

procedure TSSPICredentials.DoAcquire
  (pszPrincipal: PSEC_CHAR; pvLogonId, pAuthData: PVOID);
var
  cu: ULONG;
begin
  Release;
  case Use of
    scuInBound:
      cu := SECPKG_CRED_INBOUND;
    scuOutBound:
      cu := SECPKG_CRED_OUTBOUND;
    scuBoth:
      cu := SECPKG_CRED_BOTH;
  else
    raise ESSPIException.Create(RSHTTPSSPIUnknwonCredentialUse);
  end;
  g.RaiseIfError(
    g.FunctionTable.AcquireCredentialsHandleA(
    pszPrincipal, PSEC_CHAR(Package.Name), cu, pvLogonId, pAuthData, nil, nil,
    @fHandle, @fExpiry),
    'AcquireCredentialsHandleA');  {Do not translater}
  fAcquired := True;
end;

procedure TSSPICredentials.DoRelease;
begin
  g.RaiseIfError(
    g.FunctionTable.FreeCredentialHandle(@fHandle),
    'FreeCredentialHandle');      {Do not translate}
  SecInvalidateHandle(fHandle);
end;

procedure TSSPICredentials.Release;
begin
  if fAcquired then begin
    DoRelease;
    fAcquired := False;
  end;
end;

function TSSPICredentials.getHandle: PCredHandle;
begin
  CheckAcquired;
  Result := @fHandle;
end;

procedure TSSPICredentials.setUse(aValue: TSSPICredentialsUse);
begin
  if fUse <> aValue then begin
    CheckNotAcquired;
    fUse := aValue;
  end;
end;

constructor TSSPICredentials.Create(aPackage: TSSPIPackage);
begin
  inherited Create;
  fPackage := aPackage;
  fUse := scuOutBound;
  fAcquired := False;
end;

destructor TSSPICredentials.Destroy;
begin
  Release;
  inherited Destroy;
end;

{ TSSPIWinNTCredentials }

procedure TSSPIWinNTCredentials.Acquire(aUse: TSSPICredentialsUse);
begin
  Acquire(aUse, '', '', '');          {Do not translate}
end;

procedure TSSPIWinNTCredentials.Acquire
  (aUse: TSSPICredentialsUse; aDomain, aUserName, aPassword: string);
var
  ai: SEC_WINNT_AUTH_IDENTITY;
  pai: PVOID;
begin
  Use := aUse;
  if (Length(aDomain) > 0) and (Length(aUserName) > 0) then begin
    with ai do begin
      User := PChar(aUserName);
      UserLength := Length(aUserName);
      Domain := PChar(aDomain);
      DomainLength := Length(aDomain);
      Password := PChar(aPassword);
      PasswordLength := Length(aPassword);
      Flags := SEC_WINNT_AUTH_IDENTITY_ANSI;
    end;
    pai := @ai;
  end else
    pai := nil;
  DoAcquire(nil, nil, pai);
end;

{ TSSPIContext }

constructor TSSPIContext.Create(aCredentials: TSSPICredentials);
begin
  inherited Create;
  fCredentials := aCredentials;
  fHasHandle := False;
end;

destructor TSSPIContext.Destroy;
begin
  Release;
  inherited Destroy;
end;

procedure TSSPIContext.updateHasContextAndCheckForError(
  const aFuncResult: SECURITY_STATUS; const aFuncName: string;
  const aErrorsToIgnore: array of SECURITY_STATUS);
var
  doRaise: Boolean;
  i: Integer;
begin
  doRaise := not SEC_SUCCESS(aFuncResult);
  if doRaise then
    for i := Low(aErrorsToIgnore) to High(aErrorsToIgnore) do
      if aFuncResult = aErrorsToIgnore[i] then begin
        doRaise := False;
        break;
      end;
  if doRaise then
    raise ESSPIException.CreateError(aFuncName, aFuncResult);
  if not fHasHandle then
    fHasHandle := True;
end;

function TSSPIContext.DoInitialize
  (aTokenSourceName: PChar;
  var aIn, aOut: SecBufferDesc;
  const errorsToIgnore: array of SECURITY_STATUS): SECURITY_STATUS;
var
  tmp: PCtxtHandle;
  tmp2: PSecBufferDesc;
  r: ULONG;
begin
  if fHasHandle then begin
    tmp := @fHandle;
    tmp2 := @aIn;
  end else begin
    tmp := nil;
    tmp2 := nil;
  end;
  Result :=
    g.FunctionTable.InitializeSecurityContextA(
    Credentials.Handle, tmp, aTokenSourceName,
    GetRequestedFlags, 0, SECURITY_NATIVE_DREP, tmp2, 0,
    @fHandle, @aOut, @r, @fExpiry
    );
  updateHasContextAndCheckForError(
    Result, 'InitializeSecurityContextA', errorsToIgnore); {Do not translate}
  SetEstablishedFlags(r);
end;

procedure TSSPIContext.DoRelease;
begin
  g.RaiseIfError(
    g.FunctionTable.DeleteSecurityContext(@fHandle), 'DeleteSecurityContext'); {Do not translate}
end;

procedure TSSPIContext.Release;
begin
  if HasHandle then begin
    DoRelease;
    fHasHandle := False;
  end;
end;

procedure TSSPIContext.CheckHasHandle;
begin
  if not HasHandle then
    raise ESSPIException.Create(RSHTTPSSPINoCredentialHandle);
end;

procedure TSSPIContext.CheckCredentials;
begin
  if (not Assigned(Credentials)) or (not Credentials.Acquired) then
    raise ESSPIException.Create(RSHTTPSSPIDoAuquireCredentialHandle);
end;

function TSSPIContext.getExpiry: TimeStamp;
begin
  CheckHasHandle;
  Result := fExpiry;
end;

function TSSPIContext.getHandle: PCtxtHandle;
begin
  CheckHasHandle;
  Result := @fHandle;
end;

{ TCustomSSPIConnectionContext }

procedure TCustomSSPIConnectionContext.DoRelease;
begin
  inherited DoRelease;
  fStatus := SEC_E_INVALID_HANDLE; // just to put something other then SEC_E_OK
end;

function TCustomSSPIConnectionContext.GetAuthenticated: Boolean;
begin
  CheckHasHandle;
  Result := fStatus = SEC_E_OK;
end;

function TCustomSSPIConnectionContext.UpdateAndGenerateReply
  (const aFromPeerToken: string; var aToPeerToken: string): Boolean;
var
  fOutBuff: SecBuffer;
begin
  Result := False;
  { check credentials }
  CheckCredentials;
  { prepare input buffer }
  fInBuff.cbBuffer := Length(aFromPeerToken);
  //Assert(Length(aFromPeerToken)>0);
  if Length(aFromPeerToken)>0 then fInBuff.pvBuffer := @(aFromPeerToken[1]);

  { prepare output buffer }
  fOutBuff.BufferType := SECBUFFER_TOKEN;
  fOutBuff.cbBuffer := Credentials.Package.MaxToken;
  fOutBuff.pvBuffer := AllocMem(fOutBuff.cbBuffer);

  fOutBuffDesc.ulVersion := SECBUFFER_VERSION;
  fOutBuffDesc.cBuffers := 1;
  fOutBuffDesc.pBuffers := @fOutBuff;

  try
    { do processing }
    fStatus := DoUpdateAndGenerateReply(fInBuffDesc, fOutBuffDesc, []);
    { complete token if applicable }
    case fStatus of
      SEC_I_COMPLETE_NEEDED,
        SEC_I_COMPLETE_AND_CONTINUE:
        begin
          if not Assigned(g.FunctionTable.CompleteAuthToken) then
          begin
            raise ESSPIException.Create(RSHTTPSSPICompleteTokenNotSupported);
          end;
          fStatus := g.FunctionTable.CompleteAuthToken(Handle, @fOutBuffDesc);
          g.RaiseIfError(fStatus, 'CompleteAuthToken');   {Do not translate}
        end;
    end;
    Result :=
      (fStatus = SEC_I_CONTINUE_NEEDED) or
      (fStatus = SEC_I_COMPLETE_AND_CONTINUE) or
      (fOutBuff.cbBuffer > 0);
    if Result then
      with fOutBuff do
        SetString(aToPeerToken, PChar(pvBuffer), cbBuffer);
  finally
    FreeMem(fOutBuff.pvBuffer);
  end;
end;

constructor TCustomSSPIConnectionContext.Create(aCredentials: TSSPICredentials);
begin
  inherited Create(aCredentials);
  with fInBuff do begin
    BufferType := SECBUFFER_TOKEN;
  end;
  with fInBuffDesc do begin
    ulVersion := SECBUFFER_VERSION;
    cBuffers := 1;
    pBuffers := @fInBuff;
  end;
  with fOutBuffDesc do begin
    ulVersion := SECBUFFER_VERSION;
    cBuffers := 1;
  end;
end;

{ TSSPIClientConnectionContext }

constructor TSSPIClientConnectionContext.Create(aCredentials: TSSPICredentials);
begin
  inherited Create(aCredentials);
  fTargetName := '';   {Do not translate}
end;

function TSSPIClientConnectionContext.GetRequestedFlags: ULONG;
begin
  Result := fReqReguested;
end;

procedure TSSPIClientConnectionContext.SetEstablishedFlags(aFlags: ULONG);
begin
  fReqEstablished := aFlags;
end;

function TSSPIClientConnectionContext.DoUpdateAndGenerateReply
  (var aIn, aOut: SecBufferDesc;
  const aErrorsToIgnore: array of SECURITY_STATUS): SECURITY_STATUS;
begin
  Result := DoInitialize(PChar(fTargetName), aIn, aOut, []);
end;

function TSSPIClientConnectionContext.GenerateInitialChalenge
  (const aTargetName: string; var aToPeerToken: string): Boolean;
begin
  Release;
  fTargetName := aTargetName;
  Result := UpdateAndGenerateReply('', aToPeerToken);   {Do not translate}
end;

{ TIndySSPINTLMClient }

constructor TIndySSPINTLMClient.Create;
begin
  inherited Create;
  fNTLMPackage := TSSPINTLMPackage.Create;
  fCredentials := TSSPIWinNTCredentials.Create(fNTLMPackage);
  fContext := TSSPIClientConnectionContext.Create(fCredentials);
end;

destructor TIndySSPINTLMClient.Destroy;
begin
  Sys.FreeAndNil(fContext);
  Sys.FreeAndNil(fCredentials);
  Sys.FreeAndNil(fNTLMPackage);
  inherited Destroy;
end;

procedure TIndySSPINTLMClient.SetCredentials
  (aDomain, aUserName, aPassword: string);
begin
  fCredentials.Acquire(scuOutBound, aDomain, aUserName, aPassword);
end;

procedure TIndySSPINTLMClient.SetCredentialsAsCurrentUser;
begin
  fCredentials.Acquire(scuOutBound);
end;

function TIndySSPINTLMClient.InitAndBuildType1Message: string;
begin
  fContext.GenerateInitialChalenge('', Result);
end;

function TIndySSPINTLMClient.UpdateAndBuildType3Message
  (aServerType2Message: string): string;
begin
  fContext.UpdateAndGenerateReply(aServerType2Message, Result);
end;

{ TIdSSPINTLMAuthentication }

constructor TIdSSPINTLMAuthentication.Create;
begin
  inherited Create;
  FSSPIClient := TIndySSPINTLMClient.Create;
  Domain := IndyComputerName;
end;

function TIdSSPINTLMAuthentication.DoNext: TIdAuthWhatsNext;
begin
  result := wnDoRequest;
  case FCurrentStep of
    0:
      begin
        {if (Length(Username) > 0) and (Length(Password) > 0) then
        begin}
        result := wnDoRequest;
        FCurrentStep := 1;
        {end
        else begin
          result := wnAskTheProgram;
        end;}
      end;
    1:
      begin
        FCurrentStep := 2;
        result := wnDoRequest;
      end;
    //Authentication does the 2>3 progression
    3:
      begin
        FCurrentStep := 4;
        result := wnDoRequest;
      end;
    4:
      begin
        FCurrentStep := 0;
        If Username = '' then
          result := wnAskTheProgram
        else begin
        result := wnFail;
          Username := '';
          Password := '';
          Domain := IndyComputerName;
        end;
      end;
  end;
end;

function TIdSSPINTLMAuthentication.Authentication: string;
var
  S: string;
begin
  result := '';
  case FCurrentStep of
    1:
      begin
        if Length(Username) = 0 then
          FSSPIClient.SetCredentialsAsCurrentUser
        else
          FSSPIClient.SetCredentials(Domain, Username, Password);
        result := 'NTLM ' + TIdEncoderMIME.EncodeString(FSSPIClient.InitAndBuildType1Message);  {Do not translate}
        FNTLMInfo := '';    {Do not translate}
      end;
    2:
      begin
        if Length(FNTLMInfo) = 0 then
        begin
          FNTLMInfo := ReadAuthInfo('NTLM');  {Do not translate}
          Fetch(FNTLMInfo);
        end;

        if Length(FNTLMInfo) = 0 then
        begin
          Reset;
          Abort;
        end;

        S := TIdDecoderMIME.DecodeString(FNTLMInfo);
        result := 'NTLM ' + TIdEncoderMIME.EncodeString(FSSPIClient.UpdateAndBuildType3Message(S));  {Do not translate}
        FCurrentStep := 3;
      end;
    3: begin
        FCurrentStep := 4;
      end;
  end;
end;

procedure TIdSSPINTLMAuthentication.Reset;
begin
  inherited Reset;
  FCurrentStep := 0;
end;

function TIdSSPINTLMAuthentication.KeepAlive: Boolean;
begin
  result := FCurrentStep >= 1;
end;

function TIdSSPINTLMAuthentication.GetSteps: Integer;
begin
  result := 3;
end;

procedure TIdSSPINTLMAuthentication.SetDomain(const Value: String);
begin
  Params.Values['Domain'] := Value; {do not localize}
end;

function TIdSSPINTLMAuthentication.GetDomain: String;
begin
  result := Params.Values['Domain']; {do not localize}
end;

procedure TIdSSPINTLMAuthentication.SetUserName(const Value: String);
Var
  S: String;
begin
  S := Value;
  if IndyPos('\', S) > 0 then begin
    Domain := Copy(S, 1, IndyPos('\', S) - 1);
    Delete(S, 1, Length(Domain) + 1);
  end;

  inherited SetUserName(S);
end;

destructor TIdSSPINTLMAuthentication.Destroy;
begin
  Sys.FreeAndNil(FSSPIClient);
  inherited;
end;

initialization

  g := TSSPIInterface.Create;
  if g.IsAvailable then begin
    RegisterAuthenticationMethod('NTLM', TIdSSPINTLMAuthentication); {do not localize}
    RegisterAuthenticationMethod('Negotiate', TIdSSPINTLMAuthentication); {do not localize}
  end;

finalization

  if g.IsAvailable then begin
    UnregisterAuthenticationMethod('NTLM'); {do not localize}
    UnregisterAuthenticationMethod('Negotiate'); {do not localize}
  end;
  Sys.FreeAndNil(g);

end.

