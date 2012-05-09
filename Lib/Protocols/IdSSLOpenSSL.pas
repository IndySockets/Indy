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
  Rev 1.40    03/11/2009 09:04:00  AWinkelsdorf
  Implemented fix for Vista+ SSL_Read and SSL_Write to allow connection
  timeout.

  Rev 1.39    16/02/2005 23:26:08  CCostelloe
  Changed OnVerifyPeer.  Breaks existing implementation of OnVerifyPeer.  See
  long comment near top of file.

  Rev 1.38    1/31/05 6:02:28 PM  RLebeau
  Updated _GetThreadId() callback to reflect changes in IdGlobal unit

  Rev 1.37    7/27/2004 1:54:26 AM  JPMugaas
  Now should use the Intercept property for sends.

  Rev 1.36    2004-05-18 21:38:36  Mattias
  Fixed unload bug

  Rev 1.35    2004-05-07 16:34:26  Mattias
  Implemented  OpenSSL locking callbacks

  Rev 1.34    27/04/2004 9:38:48  HHariri
  Added compiler directive so it works in BCB

  Rev 1.33    4/26/2004 12:41:10 AM  BGooijen
  Fixed WriteDirect

  Rev 1.32    2004.04.08 10:55:30 PM  czhower
  IOHandler changes.

  Rev 1.31    3/7/2004 9:02:58 PM  JPMugaas
  Fixed compiler warning about visibility.

  Rev 1.30    2004.03.07 11:46:40 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.29    2/7/2004 5:50:50 AM  JPMugaas
  Fixed Copyright.

  Rev 1.28    2/6/2004 3:45:56 PM  JPMugaas
  Only a start on NET porting.  This is not finished and will not compile on
  DotNET>

  Rev 1.27    2004.02.03 5:44:24 PM  czhower
  Name changes

  Rev 1.26    1/21/2004 4:03:48 PM  JPMugaas
  InitComponent

  Rev 1.25    1/14/2004 11:39:10 AM  JPMugaas
  Server IOHandler now works.  Accept was commented out.

  Rev 1.24    2003.11.29 10:19:28 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.23    10/21/2003 10:09:14 AM  JPMugaas
  Intercept enabled.

  Rev 1.22    10/21/2003 09:41:38 AM  JPMugaas
  Updated for new API.  Verified with TIdFTP with active and passive transfers
  as well as clear and protected data channels.

  Rev 1.21    10/21/2003 07:32:38 AM  JPMugaas
  Checked in what I have.  Porting still continues.

  Rev 1.20    10/17/2003 1:08:08 AM  DSiders
  Added localization comments.

  Rev 1.19    2003.10.12 6:36:44 PM  czhower
  Now compiles.

  Rev 1.18    9/19/2003 11:24:58 AM  JPMugaas
  Should compile.

  Rev 1.17    9/18/2003 10:20:32 AM  JPMugaas
  Updated for new API.

  Rev 1.16    2003.07.16 3:26:52 PM  czhower
  Fixed for a core change.

  Rev 1.15    6/30/2003 1:52:22 PM  BGooijen
  Changed for new buffer interface

  Rev 1.14    6/29/2003 5:42:02 PM  BGooijen
  fixed problem in TIdSSLIOHandlerSocketOpenSSL.SetPassThrough that Henrick
  Hellstrom reported

  Rev 1.13    5/7/2003 7:13:00 PM  BGooijen
  changed Connected to BindingAllocated in ReadFromSource

  Rev 1.12    3/30/2003 12:16:40 AM  BGooijen
  bugfixed+ added MakeFTPSvrPort/MakeFTPSvrPasv

  Rev 1.11    3/14/2003 06:56:08 PM  JPMugaas
  Added a clone method to the SSLContext.

  Rev 1.10    3/14/2003 05:29:10 PM  JPMugaas
  Change to prevent an AV when shutting down the FTP Server.

  Rev 1.9    3/14/2003 10:00:38 PM  BGooijen
  Removed TIdServerIOHandlerSSLBase.PeerPassthrough, the ssl is now enabled in
  the server-protocol-files

  Rev 1.8    3/13/2003 11:55:38 AM  JPMugaas
  Updated registration framework to give more information.

  Rev 1.7    3/13/2003 11:07:14 AM  JPMugaas
  OpenSSL classes renamed.

  Rev 1.6    3/13/2003 10:28:16 AM  JPMugaas
  Forgot the reegistration - OOPS!!!

  Rev 1.5    3/13/2003 09:49:42 AM  JPMugaas
  Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
  can plug-in their products.

  Rev 1.4    3/13/2003 10:20:08 AM  BGooijen
  Server side fibers

  Rev 1.3    2003.02.25 3:56:22 AM  czhower

  Rev 1.2    2/5/2003 10:27:46 PM  BGooijen
  Fixed bug in OpenEncodedConnection

  Rev 1.1    2/4/2003 6:31:22 PM  BGooijen
  Fixed for Indy 10

  Rev 1.0    11/13/2002 08:01:24 AM  JPMugaas
}
unit IdSSLOpenSSL;
{
  Author: Gregor Ibic (gregor.ibic@intelicom.si)
  Copyright: (c) Gregor Ibic, Intelicom d.o.o and Indy Working Group.
}

{
  Indy OpenSSL now uses the standard OpenSSL libraries
    for pre-compiled win32 dlls, see:
    http://www.openssl.org/related/binaries.html
    recommended v0.9.8a or later
}

{
  Important information concerning OnVerifyPeer:
    Rev 1.39 of February 2005 deliberately broke the OnVerifyPeer interface,
    which (obviously?) only affects programs that implemented that callback
    as part of the SSL negotiation.  Note that you really should always
    implement OnVerifyPeer, otherwise the certificate of the peer you are
    connecting to is NOT checked to ensure it is valid.

    Prior to this, if the SSL library detected a problem with a certificate
    or the Depth was insufficient (i.e. the "Ok" parameter in VerifyCallback
    is 0 / FALSE), then irrespective of whether your OnVerifyPeer returned True
    or False, the SSL connection would be deliberately failed.

    This created a problem in that even if there was only a very minor
    problem with one of the certificates in the chain (OnVerifyPeer is called
    once for each certificate in the certificate chain), which the user may
    have been happy to accept, the SSL negotiation would be failed.  However,
    changing the code to allow the SSL connection when a user returned True
    for OnVerifyPeer would have meant that existing code which depended on
    automatic rejection of invalid certificates would then be accepting
    invalid certificates, which would have been an unacceptable security
    change.

    Consequently, OnVerifyPeer was changed to deliberately break existing code
    by adding an AOk parameter.  To preserve the previous functionality, your
    OnVerifyPeer event should do "Result := AOk;".  If you wish to consider
    accepting certificates that the SSL library has considered invalid, then
    in your OnVerifyPeer, make sure you satisfy yourself that the certificate
    really is valid and then set Result to True.  In reality, in addition to
    checking AOk, you should always implement code that ensures you are only
    accepting certificates which are valid (at least from your point of view).

    Ciaran Costelloe, ccostelloe@flogas.ie
}
{
RLebeau 1/12/2011: Breaking OnVerifyPeer event again, this time to add an
additional AError parameter (patch courtesy of "jvlad", dmda@yandex.ru).
This helps user code distinquish between Self-signed and invalid certificates.
}

interface

{$I IdCompilerDefines.inc}

{$IFNDEF USE_OPENSSL}
  {$message error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}

{$TYPEDADDRESS OFF}

uses
  //facilitate inlining only.
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  Classes,
  IdBuffer,
  IdCTypes,
  IdGlobal,
  IdException,
  IdStackConsts,
  IdSocketHandle,
  IdSSLOpenSSLHeaders,
  IdComponent,
  IdIOHandler,
  IdGlobalProtocols,
  IdTCPServer,
  IdThread,
  IdTCPConnection,
  IdIntercept,
  IdIOHandlerSocket,
  IdSSL,
  IdSocks,
  IdScheduler,
  IdYarn;

type
  TIdSSLVersion = (sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2);
  TIdSSLVersions = set of TIdSSLVersion;
  TIdSSLMode = (sslmUnassigned, sslmClient, sslmServer, sslmBoth);
  TIdSSLVerifyMode = (sslvrfPeer, sslvrfFailIfNoPeerCert, sslvrfClientOnce);
  TIdSSLVerifyModeSet = set of TIdSSLVerifyMode;
  TIdSSLCtxMode = (sslCtxClient, sslCtxServer);
  TIdSSLAction = (sslRead, sslWrite);

const
  DEF_SSLVERSION = sslvTLSv1;
  DEF_SSLVERSIONS = [sslvTLSv1];

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
    Length: TIdC_UINT;
    Data: PAnsiChar; // RLebeau: should be PByte, but not all Delphi versions support indexed access using PByte
  end;

  TIdX509 = class;
  TIdSSLIOHandlerSocketOpenSSL = class;
  TIdSSLCipher = class;
  TCallbackEvent  = procedure(const AMsg: String) of object;
  TCallbackExEvent = procedure(ASender : TObject; const AsslSocket: PSSL;
    const AWhere, Aret: TIdC_INT; const AType, AMsg : String ) of object;
  TPasswordEvent  = procedure(var Password: AnsiString) of object;
  TPasswordEventEx = procedure( ASender : TObject; var VPassword: AnsiString; const AIsWrite : Boolean) of object;
  TVerifyPeerEvent  = function(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean of object;
  TIOHandlerNotify = procedure(ASender: TIdSSLIOHandlerSocketOpenSSL) of object;

  TIdSSLOptions = class(TPersistent)
  protected
    fsRootCertFile,
    fsCertFile,
    fsKeyFile,
    fsDHParamsFile: String;
    fMethod: TIdSSLVersion;
    fSSLVersions : TIdSSLVersions;
    fMode: TIdSSLMode;
    fVerifyDepth: Integer;
    fVerifyMode: TIdSSLVerifyModeSet;
    //fVerifyFile,
    fVerifyDirs: String;
    fCipherList: AnsiString;
    procedure AssignTo(ASource: TPersistent); override;
    procedure SetSSLVersions(const AValue : TIdSSLVersions);
    procedure SetMethod(const AValue : TIdSSLVersion);
  public
    constructor Create;
    // procedure Assign(ASource: TPersistent); override;
  published
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property CertFile: String read fsCertFile write fsCertFile;
    property KeyFile: String read fsKeyFile write fsKeyFile;
    property DHParamsFile: String read fsDHParamsFile write fsDHParamsFile;
    property Method: TIdSSLVersion read fMethod write SetMethod default DEF_SSLVERSION;
    property SSLVersions : TIdSSLVersions read fSSLVersions write SetSSLVersions default DEF_SSLVERSIONS;
    property Mode: TIdSSLMode read fMode write fMode;
    property VerifyMode: TIdSSLVerifyModeSet read fVerifyMode write fVerifyMode;
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;
//    property VerifyFile: String read fVerifyFile write fVerifyFile;
    property VerifyDirs: String read fVerifyDirs write fVerifyDirs;
    property CipherList: AnsiString read fCipherList write fCipherList;
  end;

  TIdSSLContext = class(TObject)
  protected
    fMethod: TIdSSLVersion;
    fSSLVersions : TIdSSLVersions;
    fMode: TIdSSLMode;
    fsRootCertFile, fsCertFile, fsKeyFile, fsDHParamsFile: String;
    fVerifyDepth: Integer;
    fVerifyMode: TIdSSLVerifyModeSet;
//    fVerifyFile: String;
    fVerifyDirs: String;
    fCipherList: AnsiString;
    fContext: PSSL_CTX;
    fStatusInfoOn: Boolean;
//    fPasswordRoutineOn: Boolean;
    fVerifyOn: Boolean;
    fSessionId: Integer;
    fCtxMode: TIdSSLCtxMode;
    procedure DestroyContext;
    function SetSSLMethod: PSSL_METHOD;
    procedure SetVerifyMode(Mode: TIdSSLVerifyModeSet; CheckRoutine: Boolean);
    function GetVerifyMode: TIdSSLVerifyModeSet;
    procedure InitContext(CtxMode: TIdSSLCtxMode);
  public
    Parent: TObject;
    constructor Create;
    destructor Destroy; override;
    function Clone : TIdSSLContext;
    function LoadRootCert: Boolean;
    function LoadCert: Boolean;
    function LoadKey: Boolean;
    function LoadDHParams: Boolean;
    property StatusInfoOn: Boolean read fStatusInfoOn write fStatusInfoOn;
//    property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
    property VerifyOn: Boolean read fVerifyOn write fVerifyOn;
//THese can't be published in a TObject without a compiler warning.
 // published
    property SSLVersions : TIdSSLVersions read fSSLVersions write fSSLVersions;
    property Method: TIdSSLVersion read fMethod write fMethod;
    property Mode: TIdSSLMode read fMode write fMode;
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property CertFile: String read fsCertFile write fsCertFile;
    property CipherList: AnsiString read fCipherList write fCipherList;
    property KeyFile: String read fsKeyFile write fsKeyFile;
    property DHParamsFile: String read fsDHParamsFile write fsDHParamsFile;
//    property VerifyMode: TIdSSLVerifyModeSet read GetVerifyMode write SetVerifyMode;
//    property VerifyFile: String read fVerifyFile write fVerifyFile;
    property VerifyDirs: String read fVerifyDirs write fVerifyDirs;
    property VerifyMode: TIdSSLVerifyModeSet read fVerifyMode write fVerifyMode;
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;

  end;

  TIdSSLSocket = class(TObject)
  protected
    fParent: TObject;
    fPeerCert: TIdX509;
    fSSL: PSSL;
    fSSLCipher: TIdSSLCipher;
    fSSLContext: TIdSSLContext;
    function GetPeerCert: TIdX509;
    function GetSSLError(retCode: Integer): Integer;
    function GetSSLCipher: TIdSSLCipher;
  public
    constructor Create(Parent: TObject);
    destructor Destroy; override;
    procedure Accept(const pHandle: TIdStackSocketHandle);
    procedure Connect(const pHandle: TIdStackSocketHandle);
    function Send(const ABuffer : TIdBytes; AOffset, ALength: Integer): Integer;
    function Recv(var ABuffer : TIdBytes): Integer;
    function GetSessionID: TIdSSLByteArray;
    function GetSessionIDAsString:String;
    procedure SetCipherList(CipherList: String);
    //
    property PeerCert: TIdX509 read GetPeerCert;
    property Cipher: TIdSSLCipher read GetSSLCipher;
  end;

  TIdSSLIOHandlerSocketOpenSSL = class(TIdSSLIOHandlerSocketBase)
  protected
    fSSLContext: TIdSSLContext;
    fxSSLOptions: TIdSSLOptions;
    fSSLSocket: TIdSSLSocket;
    //fPeerCert: TIdX509;
    fOnStatusInfo: TCallbackEvent;
    FOnStatusInfoEx : TCallbackExEvent;
    fOnGetPassword: TPasswordEvent;
    fOnGetPasswordEx : TPasswordEventEx;
    fOnVerifyPeer: TVerifyPeerEvent;
    fSSLLayerClosed: Boolean;
    fOnBeforeConnect: TIOHandlerNotify;
    // function GetPeerCert: TIdX509;
    //procedure CreateSSLContext(axMode: TIdSSLMode);
    //
    procedure SetPassThrough(const Value: Boolean); override;
    procedure DoBeforeConnect(ASender: TIdSSLIOHandlerSocketOpenSSL); virtual;
    procedure DoStatusInfo(const AMsg: String); virtual;
    procedure DoStatusInfoEx(const AsslSocket: PSSL;
    const AWhere, Aret: TIdC_INT; const AWhereStr, ARetStr : String );
    procedure DoGetPassword(var Password: AnsiString); virtual;
    procedure DoGetPasswordEx(var VPassword: AnsiString; const AIsWrite : Boolean); virtual;

    function DoVerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean; virtual;
    function RecvEnc(var VBuffer: TIdBytes): Integer; override;
    function SendEnc(const ABuffer: TIdBytes; const AOffset, ALength: Integer): Integer; override;
    procedure Init;
    procedure OpenEncodedConnection; virtual;
    //some overrides from base classes
    procedure InitComponent; override;
    procedure ConnectClient; override;
    function CheckForError(ALastResult: Integer): Integer; override;
    procedure RaiseError(AError: Integer); override;
  public
    destructor Destroy; override;
    function Clone :  TIdSSLIOHandlerSocketBase; override;
    procedure StartSSL; override;
    procedure AfterAccept; override;
    procedure Close; override;
    procedure Open; override;
    property SSLSocket: TIdSSLSocket read fSSLSocket write fSSLSocket;
    property OnBeforeConnect: TIOHandlerNotify read fOnBeforeConnect write fOnBeforeConnect;
    property SSLContext: TIdSSLContext read fSSLContext write fSSLContext;
  published
    property SSLOptions: TIdSSLOptions read fxSSLOptions write fxSSLOptions;
    property OnStatusInfo: TCallbackEvent read fOnStatusInfo write fOnStatusInfo;
    property OnStatusInfoEx: TCallbackExEvent read fOnStatusInfoEx write fOnStatusInfoEx;
    property OnGetPassword: TPasswordEvent read fOnGetPassword write fOnGetPassword;
    property OnGetPasswordEx : TPasswordEventEx read fOnGetPasswordEx write fOnGetPasswordEx;
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer write fOnVerifyPeer;
  end;

  TIdServerIOHandlerSSLOpenSSL = class(TIdServerIOHandlerSSLBase)
  protected
    fxSSLOptions: TIdSSLOptions;
    fSSLContext: TIdSSLContext;
    fOnStatusInfo: TCallbackEvent;
    FOnStatusInfoEx : TCallbackExEvent;
    fOnGetPassword: TPasswordEvent;
    fOnGetPasswordEx : TPasswordEventEx;
    fOnVerifyPeer: TVerifyPeerEvent;
    //
    //procedure CreateSSLContext(axMode: TIdSSLMode);
    //procedure CreateSSLContext;
    //
    procedure DoStatusInfo(const AMsg: String); virtual;
    procedure DoStatusInfoEx(const AsslSocket: PSSL;
      const AWhere, Aret: TIdC_INT; const AWhereStr, ARetStr : String );
    procedure DoGetPassword(var Password: AnsiString); virtual;
//TPasswordEventEx
    procedure DoGetPasswordEx(var VPassword: AnsiString; const AIsWrite : Boolean); virtual;
    function DoVerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean; virtual;
    procedure InitComponent; override;
  public
    procedure Init; override;
    procedure Shutdown; override;
    // AListenerThread is a thread and not a yarn. Its the listener thread.
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread;
      AYarn: TIdYarn): TIdIOHandler; override;
//    function Accept(ASocket: TIdSocketHandle; AThread: TIdThread) : TIdIOHandler;  override;
    destructor Destroy; override;
    function MakeClientIOHandler : TIdSSLIOHandlerSocketBase; override;
    //
    function MakeFTPSvrPort : TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPasv : TIdSSLIOHandlerSocketBase; override;
    //
    property SSLContext: TIdSSLContext read fSSLContext;
  published
    property SSLOptions: TIdSSLOptions read fxSSLOptions write fxSSLOptions;
    property OnStatusInfo: TCallbackEvent read fOnStatusInfo write fOnStatusInfo;
    property OnStatusInfoEx: TCallbackExEvent read fOnStatusInfoEx write fOnStatusInfoEx;
    property OnGetPassword: TPasswordEvent read fOnGetPassword write fOnGetPassword;
    property OnGetPasswordEx : TPasswordEventEx read fOnGetPasswordEx write fOnGetPasswordEx;
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer write fOnVerifyPeer;
  end;

  TIdX509Name = class(TObject)
  protected
    fX509Name: PX509_NAME;
    function CertInOneLine: String;
    function GetHash: TIdSSLULong;
    function GetHashAsString: String;
  public
    constructor Create(aX509Name: PX509_NAME);
    //
    property Hash: TIdSSLULong read GetHash;
    property HashAsString: string read GetHashAsString;
    property OneLine: string read CertInOneLine;
  end;

  TIdX509Info = class(TObject)
  protected
    //Do not free this here because it belongs
    //to the X509 or something else.
    FX509 : PX509;
  public
    constructor Create( aX509: PX509);
  end;

  TIdX509Fingerprints = class(TIdX509Info)
  protected
    function GetMD5: TIdSSLEVP_MD;
    function GetMD5AsString:String;
    function GetSHA1: TIdSSLEVP_MD;
    function GetSHA1AsString:String;
    function GetSHA224 : TIdSSLEVP_MD;
    function GetSHA224AsString : String;
    function GetSHA256 : TIdSSLEVP_MD;
    function GetSHA256AsString : String;
    function GetSHA384 : TIdSSLEVP_MD;
    function GetSHA384AsString : String;
    function GetSHA512 : TIdSSLEVP_MD;
    function GetSHA512AsString : String;
  public
     property MD5 : TIdSSLEVP_MD read GetMD5;
     property MD5AsString : String read  GetMD5AsString;
{IMPORTANT!!!

FIPS approves only these algorithms for hashing.
SHA-1
SHA-224
SHA-256
SHA-384
SHA-512

http://csrc.nist.gov/CryptoToolkit/tkhash.html
}
    property SHA1 : TIdSSLEVP_MD read GetSHA1;
    property SHA1AsString : String read  GetSHA1AsString;
    property SHA224 : TIdSSLEVP_MD read GetSHA224;
    property SHA224AsString : String read GetSHA224AsString;
    property SHA256 : TIdSSLEVP_MD read GetSHA256;
    property SHA256AsString : String read GetSHA256AsString;
    property SHA384 : TIdSSLEVP_MD read GetSHA384;
    property SHA384AsString : String read GetSHA384AsString;
    property SHA512 : TIdSSLEVP_MD read GetSHA512;
    property SHA512AsString : String read GetSHA512AsString;
  end;

  TIdX509SigInfo = class(TIdX509Info)
  protected
    function GetSignature : String;
    function GetSigType : TIdC_INT;
    function GetSigTypeAsString : String;
  public
    property Signature : String read GetSignature;
    property SigType : TIdC_INT read  GetSigType ;
    property SigTypeAsString : String read GetSigTypeAsString;
  end;

  TIdX509 = class(TObject)
  protected
    FFingerprints : TIdX509Fingerprints;
    FSigInfo : TIdX509SigInfo;
    FCanFreeX509 : Boolean;
    FX509    : PX509;
    FSubject : TIdX509Name;
    FIssuer  : TIdX509Name;
    FDisplayInfo : TStrings;
    function RSubject:TIdX509Name;
    function RIssuer:TIdX509Name;
    function RnotBefore:TDateTime;
    function RnotAfter:TDateTime;
    function RFingerprint:TIdSSLEVP_MD;
    function RFingerprintAsString:String;
    function GetSerialNumber: String;
    function GetVersion : TIdC_LONG;
    function GetDisplayInfo : TStrings;
  public
    Constructor Create(aX509: PX509; aCanFreeX509: Boolean = True); virtual;
    Destructor Destroy; override;
    property Version : TIdC_LONG read GetVersion;
    //
    property SigInfo : TIdX509SigInfo read FSigInfo;
    property Fingerprints : TIdX509Fingerprints read FFingerprints;
    //
    property Fingerprint: TIdSSLEVP_MD read RFingerprint;
    property FingerprintAsString: String read RFingerprintAsString;
    property Subject: TIdX509Name read RSubject;
    property Issuer: TIdX509Name read RIssuer;
    property notBefore: TDateTime read RnotBefore;
    property notAfter: TDateTime read RnotAfter;
    property SerialNumber : string read GetSerialNumber;
    property DisplayInfo : TStrings read GetDisplayInfo;
  end;

  TIdSSLCipher = class(TObject)
  protected
    FSSLSocket: TIdSSLSocket;
    function GetDescription: String;
    function GetName: String;
    function GetBits: Integer;
    function GetVersion: String;
  public
    constructor Create(AOwner: TIdSSLSocket);
    destructor Destroy; override;
 //These can't be published without a compiler warning.
 // published
    property Description: String read GetDescription;
    property Name: String read GetName;
    property Bits: Integer read GetBits;
    property Version: String read GetVersion;
  end;
  EIdOSSLCouldNotLoadSSLLibrary = class(EIdOpenSSLError);
  EIdOSSLModeNotSet             = class(EIdOpenSSLError);
  EIdOSSLGetMethodError         = class(EIdOpenSSLError);
  EIdOSSLCreatingSessionError   = class(EIdOpenSSLError);
  EIdOSSLCreatingContextError   = class(EIdOpenSSLAPICryptoError);
  EIdOSSLLoadingRootCertError = class(EIdOpenSSLAPICryptoError);
  EIdOSSLLoadingCertError = class(EIdOpenSSLAPICryptoError);
  EIdOSSLLoadingKeyError = class(EIdOpenSSLAPICryptoError);
  EIdOSSLLoadingDHParamsError = class(EIdOpenSSLAPICryptoError);
  EIdOSSLSettingCipherError = class(EIdOpenSSLError);
  EIdOSSLFDSetError = class(EIdOpenSSLAPISSLError);
  EIdOSSLDataBindingError = class(EIdOpenSSLAPISSLError);
  EIdOSSLAcceptError = class(EIdOpenSSLAPISSLError);
  EIdOSSLConnectError = class(EIdOpenSSLAPISSLError);

function LoadOpenSSLLibrary: Boolean;
procedure UnLoadOpenSSLLibrary;

function OpenSSLVersion: string;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.SysTime,
  Posix.Time,
  Posix.Unistd,
  {$ENDIF}
  IdFIPS,
  IdResourceStringsCore,
  IdResourceStringsProtocols,
  IdStack,
  IdStackBSDBase,
  IdAntiFreezeBase,
  IdExceptionCore,
  IdResourceStrings,
  IdThreadSafe,
  SysUtils,
  SyncObjs;

var
  SSLIsLoaded: TIdThreadSafeBoolean = nil;
  LockInfoCB: TIdCriticalSection = nil;
  LockPassCB: TIdCriticalSection = nil;
  LockVerifyCB: TIdCriticalSection = nil;
  CallbackLockList: TThreadList = nil;

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

function PasswordCallback(buf: PAnsiChar; size: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT; cdecl;
var
  Password: AnsiString;
  IdSSLContext: TIdSSLContext;
  LErr : Integer;
begin
  //Preserve last eror just in case OpenSSL is using it and we do something that
  //clobers it.  CYA.
  LErr := GStack.WSGetLastError;
  try
    LockPassCB.Enter;
    try
      Password := '';    {Do not Localize}
      IdSSLContext := TIdSSLContext(userdata);
      if (IdSSLContext.Parent is TIdSSLIOHandlerSocketOpenSSL) then begin
        TIdSSLIOHandlerSocketOpenSSL(IdSSLContext.Parent).DoGetPasswordEx(Password,rwflag > 0);
        if Password = '' then begin
          TIdSSLIOHandlerSocketOpenSSL(IdSSLContext.Parent).DoGetPassword(Password);
        end;
      end;
      if (IdSSLContext.Parent is TIdServerIOHandlerSSLOpenSSL) then begin
        TIdServerIOHandlerSSLOpenSSL(IdSSLContext.Parent).DoGetPasswordEx(Password,rwflag > 0);
        if Password = '' then begin
          TIdServerIOHandlerSSLOpenSSL(IdSSLContext.Parent).DoGetPassword(Password);
        end;
      end;
      FillChar(buf^, size, 0);
      StrPLCopy(buf, Password, size);
      Result := Length(Password);
      buf[size-1] := #0; // RLebeau: truncate the password if needed
    finally
      LockPassCB.Leave;
    end;
  finally
     GStack.WSSetLastError(LErr);
  end;
end;

procedure InfoCallback(const sslSocket: PSSL; where, ret: TIdC_INT); cdecl;
var
  IdSSLSocket: TIdSSLSocket;
  StatusStr : String;
  LMsg : String;
  LErr : Integer;
begin
{
You have to save the value of WSGetLastError as some Operating System API
function calls will reset that value and we can't know what a programmer will
do in this event.  We need the value of WSGetLastError so we can report
an underlying socket error when the OpenSSL function returns.

JPM.
}
  LErr := GStack.WSGetLastError;
  try
    LockInfoCB.Enter;
    try
      IdSSLSocket := TIdSSLSocket(
      SSL_get_app_data(sslSocket));
      StatusStr := IndyFormat(RSOSSLStatusString, [StrPas(SSL_state_string_long(sslSocket))]);
      if (IdSSLSocket.fParent is TIdSSLIOHandlerSocketOpenSSL) then begin
        TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).DoStatusInfo(StatusStr);
        if Assigned(TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).fOnStatusInfoEx) then begin
          GetStateVars(sslSocket,where,ret,StatusStr,LMsg);
          TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).DoStatusInfoEx(sslSocket,where,ret,StatusStr,LMsg);
        end;
      end;
      if (IdSSLSocket.fParent is TIdServerIOHandlerSSLOpenSSL) then begin
        TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).DoStatusInfo(StatusStr);
        if Assigned(TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).fOnStatusInfoEx) then begin
          GetStateVars(sslSocket,where,ret,StatusStr,LMsg);
          TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).DoStatusInfoEx(sslSocket,where,ret,StatusStr,LMsg);
        end;
      end;
    finally
      LockInfoCB.Leave;
    end;
  finally
    GStack.WSSetLastError(LErr);
  end;
end;

function TranslateInternalVerifyToSSL(Mode: TIdSSLVerifyModeSet): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_VERIFY_NONE;
  if sslvrfPeer in Mode then begin
    Result := Result or SSL_VERIFY_PEER;
  end;
  if sslvrfFailIfNoPeerCert in Mode then begin
    Result:= Result or SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
  end;
  if sslvrfClientOnce in Mode then begin
    Result:= Result or SSL_VERIFY_CLIENT_ONCE;
  end;
end;

function VerifyCallback(Ok: TIdC_INT; ctx: PX509_STORE_CTX): TIdC_INT; cdecl;
var
  hcert: PX509;
  Certificate: TIdX509;
  hSSL: PSSL;
  IdSSLSocket: TIdSSLSocket;
  // str: String;
  VerifiedOK: Boolean;
  Depth: Integer;
  Error: Integer;
  LOk: Boolean;
begin
  LockVerifyCB.Enter;
  try
    VerifiedOK := True;
    try
      hSSL := X509_STORE_CTX_get_app_data(ctx);
      if hSSL = nil then begin
        Result := Ok;
        Exit;
      end;
      hcert := X509_STORE_CTX_get_current_cert(ctx);
      Certificate := TIdX509.Create(hcert, False); // the certificate is owned by the store
      try
        IdSSLSocket := TIdSSLSocket(SSL_get_app_data(hSSL));
        Error := X509_STORE_CTX_get_error(ctx);
        Depth := X509_STORE_CTX_get_error_depth(ctx);
        if not ((Ok > 0) and (IdSSLSocket.fSSLContext.VerifyDepth >= Depth)) then begin
          Ok := 0;
          {if Error = X509_V_OK then begin
            Error := X509_V_ERR_CERT_CHAIN_TOO_LONG;
          end;}
        end;
        LOk := False;
        if Ok = 1 then begin
          LOk := True;
        end;
        if (IdSSLSocket.fParent is TIdSSLIOHandlerSocketOpenSSL) then begin
          VerifiedOK := TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).DoVerifyPeer(Certificate, LOk, Depth, Error);
        end;
        if (IdSSLSocket.fParent is TIdServerIOHandlerSSLOpenSSL) then begin
          VerifiedOK := TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).DoVerifyPeer(Certificate, LOk, Depth, Error);
        end;
      finally
        FreeAndNil(Certificate);
      end;
    except
    end;
    //if VerifiedOK and (Ok > 0) then begin
    if VerifiedOK {and (Ok > 0)} then begin
      Result := 1;
    end
    else begin
      Result := 0;
    end;
  //  Result := Ok; // testing
  finally
    LockVerifyCB.Leave;
  end;
end;

//////////////////////////////////////////////////////
//   Utilities
//////////////////////////////////////////////////////

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME; forward;
function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): TIdC_INT; forward;
function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): TIdC_INT; forward;
function IndyX509_STORE_load_locations(ctx: PX509_STORE;
  const AFileName, APathName: String): TIdC_INT; forward;
function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT; forward;
function IndySSL_CTX_use_DHparams_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT; forward;

// TODO
{
function d2i_DHparams_bio(bp: PBIO; x: PPointer): PDH; inline;
begin
  Result := PDH(ASN1_d2i_bio(@DH_new, @d2i_DHparams, bp, x));
end;
}

{
  IMPORTANT!!!

  OpenSSL can not handle Unicode file names at all.  On Posix systems, UTF8 File
  names can be used with OpenSSL.  The Windows operating system does not accept
  UTF8 file names at all so we have our own routines that will handle Unicode
  filenames.   Most of this section of code is based on code in the OpenSSL .DLL
  which is copyrighted by the OpenSSL developers.  Some of it is translated into
  Pascal and made some modifications so that it will handle Unicode filenames.
}

{$IFDEF STRING_IS_UNICODE}

  {$IFDEF WINDOWS}

function Indy_unicode_X509_load_cert_crl_file(ctx: PX509_LOOKUP; const AFileName: String;
  const _type: TIdC_INT): TIdC_INT; forward;
function Indy_unicode_X509_load_cert_file(ctx: PX509_LOOKUP; const AFileName: String;
  _type: TIdC_INT): TIdC_INT; forward;

{
  This is for some file lookup definitions for a LOOKUP method that
  uses Unicode filenames instead of ASCII or UTF8.  It is not meant
  to be portable at all.
}
function by_Indy_unicode_file_ctrl(ctx: PX509_LOOKUP; cmd: TIdC_INT;
  const argc: PAnsiChar; argl: TIdC_LONG; out ret: PAnsiChar): TIdC_INT;
  cdecl; forward;

const
  Indy_x509_unicode_file_lookup: X509_LOOKUP_METHOD =
    (
    name: PAnsiChar('Load file into cache');
    new_item: nil; // * new */
    free: nil; // * free */
    init: nil; // * init */
    shutdown: nil; // * shutdown */
    ctrl: by_Indy_unicode_file_ctrl; // * ctrl */
    get_by_subject: nil; // * get_by_subject */
    get_by_issuer_serial: nil; // * get_by_issuer_serial */
    get_by_fingerprint: nil; // * get_by_fingerprint */
    get_by_alias: nil // * get_by_alias */
    );

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
                LOk := Ord(Indy_unicode_X509_load_cert_crl_file(ctx, LFileName,
                  X509_FILETYPE_PEM) <> 0);
              end else begin
                LOk := Ord(Indy_unicode_X509_load_cert_crl_file(ctx,
                  String(X509_get_default_cert_file), X509_FILETYPE_PEM) <> 0);
              end;
              if LOk = 0 then begin
                X509err(X509_F_BY_FILE_CTRL, X509_R_LOADING_DEFAULTS);
              end;
            end;
          X509_FILETYPE_PEM:
            begin
              // Note that typecasting an AnsiChar as a WideChar is normally a crazy
              // thing to do.  The thing is that the OpenSSL API is based on ASCII or
              // UTF8, not Unicode and we are writing this just for Unicode filenames.
              LFileName := PWideChar(argc);
              LOk := Ord(Indy_unicode_X509_load_cert_crl_file(ctx, LFileName,
                X509_FILETYPE_PEM) <> 0);
            end;
        else
          LFileName := PWideChar(argc);
          LOk := Ord(Indy_unicode_X509_load_cert_file(ctx, LFileName, TIdC_INT(argl)) <> 0);
        end;
      end;
  end;
  Result := LOk;
end;

function Indy_unicode_X509_load_cert_file(ctx: PX509_LOOKUP; const AFileName: String;
  _type: TIdC_INT): TIdC_INT;
var
  LM: TMemoryStream;
  Lin: PBIO;
  LX: PX509;
  i, count: Integer;
begin
  Result := 0;
  count := 0;
  Lin := nil;

  if AFileName = '' then begin
    Result := 1;
    Exit;
  end;

  LM := nil;
  try
    LM := TMemoryStream.Create;
    LM.LoadFromFile(AFileName);
  except
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
    X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_SYS_LIB);
    LM.Free;
    Exit;
  end;

  try
    Lin := BIO_new_mem_buf(LM.Memory, LM.Size);
    if not Assigned(Lin) then begin
      X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_SYS_LIB);
      Exit;
    end;
    case _type of
      X509_FILETYPE_PEM:
        begin
          repeat
            LX := PEM_read_bio_X509_AUX(Lin, nil, nil, nil);
            if not Assigned(LX) then begin
              if ((ERR_GET_REASON(ERR_peek_last_error())
                    = PEM_R_NO_START_LINE) and (count > 0)) then begin
                ERR_clear_error();
                Break;
              end else begin
                X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_PEM_LIB);
                Exit;
              end;
            end;
            i := X509_STORE_add_cert(ctx^.store_ctx, LX);
            if i = 0 then begin
              Exit;
            end;
            Inc(count);
            X509_Free(LX);
          until False;
          Result := count;
        end;
      X509_FILETYPE_ASN1:
        begin
          LX := d2i_X509_bio(Lin, nil);
          if not Assigned(LX) then begin
            X509err(X509_F_X509_LOAD_CERT_FILE, ERR_R_ASN1_LIB);
            Exit;
          end;
          i := X509_STORE_add_cert(ctx^.store_ctx, LX);
          if i = 0 then begin
            Exit;
          end;
          Result := i;
        end;
    else
      X509err(X509_F_X509_LOAD_CERT_FILE, X509_R_BAD_X509_FILETYPE);
      Exit;
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
  i, count: Integer;
begin
  Result := 0;
  count := 0;
  LM := nil;
  Lin := nil;

  if _type <> X509_FILETYPE_PEM then begin
    Result := Indy_unicode_X509_load_cert_file(ctx, AFileName, _type);
    Exit;
  end;

  try
    LM := TMemoryStream.Create;
    LM.LoadFromFile(AFileName);
  except
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
    X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_SYS_LIB);
    LM.Free;
    Exit;
  end;

  try
    Lin := BIO_new_mem_buf(LM.Memory, LM.Size);
    if not Assigned(Lin) then begin
      X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_SYS_LIB);
      Exit;
    end;
    Linf := PEM_X509_INFO_read_bio(Lin, nil, nil, nil);
  finally
    BIO_free(Lin);
    FreeAndNil(LM);
  end;
  if not Assigned(Linf) then begin
    X509err(X509_F_X509_LOAD_CERT_CRL_FILE, ERR_R_PEM_LIB);
    Exit;
  end;
  try
    for i := 0 to sk_X509_INFO_num(Linf) - 1 do begin
      Litmp := sk_X509_INFO_value(Linf, i);
      if Assigned(Litmp^.x509) then begin
        X509_STORE_add_cert(ctx^.store_ctx, Litmp^.x509);
        Inc(count);
      end;
      if Assigned(Litmp^.crl) then begin
        X509_STORE_add_crl(ctx^.store_ctx, Litmp^.crl);
        Inc(count);
      end;
    end;
  finally
    sk_X509_INFO_pop_free(Linf, @X509_INFO_free);
  end;
  Result := count;
end;

procedure IndySSL_load_client_CA_file_err(var VRes: PSTACK_OF_X509_NAME);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  if Assigned(VRes) then begin
    sk_X509_NAME_pop_free(VRes, @X509_NAME_free);
    VRes := nil;
  end;
end;

function xname_cmp(const a, b: PPX509_NAME): TIdC_INT; cdecl;
begin
  Result := X509_NAME_cmp(a^, b^);
end;

function IndySSL_load_client_CA_file(const AFileName: String): PSTACK_OF_X509_NAME;
var
  LM: TMemoryStream;
  LB: PBIO;
  Lsk: PSTACK_OF_X509_NAME;
  LX: PX509;
  LXN, LXNDup: PX509_NAME;
  Failed: Boolean;
begin
  Result := nil;
  Failed := False;
  LX := nil;
  Lsk := sk_X509_NAME_new(@xname_cmp);
  if Assigned(Lsk) then begin
    try
      LM := nil;
      try
        LM := TMemoryStream.Create;
        LM.LoadFromFile(AFileName);
      except
        // Surpress exception here since it's going to be called by the OpenSSL .DLL
        // Follow the OpenSSL .DLL Error conventions.
        SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_SYS_LIB);
        LM.Free;
        Exit;
      end;
      try
        LB := BIO_new_mem_buf(LM.Memory, LM.Size);
        if Assigned(LB) then begin
          try
            try
              repeat
                LX := PEM_read_bio_X509(LB, nil, nil, nil);
                if LX = nil then begin
                  Break;
                end;
                if not Assigned(Result) then begin
                  Result := sk_X509_NAME_new_null;
                  if not Assigned(Result) then begin
                    SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
                    Failed := True;
                    Exit;
                  end;
                end;
                LXN := X509_get_subject_name(LX);
                if not Assigned(LXN) then begin
                  // error
                  IndySSL_load_client_CA_file_err(Result);
                  Failed := True;
                  Exit;
                end;
                // * check for duplicates */
                LXNDup := X509_NAME_dup(LXN);
                if not Assigned(LXNDup) then begin
                  // error
                  IndySSL_load_client_CA_file_err(Result);
                  Failed := True;
                  Exit;
                end;
                if (sk_X509_NAME_find(Lsk, LXNDup) >= 0) then begin
                  X509_NAME_free(LXNDup);
                end else begin
                  sk_X509_NAME_push(Lsk, LXNDup);
                  sk_X509_NAME_push(Result, LXNDup);
                end;
                X509_free(LX);
                LX := nil;
              until False;
            finally
              if Assigned(LX) then begin
                X509_free(LX);
              end;
              if Failed and Assigned(Result) then begin
                sk_X509_NAME_pop_free(Result, @X509_NAME_free);
                Result := nil;
              end;
            end;
          finally
            BIO_free(LB);
          end;
        end
        else begin
          SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
        end;
      finally
        FreeAndNil(LM);
      end;
    finally
      sk_X509_NAME_free(Lsk);
    end;
  end
  else begin
    SSLerr(SSL_F_SSL_LOAD_CLIENT_CA_FILE, ERR_R_MALLOC_FAILURE);
  end;
  if Assigned(Result) then begin
    ERR_clear_error;
  end;
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): TIdC_INT;
var
  LM: TMemoryStream;
  B: PBIO;
  LKey: PEVP_PKEY;
  j: TIdC_INT;
begin
  Result := 0;

  LM := nil;
  try
    LM := TMemoryStream.Create;
    LM.LoadFromFile(AFileName);
  except
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
    SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, ERR_R_SYS_LIB);
    LM.Free;
    Exit;
  end;

  try
    B := BIO_new_mem_buf(LM.Memory, LM.Size);
    if not Assigned(B) then begin
      SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, ERR_R_BUF_LIB);
      Exit;
    end;
    try
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
        SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, SSL_R_BAD_SSL_FILETYPE);
        Exit;
      end;
      if not Assigned(LKey) then begin
        SSLerr(SSL_F_SSL_CTX_USE_PRIVATEKEY_FILE, j);
        Exit;
      end;
      Result := SSL_CTX_use_PrivateKey(ctx, LKey);
      EVP_PKEY_free(LKey);
    finally
      BIO_free(B);
    end;
  finally
    FreeAndNil(LM);
  end;
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
var
  LM: TMemoryStream;
  B: PBIO;
  LX: PX509;
  j: TIdC_INT;
begin
  Result := 0;

  LM := nil;
  try
    LM := TMemoryStream.Create;
    LM.LoadFromFile(AFileName);
  except
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
    SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_SYS_LIB);
    LM.Free;
    Exit;
  end;

  try
    B := BIO_new_mem_buf(LM.Memory, LM.Size);
    if not Assigned(B) then begin
      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_BUF_LIB);
      Exit;
    end;
    try
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
        else begin
          SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, SSL_R_BAD_SSL_FILETYPE);
          Exit;
        end;
      end;
      if not Assigned(LX) then begin
        SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, j);
        Exit;
      end;
      Result := SSL_CTX_use_certificate(ctx, LX);
      X509_free(LX);
    finally
      BIO_free(B);
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
    if not Assigned(lookup) then begin
      Exit;
    end;
    if (X509_LOOKUP_load_file(lookup, PAnsiChar(@AFileName[1]),
        X509_FILETYPE_PEM) <> 1) then begin
      Exit;
    end;
  end;
  if APathName <> '' then begin
    { TODO: Figure out how to do the hash dir lookup with Unicode. }
    if (X509_STORE_load_locations(ctx, nil, PAnsiChar(AnsiString(APathName))) <> 1) then begin
      Exit;
    end;
  end;
  if (AFileName = '') and (APathName = '') then begin
    Exit;
  end;
  Result := 1;
end;

function IndySSL_CTX_load_verify_locations(ctx: PSSL_CTX;
  const ACAFile, ACAPath: String): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := IndyX509_STORE_load_locations(ctx^.cert_store, ACAFile, ACAPath);
end;

function IndySSL_CTX_use_DHparams_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
var
  LM: TMemoryStream;
  B: PBIO;
  LDH: PDH;
  j: Integer;
begin
  Result := 0;

  LM := nil;
  try
    LM := TMemoryStream.Create;
    LM.LoadFromFile(AFileName);
  except
    // Surpress exception here since it's going to be called by the OpenSSL .DLL
    // Follow the OpenSSL .DLL Error conventions.
    SSLerr(SSL_F_SSL3_CTRL, ERR_R_SYS_LIB);
    LM.Free;
    Exit;
  end;

  try
    B := BIO_new_mem_buf(LM.Memory, LM.Size);
    if not Assigned(B) then begin
      SSLerr(SSL_F_SSL3_CTRL, ERR_R_BUF_LIB);
      Exit;
    end;
    try
      case AType of
        // TODO
        {
        SSL_FILETYPE_ASN1:
          begin
            j := ERR_R_ASN1_LIB;
            LDH := d2i_DHparams_bio(B, nil);
          end;
        }
        SSL_FILETYPE_PEM:
          begin
            j := ERR_R_DH_LIB;
            LDH := PEM_read_bio_DHparams(B, nil, ctx^.default_passwd_callback,
              ctx^.default_passwd_callback_userdata);
          end
        else begin
          SSLerr(SSL_F_SSL3_CTRL, SSL_R_BAD_SSL_FILETYPE);
          Exit;
        end;
      end;
      if not Assigned(LDH) then begin
        SSLerr(SSL_F_SSL3_CTRL, j);
        Exit;
      end;
      Result := SSL_CTX_set_tmp_dh(ctx, LDH);
      DH_free(LDH);
    finally
      BIO_free(B);
    end;
  finally
    FreeAndNil(LM);
  end;
end;

  {$ENDIF} // WINDOWS

  {$IFDEF UNIX}

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME;
begin
  Result := SSL_load_client_CA_file(PAnsiChar(UTF8String(AFileName)));
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_PrivateKey_file(ctx, PAnsiChar(UTF8String(AFileName)), AType);
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_certificate_file(ctx, PAnsiChar(UTF8String(AFileName)), AType);
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

function IndySSL_CTX_use_DHparams_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
var
  B: PBIO;
  LDH: PDH;
  j: Integer;
begin
  Result := 0;
  B := BIO_new_file(PAnsiChar(UTF8String(AFileName)), 'r');
  if Assigned(B) then begin
    try
      case AType of
        // TODO
        {
        SSL_FILETYPE_ASN1:
          begin
            j := ERR_R_ASN1_LIB;
            LDH := d2i_DHparams_bio(B, nil);
          end;
        }
        SSL_FILETYPE_PEM:
          begin
            j := ERR_R_DH_LIB;
            LDH := PEM_read_bio_DHparams(B, nil, ctx^.default_passwd_callback,
              ctx^.default_passwd_callback_userdata);
          end
        else begin
          SSLerr(SSL_F_SSL3_CTRL, SSL_R_BAD_SSL_FILETYPE);
          Exit;
        end;
      end;
      if not Assigned(LDH) then begin
        SSLerr(SSL_F_SSL3_CTRL, j);
        Exit;
      end;
      Result := SSL_CTX_set_tmp_dh(ctx, LDH);
      DH_free(LDH);
    finally
      BIO_free(B);
    end;
  end;
end;

  {$ENDIF} // UNIX

{$ELSE} // STRING_IS_UNICODE

function IndySSL_load_client_CA_file(const AFileName: String) : PSTACK_OF_X509_NAME;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_load_client_CA_file(PAnsiChar(AFileName));
end;

function IndySSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const AFileName: String;
  AType: Integer): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_PrivateKey_file(ctx, PAnsiChar(AFileName), AType);
end;

function IndySSL_CTX_use_certificate_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_CTX_use_certificate_file(ctx, PAnsiChar(AFileName), AType);
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

function IndySSL_CTX_use_DHparams_file(ctx: PSSL_CTX;
  const AFileName: String; AType: Integer): TIdC_INT;
var
  B: PBIO;
  LDH: PDH;
  j: Integer;
begin
  Result := 0;
  B := BIO_new_file(PAnsiChar(AFileName), 'r');
  if Assigned(B) then begin
    try
      case AType of
        // TODO
        {
        SSL_FILETYPE_ASN1:
          begin
            j := ERR_R_ASN1_LIB;
            LDH := d2i_DHparams_bio(B, nil);
          end;
        }
        SSL_FILETYPE_PEM:
          begin
            j := ERR_R_DH_LIB;
            LDH := PEM_read_bio_DHparams(B, nil, ctx^.default_passwd_callback,
              ctx^.default_passwd_callback_userdata);
          end
        else begin
          SSLerr(SSL_F_SSL3_CTRL, SSL_R_BAD_SSL_FILETYPE);
          Exit;
        end;
      end;
      if not Assigned(LDH) then begin
        SSLerr(SSL_F_SSL3_CTRL, j);
        Exit;
      end;
      Result := SSL_CTX_set_tmp_dh(ctx, LDH);
      DH_free(LDH);
    finally
      BIO_free(B);
    end;
  end;
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

function GetLocalTime(const DT: TDateTime): TDateTime;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := DT - TimeZoneBias { / (24 * 60) } ;
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

function IsTLSv1_1Available : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := Assigned(TLSv1_1_method) and
    Assigned(TLSv1_1_server_method) and
    Assigned(TLSv1_1_client_method);
end;

function IsTLSv1_2Available : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := Assigned(TLSv1_1_method) and
    Assigned(TLSv1_2_server_method) and
    Assigned(TLSv1_2_client_method);
end;

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
        AOut.Text := IndyUTF8Encoding.GetString( TIdBytes(LBufPtr^), 0, LLen);
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
  if UTC_Time_Decode(UCTTime, year, month, day, hour, min, sec, tz_h,
    tz_m) > 0 then begin
    Result := EncodeDate(year, month, day) + EncodeTime(hour, min, sec, 0);
    AddMins(Result, tz_m);
    AddHrs(Result, tz_h);
    Result := GetLocalTime(Result);
  end;
end;

{ function RSACallback(sslSocket: PSSL; e: Integer; KeyLength: Integer):PRSA; cdecl;
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

  if not Assigned(RSA) then begin
  RSA := f_RSA_generate_key(KeyLength, RSA_F4, @RSAProgressCallback, ssl);
  end;
  Result := RSA;
  end; }

function LogicalAnd(A, B: Integer): Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := (A and B) = B;
end;

function BytesToHexString(APtr: Pointer; ALen: Integer): String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: Integer;
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
    CRYPTO_set_locking_callback(@SslLockingCallback);
{$IFNDEF WIN32_OR_WIN64}
    if Assigned(CRYPTO_THREADID_set_callback) then begin
      CRYPTO_THREADID_set_callback(@_threadid_func);
    end else begin
      CRYPTO_set_id_callback(@_GetThreadID);
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

function OpenSSLVersion: string;
begin
  Result := '';
  if IdSSLOpenSSL.LoadOpenSSLLibrary then
  begin
    Result := String(_SSLeay_version(SSLEAY_VERSION));
  end;
end;

//////////////////////////////////////////////////////
//   TIdSSLOptions
///////////////////////////////////////////////////////

constructor TIdSSLOptions.Create;
begin
  inherited Create;
  fMethod := DEF_SSLVERSION;
  fSSLVersions := DEF_SSLVERSIONS;
end;

procedure TIdSSLOptions.SetMethod(const AValue: TIdSSLVersion);
begin
  fMethod := AValue;
  case AValue of
    sslvSSLv2 : fSSLVersions := [sslvSSLv2];
    sslvSSLv23 : fSSLVersions := [sslvSSLv2,sslvSSLv3,sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
    sslvSSLv3 : fSSLVersions := [sslvSSLv3];
    sslvTLSv1 : fSSLVersions := [sslvTLSv1];
    sslvTLSv1_1 : fSSLVersions := [sslvTLSv1_1];
    sslvTLSv1_2 : fSSLVersions := [sslvTLSv1_2];
  end;
end;

procedure TIdSSLOptions.SetSSLVersions(const AValue: TIdSSLVersions);
begin
  fSSLVersions := AValue;
  if fSSLVersions = [sslvSSLv2] then begin
    fMethod := sslvSSLv2;
  end
  else if fSSLVersions = [sslvSSLv3] then begin
    fMethod := sslvSSLv3;
  end
  else if fSSLVersions = [sslvTLSv1] then begin
    fMethod := sslvTLSv1;
  end
  else if fSSLVersions = [sslvTLSv1_1 ] then begin
    fMethod := sslvTLSv1_1;
  end
  else if fSSLVersions = [sslvTLSv1_2 ] then begin
    fMethod := sslvTLSv1_2;

  end
  else begin
    fMethod := sslvSSLv23;
    if sslvSSLv23 in fSSLVersions then begin
      Exclude(fSSLVersions, sslvSSLv23);
      if fSSLVersions = [] then begin
        fSSLVersions := [sslvSSLv2,sslvSSLv3,sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
      end;
    end;
  end;
end;

procedure TIdSSLOptions.AssignTo(ASource: TPersistent);
begin
  if ASource is TIdSSLOptions then
    with TIdSSLOptions(ASource) do begin
      RootCertFile := Self.RootCertFile;
      CertFile := Self.CertFile;
      KeyFile := Self.KeyFile;
      DHParamsFile := Self.DHParamsFile;
      Method := Self.Method;
      SSLVersions := Self.SSLVersions;
      Mode := Self.Mode;
      VerifyMode := Self.VerifyMode;
      VerifyDepth := Self.VerifyDepth;
      VerifyDirs := Self.VerifyDirs;
      CipherList := Self.CipherList;
    end
  else
    inherited AssignTo(ASource);
end;

///////////////////////////////////////////////////////
//   TIdServerIOHandlerSSLOpenSSL
///////////////////////////////////////////////////////

{ TIdServerIOHandlerSSLOpenSSL }

procedure TIdServerIOHandlerSSLOpenSSL.InitComponent;
begin
  inherited InitComponent;
  fxSSLOptions := TIdSSLOptions.Create;
end;

destructor TIdServerIOHandlerSSLOpenSSL.Destroy;
begin
  FreeAndNil(fxSSLOptions);
  inherited Destroy;
end;

procedure TIdServerIOHandlerSSLOpenSSL.Init;
//see also TIdSSLIOHandlerSocketOpenSSL.Init
begin
  //ensure Init isn't called twice
  Assert(fSSLContext = nil);
  fSSLContext := TIdSSLContext.Create;
  with fSSLContext do begin
    Parent := Self;
    RootCertFile := SSLOptions.RootCertFile;
    CertFile := SSLOptions.CertFile;
    KeyFile := SSLOptions.KeyFile;
    DHParamsFile := SSLOptions.DHParamsFile;
    fVerifyDepth := SSLOptions.fVerifyDepth;
    fVerifyMode := SSLOptions.fVerifyMode;
    // fVerifyFile := SSLOptions.fVerifyFile;
    fVerifyDirs := SSLOptions.fVerifyDirs;
    fCipherList := SSLOptions.fCipherList;
    VerifyOn := Assigned(fOnVerifyPeer);
    StatusInfoOn := Assigned(fOnStatusInfo) or Assigned(FOnStatusInfoEx);
    //PasswordRoutineOn := Assigned(fOnGetPassword);
    fMethod :=  SSLOptions.Method;
    fMode := SSLOptions.Mode;
    fSSLVersions := SSLOptions.SSLVersions;

    fSSLContext.InitContext(sslCtxServer);
  end;
end;

function TIdServerIOHandlerSSLOpenSSL.Accept(ASocket: TIdSocketHandle;
  // This is a thread and not a yarn. Its the listener thread.
  AListenerThread: TIdThread; AYarn: TIdYarn ): TIdIOHandler;
var
  LIO: TIdSSLIOHandlerSocketOpenSSL;
begin
  Assert(ASocket<>nil);
  Assert(fSSLContext<>nil);
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    LIO.PassThrough := True;
    LIO.Open;
    if LIO.Binding.Accept(ASocket.Handle) then begin
      //we need to pass the SSLOptions for the socket from the server
      FreeAndNil(LIO.fxSSLOptions);
      LIO.IsPeer := True;
      LIO.fxSSLOptions := fxSSLOptions;
      LIO.fSSLSocket := TIdSSLSocket.Create(Self);
      LIO.fSSLContext := fSSLContext;
    end else begin
      FreeAndNil(LIO);
    end;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoStatusInfo(const AMsg: String);
begin
  if Assigned(fOnStatusInfo) then begin
    fOnStatusInfo(AMsg);
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoStatusInfoEx(const AsslSocket: PSSL;
  const AWhere, Aret: TIdC_INT; const AWhereStr, ARetStr: String);
begin
  if Assigned(FOnStatusInfoEx) then begin
    FOnStatusInfoEx(Self,AsslSocket,AWhere,Aret,AWHereStr,ARetStr);
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoGetPassword(var Password: AnsiString);
begin
  if Assigned(fOnGetPassword) then  begin
    fOnGetPassword(Password);
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoGetPasswordEx(
  var VPassword: AnsiString; const AIsWrite: Boolean);
begin
  if Assigned(fOnGetPasswordEx) then begin
    fOnGetPasswordEx(Self,VPassword,AIsWrite);
  end;
end;

function TIdServerIOHandlerSSLOpenSSL.DoVerifyPeer(Certificate: TIdX509;
  AOk: Boolean; ADepth, AError: Integer): Boolean;
begin
  Result := True;
  if Assigned(fOnVerifyPeer) then begin
    Result := fOnVerifyPeer(Certificate, AOk, ADepth, AError);
  end;
end;

function TIdServerIOHandlerSSLOpenSSL.MakeFTPSvrPort : TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    LIO.PassThrough := True;
    LIO.OnGetPassword := DoGetPassword;
    LIO.OnGetPasswordEx := OnGetPasswordEx;
    //todo memleak here - setting IsPeer causes SSLOptions to not free
    LIO.IsPeer := True;
    LIO.SSLOptions.Assign(SSLOptions);
    LIO.SSLOptions.Mode := sslmBoth;{doesn't really matter}
    LIO.SSLContext := SSLContext;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

procedure TIdServerIOHandlerSSLOpenSSL.Shutdown;
begin
  FreeAndNil(fSSLContext);
  inherited Shutdown;
end;

function TIdServerIOHandlerSSLOpenSSL.MakeFTPSvrPasv : TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    LIO.PassThrough := True;
    LIO.OnGetPassword := DoGetPassword;
    LIO.OnGetPasswordEx := OnGetPasswordEx;
    //todo memleak here - setting IsPeer causes SSLOptions to not free
    LIO.IsPeer := True;
    LIO.SSLOptions.Assign(SSLOptions);
    LIO.SSLOptions.Mode := sslmBoth;{or sslmServer}
    LIO.SSLContext := nil;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

///////////////////////////////////////////////////////
//   TIdSSLIOHandlerSocketOpenSSL
///////////////////////////////////////////////////////

function TIdServerIOHandlerSSLOpenSSL.MakeClientIOHandler: TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    LIO.PassThrough := True;
  //  LIO.SSLOptions.Free;
  //  LIO.SSLOptions := SSLOptions;
  //  LIO.SSLContext := SSLContext;
    LIO.SSLOptions.Assign(SSLOptions);
  //  LIO.SSLContext := SSLContext;
    LIO.SSLContext := nil;//SSLContext.Clone; // BGO: clone does not work, it must be either NIL, or SSLContext
    LIO.OnGetPassword := DoGetPassword;
    LIO.OnGetPasswordEx := OnGetPasswordEx;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

{ TIdSSLIOHandlerSocketOpenSSL }

procedure TIdSSLIOHandlerSocketOpenSSL.InitComponent;
begin
  inherited InitComponent;
  IsPeer := False;
  fxSSLOptions := TIdSSLOptions.Create;
  fSSLLayerClosed := True;
  fSSLContext := nil;
end;

destructor TIdSSLIOHandlerSocketOpenSSL.Destroy;
begin
  FreeAndNil(fSSLSocket);
  if not IsPeer then begin
    //we do not destroy these in IsPeer equals true
    //because these do not belong to us when we are in a server.
    FreeAndNil(fSSLContext);
    FreeAndNil(fxSSLOptions);
  end;
  inherited Destroy;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.ConnectClient;
var
  LPassThrough: Boolean;
begin
  // RLebeau 1/11/07: In case a proxy is being used, pass through
  // any data from the base class unencrypted when setting up that
  // connection.  We should do this anyway since SSL hasn't been
  // initialized yet!
  LPassThrough := fPassThrough;
  fPassThrough := True;
  try
    inherited ConnectClient;
  finally
    fPassThrough := LPassThrough;
  end;
  DoBeforeConnect(Self);
  // CreateSSLContext(sslmClient);
  // CreateSSLContext(SSLOptions.fMode);
  StartSSL;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.StartSSL;
begin
  try
    Init;
  except
    on EIdOSSLCouldNotLoadSSLLibrary do begin
      if not PassThrough then raise;
    end;
  end;
  if not PassThrough then begin
    OpenEncodedConnection;
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.Close;
begin
  FreeAndNil(fSSLSocket);
  if not IsPeer then begin
    FreeAndNil(fSSLContext);
  end;
  inherited Close;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.Open;
begin
  FOpened := False;
  inherited Open;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.SetPassThrough(const Value: Boolean);
begin
  if fPassThrough <> Value then begin
    if not Value then begin
      if BindingAllocated then begin
        if Assigned(fSSLContext) then begin
          OpenEncodedConnection;
        end else begin
          raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
        end;
      end;
      {$IFDEF WIN32_OR_WIN64}
      // begin bug fix
      end
      else if BindingAllocated and (Win32MajorVersion >= 6) then
      begin
        // disables Vista+ SSL_Read and SSL_Write timeout fix
        Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_RCVTIMEO, 0);
        Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_SNDTIMEO, 0);
      // end bug fix
      {$ENDIF}
    end;
    fPassThrough := Value;
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.RecvEnc(var VBuffer: TIdBytes): Integer;
begin
  Result := fSSLSocket.Recv(VBuffer);
end;

function TIdSSLIOHandlerSocketOpenSSL.SendEnc(const ABuffer: TIdBytes;
  const AOffset, ALength: Integer): Integer;
begin
  Result := fSSLSocket.Send(ABuffer, AOffset, ALength);
end;

procedure TIdSSLIOHandlerSocketOpenSSL.AfterAccept;
begin
  try
    inherited AfterAccept;
    StartSSL;
  except
    Close;
    raise;
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.Init;
//see also TIdServerIOHandlerSSLOpenSSL.Init
begin
  if not Assigned(fSSLContext) then begin
    fSSLContext := TIdSSLContext.Create;
    with fSSLContext do begin
      Parent := Self;
      RootCertFile := SSLOptions.RootCertFile;
      CertFile := SSLOptions.CertFile;
      KeyFile := SSLOptions.KeyFile;
      DHParamsFile := SSLOptions.DHParamsFile;
      fVerifyDepth := SSLOptions.fVerifyDepth;
      fVerifyMode := SSLOptions.fVerifyMode;
      // fVerifyFile := SSLOptions.fVerifyFile;
      fVerifyDirs := SSLOptions.fVerifyDirs;
      fCipherList := SSLOptions.fCipherList;
      VerifyOn := Assigned(fOnVerifyPeer);
      StatusInfoOn := Assigned(fOnStatusInfo) or Assigned(fOnStatusInfoEx);
      //PasswordRoutineOn := Assigned(fOnGetPassword);
      fMethod :=  SSLOptions.Method;
      fSSLVersions := SSLOptions.SSLVersions;
      fMode := SSLOptions.Mode;
      fSSLContext.InitContext(sslCtxClient);
    end;
  end;
end;
//}

procedure TIdSSLIOHandlerSocketOpenSSL.DoStatusInfo(const AMsg: String);
begin
  if Assigned(fOnStatusInfo) then begin
    fOnStatusInfo(AMsg);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoStatusInfoEx(
  const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AWhereStr,
  ARetStr: String);
begin
  if Assigned(FOnStatusInfoEx) then begin
    FOnStatusInfoEx(Self,AsslSocket,AWhere,Aret,AWHereStr,ARetStr);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoGetPassword(var Password: AnsiString);
begin
  if Assigned(fOnGetPassword) then begin
    fOnGetPassword(Password);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoGetPasswordEx(var VPassword: AnsiString;
  const AIsWrite: Boolean);
begin
  if Assigned(fOnGetPasswordEx) then begin
    fOnGetPasswordEx(Self,VPassword,AIsWrite);
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.DoVerifyPeer(Certificate: TIdX509;
  AOk: Boolean; ADepth, AError: Integer): Boolean;
begin
  Result := True;
  if Assigned(fOnVerifyPeer) then begin
    Result := fOnVerifyPeer(Certificate, AOk, ADepth, AError);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.OpenEncodedConnection;
{$IFDEF WIN32_OR_WIN64}
var
  LTimeout: Integer;
{$ENDIF}
begin
  Assert(Binding<>nil);
  if not Assigned(fSSLSocket) then begin
    fSSLSocket := TIdSSLSocket.Create(Self);
  end;
  Assert(fSSLSocket.fSSLContext=nil);
  fSSLSocket.fSSLContext := fSSLContext;
  {$IFDEF WIN32_OR_WIN64}
  // begin bug fix
  if Win32MajorVersion >= 6 then
  begin
    // Note: Fix needed to allow SSL_Read and SSL_Write to timeout under
    // Vista+ when connection is dropped
    LTimeout := FReadTimeOut;
    if LTimeout <= 0 then begin
      LTimeout := 30000; // 30 seconds
    end;
    Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_RCVTIMEO, LTimeout);
    Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_SNDTIMEO, LTimeout);
  end;
  // end bug fix
  {$ENDIF}
  if IsPeer then begin
    fSSLSocket.Accept(Binding.Handle);
  end else begin
    fSSLSocket.Connect(Binding.Handle);
  end;
  fPassThrough := False;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoBeforeConnect(ASender: TIdSSLIOHandlerSocketOpenSSL);
begin
  if Assigned(OnBeforeConnect) then begin
    OnBeforeConnect(Self);
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.Clone: TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    LIO.SSLOptions.Assign( SSLOptions );
    LIO.OnStatusInfo := DoStatusInfo;
    LIO.OnGetPassword := DoGetPassword;
    LIO.OnVerifyPeer := DoVerifyPeer;
    LIO.fSSLSocket := TIdSSLSocket.Create(Self);
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

function TIdSSLIOHandlerSocketOpenSSL.CheckForError(ALastResult: Integer): Integer;
//var
//  err: Integer;
begin
  if PassThrough then begin
    Result := inherited CheckForError(ALastResult);
  end else begin
    Result := fSSLSocket.GetSSLError(ALastResult);
    if Result = SSL_ERROR_NONE then begin
      Result := 0;
      Exit;
    end;
    if Result = SSL_ERROR_SYSCALL then begin
      Result := inherited CheckForError(Integer(Id_SOCKET_ERROR));
      Exit;
    end;
    EIdOpenSSLAPISSLError.RaiseExceptionCode(Result, ALastResult, '');
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.RaiseError(AError: Integer);
begin
  if (PassThrough) or (AError = Id_WSAESHUTDOWN) or (AError = Id_WSAECONNABORTED) or (AError = Id_WSAECONNRESET) then begin
    inherited RaiseError(AError);
  end else begin
    EIdOpenSSLAPISSLError.RaiseException(fSSLSocket.fSSL, AError, '');
  end;
end;

{ TIdSSLContext }

constructor TIdSSLContext.Create;
begin
  inherited Create;
  //an exception here probably means that you are using the wrong version
  //of the openssl libraries. refer to comments at the top of this file.
  if not LoadOpenSSLLibrary then begin
    raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
  end;
  fVerifyMode := [];
  fMode := sslmUnassigned;
  fSessionId := 1;
end;

destructor TIdSSLContext.Destroy;
begin
  DestroyContext;
  inherited Destroy;
end;

procedure TIdSSLContext.DestroyContext;
begin
  if fContext <> nil then begin
    SSL_CTX_free(fContext);
    fContext := nil;
  end;
end;

procedure TIdSSLContext.InitContext(CtxMode: TIdSSLCtxMode);
var
  SSLMethod: PSSL_METHOD;
  error: TIdC_INT;
//  pCAname: PSTACK_X509_NAME;

begin
  // Destroy the context first
  DestroyContext;
  if fMode = sslmUnassigned then begin
    if CtxMode = sslCtxServer then begin
      fMode := sslmServer;
    end else begin
      fMode := sslmClient;
    end
  end;
  // get SSL method function (SSL2, SSL23, SSL3, TLS)
  SSLMethod := SetSSLMethod;
  // create new SSL context
  fContext := SSL_CTX_new(SSLMethod);
  if fContext = nil then begin
    raise EIdOSSLCreatingContextError.Create(RSSSLCreatingContextError);
  end;
  //set SSL Versions we will use
  if not (sslvSSLv2 in SSLVersions) then begin
    SSL_CTX_set_options(fContext, SSL_OP_NO_SSLv2);
  end;
  if not (sslvSSLv3 in SSLVersions) then begin
    SSL_CTX_set_options(fContext, SSL_OP_NO_SSLv3);
  end;
  if not (sslvTLSv1 in SSLVersions) then begin
    SSL_CTX_set_options(fContext, SSL_OP_NO_TLSv1);
  end;
  if not ( sslvTLSv1_1 in SSLVersions) then begin
    SSL_CTX_set_options(fContext, SSL_OP_NO_TLSv1_1);
  end;
  if not ( sslvTLSv1_2 in SSLVersions) then begin
    SSL_CTX_set_options(fContext, SSL_OP_NO_TLSv1_2);
  end;
  SSL_CTX_set_mode(fContext, SSL_MODE_AUTO_RETRY);
  // assign a password lookup routine
//  if PasswordRoutineOn then begin
    SSL_CTX_set_default_passwd_cb(fContext, @PasswordCallback);
    SSL_CTX_set_default_passwd_cb_userdata(fContext, Self);
//  end;
  SSL_CTX_set_default_verify_paths(fContext);
  // load key and certificate files
  if (RootCertFile <> '') or (VerifyDirs <> '') then begin    {Do not Localize}
    if not LoadRootCert then begin
       EIdOSSLLoadingRootCertError.RaiseException(RSSSLLoadingRootCertError);
    end;
  end;
  if CertFile <> '' then begin    {Do not Localize}
    if not LoadCert then begin
      EIdOSSLLoadingCertError.RaiseException(RSSSLLoadingCertError);
    end;
  end;
  if KeyFile <> '' then begin    {Do not Localize}
    if not LoadKey then begin
      EIdOSSLLoadingKeyError.RaiseException(RSSSLLoadingKeyError);
    end;
  end;
  if DHParamsFile <> '' then begin     {Do not Localize}
    if not LoadDHParams then begin
      EIdOSSLLoadingDHParamsError.RaiseException(RSSSLLoadingDHParamsError);
    end;
  end;
  if StatusInfoOn then begin
    SSL_CTX_set_info_callback(fContext, InfoCallback);
  end;
  //if_SSL_CTX_set_tmp_rsa_callback(hSSLContext, @RSACallback);
  if fCipherList <> '' then begin    {Do not Localize}
    error := SSL_CTX_set_cipher_list(fContext, PAnsiChar(fCipherList));
  end else begin
    error := SSL_CTX_set_cipher_list(fContext, SSL_DEFAULT_CIPHER_LIST);
  end;
  if error <= 0 then begin
    EIdOSSLLoadingKeyError.RaiseException(RSSSLSettingCipherError);
  end;
  if fVerifyMode <> [] then begin
    SetVerifyMode(fVerifyMode, VerifyOn);
  end;
  if CtxMode = sslCtxServer then begin
    SSL_CTX_set_session_id_context(fContext, PByte(@fSessionId), SizeOf(fSessionId));
  end;
  // CA list
  if RootCertFile <> '' then begin    {Do not Localize}
    SSL_CTX_set_client_CA_list(fContext, IndySSL_load_client_CA_file(RootCertFile));
  end
end;

procedure TIdSSLContext.SetVerifyMode(Mode: TIdSSLVerifyModeSet; CheckRoutine: Boolean);
var
  Func: TSSL_CTX_set_verify_callback;
begin
  if fContext<>nil then begin
//    SSL_CTX_set_default_verify_paths(fContext);
    if CheckRoutine then begin
      Func := VerifyCallback;
    end else begin
      Func := nil;
    end;
    SSL_CTX_set_verify(fContext, TranslateInternalVerifyToSSL(Mode), Func);
    SSL_CTX_set_verify_depth(fContext, fVerifyDepth);
  end;
end;

function TIdSSLContext.GetVerifyMode: TIdSSLVerifyModeSet;
begin
  Result := fVerifyMode;
end;
{
function TIdSSLContext.LoadVerifyLocations(FileName: String; Dirs: String): Boolean;
begin
  Result := False;

  if (Dirs <> '') or (FileName <> '') then begin
    if SSL_CTX_load_verify_locations(fContext, PAnsiChar(FileName), PAnsiChar(Dirs)) <= 0 then begin
      raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
    end;
  end;

  Result := True;
end;
}
function TIdSSLContext.SetSSLMethod: PSSL_METHOD;
begin
  if fMode = sslmUnassigned then begin
    raise EIdOSSLModeNotSet.create(RSOSSLModeNotSet);
  end;
  case fMethod of
    sslvSSLv2:
      case fMode of
        sslmServer : Result := SSLv2_server_method;
        sslmClient : Result := SSLv2_client_method;
      else
        Result := SSLv2_method;
      end;
    sslvSSLv23:
        case fMode of
          sslmServer : Result := SSLv23_server_method;
          sslmClient : Result := SSLv23_client_method;
        else
          Result := SSLv23_method;
        end;
    sslvSSLv3:
      case fMode of
        sslmServer : Result := SSLv3_server_method;
        sslmClient : Result := SSLv3_client_method;
      else
        Result := SSLv3_method;
      end;
    sslvTLSv1:
      case fMode of
        sslmServer : Result := TLSv1_server_method;
        sslmClient : Result := TLSv1_client_method;
      else
        Result := TLSv1_method;
      end;
    sslvTLSv1_1 :
      case fMode of
        sslmServer : Result := TLSv1_1_server_method;
        sslmClient : Result := TLSv1_1_client_method;
      else
        Result := TLSv1_1_method;
      end;
    sslvTLSv1_2 :
      case fMode of
        sslmServer : Result := TLSv1_2_server_method;
        sslmClient : Result := TLSv1_2_client_method;
      else
        Result := TLSv1_2_method;
      end;
  else
    raise EIdOSSLGetMethodError.Create(RSSSLGetMethodError);
  end;
end;

function TIdSSLContext.LoadRootCert: Boolean;
begin
    Result := IndySSL_CTX_load_verify_locations(
                   fContext,
                   RootCertFile,
                   VerifyDirs) > 0;
end;

function TIdSSLContext.LoadCert: Boolean;
begin
  Result := IndySSL_CTX_use_certificate_file(fContext, CertFile, SSL_FILETYPE_PEM) > 0;
end;

function TIdSSLContext.LoadKey: Boolean;
begin
  Result := IndySSL_CTX_use_PrivateKey_file(fContext, fsKeyFile, SSL_FILETYPE_PEM) > 0;
  if Result then begin
    Result := SSL_CTX_check_private_key(fContext) > 0;
  end;
end;

function TIdSSLContext.LoadDHParams: Boolean;
begin
  Result := IndySSL_CTX_use_DHparams_file(fContext, fsDHParamsFile, SSL_FILETYPE_PEM) > 0;
end;

//////////////////////////////////////////////////////////////

function TIdSSLContext.Clone: TIdSSLContext;
begin
  Result := TIdSSLContext.Create;
  Result.StatusInfoOn := StatusInfoOn;
//    property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
  Result.VerifyOn := VerifyOn;
  Result.Method := Method;
  Result.SSLVersions := SSLVersions;
  Result.Mode := Mode;
  Result.RootCertFile := RootCertFile;
  Result.CertFile := CertFile;
  Result.KeyFile := KeyFile;
  Result.VerifyMode := VerifyMode;
  Result.VerifyDepth := VerifyDepth;
end;

{ TIdSSLSocket }

constructor TIdSSLSocket.Create(Parent: TObject);
begin
  inherited Create;
  fParent := Parent;
end;

destructor TIdSSLSocket.Destroy;
begin
  if fSSL <> nil then begin
    if (fSSLContext <> nil) and (fSSLContext.StatusInfoOn) and
       (fSSLContext.fContext <> nil) then begin
      SSL_CTX_set_info_callback(fSSLContext.fContext, nil);
    end;
    //SSL_set_shutdown(fSSL, SSL_SENT_SHUTDOWN);
    SSL_shutdown(fSSL);
    SSL_free(fSSL);
    fSSL := nil;
  end;
  FreeAndNil(fSSLCipher);
  FreeAndNil(fPeerCert);
  inherited Destroy;
end;

function TIdSSLSocket.GetSSLError(retCode: Integer): Integer;
begin
  // COMMENT!!!
  // I found out that SSL layer should not interpret errors, cause they will pop up
  // on the socket layer. Only thing that the SSL layer should consider is key
  // or protocol renegotiation. This is done by loop in read and write
  Result := SSL_get_error(fSSL, retCode);
  case Result of
    SSL_ERROR_NONE:
      Result := SSL_ERROR_NONE;
    SSL_ERROR_WANT_WRITE:
      Result := SSL_ERROR_WANT_WRITE;
    SSL_ERROR_WANT_READ:
      Result := SSL_ERROR_WANT_READ;
    SSL_ERROR_ZERO_RETURN:
      Result := SSL_ERROR_ZERO_RETURN;
      //Result := SSL_ERROR_NONE;
      {
      // ssl layer has been disconnected, it is not necessary that also
      // socked has been closed
      case Mode of
        sslemClient: begin
          case Action of
            sslWrite: begin
              if retCode = 0 then begin
                Result := 0;
              end
              else begin
                raise EIdException.Create(RSOSSLConnectionDropped);
              end;
            end;
        end;
      end;}

        //raise EIdException.Create(RSOSSLConnectionDropped);
      // X509_LOOKUP event is not really an error, just an event
    // SSL_ERROR_WANT_X509_LOOKUP:
        // raise EIdException.Create(RSOSSLCertificateLookup);
    SSL_ERROR_SYSCALL:
      Result := SSL_ERROR_SYSCALL;
      // Result := SSL_ERROR_NONE;

        {//raise EIdException.Create(RSOSSLInternal);
        if (retCode <> 0) or (DataLen <> 0) then begin
          raise EIdException.Create(RSOSSLConnectionDropped);
        end
        else begin
          Result := 0;
        end;}

    SSL_ERROR_SSL:
      // raise EIdException.Create(RSOSSLInternal);
      Result := SSL_ERROR_SSL;
      // Result := SSL_ERROR_NONE;
  end;
end;

procedure TIdSSLSocket.Accept(const pHandle: TIdStackSocketHandle);
//Accept and Connect have a lot of duplicated code
var
  error: Integer;
  StatusStr: String;
  LParentIO: TIdSSLIOHandlerSocketOpenSSL;
begin
  Assert(fSSL=nil);
  Assert(fSSLContext<>nil);
  if fParent is TIdSSLIOHandlerSocketOpenSSL then begin
    LParentIO := fParent as TIdSSLIOHandlerSocketOpenSSL;
  end else begin
    LParentIO := nil;
  end;
  fSSL := SSL_new(fSSLContext.fContext);
  if fSSL = nil then begin
    raise EIdOSSLCreatingSessionError.Create(RSSSLCreatingSessionError);
  end;
  error := SSL_set_app_data(fSSL, Self);
  if error <= 0 then begin
    EIdOSSLDataBindingError.RaiseException(fSSL, error, RSSSLDataBindingError);
  end;
  error := SSL_set_fd(fSSL, pHandle);
  if error <= 0 then begin
    EIdOSSLFDSetError.RaiseException(fSSL, error, RSSSLFDSetError);
  end;
  // RLebeau: if this socket's IOHandler was cloned, no need to reuse the
  // original IOHandler's active session ID, since this is a server socket
  // that generates its own sessions...
  error := SSL_accept(fSSL);
  if error <= 0 then begin
    EIdOSSLAcceptError.RaiseException(fSSL, error, RSSSLAcceptError);
  end;
  StatusStr := 'Cipher: name = ' + Cipher.Name + '; ' +    {Do not Localize}
               'description = ' + Cipher.Description + '; ' +    {Do not Localize}
               'bits = ' + IntToStr(Cipher.Bits) + '; ' +    {Do not Localize}
               'version = ' + Cipher.Version + '; ';    {Do not Localize}
  if LParentIO <> nil then begin
    LParentIO.DoStatusInfo(StatusStr);
  end;
end;

procedure TIdSSLSocket.Connect(const pHandle: TIdStackSocketHandle);
var
  error: Integer;
  StatusStr: String;
  LParentIO: TIdSSLIOHandlerSocketOpenSSL;
begin
  Assert(fSSL=nil);
  Assert(fSSLContext<>nil);
  if fParent is TIdSSLIOHandlerSocketOpenSSL then begin
    LParentIO := fParent as TIdSSLIOHandlerSocketOpenSSL;
  end else begin
    LParentIO := nil;
  end;
  fSSL := SSL_new(fSSLContext.fContext);
  if fSSL = nil then begin
    raise EIdOSSLCreatingSessionError.Create(RSSSLCreatingSessionError);
  end;
  error := SSL_set_app_data(fSSL, Self);
  if error <= 0 then begin
    EIdOSSLDataBindingError.RaiseException(fSSL, error, RSSSLDataBindingError);
  end;
  error := SSL_set_fd(fSSL, pHandle);
  if error <= 0 then begin
    EIdOSSLFDSetError.RaiseException(fSSL, error, RSSSLFDSetError);
  end;
  // RLebeau: if this socket's IOHandler was cloned, reuse the
  // original IOHandler's active session ID...
  if (LParentIO <> nil) and (LParentIO.fSSLSocket <> nil) and
     (LParentIO.fSSLSocket <> Self) then
  begin
    SSL_copy_session_id(fSSL, LParentIO.fSSLSocket.fSSL);
  end;
  error := SSL_connect(fSSL);
  if error <= 0 then begin
    EIdOSSLConnectError.RaiseException(fSSL, error, RSSSLConnectError);
  end;
  StatusStr := 'Cipher: name = ' + Cipher.Name + '; ' +    {Do not Localize}
               'description = ' + Cipher.Description + '; ' +    {Do not Localize}
               'bits = ' + IntToStr(Cipher.Bits) + '; ' +    {Do not Localize}
               'version = ' + Cipher.Version + '; ';    {Do not Localize}
  if LParentIO <> nil then begin
    LParentIO.DoStatusInfo(StatusStr);
  end;
end;

function TIdSSLSocket.Recv(var ABuffer: TIdBytes): Integer;
var
  ret, err: Integer;
begin
  repeat
    ret := SSL_read(fSSL, @ABuffer[0], Length(ABuffer));
    if ret > 0 then begin
      Result := ret;
      Exit;
    end;
    err := GetSSLError(ret);
    if (err = SSL_ERROR_WANT_READ) or (err = SSL_ERROR_WANT_WRITE) then begin
      Continue;
    end;
    if err = SSL_ERROR_ZERO_RETURN then begin
      Result := 0;
    end else begin
      Result := ret;
    end;
    Exit;
  until False;
end;

function TIdSSLSocket.Send(const ABuffer: TIdBytes; AOffset, ALength: Integer): Integer;
var
  ret, err: Integer;
begin
  Result := 0;
  repeat
    ret := SSL_write(fSSL, @ABuffer[AOffset], ALength);
    if ret > 0 then begin
      Inc(Result, ret);
      Inc(AOffset, ret);
      Dec(ALength, ret);
      if ALength < 1 then begin
        Exit;
      end;
      Continue;
    end;
    err := GetSSLError(ret);
    if (err = SSL_ERROR_WANT_READ) or (err = SSL_ERROR_WANT_WRITE) then begin
      Continue;
    end;
    if err = SSL_ERROR_ZERO_RETURN then begin
      Result := 0;
    end else begin
      Result := ret;
    end;
    Exit;
  until False;
end;

function TIdSSLSocket.GetPeerCert: TIdX509;
var
  LX509: PX509;
begin
  if fPeerCert = nil then begin
    LX509 := SSL_get_peer_certificate(fSSL);
    if LX509 <> nil then begin
      fPeerCert := TIdX509.Create(LX509, False);
    end;
  end;
  Result := fPeerCert;
end;

function TIdSSLSocket.GetSSLCipher: TIdSSLCipher;
begin
  if (fSSLCipher = nil) and (fSSL<>nil) then begin
    fSSLCipher := TIdSSLCipher.Create(Self);
  end;
  Result := fSSLCipher;
end;

function TIdSSLSocket.GetSessionID: TIdSSLByteArray;
var
  pSession: PSSL_SESSION;
begin
  Result.Length := 0;
  Result.Data := nil;
  if Assigned(SSL_get_session) and Assigned(SSL_SESSION_get_id) then
  begin
    if fSSL <> nil then begin
      pSession := SSL_get_session(fSSL);
      if pSession <> nil then begin
        Result.Data := SSL_SESSION_get_id(pSession, @Result.Length);
      end;
    end;
  end;
end;

function  TIdSSLSocket.GetSessionIDAsString:String;
var
  Data: TIdSSLByteArray;
  i: TIdC_UINT;
begin
  Result := '';    {Do not Localize}
  Data := GetSessionID;
  if Data.Length > 0 then begin
    for i := 0 to Data.Length-1 do begin
      Result := Result + IndyFormat('%.2x', [Byte(Data.Data[I])]);{do not localize}
    end;
  end;
end;

procedure TIdSSLSocket.SetCipherList(CipherList: String);
//var
//  tmpPStr: PAnsiChar;
begin
{
  fCipherList := CipherList;
  fCipherList_Ch := True;
  aCipherList := aCipherList+#0;
  if hSSL <> nil then f_SSL_set_cipher_list(hSSL, @aCipherList[1]);
}
end;

///////////////////////////////////////////////////////////////
//  X509 Certificate
///////////////////////////////////////////////////////////////

{ TIdX509Name }

function TIdX509Name.CertInOneLine: String;
var
  LOneLine: array[0..2048] of AnsiChar;
begin
  if FX509Name = nil then begin
    Result := '';    {Do not Localize}
  end else begin
    Result := String(StrPas(X509_NAME_oneline(FX509Name, PAnsiChar(@LOneLine), SizeOf(LOneLine))));
  end;
end;

function TIdX509Name.GetHash: TIdSSLULong;
begin
  if FX509Name = nil then begin
    FillChar(Result, SizeOf(Result), 0)
  end else begin
    Result.C1 := X509_NAME_hash(FX509Name);
  end;
end;

function TIdX509Name.GetHashAsString: String;
begin
  Result := IndyFormat('%.8x', [Hash.L1]); {do not localize}
end;

constructor TIdX509Name.Create(aX509Name: PX509_NAME);
begin
  Inherited Create;
  FX509Name := aX509Name;
end;


///////////////////////////////////////////////////////////////
//  X509 Certificate
///////////////////////////////////////////////////////////////

{ TIdX509Info }

constructor TIdX509Info.Create(aX509: PX509);
begin
  inherited Create;
  FX509 := aX509;
end;

{ TIdX509Fingerprints }

function TIdX509Fingerprints.GetMD5: TIdSSLEVP_MD;
begin
  CheckMD5Permitted;
  X509_digest(FX509, EVP_md5, PByte(@Result.MD), Result.Length);
end;

function TIdX509Fingerprints.GetMD5AsString: String;
begin
  Result := MDAsString(MD5);
end;

function TIdX509Fingerprints.GetSHA1: TIdSSLEVP_MD;
begin
  X509_digest(FX509, EVP_sha1, PByte(@Result.MD), Result.Length);
end;

function TIdX509Fingerprints.GetSHA1AsString: String;
begin
  Result := MDAsString(SHA1);
end;

function TIdX509Fingerprints.GetSHA224 : TIdSSLEVP_MD;
begin
  if Assigned(EVP_sha224) then begin
    X509_digest(FX509, EVP_sha224, PByte(@Result.MD), Result.Length);
  end else begin
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

function TIdX509Fingerprints.GetSHA224AsString : String;
begin
  if Assigned(EVP_sha224) then begin
    Result := MDAsString(SHA224);
  end else begin
    Result := '';
  end;
end;

function TIdX509Fingerprints.GetSHA256 : TIdSSLEVP_MD;
begin
  if Assigned(EVP_sha256) then begin
    X509_digest(FX509, EVP_sha256, PByte(@Result.MD), Result.Length);
  end else begin
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

function TIdX509Fingerprints.GetSHA256AsString : String;
begin
  if Assigned(EVP_sha256) then begin
    Result := MDAsString(SHA256);
  end else begin
    Result := '';
  end;
end;

function TIdX509Fingerprints.GetSHA384 : TIdSSLEVP_MD;
begin
  if Assigned(EVP_SHA384) then begin
    X509_digest(FX509, EVP_SHA384, PByte(@Result.MD), Result.Length);
  end else begin
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

function TIdX509Fingerprints.GetSHA384AsString : String;
begin
  if Assigned(EVP_SHA384) then begin
    Result := MDAsString(SHA384);
  end else begin
    Result := '';
  end;
end;

function TIdX509Fingerprints.GetSHA512 : TIdSSLEVP_MD;
begin
  if Assigned(EVP_sha512) then begin
    X509_digest(FX509, EVP_sha512, PByte(@Result.MD), Result.Length);
  end else begin
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

function TIdX509Fingerprints.GetSHA512AsString : String;
begin
  if Assigned(EVP_sha512) then begin
    Result := MDAsString(SHA512);
  end else begin
    Result := '';
  end;
end;

{ TIdX509SigInfo }

function TIdX509SigInfo.GetSignature: String;
begin
  Result := BytesToHexString(FX509^.signature^.data, FX509^.signature^.length);
end;

function TIdX509SigInfo.GetSigType: TIdC_INT;
begin
  Result := X509_get_signature_type(FX509);
end;

function TIdX509SigInfo.GetSigTypeAsString: String;
begin
  Result := String(OBJ_nid2ln(SigType));
end;

{ TIdX509 }

constructor TIdX509.Create(aX509: PX509; aCanFreeX509: Boolean = True);
begin
  inherited Create;
  //don't create FDisplayInfo unless specifically requested.
  FDisplayInfo := nil;
  FX509 := aX509;
  FCanFreeX509 := aCanFreeX509;
  FFingerprints := TIdX509Fingerprints.Create(FX509);
  FSigInfo := TIdX509SigInfo.Create(FX509);
  FSubject := nil;
  FIssuer := nil;
end;

destructor TIdX509.Destroy;
begin
  FreeAndNil(FDisplayInfo);
  FreeAndNil(FSubject);
  FreeAndNil(FIssuer);
  FreeAndNil(FFingerprints);
  FreeAndNil(FSigInfo);
  { If the X.509 certificate handle was obtained from a certificate
  store or from the SSL connection as a peer certificate, then DO NOT
  free it here!  The memory is owned by the OpenSSL library and will
  crash the library if Indy tries to free its private memory here }
  if FCanFreeX509 then begin
    X509_free(FX509);
  end;
  inherited Destroy;
end;


function TIdX509.GetDisplayInfo: TStrings;
begin
  if not Assigned(FDisplayInfo) then begin
    FDisplayInfo := TStringList.Create;
    DumpCert(FDisplayInfo, FX509);
  end;
  Result := FDisplayInfo;
end;

function TIdX509.GetSerialNumber: String;
var
  LSN : PASN1_INTEGER;
begin
  if FX509 <> nil then begin
    LSN := X509_get_serialNumber(FX509);
    Result := BytesToHexString(LSN.data, LSN.length);
  end else begin
    Result := '';
  end;
end;

function TIdX509.GetVersion : TIdC_LONG;
begin
  Result := X509_get_version(FX509);
end;

function TIdX509.RSubject: TIdX509Name;
var
  Lx509_name: PX509_NAME;
Begin
  if not Assigned(FSubject) then begin
    if FX509 <> nil then begin
      Lx509_name := X509_get_subject_name(FX509);
    end else begin
      Lx509_name := nil;
    end;
    FSubject := TIdX509Name.Create(Lx509_name);
  end;
  Result := FSubject;
end;

function TIdX509.RIssuer: TIdX509Name;
var
  Lx509_name: PX509_NAME;
begin
  if not Assigned(FIssuer) then begin
    if FX509 <> nil then begin
      Lx509_name := X509_get_issuer_name(FX509);
    end else begin
      Lx509_name := nil;
    end;
    FIssuer := TIdX509Name.Create(Lx509_name);
  End;
  Result := FIssuer;
end;

function TIdX509.RFingerprint: TIdSSLEVP_MD;
begin
  X509_digest(FX509, EVP_md5, PByte(@Result.MD), Result.Length);
end;

function TIdX509.RFingerprintAsString: String;
begin
  Result := MDAsString(Fingerprint);
end;

function TIdX509.RnotBefore: TDateTime;
begin
  if FX509 = nil then begin
    Result := 0
  end else begin                                    
    //This is a safe typecast since PASN1_UTCTIME and PASN1_TIME are really
    //pointers to ASN1 strings since ASN1_UTCTIME amd ASM1_TIME are ASN1_STRING.
    Result := UTCTime2DateTime(PASN1_UTCTIME(X509_get_notBefore(FX509)));
  end;
end;

function TIdX509.RnotAfter:TDateTime;
begin
  if FX509 = nil then begin
    Result := 0
  end else begin
    Result := UTCTime2DateTime(PASN1_UTCTIME(X509_get_notAfter(FX509)));
  end;
end;

///////////////////////////////////////////////////////////////
//  TIdSSLCipher
///////////////////////////////////////////////////////////////
constructor TIdSSLCipher.Create(AOwner: TIdSSLSocket);
begin
  inherited Create;
  FSSLSocket := AOwner;
end;

destructor TIdSSLCipher.Destroy;
begin
  inherited Destroy;
end;

function TIdSSLCipher.GetDescription;
var
  Buf: Array[0..1024] of AnsiChar;
begin
  Result := String(StrPas(SSL_CIPHER_description(SSL_get_current_cipher(FSSLSocket.fSSL), PAnsiChar(@Buf[0]), SizeOf(Buf)-1)));
end;

function TIdSSLCipher.GetName:String;
begin
  Result := String(StrPas(SSL_CIPHER_get_name(SSL_get_current_cipher(FSSLSocket.fSSL))));
end;

function TIdSSLCipher.GetBits:TIdC_INT;
begin
  SSL_CIPHER_get_bits(SSL_get_current_cipher(FSSLSocket.fSSL), Result);
end;

function TIdSSLCipher.GetVersion:String;
begin
  Result := String(StrPas(SSL_CIPHER_get_version(SSL_get_current_cipher(FSSLSocket.fSSL))));
end;

initialization
  Assert(SSLIsLoaded=nil);
  SSLIsLoaded := TIdThreadSafeBoolean.Create;
  RegisterSSL('OpenSSL','Indy Pit Crew',                                  {do not localize}
    'Copyright '+Char(169)+' 1993 - 2012'#10#13 +                                     {do not localize}
    'Chad Z. Hower (Kudzu) and the Indy Pit Crew. All rights reserved.',  {do not localize}
    'Open SSL Support DLL Delphi and C++Builder interface',               {do not localize}
    'http://www.indyproject.org/'#10#13 +                                 {do not localize}
    'Original Author - Gregor Ibic',                                        {do not localize}
    TIdSSLIOHandlerSocketOpenSSL,
    TIdServerIOHandlerSSLOpenSSL);
finalization
  UnLoadOpenSSLLibrary;
  //free the lock last as unload makes calls that use it
  FreeAndNil(SSLIsLoaded);
end.
