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
    Rev 1.3    6/11/2004 9:33:58 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.2    13.1.2004 ã. 17:26:06  DBondzhev
  Added Domain property

  Rev 1.1    4/12/2003 10:24:04 PM  GGrieve
  Fix to Compile

  Rev 1.0    11/14/2002 02:13:50 PM  JPMugaas
}

unit IdAuthenticationSSPI;

{
  Implementation of the NTLM authentication with SSPI
  Author: Alex Brainman
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.
}

{$DEFINE SET_ENCRYPT_IN_FT_WITH_GETPROCADDRESS_FUDGE}

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdAuthentication,
  IdCoder,
  Windows,
  SysUtils,
  IdSSPI;

const
  SEC_E_OK                         = 0;
  {$EXTERNALSYM SEC_E_OK}
  SEC_E_INSUFFICIENT_MEMORY        = HRESULT($80090300);
  {$EXTERNALSYM SEC_E_INSUFFICIENT_MEMORY}
  SEC_E_INVALID_HANDLE             = HRESULT($80090301);
  {$EXTERNALSYM SEC_E_INVALID_HANDLE}
  SEC_E_UNSUPPORTED_FUNCTION       = HRESULT($80090302);
  {$EXTERNALSYM SEC_E_UNSUPPORTED_FUNCTION}
  SEC_E_TARGET_UNKNOWN             = HRESULT($80090303);
  {$EXTERNALSYM SEC_E_TARGET_UNKNOWN}
  SEC_E_INTERNAL_ERROR             = HRESULT($80090304);
  {$EXTERNALSYM SEC_E_INTERNAL_ERROR}
  SEC_E_SECPKG_NOT_FOUND           = HRESULT($80090305);
  {$EXTERNALSYM SEC_E_SECPKG_NOT_FOUND}
  SEC_E_NOT_OWNER                  = HRESULT($80090306);
  {$EXTERNALSYM SEC_E_NOT_OWNER}
  SEC_E_CANNOT_INSTALL             = HRESULT($80090307);
  {$EXTERNALSYM SEC_E_CANNOT_INSTALL}
  SEC_E_INVALID_TOKEN              = HRESULT($80090308);
  {$EXTERNALSYM SEC_E_INVALID_TOKEN}
  SEC_E_CANNOT_PACK                = HRESULT($80090309);
  {$EXTERNALSYM SEC_E_CANNOT_PACK}
  SEC_E_QOP_NOT_SUPPORTED          = HRESULT($8009030A);
  {$EXTERNALSYM SEC_E_QOP_NOT_SUPPORTED}
  SEC_E_NO_IMPERSONATION           = HRESULT($8009030B);
  {$EXTERNALSYM SEC_E_NO_IMPERSONATION}
  SEC_E_LOGON_DENIED               = HRESULT($8009030C);
  {$EXTERNALSYM SEC_E_LOGON_DENIED}
  SEC_E_UNKNOWN_CREDENTIALS        = HRESULT($8009030D);
  {$EXTERNALSYM SEC_E_UNKNOWN_CREDENTIALS}
  SEC_E_NO_CREDENTIALS             = HRESULT($8009030E);
  {$EXTERNALSYM SEC_E_NO_CREDENTIALS}
  SEC_E_MESSAGE_ALTERED            = HRESULT($8009030F);
  {$EXTERNALSYM SEC_E_MESSAGE_ALTERED}
  SEC_E_OUT_OF_SEQUENCE            = HRESULT($80090310);
  {$EXTERNALSYM SEC_E_OUT_OF_SEQUENCE}
  SEC_E_NO_AUTHENTICATING_AUTHORITY = HRESULT($80090311);
  {$EXTERNALSYM SEC_E_NO_AUTHENTICATING_AUTHORITY}
  SEC_I_CONTINUE_NEEDED            = HRESULT($00090312);
  {$EXTERNALSYM SEC_I_CONTINUE_NEEDED}
  SEC_I_COMPLETE_NEEDED            = HRESULT($00090313);
  {$EXTERNALSYM SEC_I_COMPLETE_NEEDED}
  SEC_I_COMPLETE_AND_CONTINUE      = HRESULT($00090314);
  {$EXTERNALSYM SEC_I_COMPLETE_AND_CONTINUE}
  SEC_I_LOCAL_LOGON                = HRESULT($00090315);
  {$EXTERNALSYM SEC_I_LOCAL_LOGON}
  SEC_E_BAD_PKGID                  = HRESULT($80090316);
  {$EXTERNALSYM SEC_E_BAD_PKGID}
  SEC_E_CONTEXT_EXPIRED            = HRESULT($80090317);
  {$EXTERNALSYM SEC_E_CONTEXT_EXPIRED}
  SEC_E_INCOMPLETE_MESSAGE         = HRESULT($80090318);
  {$EXTERNALSYM SEC_E_INCOMPLETE_MESSAGE}
  SEC_E_INCOMPLETE_CREDENTIALS     = HRESULT($80090320);
  {$EXTERNALSYM SEC_E_INCOMPLETE_CREDENTIALS}
  SEC_E_BUFFER_TOO_SMALL           = HRESULT($80090321);
  {$EXTERNALSYM SEC_E_BUFFER_TOO_SMALL}
  SEC_I_INCOMPLETE_CREDENTIALS     = HRESULT($00090320);
  {$EXTERNALSYM SEC_I_INCOMPLETE_CREDENTIALS}
  SEC_I_RENEGOTIATE                = HRESULT($00090321);
  {$EXTERNALSYM SEC_I_RENEGOTIATE}
  SEC_E_WRONG_PRINCIPAL            = HRESULT($80090322);
  {$EXTERNALSYM SEC_E_WRONG_PRINCIPAL}
  SEC_I_NO_LSA_CONTEXT             = HRESULT($00090323);
  {$EXTERNALSYM SEC_I_NO_LSA_CONTEXT}
  SEC_E_TIME_SKEW                  = HRESULT($80090324);
  {$EXTERNALSYM SEC_E_TIME_SKEW}
  SEC_E_UNTRUSTED_ROOT             = HRESULT($80090325);
  {$EXTERNALSYM SEC_E_UNTRUSTED_ROOT}
  SEC_E_ILLEGAL_MESSAGE            = HRESULT($80090326);
  {$EXTERNALSYM SEC_E_ILLEGAL_MESSAGE}
  SEC_E_CERT_UNKNOWN               = HRESULT($80090327);
  {$EXTERNALSYM SEC_E_CERT_UNKNOWN}
  SEC_E_CERT_EXPIRED               = HRESULT($80090328);
  {$EXTERNALSYM SEC_E_CERT_EXPIRED}
  SEC_E_ENCRYPT_FAILURE            = HRESULT($80090329);
  {$EXTERNALSYM SEC_E_ENCRYPT_FAILURE}
  SEC_E_DECRYPT_FAILURE            = HRESULT($80090330);
  {$EXTERNALSYM SEC_E_DECRYPT_FAILURE}
  SEC_E_ALGORITHM_MISMATCH         = HRESULT($80090331);
  {$EXTERNALSYM SEC_E_ALGORITHM_MISMATCH}
  SEC_E_SECURITY_QOS_FAILED        = HRESULT($80090332);
  {$EXTERNALSYM SEC_E_SECURITY_QOS_FAILED}
 
  SEC_E_UNFINISHED_CONTEXT_DELETED = HRESULT($80090333);
  {$EXTERNALSYM SEC_E_UNFINISHED_CONTEXT_DELETED}
  SEC_E_NO_TGT_REPLY               = HRESULT($80090334);
  {$EXTERNALSYM SEC_E_NO_TGT_REPLY}
  SEC_E_NO_IP_ADDRESSES            = HRESULT($80090335);
  {$EXTERNALSYM SEC_E_NO_IP_ADDRESSES}
  SEC_E_WRONG_CREDENTIAL_HANDLE    = HRESULT($80090336);
  {$EXTERNALSYM SEC_E_WRONG_CREDENTIAL_HANDLE}
  SEC_E_CRYPTO_SYSTEM_INVALID      = HRESULT($80090337);
  {$EXTERNALSYM SEC_E_CRYPTO_SYSTEM_INVALID}
  SEC_E_MAX_REFERRALS_EXCEEDED     = HRESULT($80090338);
  {$EXTERNALSYM SEC_E_MAX_REFERRALS_EXCEEDED}
  SEC_E_MUST_BE_KDC                = HRESULT($80090339);
  {$EXTERNALSYM SEC_E_MUST_BE_KDC}
  SEC_E_STRONG_CRYPTO_NOT_SUPPORTED = HRESULT($8009033A);
  {$EXTERNALSYM SEC_E_STRONG_CRYPTO_NOT_SUPPORTED}
  SEC_E_TOO_MANY_PRINCIPALS        = HRESULT($8009033B);
  {$EXTERNALSYM SEC_E_TOO_MANY_PRINCIPALS}
  SEC_E_NO_PA_DATA                 = HRESULT($8009033C);
  {$EXTERNALSYM SEC_E_NO_PA_DATA}
  SEC_E_PKINIT_NAME_MISMATCH       = HRESULT($8009033D);
  {$EXTERNALSYM SEC_E_PKINIT_NAME_MISMATCH}
  SEC_E_SMARTCARD_LOGON_REQUIRED   = HRESULT($8009033E);
  {$EXTERNALSYM SEC_E_SMARTCARD_LOGON_REQUIRED}
  SEC_E_SHUTDOWN_IN_PROGRESS       = HRESULT($8009033F);
  {$EXTERNALSYM SEC_E_SHUTDOWN_IN_PROGRESS}
  SEC_E_KDC_INVALID_REQUEST        = HRESULT($80090340);
  {$EXTERNALSYM SEC_E_KDC_INVALID_REQUEST}
  SEC_E_KDC_UNABLE_TO_REFER        = HRESULT($80090341);
  {$EXTERNALSYM SEC_E_KDC_UNABLE_TO_REFER}
  SEC_E_KDC_UNKNOWN_ETYPE          = HRESULT($80090342);
  {$EXTERNALSYM SEC_E_KDC_UNKNOWN_ETYPE}
  SEC_E_UNSUPPORTED_PREAUTH        = HRESULT($80090343);
  {$EXTERNALSYM SEC_E_UNSUPPORTED_PREAUTH}
  SEC_E_DELEGATION_REQUIRED        = HRESULT($80090345);
  {$EXTERNALSYM SEC_E_DELEGATION_REQUIRED}
  SEC_E_BAD_BINDINGS               = HRESULT($80090346);
  {$EXTERNALSYM SEC_E_BAD_BINDINGS}
  SEC_E_MULTIPLE_ACCOUNTS          = HRESULT($80090347);
  {$EXTERNALSYM SEC_E_MULTIPLE_ACCOUNTS}
  SEC_E_NO_KERB_KEY                = HRESULT($80090348);
  {$EXTERNALSYM SEC_E_NO_KERB_KEY}
  SEC_E_CERT_WRONG_USAGE           = HRESULT($80090349);
  {$EXTERNALSYM SEC_E_CERT_WRONG_USAGE}
  SEC_E_DOWNGRADE_DETECTED         = HRESULT($80090350);
  {$EXTERNALSYM SEC_E_DOWNGRADE_DETECTED}
  SEC_E_SMARTCARD_CERT_REVOKED     = HRESULT($80090351);
  {$EXTERNALSYM SEC_E_SMARTCARD_CERT_REVOKED}
  SEC_E_ISSUING_CA_UNTRUSTED       = HRESULT($80090352);
  {$EXTERNALSYM SEC_E_ISSUING_CA_UNTRUSTED}
  SEC_E_REVOCATION_OFFLINE_C       = HRESULT($80090353);
  {$EXTERNALSYM SEC_E_REVOCATION_OFFLINE_C}
  SEC_E_PKINIT_CLIENT_FAILURE      = HRESULT($80090354);
  {$EXTERNALSYM SEC_E_PKINIT_CLIENT_FAILURE}
  SEC_E_SMARTCARD_CERT_EXPIRED     = HRESULT($80090355);
  {$EXTERNALSYM SEC_E_SMARTCARD_CERT_EXPIRED}
  SEC_E_NO_S4U_PROT_SUPPORT        = HRESULT($80090356);
  {$EXTERNALSYM SEC_E_NO_S4U_PROT_SUPPORT}
  SEC_E_CROSSREALM_DELEGATION_FAILURE = HRESULT($80090357);
  {$EXTERNALSYM SEC_E_CROSSREALM_DELEGATION_FAILURE}
  SEC_E_REVOCATION_OFFLINE_KDC     = HRESULT($80090358);
  {$EXTERNALSYM SEC_E_REVOCATION_OFFLINE_KDC}
  SEC_E_ISSUING_CA_UNTRUSTED_KDC   = HRESULT($80090359);
  {$EXTERNALSYM SEC_E_ISSUING_CA_UNTRUSTED_KDC}
  SEC_E_KDC_CERT_EXPIRED           = HRESULT($8009035A);
  {$EXTERNALSYM SEC_E_KDC_CERT_EXPIRED}
  SEC_E_KDC_CERT_REVOKED           = HRESULT($8009035B);
  {$EXTERNALSYM SEC_E_KDC_CERT_REVOKED}
  SEC_I_SIGNATURE_NEEDED           = HRESULT($0009035C);
  {$EXTERNALSYM SEC_I_SIGNATURE_NEEDED}
  SEC_E_INVALID_PARAMETER          = HRESULT($8009035D);
  {$EXTERNALSYM SEC_E_INVALID_PARAMETER}
  SEC_E_DELEGATION_POLICY          = HRESULT($8009035E);
  {$EXTERNALSYM SEC_E_DELEGATION_POLICY}
  SEC_E_POLICY_NLTM_ONLY           = HRESULT($8009035F);
  {$EXTERNALSYM SEC_E_POLICY_NLTM_ONLY}
  SEC_I_NO_RENEGOTIATION           = HRESULT($00090360);
  {$EXTERNALSYM SEC_I_NO_RENEGOTIATION}
  SEC_E_NO_CONTEXT                 = HRESULT($80090361);
  {$EXTERNALSYM SEC_E_NO_CONTEXT}
  SEC_E_PKU2U_CERT_FAILURE         = HRESULT($80090362);
  {$EXTERNALSYM SEC_E_PKU2U_CERT_FAILURE}
  SEC_E_MUTUAL_AUTH_FAILED         = HRESULT($80090363);
  {$EXTERNALSYM SEC_E_MUTUAL_AUTH_FAILED}

type
  ESSPIException = class(Exception)
  public
    // Params must be in this order to avoid conflict with CreateHelp
    // constructor in CBuilder as CB does not differentiate constructors
    // by name as Delphi does
    constructor CreateError(const AErrorNo: Integer; const AFailedFuncName: string);
    //
    class function GetErrorMessageByNo(AErrorNo: UInt32): string;
  end;

  ESSPIInterfaceInitFailed = class(ESSPIException);

  { TSSPIInterface }

  TSSPIInterface = class(TObject)
  private
    fLoadPending, fIsAvailable: Boolean;
    fPFunctionTable: PSecurityFunctionTable;
    fDLLHandle: TIdLibHandle;
    procedure ReleaseFunctionTable;
    procedure CheckAvailable;
    function GetFunctionTable: SecurityFunctionTable;
  public
    class procedure RaiseIfError(aStatus: SECURITY_STATUS; const aFunctionName: string);
    function IsAvailable: Boolean;
    property FunctionTable: SecurityFunctionTable read GetFunctionTable;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { TSSPIPackages }

  TSSPIPackage = class(TObject)
  private
    fPSecPkginfo: PSecPkgInfo;
    function GetPSecPkgInfo: PSecPkgInfo;
    function GetMaxToken: ULONG;
    function GetName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF};
  public
    property MaxToken: ULONG read GetMaxToken;
    property Name: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF} read GetName;
  public
    constructor Create(aPSecPkginfo: PSecPkgInfo);
  end;

  TCustomSSPIPackage = class(TSSPIPackage)
  private
    fInfo: PSecPkgInfo;
  public
    constructor Create(const aPkgName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF});
    destructor Destroy; override;
  end;

  TSSPINTLMPackage = class(TCustomSSPIPackage)
  public
    constructor Create;
  end;

  { TSSPICredentials }

  TSSPICredentialsUse = (scuInBound, scuOutBound, scuBoth);

  TSSPICredentials = class(TObject)
  private
    fPackage: TSSPIPackage;
    fHandle: CredHandle;
    fUse: TSSPICredentialsUse;
    fAcquired: Boolean;
    fExpiry: TimeStamp;
    function GetHandle: PCredHandle;
    procedure SetUse(aValue: TSSPICredentialsUse);
  protected
    procedure CheckAcquired;
    procedure CheckNotAcquired;
    procedure DoAcquire(pszPrincipal: {$IFDEF SSPI_UNICODE}PSEC_WCHAR{$ELSE}PSEC_CHAR{$ENDIF}; pvLogonId, pAuthData: PVOID);
    procedure DoRelease; virtual;
  public
    procedure Release;
    property Package: TSSPIPackage read fPackage;
    property Handle: PCredHandle read GetHandle;
    property Use: TSSPICredentialsUse read fUse write SetUse;
    property Acquired: Boolean read fAcquired;
  public
    constructor Create(aPackage: TSSPIPackage);
    destructor Destroy; override;
  end;

  { TSSPIWinNTCredentials }

  TSSPIWinNTCredentials = class(TSSPICredentials)
  protected
  public
    procedure Acquire(aUse: TSSPICredentialsUse); overload;
    procedure Acquire(aUse: TSSPICredentialsUse;
      const aDomain, aUserName, aPassword: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF}); overload;
  end;

  { TSSPIContext }

  TSSPIContext = class(TObject)
  private
    fCredentials: TSSPICredentials;
    fHandle: CtxtHandle;
    fHasHandle: Boolean;
    fExpiry: TimeStamp;
    function GetHandle: PCtxtHandle;
    function GetExpiry: TimeStamp;
    procedure UpdateHasContextAndCheckForError(
      const aFuncResult: SECURITY_STATUS; const aFuncName: string;
      const aErrorsToIgnore: array of SECURITY_STATUS);
  protected
    procedure CheckHasHandle;
    procedure CheckCredentials;
    function DoInitialize(const aTokenSourceName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF};
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
    property Handle: PCtxtHandle read GetHandle;
    property Authenticated: Boolean read GetAuthenticated;
    property Expiry: TimeStamp read GetExpiry;
  public
    constructor Create(aCredentials: TSSPICredentials);
    destructor Destroy; override;
  end;

  { TSSPIConnectionContext }

  TCustomSSPIConnectionContext = class(TSSPIContext)
  private
    fStatus: SECURITY_STATUS;
    fOutBuffDesc, fInBuffDesc: SecBufferDesc;
    fInBuff: SecBuffer;
  protected
    procedure DoRelease; override;
    function GetAuthenticated: Boolean; override;
    function DoUpdateAndGenerateReply(var aIn, aOut: SecBufferDesc;
      const aErrorsToIgnore: array of SECURITY_STATUS
      ): SECURITY_STATUS; virtual; abstract;
  public
    constructor Create(ACredentials: TSSPICredentials);
    function UpdateAndGenerateReply(
      const aFromPeerToken: TIdBytes; var aToPeerToken: TIdBytes): Boolean;
  end;

  TSSPIClientConnectionContext = class(TCustomSSPIConnectionContext)
  private
    fTargetName: string;
    fReqReguested, fReqEstablished: ULONG;
  protected
    function GetRequestedFlags: ULONG; override;
    procedure SetEstablishedFlags(aFlags: ULONG); override;
    function DoUpdateAndGenerateReply(var aIn, aOut: SecBufferDesc;
      const aErrorsToIgnore: array of SECURITY_STATUS
      ): SECURITY_STATUS; override;
  public
    function GenerateInitialChallenge(const aTargetName: string;
      var aToPeerToken: TIdBytes): Boolean;
  public
    constructor Create(aCredentials: TSSPICredentials);
  end;

  TIndySSPINTLMClient = class(TObject)
  protected
    fNTLMPackage: TSSPINTLMPackage;
    fCredentials: TSSPIWinNTCredentials;
    fContext: TSSPIClientConnectionContext;
  public
    procedure SetCredentials(const aDomain, aUserName, aPassword: string);
    procedure SetCredentialsAsCurrentUser;
    function InitAndBuildType1Message: TIdBytes;
    function UpdateAndBuildType3Message(const aServerType2Message: TIdBytes): TIdBytes;
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
    destructor Destroy; override;
    function Authentication: string; override;
    function KeepAlive: Boolean; override;
    property Domain: String read GetDomain write SetDomain;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterAuthenticationMethod can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdAuthenticationSSPI"'}
  {$ENDIF}

implementation

uses
  IdGlobalCore,
  IdGlobalProtocols,
  IdException,
  IdCoderMIME,
  IdResourceStringsSSPI,
  IdHeaderList;

var
  gSSPIInterface: TSSPIInterface = nil;
  gAuthRegistered: Boolean = False;

{ ESSPIException }

class function ESSPIException.GetErrorMessageByNo(aErrorNo: UInt32): string;
begin
  case HRESULT(aErrorNo) of
    SEC_E_OK:
      Result := RSHTTPSSPISuccess;
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
    SEC_E_UNFINISHED_CONTEXT_DELETED :
      Result := RSHTTPSSPISecCtxWasDelBeforeUpdated;
    SEC_E_NO_TGT_REPLY :
      Result := RSHTTPSSPIClientNoTGTReply;
    SEC_E_NO_IP_ADDRESSES :
      Result := RSHTTPSSPILocalNoIPAddr;
    SEC_E_WRONG_CREDENTIAL_HANDLE :
      Result := RSHTTPSSPIWrongCredHandle;
    SEC_E_CRYPTO_SYSTEM_INVALID :
      Result := RSHTTPSSPICryptoSysInvalid;
    SEC_E_MAX_REFERRALS_EXCEEDED :
      Result := RSHTTPSSPIMaxTicketRef;
    SEC_E_MUST_BE_KDC :
      Result := RSHTTPSSPIMustBeKDC;
    SEC_E_STRONG_CRYPTO_NOT_SUPPORTED :
      Result := RSHTTPSSPIStrongCryptoNotSupported;
    SEC_E_TOO_MANY_PRINCIPALS :
      Result := RSHTTPSSPIKDCReplyTooManyPrincipals;
    SEC_E_NO_PA_DATA :
      Result := RSHTTPSSPINoPAData;
    SEC_E_PKINIT_NAME_MISMATCH :
      Result := RSHTTPSSPIPKInitNameMismatch;
    SEC_E_SMARTCARD_LOGON_REQUIRED :
      Result := RSHTTPSSPISmartcardLogonReq;
    SEC_E_SHUTDOWN_IN_PROGRESS :
      Result := RSHTTPSSPISysShutdownInProg;
    SEC_E_KDC_INVALID_REQUEST :
      Result := RSHTTPSSPIKDCInvalidRequest;
    SEC_E_KDC_UNABLE_TO_REFER :
      Result := RSHTTPSSPIKDCUnableToRefer;
    SEC_E_KDC_UNKNOWN_ETYPE :
      Result := RSHTTPSSPIKDCETypeUnknown;
    SEC_E_UNSUPPORTED_PREAUTH :
      Result := RSHTTPSSPIUnsupPreauth;
    SEC_E_DELEGATION_REQUIRED :
      Result := RSHTTPSSPIDeligationReq;
    SEC_E_BAD_BINDINGS :
      Result := RSHTTPSSPIBadBindings;
    SEC_E_MULTIPLE_ACCOUNTS :
      Result := RSHTTPSSPIMultipleAccounts;
    SEC_E_NO_KERB_KEY :
      Result := RSHTTPSSPINoKerbKey;
    SEC_E_CERT_WRONG_USAGE :
      Result := RSHTTPSSPICertWrongUsage;
    SEC_E_DOWNGRADE_DETECTED :
      Result := RSHTTPSSPIDowngradeDetected;
    SEC_E_SMARTCARD_CERT_REVOKED :
      Result := RSHTTPSSPISmartcardCertRevoked;
    SEC_E_ISSUING_CA_UNTRUSTED :
      Result := RSHTTPSSPIIssuingCAUntrusted;
    SEC_E_REVOCATION_OFFLINE_C :
      Result := RSHTTPSSPIRevocationOffline;
    SEC_E_PKINIT_CLIENT_FAILURE :
      Result := RSHTTPSSPIPKInitClientFailure;
    SEC_E_SMARTCARD_CERT_EXPIRED :
      Result := RSHTTPSSPISmartcardExpired;
    SEC_E_NO_S4U_PROT_SUPPORT :
      Result := RSHTTPSSPINoS4UProtSupport;
    SEC_E_CROSSREALM_DELEGATION_FAILURE :
      Result := RSHTTPSSPICrossRealmDeligationFailure;
    SEC_E_REVOCATION_OFFLINE_KDC :
      Result := RSHTTPSSPIRevocationOfflineKDC;
    SEC_E_ISSUING_CA_UNTRUSTED_KDC :
      Result := RSHTTPSSPICAUntrustedKDC;
    SEC_E_KDC_CERT_EXPIRED :
      Result := RSHTTPSSPIKDCCertExpired;
    SEC_E_KDC_CERT_REVOKED :
      Result := RSHTTPSSPIKDCCertRevoked;
    SEC_I_SIGNATURE_NEEDED :
      Result := RSHTTPSSPISignatureNeeded;
    SEC_E_INVALID_PARAMETER :
      Result := RSHTTPSSPIInvalidParameter;
    SEC_E_DELEGATION_POLICY :
      Result := RSHTTPSSPIDeligationPolicy;
    SEC_E_POLICY_NLTM_ONLY :
      Result := RSHTTPSSPIPolicyNTLMOnly;
    SEC_I_NO_RENEGOTIATION :
      Result := RSHTTPSSPINoRenegotiation;
    SEC_E_NO_CONTEXT :
      Result := RSHTTPSSPINoContext;
    SEC_E_PKU2U_CERT_FAILURE :
      Result := RSHTTPSSPIPKU2UCertFailure;
    SEC_E_MUTUAL_AUTH_FAILED :
      Result := RSHTTPSSPIMutualAuthFailed;
  else
    Result := RSHTTPSSPIUnknwonError;
  end;
end;

constructor ESSPIException.CreateError(const AErrorNo: Integer; const AFailedFuncName: string);
begin
  if AErrorNo = SEC_E_OK then begin
    inherited Create(AFailedFuncName);
  end else begin
    inherited CreateFmt(RSHTTPSSPIErrorMsg,
      [AFailedFuncName, AErrorNo, AErrorNo, GetErrorMessageByNo(AErrorNo)]);
  end;
end;

{ TSSPIInterface }

procedure TSSPIInterface.ReleaseFunctionTable;
begin
  if fPFunctionTable <> nil then begin
    fPFunctionTable := nil;
  end;
end;

procedure TSSPIInterface.CheckAvailable;
begin
  if not IsAvailable then begin
    raise ESSPIInterfaceInitFailed.Create(RSHTTPSSPIInterfaceInitFailed);
  end;
end;

function TSSPIInterface.GetFunctionTable: SecurityFunctionTable;
begin
  CheckAvailable;
  Result := fPFunctionTable^;
end;

class procedure TSSPIInterface.RaiseIfError(aStatus: SECURITY_STATUS;
  const aFunctionName: string);
begin
  if not SEC_SUCCESS(aStatus) then begin
    raise ESSPIException.CreateError(aStatus, aFunctionName);
  end;
end;

function TSSPIInterface.IsAvailable: Boolean;

  procedure LoadDLL;
  const
    SECURITY_DLL_NT = 'security.dll';    {Do not translate}
    SECURITY_DLL_95 = 'secur32.dll';   {Do not translate}
    ENCRYPT_MESSAGE = 'EncryptMessage';   {Do not translate}
    DECRYPT_MESSAGE = 'DecryptMessage';    {Do not translate}
  var
    dllName: string;
    entrypoint: INIT_SECURITY_INTERFACE;
  begin
    fIsAvailable := False;
    if IndyWindowsPlatform = VER_PLATFORM_WIN32_WINDOWS then
      { Windows95 SSPI dll }
      dllName := SECURITY_DLL_95
    else
      { WindowsNT & Windows2000 SSPI dll }
      dllName := SECURITY_DLL_NT;
    { load SSPI dll }
    //In Windows, you should use SafeLoadLibrary instead of the LoadLibrary API
    //call because LoadLibrary messes with the FPU control word.
    fDLLHandle := SafeLoadLibrary(dllName);
    if fDLLHandle <> IdNilHandle then begin
      { get InitSecurityInterface entry point
        and call it to fetch SPPI function table}
      entrypoint := GetProcAddress(fDLLHandle, SECURITY_ENTRYPOINT);
      fPFunctionTable := entrypoint();
      { let's see what SSPI functions are available
        and if we can continue on with the set }
      fIsAvailable :=
        Assigned({$IFDEF SSPI_UNICODE}fPFunctionTable^.QuerySecurityPackageInfoW{$ELSE}fPFunctionTable^.QuerySecurityPackageInfoA{$ENDIF}) and
        Assigned(fPFunctionTable^.FreeContextBuffer) and
        Assigned(fPFunctionTable^.DeleteSecurityContext) and
        Assigned(fPFunctionTable^.FreeCredentialsHandle) and
        Assigned({$IFDEF SSPI_UNICODE}fPFunctionTable^.AcquireCredentialsHandleW{$ELSE}fPFunctionTable^.AcquireCredentialsHandleA{$ENDIF}) and
        Assigned({$IFDEF SSPI_UNICODE}fPFunctionTable^.InitializeSecurityContextW{$ELSE}fPFunctionTable^.InitializeSecurityContextA{$ENDIF}) and
        Assigned(fPFunctionTable^.AcceptSecurityContext) and
        Assigned(fPFunctionTable^.ImpersonateSecurityContext) and
        Assigned(fPFunctionTable^.RevertSecurityContext) and
        Assigned({$IFDEF SSPI_UNICODE}fPFunctionTable^.QueryContextAttributesW{$ELSE}fPFunctionTable^.QueryContextAttributesA{$ENDIF}) and
        Assigned(fPFunctionTable^.MakeSignature) and
        Assigned(fPFunctionTable^.VerifySignature);
      {$IFDEF SET_ENCRYPT_IN_FT_WITH_GETPROCADDRESS_FUDGE}
      { fudge for Encrypt/DecryptMessage }
      if not Assigned(fPFunctionTable^.EncryptMessage) then begin
        fPFunctionTable^.EncryptMessage := GetProcAddress(fDLLHandle, ENCRYPT_MESSAGE);
      end;
      if not Assigned(fPFunctionTable^.DecryptMessage) then begin
        fPFunctionTable^.DecryptMessage := GetProcAddress(fDLLHandle, DECRYPT_MESSAGE);
      end;
      {$ENDIF}
    end;
  end;

begin
  if not fIsAvailable then begin
    if fLoadPending then begin
      ReleaseFunctionTable;
      LoadDLL;
      fLoadPending := False;
    end;
  end;
  Result := fIsAvailable;
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
  ReleaseFunctionTable;
  if fDLLHandle <> IdNilHandle then begin
    FreeLibrary(fDLLHandle);
    fDLLHandle := IdNilHandle;
  end;
  inherited Destroy;
end;

{ TSSPIPackage }

constructor TSSPIPackage.Create(aPSecPkginfo: PSecPkgInfo);
begin
  inherited Create;
  fPSecPkginfo := aPSecPkginfo;
end;

function TSSPIPackage.GetPSecPkgInfo: PSecPkgInfo;
begin
  if not Assigned(fPSecPkginfo) then begin
    raise ESSPIException.Create(RSHTTPSSPINoPkgInfoSpecified);
  end;
  Result := fPSecPkginfo;
end;

function TSSPIPackage.GetMaxToken: ULONG;
begin
  Result := GetPSecPkgInfo^.cbMaxToken;
end;

function TSSPIPackage.GetName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF};
begin
  Result := GetPSecPkgInfo^.Name;
end;

{ TCustomSSPIPackage }

constructor TCustomSSPIPackage.Create(const aPkgName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF});
begin
  gSSPIInterface.RaiseIfError(
    {$IFDEF SSPI_UNICODE}
    gSSPIInterface.FunctionTable.QuerySecurityPackageInfoW(PWideChar(aPkgName), @fInfo),
    'QuerySecurityPackageInfoW' {Do not translate}
    {$ELSE}
    gSSPIInterface.FunctionTable.QuerySecurityPackageInfoA(PAnsiChar(aPkgName), @fInfo),
    'QuerySecurityPackageInfoA' {Do not translate}
    {$ENDIF}
    );
  inherited Create(fInfo);
end;

destructor TCustomSSPIPackage.Destroy;
begin
  if fInfo <> nil then begin
    gSSPIInterface.RaiseIfError(
      gSSPIInterface.FunctionTable.FreeContextBuffer(fInfo), 'FreeContextBuffer');  {Do not localize}
  end;
  inherited Destroy;
end;

{ TSSPINTLMPackage }

constructor TSSPINTLMPackage.Create;
begin
  inherited Create(NTLMSP_NAME);
end;

{ TSSPICredentials }

constructor TSSPICredentials.Create(aPackage: TSSPIPackage);
begin
  inherited Create;
  fPackage := aPackage;
  fUse := scuOutBound;
  fAcquired := False;
end;

procedure TSSPICredentials.CheckAcquired;
begin
  if not fAcquired then begin
    raise ESSPIException.Create(RSHTTPSSPINoCredentialHandle);
  end;
end;

procedure TSSPICredentials.CheckNotAcquired;
begin
  if fAcquired then begin
    raise ESSPIException.Create(RSHTTPSSPICanNotChangeCredentials);
  end;
end;

procedure TSSPICredentials.DoAcquire
  (pszPrincipal: {$IFDEF SSPI_UNICODE}PSEC_WCHAR{$ELSE}PSEC_CHAR{$ENDIF}; pvLogonId, pAuthData: PVOID);
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
  gSSPIInterface.RaiseIfError(
    gSSPIInterface.FunctionTable.{$IFDEF SSPI_UNICODE}AcquireCredentialsHandleW{$ELSE}AcquireCredentialsHandleA{$ENDIF}(
    pszPrincipal, {$IFDEF SSPI_UNICODE}PSEC_WCHAR{$ELSE}PSEC_CHAR{$ENDIF}(Package.Name), cu, pvLogonId, pAuthData, nil, nil,
    @fHandle, @fExpiry),
    {$IFDEF SSPI_UNICODE}
    'AcquireCredentialsHandleW' {Do not translater}
    {$ELSE}
    'AcquireCredentialsHandleA' {Do not translater}
    {$ENDIF}
    );
  fAcquired := True;
end;

procedure TSSPICredentials.DoRelease;
begin
  gSSPIInterface.RaiseIfError(
    gSSPIInterface.FunctionTable.FreeCredentialsHandle(@fHandle),
    'FreeCredentialsHandle');      {Do not translate}
  SecInvalidateHandle(fHandle);
end;

procedure TSSPICredentials.Release;
begin
  if fAcquired then begin
    DoRelease;
    fAcquired := False;
  end;
end;

function TSSPICredentials.GetHandle: PCredHandle;
begin
  CheckAcquired;
  Result := @fHandle;
end;

procedure TSSPICredentials.SetUse(aValue: TSSPICredentialsUse);
begin
  if fUse <> aValue then begin
    CheckNotAcquired;
    fUse := aValue;
  end;
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

procedure TSSPIWinNTCredentials.Acquire(aUse: TSSPICredentialsUse;
  const aDomain, aUserName, aPassword: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF});
var
  ai: SEC_WINNT_AUTH_IDENTITY;
  pai: PVOID;
begin
  Use := aUse;
  if (Length(aDomain) > 0) and (Length(aUserName) > 0) then begin
    {$IFDEF SSPI_UNICODE}
    ai.User := PUSHORT(PWideChar(aUserName));
    ai.UserLength := Length(aUserName);
    ai.Domain := PUSHORT(PWideChar(aDomain));
    ai.DomainLength := Length(aDomain);
    ai.Password := PUSHORT(PWideChar(aPassword));
    ai.PasswordLength := Length(aPassword);
    ai.Flags := SEC_WINNT_AUTH_IDENTITY_UNICODE;
    {$ELSE}
    ai.User := PUCHAR(PAnsiChar(aUserName));
    ai.UserLength := Length(aUserName);
    ai.Domain := PUCHAR(PAnsiChar(aDomain));
    ai.DomainLength := Length(aDomain);
    ai.Password := PUCHAR(PAnsiChar(aPassword));
    ai.PasswordLength := Length(aPassword);
    ai.Flags := SEC_WINNT_AUTH_IDENTITY_ANSI;
    {$ENDIF}
    pai := @ai;
  end else
  begin
    pai := nil;
  end;
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

procedure TSSPIContext.UpdateHasContextAndCheckForError(
  const aFuncResult: SECURITY_STATUS; const aFuncName: string;
  const aErrorsToIgnore: array of SECURITY_STATUS);
var
  doRaise: Boolean;
  i: Integer;
begin
  doRaise := not SEC_SUCCESS(aFuncResult);
  if doRaise then begin
    for i := Low(aErrorsToIgnore) to High(aErrorsToIgnore) do begin
      if aFuncResult = aErrorsToIgnore[i] then begin
        doRaise := False;
        Break;
      end;
    end;
  end;
  if doRaise then begin
    raise ESSPIException.CreateError(aFuncResult, aFuncName);
  end;
  fHasHandle := True;
end;

function TSSPIContext.DoInitialize(const aTokenSourceName: {$IFDEF SSPI_UNICODE}TIdUnicodeString{$ELSE}AnsiString{$ENDIF};
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
    gSSPIInterface.FunctionTable.{$IFDEF SSPI_UNICODE}InitializeSecurityContextW{$ELSE}InitializeSecurityContextA{$ENDIF}(
    Credentials.Handle, tmp,
    {$IFDEF SSPI_UNICODE}PWideChar{$ELSE}PAnsiChar{$ENDIF}(aTokenSourceName),
    GetRequestedFlags, 0, SECURITY_NATIVE_DREP, tmp2, 0,
    @fHandle, @aOut, @r, @fExpiry
    );
  UpdateHasContextAndCheckForError(Result,
    {$IFDEF SSPI_UNICODE}'InitializeSecurityContextW'{$ELSE}'InitializeSecurityContextA'{$ENDIF}, {Do not translate}
    errorsToIgnore);
  SetEstablishedFlags(r);
end;

procedure TSSPIContext.DoRelease;
begin
  gSSPIInterface.RaiseIfError(
    gSSPIInterface.FunctionTable.DeleteSecurityContext(@fHandle), 'DeleteSecurityContext'); {Do not translate}
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
  if not HasHandle then begin
    raise ESSPIException.Create(RSHTTPSSPINoCredentialHandle);
  end;
end;

procedure TSSPIContext.CheckCredentials;
begin
  if (not Assigned(Credentials)) or (not Credentials.Acquired) then begin
    raise ESSPIException.Create(RSHTTPSSPIDoAuquireCredentialHandle);
  end;
end;

function TSSPIContext.GetExpiry: TimeStamp;
begin
  CheckHasHandle;
  Result := fExpiry;
end;

function TSSPIContext.GetHandle: PCtxtHandle;
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
  (const aFromPeerToken: TIdBytes; var aToPeerToken: TIdBytes): Boolean;
var
  fOutBuff: SecBuffer;
begin
  Result := False;

  { check credentials }
  CheckCredentials;
  { prepare input buffer }

  fInBuff.cbBuffer := Length(aFromPeerToken);

  //Assert(Length(aFromPeerToken)>0);
  if fInBuff.cbBuffer > 0 then begin
    fInBuff.pvBuffer := @aFromPeerToken[0];
  end;

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
          if not Assigned(gSSPIInterface.FunctionTable.CompleteAuthToken) then begin
            raise ESSPIException.Create(RSHTTPSSPICompleteTokenNotSupported);
          end;
          fStatus := gSSPIInterface.FunctionTable.CompleteAuthToken(Handle, @fOutBuffDesc);
          gSSPIInterface.RaiseIfError(fStatus, 'CompleteAuthToken');   {Do not translate}
        end;
    end;
    Result :=
      (fStatus = SEC_I_CONTINUE_NEEDED) or
      (fStatus = SEC_I_COMPLETE_AND_CONTINUE) or
      (fOutBuff.cbBuffer > 0);
    if Result then begin
      aToPeerToken := RawToBytes(fOutBuff.pvBuffer^, fOutBuff.cbBuffer);
    end;
  finally
    FreeMem(fOutBuff.pvBuffer);
  end;
end;

constructor TCustomSSPIConnectionContext.Create(aCredentials: TSSPICredentials);
begin
  inherited Create(aCredentials);

  fInBuff.BufferType := SECBUFFER_TOKEN;

  fInBuffDesc.ulVersion := SECBUFFER_VERSION;
  fInBuffDesc.cBuffers := 1;
  fInBuffDesc.pBuffers := @fInBuff;

  fOutBuffDesc.ulVersion := SECBUFFER_VERSION;
  fOutBuffDesc.cBuffers := 1;
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
  Result := DoInitialize(fTargetName, aIn, aOut, []);
end;

function TSSPIClientConnectionContext.GenerateInitialChallenge
  (const aTargetName: string; var aToPeerToken: TIdBytes): Boolean;
begin
  Release;
  fTargetName := aTargetName;
  Result := UpdateAndGenerateReply(nil, aToPeerToken);   {Do not translate}
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
  FreeAndNil(fContext);
  FreeAndNil(fCredentials);
  FreeAndNil(fNTLMPackage);
  inherited Destroy;
end;

procedure TIndySSPINTLMClient.SetCredentials(const aDomain, aUserName, aPassword: string);
begin
  fCredentials.Acquire(scuOutBound, aDomain, aUserName, aPassword);
end;

procedure TIndySSPINTLMClient.SetCredentialsAsCurrentUser;
begin
  fCredentials.Acquire(scuOutBound);
end;

function TIndySSPINTLMClient.InitAndBuildType1Message: TIdBytes;
begin
  fContext.GenerateInitialChallenge('', Result);
end;

function TIndySSPINTLMClient.UpdateAndBuildType3Message(const aServerType2Message: TIdBytes): TIdBytes;
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
  Result := wnDoRequest;
  case FCurrentStep of
    //Authentication() does the 2>3 progression
    0, 1, 3:
      begin
        Inc(FCurrentStep);
        Result := wnDoRequest;
      end;
    4:
      begin
        FCurrentStep := 0;
        if Username = '' then begin
          Result := wnAskTheProgram;
        end else begin
          Result := wnFail;
          Username := '';
          Password := '';
          Domain := IndyComputerName;
        end;
      end;
  end;
end;

function TIdSSPINTLMAuthentication.Authentication: string;
var
  buf: TIdBytes;
begin
  Result := '';
  buf := nil;
  case FCurrentStep of
    1:
      begin
        if Length(Username) = 0 then begin
          FSSPIClient.SetCredentialsAsCurrentUser;
        end else begin
          FSSPIClient.SetCredentials(Domain, Username, Password);
        end;
        Result := 'NTLM ' + TIdEncoderMIME.EncodeBytes(FSSPIClient.InitAndBuildType1Message);  {Do not translate}
        FNTLMInfo := '';    {Do not translate}
      end;
    2:
      begin
        if Length(FNTLMInfo) = 0 then begin
          FNTLMInfo := ReadAuthInfo('NTLM');  {Do not translate}
          Fetch(FNTLMInfo);
        end;

        if Length(FNTLMInfo) = 0 then begin
          Reset;
          Abort;
        end;

        buf := TIdDecoderMIME.DecodeBytes(FNTLMInfo);
        Result := 'NTLM ' + TIdEncoderMIME.EncodeBytes(FSSPIClient.UpdateAndBuildType3Message(buf));  {Do not translate}

        FCurrentStep := 3;
      end;
    3: begin
        FCurrentStep := 4;
      end;
  end;
end;

function TIdSSPINTLMAuthentication.KeepAlive: Boolean;
begin
  Result := FCurrentStep >= 1;
end;

function TIdSSPINTLMAuthentication.GetSteps: Integer;
begin
  Result := 3;
end;

procedure TIdSSPINTLMAuthentication.SetDomain(const Value: String);
begin
  Params.Values['Domain'] := Value; {do not localize}
end;

function TIdSSPINTLMAuthentication.GetDomain: String;
begin
  Result := Params.Values['Domain']; {do not localize}
end;

procedure TIdSSPINTLMAuthentication.SetUserName(const Value: String);
var
  S: String;
  Idx: Integer;
begin
  S := Value;
  Idx := IndyPos('\', S);
  if Idx > 0 then begin
    Domain := Copy(S, 1, Idx - 1);
    Delete(S, 1, Idx);
  end;
  inherited SetUserName(S);
end;

destructor TIdSSPINTLMAuthentication.Destroy;
begin
  FreeAndNil(FSSPIClient);
  inherited;
end;

initialization
  gSSPIInterface := TSSPIInterface.Create;
  if gSSPIInterface.IsAvailable then begin
    RegisterAuthenticationMethod('NTLM', TIdSSPINTLMAuthentication); {do not localize}
    RegisterAuthenticationMethod('Negotiate', TIdSSPINTLMAuthentication); {do not localize}
    gAuthRegistered := True;
  end;
finalization
  if gAuthRegistered then begin
    UnregisterAuthenticationMethod('NTLM'); {do not localize}
    UnregisterAuthenticationMethod('Negotiate'); {do not localize}
  end;
  FreeAndNil(gSSPIInterface);

end.

