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
{   Rev 1.39    16/02/2005 23:26:08  CCostelloe
{ Changed OnVerifyPeer.  Breaks existing implementation of OnVerifyPeer.  See
{ long comment near top of file.
}
{
{   Rev 1.38    1/31/05 6:02:28 PM  RLebeau
{ Updated _GetThreadId() callback to reflect changes in IdGlobal unit
}
{
{   Rev 1.37    7/27/2004 1:54:26 AM  JPMugaas
{ Now should use the Intercept property for sends.
}
{
{   Rev 1.36    2004-05-18 21:38:36  Mattias
{ Fixed unload bug
}
{
{   Rev 1.35    2004-05-07 16:34:26  Mattias
{ Implemented  OpenSSL locking callbacks
}
{
{   Rev 1.34    27/04/2004 9:38:48  HHariri
{ Added compiler directive so it works in BCB
}
{
{   Rev 1.33    4/26/2004 12:41:10 AM  BGooijen
{ Fixed WriteDirect
}
{
{   Rev 1.32    2004.04.08 10:55:30 PM  czhower
{ IOHandler chanegs.
}
{
{   Rev 1.31    3/7/2004 9:02:58 PM  JPMugaas
{ Fixed compiler warning about visibility.
}
{
{   Rev 1.30    2004.03.07 11:46:40 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.29    2/7/2004 5:50:50 AM  JPMugaas
{ Fixed Copyright.
}
{
{   Rev 1.28    2/6/2004 3:45:56 PM  JPMugaas
{ Only a start on NET porting.  This is not finished and will not compile on
{ DotNET>
}
{
{   Rev 1.27    2004.02.03 5:44:24 PM  czhower
{ Name changes
}
{
{   Rev 1.26    1/21/2004 4:03:48 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.25    1/14/2004 11:39:10 AM  JPMugaas
{ Server IOHandler now works.  Accept was commented out.
}
{
{   Rev 1.24    2003.11.29 10:19:28 AM  czhower
{ Updated for core change to InputBuffer.
}
{
{   Rev 1.23    10/21/2003 10:09:14 AM  JPMugaas
{ Intercept enabled.
}
{
{   Rev 1.22    10/21/2003 09:41:38 AM  JPMugaas
{ Updated for new API.  Verified with TIdFTP with active and passive transfers
{ as well as clear and protected data channels.
}
{
{   Rev 1.21    10/21/2003 07:32:38 AM  JPMugaas
{ Checked in what I have.  Porting still continues.
}
{
    Rev 1.20    10/17/2003 1:08:08 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.19    2003.10.12 6:36:44 PM  czhower
{ Now compiles.
}
{
{   Rev 1.18    9/19/2003 11:24:58 AM  JPMugaas
{ Should compile.
}
{
{   Rev 1.17    9/18/2003 10:20:32 AM  JPMugaas
{ Updated for new API.
}
{
{   Rev 1.16    2003.07.16 3:26:52 PM  czhower
{ Fixed for a core change.
}
{
    Rev 1.15    6/30/2003 1:52:22 PM  BGooijen
  Changed for new buffer interface
}
{
    Rev 1.14    6/29/2003 5:42:02 PM  BGooijen
  fixed probelm in TIdSSLIOHandlerSocketOpenSSL.SetPassThrough that Henrick
  Hellström reported
}
{
    Rev 1.13    5/7/2003 7:13:00 PM  BGooijen
  changed Connected to BindingAllocated in ReadFromSource
}
{
    Rev 1.12    3/30/2003 12:16:40 AM  BGooijen
  bugfixed+ added MakeFTPSvrPort/MakeFTPSvrPasv
}
{
{   Rev 1.11    3/14/2003 06:56:08 PM  JPMugaas
{ Added a clone method to the SSLContext.
}
{
{   Rev 1.10    3/14/2003 05:29:10 PM  JPMugaas
{ Change to prevent an AV when shutting down the FTP Server.
}
{
    Rev 1.9    3/14/2003 10:00:38 PM  BGooijen
  Removed TIdServerIOHandlerSSLBase.PeerPassthrough, the ssl is now enabled in
  the server-protocol-files
}
{
{   Rev 1.8    3/13/2003 11:55:38 AM  JPMugaas
{ Updated registration framework to give more information.
}
{
{   Rev 1.7    3/13/2003 11:07:14 AM  JPMugaas
{ OpenSSL classes renamed.
}
{
{   Rev 1.6    3/13/2003 10:28:16 AM  JPMugaas
{ Forgot the reegistration - OOPS!!!
}
{
{   Rev 1.5    3/13/2003 09:49:42 AM  JPMugaas
{ Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
{ can plug-in their products.
}
{
    Rev 1.4    3/13/2003 10:20:08 AM  BGooijen
  Server side fibers
}
{
{   Rev 1.3    2003.02.25 3:56:22 AM  czhower
}
{
    Rev 1.2    2/5/2003 10:27:46 PM  BGooijen
  Fixed bug in OpenEncodedConnection
}
{
    Rev 1.1    2/4/2003 6:31:22 PM  BGooijen
  Fixed for Indy 10
}
{
{   Rev 1.0    11/13/2002 08:01:24 AM  JPMugaas
}
unit IdSSLOpenSSL;
{
  Author: Gregor Ibic (gregor.ibic@intelicom.si)
  Copyright: (c) Gregor Ibic, Intelicom d.o.o and Indy Working Group.
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

interface
{$TYPEDADDRESS OFF}
{$I IdCompilerDefines.inc}
uses
  Classes,
  IdGlobal,
  IdException,
  IdStackConsts,
  IdSocketHandle,
  {$IFNDEF DOTNET}
  IdSSLOpenSSLHeaders,
  {$ELSE}
  IdSSLOpenSSLHeadersNET,
  {$ENDIF}
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
  IdSys,
  IdYarn;

type
  TIdX509 = class;

  TIdSSLVersion = (sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1);
  TIdSSLMode = (sslmUnassigned, sslmClient, sslmServer, sslmBoth);
  TIdSSLVerifyMode = (sslvrfPeer, sslvrfFailIfNoPeerCert, sslvrfClientOnce);
  TIdSSLVerifyModeSet = set of TIdSSLVerifyMode;
  TIdSSLCtxMode = (sslCtxClient, sslCtxServer);
  TIdSSLAction = (sslRead, sslWrite);

  TULong = packed record
    case Byte of
      0: (B1,B2,B3,B4: Byte);
      1: (W1,W2: Word);
      2: (L1: Longint);
      3: (C1: Cardinal);
  end;

  TEVP_MD = record
    Length: Integer;
    MD: Array[0..OPENSSL_EVP_MAX_MD_SIZE-1] of Char;
  end;

  TByteArray = record
    Length: Integer;
    Data: PChar;
  End;

  TIdSSLIOHandlerSocketOpenSSL = class;
  TIdSSLCipher = class;

  TCallbackEvent  = procedure(Msg: String) of object;
  TPasswordEvent  = procedure(var Password: String) of object;
  TVerifyPeerEvent  = function(Certificate: TIdX509; AOk: Boolean): Boolean of object;
  TIOHandlerNotify = procedure(ASender: TIdSSLIOHandlerSocketOpenSSL) of object;

  TIdSSLOptions = class(TPersistent)
  protected
    fsRootCertFile, fsCertFile, fsKeyFile: String;
    fMethod: TIdSSLVersion;
    fMode: TIdSSLMode;

    fVerifyDepth: Integer;
    fVerifyMode: TIdSSLVerifyModeSet;
    //fVerifyFile,
    fVerifyDirs, fCipherList: String;
    procedure AssignTo(ASource: TPersistent); override;
  published
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property CertFile: String read fsCertFile write fsCertFile;
    property KeyFile: String read fsKeyFile write fsKeyFile;
    property Method: TIdSSLVersion read fMethod write fMethod;
    property Mode: TIdSSLMode read fMode write fMode;
    property VerifyMode: TIdSSLVerifyModeSet read fVerifyMode write fVerifyMode;
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;
//    property VerifyFile: String read fVerifyFile write fVerifyFile;
    property VerifyDirs: String read fVerifyDirs write fVerifyDirs;
    property CipherList: String read fCipherList write fCipherList;
  public
    // procedure Assign(ASource: TPersistent); override;
  end;

  TIdSSLContext = class(TObject)
  protected
    fMethod: TIdSSLVersion;
    fMode: TIdSSLMode;
    fsRootCertFile, fsCertFile, fsKeyFile: String;
    fVerifyDepth: Integer;
    fVerifyMode: TIdSSLVerifyModeSet;
//    fVerifyFile: String;
    fVerifyDirs: String;
    fCipherList: String;
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
    property StatusInfoOn: Boolean read fStatusInfoOn write fStatusInfoOn;
//    property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
    property VerifyOn: Boolean read fVerifyOn write fVerifyOn;
  published
    property Method: TIdSSLVersion read fMethod write fMethod;
    property Mode: TIdSSLMode read fMode write fMode;
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property CertFile: String read fsCertFile write fsCertFile;
    property KeyFile: String read fsKeyFile write fsKeyFile;
//    property VerifyMode: TIdSSLVerifyModeSet read GetVerifyMode write SetVerifyMode;
    property VerifyMode: TIdSSLVerifyModeSet read fVerifyMode write fVerifyMode;
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;
  end;

  TIdSSLSocket = class(TObject)
  private
    fPeerCert: TIdX509;
    //fCipherList: String;
    fSSLCipher: TIdSSLCipher;
    fParent: TObject;
    fSSLContext: TIdSSLContext;
    function GetPeerCert: TIdX509;
    function GetSSLError(retCode: Integer): Integer;
    function GetSSLCipher: TIdSSLCipher;
  public
    fSSL: PSSL;
    //
    constructor Create(Parent: TObject);
    procedure Accept(const pHandle: TIdStackSocketHandle; fSSLContext: TIdSSLContext);
    procedure Connect(const pHandle: TIdStackSocketHandle; fSSLContext: TIdSSLContext);
    function Send(const ABuf : TIdBytes): integer;
    function Recv(var ABuf : TIdBytes): integer;
    destructor Destroy; override;
    function GetSessionID: TByteArray;
    function GetSessionIDAsString:String;
    procedure SetCipherList(CipherList: String);
    //
    property PeerCert: TIdX509 read GetPeerCert;
    property Cipher: TIdSSLCipher read GetSSLCipher;
  end;

  TIdSSLIOHandlerSocketOpenSSL = class(TIdSSLIOHandlerSocketBase)
  private
    fSSLContext: TIdSSLContext;
    fxSSLOptions: TIdSSLOptions;
    fSSLSocket: TIdSSLSocket;
    //fPeerCert: TIdX509;
    fOnStatusInfo: TCallbackEvent;
    fOnGetPassword: TPasswordEvent;
    fOnVerifyPeer: TVerifyPeerEvent;
    fSSLLayerClosed: Boolean;
    fOnBeforeConnect: TIOHandlerNotify;
    // function GetPeerCert: TIdX509;
    //procedure CreateSSLContext(axMode: TIdSSLMode);
    //

  protected
    procedure SetPassThrough(const Value: Boolean); override;
    procedure DoBeforeConnect(ASender: TIdSSLIOHandlerSocketOpenSSL); virtual;
    procedure DoStatusInfo(Msg: String); virtual;
    procedure DoGetPassword(var Password: String); virtual;
    function DoVerifyPeer(Certificate: TIdX509; AOk: Boolean): Boolean; virtual;
    function RecvEnc(var ABuf : TIdBytes): integer; virtual;
    function SendEnc(const ABuf : TIdBytes): integer; virtual;
    procedure Init;
    procedure OpenEncodedConnection; virtual;
    //some overrides from base classes
    procedure InitComponent; override;

    procedure ConnectClient; override;
    function ReadFromSource(ARaiseExceptionIfDisconnected: Boolean = True;
     ATimeout: Integer = IdTimeoutDefault;
     ARaiseExceptionOnTimeout: Boolean = True): Integer; override;
  public
    procedure WriteDirect(var ABuffer: TIdBytes); override;
    destructor Destroy; override;
    function Clone :  TIdSSLIOHandlerSocketBase; override;
    procedure StartSSL; override;

    procedure AfterAccept; override;

    procedure Close; override;
    procedure Open; override;

    function Recv(var ABuf : TIdBytes): integer;
    function Send(const ABuf : TIdBytes): integer;

    property SSLSocket: TIdSSLSocket read fSSLSocket write fSSLSocket;
    property PassThrough: Boolean read fPassThrough write SetPassThrough;

    property OnBeforeConnect: TIOHandlerNotify read fOnBeforeConnect write fOnBeforeConnect;
    property SSLContext: TIdSSLContext read fSSLContext write fSSLContext;
  published
    property SSLOptions: TIdSSLOptions read fxSSLOptions write fxSSLOptions;
    property OnStatusInfo: TCallbackEvent read fOnStatusInfo write fOnStatusInfo;
    property OnGetPassword: TPasswordEvent read fOnGetPassword write fOnGetPassword;
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer write fOnVerifyPeer;
  end;

  TIdServerIOHandlerSSLOpenSSL = class(TIdServerIOHandlerSSLBase)
  private
    fSSLContext: TIdSSLContext;
    fxSSLOptions: TIdSSLOptions;
//    fPeerCert: TIdX509;
//    function GetPeerCert: TIdX509;
    fIsInitialized: Boolean;
    fOnStatusInfo: TCallbackEvent;
    fOnGetPassword: TPasswordEvent;
    fOnVerifyPeer: TVerifyPeerEvent;

    //procedure CreateSSLContext(axMode: TIdSSLMode);
    //procedure CreateSSLContext;
  protected
    procedure DoStatusInfo(Msg: String); virtual;
    procedure DoGetPassword(var Password: String); virtual;
    function DoVerifyPeer(Certificate: TIdX509; AOk: Boolean): Boolean; virtual;
    procedure InitComponent; override;
  public
    procedure Init; override;

    // AListenerThread is a thread and not a yarn. Its the listener thread.
    function Accept(
      ASocket: TIdSocketHandle;
      AListenerThread: TIdThread;
      AYarn: TIdYarn
      ): TIdIOHandler; override;

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
    property OnGetPassword: TPasswordEvent read fOnGetPassword write fOnGetPassword;
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer write fOnVerifyPeer;
  end;

  TIdX509Name = class(TObject)
  private
    fX509Name: PX509_NAME;
    function CertInOneLine: String;
    function GetHash: TULong;
    function GetHashAsString: String;
  public
    constructor Create(aX509Name: PX509_NAME);
    //
    property Hash: TULong read GetHash;
    property HashAsString: string read GetHashAsString;
    property OneLine: string read CertInOneLine;
  end;

  TIdX509 = class(TObject)
  protected
    FX509    : PX509;
    FSubject : TIdX509Name;
    FIssuer  : TIdX509Name;
    function RSubject:TIdX509Name;
    function RIssuer:TIdX509Name;
    function RnotBefore:TDateTime;
    function RnotAfter:TDateTime;
    function RFingerprint:TEVP_MD;
    function RFingerprintAsString:String;
  public
    Constructor Create(aX509: PX509); virtual;
    Destructor Destroy; override;
    //
    property Fingerprint: TEVP_MD read RFingerprint;
    property FingerprintAsString: String read RFingerprintAsString;
    property Subject: TIdX509Name read RSubject;
    property Issuer: TIdX509Name read RIssuer;
    property notBefore: TDateTime read RnotBefore;
    property notAfter: TDateTime read RnotAfter;
  end;

  TIdSSLCipher = class(TObject)
  private
    FSSLSocket: TIdSSLSocket;
    function GetDescription: String;
    function GetName: String;
    function GetBits: Integer;
    function GetVersion: String;
  public
    constructor Create(AOwner: TIdSSLSocket);
    destructor Destroy; override;
  published
    property Description: String read GetDescription;
    property Name: String read GetName;
    property Bits: Integer read GetBits;
    property Version: String read GetVersion;
  end;


  type
    EIdOpenSSLError = class(EIdException);
    EIdOpenSSLLoadError = class(EIdOpenSSLError);
    EIdOSSLCouldNotLoadSSLLibrary = class(EIdOpenSSLLoadError);
    EIdOSSLModeNotSet = class(EIdOpenSSLError);
    EIdOSSLGetMethodError = class(EIdOpenSSLError);
    EIdOSSLCreatingContextError = class(EIdOpenSSLError);
    EIdOSSLLoadingRootCertError = class(EIdOpenSSLLoadError);
    EIdOSSLLoadingCertError = class(EIdOpenSSLLoadError);
    EIdOSSLLoadingKeyError = class(EIdOpenSSLLoadError);
    EIdOSSLSettingCipherError = class(EIdOpenSSLError);
    EIdOSSLDataBindingError = class(EIdOpenSSLError);
    EIdOSSLAcceptError = class(EIdOpenSSLError);
    EIdOSSLConnectError = class(EIdOpenSSLError);

function LogicalAnd(A, B: Integer): Boolean;
procedure InfoCallback(sslSocket: PSSL; where: Integer; ret: Integer); cdecl;
function PasswordCallback(buf:PChar; size:Integer; rwflag:Integer; userdata: Pointer):Integer; cdecl;
function VerifyCallback(Ok: Integer; ctx: PX509_STORE_CTX):Integer; cdecl;

implementation

uses
  IdResourceStringsCore, IdResourceStringsProtocols, IdStack, IdStackBSDBase, IdAntiFreezeBase,
  IdExceptionCore, IdResourceStrings,
  SyncObjs;

var
  DLLLoadCount: Integer = 0;
  LockInfoCB: TCriticalSection;
  LockPassCB: TCriticalSection;
  LockVerifyCB: TCriticalSection;
  CallbackLockList: TThreadList;

//////////////////////////////////////////////////////////////
// SSL SUPPORT FUNCTIONS
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// SSL CALLBACK ROUTINES
//////////////////////////////////////////////////////////////

function PasswordCallback(buf:PChar; size:Integer; rwflag:Integer; userdata: Pointer):Integer; cdecl;
var
  Password: String;
  IdSSLContext: TIdSSLContext;
begin
  LockPassCB.Enter;
  try
    Password := '';    {Do not Localize}

    IdSSLContext := TIdSSLContext(userdata);

    if (IdSSLContext.Parent is TIdSSLIOHandlerSocketOpenSSL) then begin
      TIdSSLIOHandlerSocketOpenSSL(IdSSLContext.Parent).DoGetPassword(Password);
    end;

    if (IdSSLContext.Parent is TIdServerIOHandlerSSLOpenSSL) then begin
      TIdServerIOHandlerSSLOpenSSL(IdSSLContext.Parent).DoGetPassword(Password);
    end;

    size := Length(Password);
    Sys.StrLCopy(buf, PChar(Password + #0), size + 1);
    Result := size;
  finally
    LockPassCB.Leave;
  end;
end;

procedure InfoCallback(sslSocket: PSSL; where: Integer; ret: Integer); cdecl;
var
  IdSSLSocket: TIdSSLSocket;
  StatusStr : String;
begin
  LockInfoCB.Enter;
  try
    IdSSLSocket := TIdSSLSocket(IdSslGetAppData(sslSocket));

    StatusStr := Sys.Format(RSOSSLStatusString, [Sys.StrPas(IdSslStateStringLong(sslSocket))]);

    if (IdSSLSocket.fParent is TIdSSLIOHandlerSocketOpenSSL) then begin
      TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).DoStatusInfo(StatusStr);
    end;

    if (IdSSLSocket.fParent is TIdServerIOHandlerSSLOpenSSL) then begin
      TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).DoStatusInfo(StatusStr);
    end;
  finally
    LockInfoCB.Leave;
  end;

end;

{function RSACallback(sslSocket: PSSL; e: Integer; KeyLength: Integer):PRSA; cdecl;
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
end;}

function AddMins (const DT: TDateTime; const Mins: Extended): TDateTime;
begin
  Result := DT + Mins / (60 * 24)
end;

function AddHrs (const DT: TDateTime; const Hrs: Extended): TDateTime;
begin
  Result := DT + Hrs / 24.0
end;

{function GetLocalTZBias: LongInt;
var
	TZ : TTimeZoneInformation;
begin
	case GetTimeZoneInformation (TZ) of
		TIME_ZONE_ID_STANDARD: Result := TZ.Bias + TZ.StandardBias;
		TIME_ZONE_ID_DAYLIGHT: Result := TZ.Bias + TZ.DaylightBias;
	else
		Result := TZ.Bias;
	end;
end;}

function GetLocalTime (const DT: TDateTime): TDateTime;
begin
  Result := DT - TimeZoneBias{ / (24 * 60)};
end;

procedure SslLockingCallback(mode, n : integer; Afile : PChar; line : integer) cdecl;
var
  Lock : TCriticalSection;
begin
  with CallbackLockList.LockList do
  try
    Lock := TCriticalSection(Items[n]);
  finally
    CallbackLockList.UnlockList;
  end;

  if (mode and OPENSSL_CRYPTO_LOCK) > 0 then
    Lock.Acquire
  else
    Lock.Release;
end;

procedure PrepareOpenSSLLocking;
var
  i, cnt : integer;
begin
  with CallbackLockList.LockList do
  try
    cnt := IdSslCryptoNumLocks;
    for i := 0 to cnt-1 do
      Add(TCriticalSection.Create);
  finally
    CallbackLockList.UnlockList;
  end;
end;

function _GetThreadID: Integer; cdecl;
begin
  // TODO: Verify how well this will work with fibers potentially running from
  // thread to thread or many on the same thread.
  Result := CurrentThreadId;
end;

function LoadOpenSLLibrary: Boolean;
begin
  if not IdSSLOpenSSLHeaders.Load then begin
    Result := False;
    Exit;
  end;

  InitializeRandom;
  // IdSslRandScreen;
  IdSslLoadErrorStrings;

  // Successful loading if true
  result := IdSslAddSslAlgorithms > 0;

  // Create locking structures, we need them for callback routines
  // they are probably not thread safe
  LockInfoCB := TCriticalSection.Create;
  LockPassCB := TCriticalSection.Create;
  LockVerifyCB := TCriticalSection.Create;

  // Handle internal OpenSSL locking
  CallbackLockList := TThreadList.Create;
  IdSslSetLockingCallback(SslLockingCallback);
  PrepareOpenSSLLocking;
  
  IdSslSetIdCallback(_GetThreadID);
end;

procedure UnLoadOpenSLLibrary;
var
  i : integer;
begin
  Sys.FreeAndNil(LockInfoCB);
  Sys.FreeAndNil(LockPassCB);
  Sys.FreeAndNil(LockVerifyCB);

  if Assigned(CallbackLockList) then
  begin
    with CallbackLockList.LockList do
      try
        for i := 0 to Count-1 do
          TObject(Items[i]).Free;

        Clear;
      finally
        CallbackLockList.UnlockList;
      end;

    Sys.FreeAndNil(CallbackLockList);
  end;

  IdSSLOpenSSLHeaders.Unload;
end;

function UTCTime2DateTime(UCTTime: PASN1_UTCTIME):TDateTime;
var
  year  : Word;
  month : Word;
  day   : Word;
  hour  : Word;
  min   : Word;
  sec   : Word;
  tz_h  : Integer;
  tz_m  : Integer;
begin
  Result := 0;
  if IdSslUCTTimeDecode(UCTTime, year, month, day, hour, min, sec, tz_h, tz_m) > 0 Then Begin
    Result := Sys.EncodeDate(year, month, day) + Sys.EncodeTime(hour, min, sec, 0);
    AddMins(Result, tz_m);
    AddHrs(Result, tz_h);
    Result := GetLocalTime(Result);
  end;
end;

function TranslateInternalVerifyToSLL(Mode: TIdSSLVerifyModeSet): Integer;
begin
  Result := OPENSSL_SSL_VERIFY_NONE;
  if sslvrfPeer in Mode then Result := Result or OPENSSL_SSL_VERIFY_PEER;
  if sslvrfFailIfNoPeerCert in Mode then Result:= Result or OPENSSL_SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
  if sslvrfClientOnce in Mode then Result:= Result or OPENSSL_SSL_VERIFY_CLIENT_ONCE;
end;

{function TranslateSLLVerifyToInternal(Mode: Integer): TIdSSLVerifyModeSet;
begin
  Result := [];
  if LogicalAnd(Mode, OPENSSL_SSL_VERIFY_PEER) then Result := Result + [sslvrfPeer];
  if LogicalAnd(Mode, OPENSSL_SSL_VERIFY_FAIL_IF_NO_PEER_CERT) then Result := Result + [sslvrfFailIfNoPeerCert];
  if LogicalAnd(Mode, OPENSSL_SSL_VERIFY_CLIENT_ONCE) then Result := Result + [sslvrfClientOnce];
end;}

function LogicalAnd(A, B: Integer): Boolean;
begin
  Result := (A and B) = B;
end;

function VerifyCallback(Ok: Integer; ctx: PX509_STORE_CTX): Integer; cdecl;
var
  hcert: PX509;
  Certificate: TIdX509;
  hSSL: PSSL;
  IdSSLSocket: TIdSSLSocket;
  // str: String;
  VerifiedOK: Boolean;
  Depth: Integer;
  // Error: Integer;
  LOk: Boolean;
begin
  LockVerifyCB.Enter;
  try
    VerifiedOK := True;
    try
      hcert := IdSslX509StoreCtxGetCurrentCert(ctx);
      hSSL := IdSslX509StoreCtxGetAppData(ctx);
      Certificate := TIdX509.Create(hcert);

      if hSSL <> nil then begin
        IdSSLSocket := TIdSSLSocket(IdSslGetAppData(hSSL));
      end
      else begin
        Result := Ok;
        exit;
      end;

      //Error :=
      IdSslX509StoreCtxGetError(ctx);
      Depth := IdSslX509StoreCtxGetErrorDepth(ctx);
      //  str := Format('Certificate: %s', [Certificate.Subject.OneLine]);    {Do not Localize}
      //  str := IdSSLSocket.GetSessionIDAsString;
      //  ShowMessage(str);

      if not ((Ok>0) and (IdSSLSocket.fSSLContext.VerifyDepth>=Depth)) then begin
        Ok := 0;
        {if Error = OPENSSL_X509_V_OK then begin
          Error := OPENSSL_X509_V_ERR_CERT_CHAIN_TOO_LONG;
        end;}
      end;
      
      LOk := False;
      if Ok = 1 then begin
        LOk := True;
      end;

      if (IdSSLSocket.fParent is TIdSSLIOHandlerSocketOpenSSL) then begin
        VerifiedOK := TIdSSLIOHandlerSocketOpenSSL(IdSSLSocket.fParent).DoVerifyPeer(Certificate, LOk);
      end;

      if (IdSSLSocket.fParent is TIdServerIOHandlerSSLOpenSSL) then begin
        VerifiedOK := TIdServerIOHandlerSSLOpenSSL(IdSSLSocket.fParent).DoVerifyPeer(Certificate, LOk);
      end;

      Sys.FreeAndNil(Certificate); // Used to be Certificate.Destroy - any reason for that?
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
//   TIdSSLOptions
///////////////////////////////////////////////////////

procedure TIdSSLOptions.AssignTo(ASource: TPersistent);
begin
  if ASource is TIdSSLOptions then
    with TIdSSLOptions(ASource) do begin
      RootCertFile := Self.RootCertFile;
      CertFile := Self.CertFile;
      KeyFile := Self.KeyFile;
      Method := Self.Method;
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
  inherited;
  fIsInitialized := False;
  fxSSLOptions := TIdSSLOptions.Create;
end;

destructor TIdServerIOHandlerSSLOpenSSL.Destroy;
begin
  if fSSLContext <> nil then begin
    Sys.FreeAndNil(fSSLContext);
  end;

  Sys.FreeAndNil(fxSSLOptions);
  inherited Destroy;
end;

procedure TIdServerIOHandlerSSLOpenSSL.Init;
begin
  // CreateSSLContext(SSLOptions.fMode);
  // CreateSSLContext;
  fSSLContext := TIdSSLContext.Create;
  with fSSLContext do begin
    Parent := self;
    RootCertFile := SSLOptions.RootCertFile;
    CertFile := SSLOptions.CertFile;
    KeyFile := SSLOptions.KeyFile;

    fVerifyDepth := SSLOptions.fVerifyDepth;
    fVerifyMode := SSLOptions.fVerifyMode;
    // fVerifyFile := SSLOptions.fVerifyFile;
    fVerifyDirs := SSLOptions.fVerifyDirs;
    fCipherList := SSLOptions.fCipherList;

    if Assigned(fOnVerifyPeer) then begin
      VerifyOn := True;
    end
    else begin
      VerifyOn := False;
    end;

    if Assigned(fOnStatusInfo) then begin
      StatusInfoOn := True;
    end
    else begin
      StatusInfoOn := False;
    end;

   { if Assigned(fOnGetPassword) then begin
      PasswordRoutineOn := True;
    end
    else begin
      PasswordRoutineOn := False;
    end;     }

    fMethod :=  SSLOptions.Method;
    fMode := SSLOptions.Mode;
    fSSLContext.InitContext(sslCtxServer);
  end;

  fIsInitialized := True;
end;

{function TIdServerIOHandlerSSLOpenSSL.Accept(ASocket: TIdSocketHandle; AThread: TIdThread) : TIdIOHandler;  }
function TIdServerIOHandlerSSLOpenSSL.Accept(
      ASocket: TIdSocketHandle;
      // This is a thread and not a yarn. Its the listener thread.
      AListenerThread: TIdThread;
      AYarn: TIdYarn
      ): TIdIOHandler; 
var
  tmpIdCIOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  if not fIsInitialized then begin
    Init;
  end;

  tmpIdCIOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  tmpIdCIOpenSSL.PassThrough := true;
  tmpIdCIOpenSSL.fIsPeer := True;
  tmpIdCIOpenSSL.Open;
  if tmpIdCIOpenSSL.Binding.Accept(ASocket.Handle) then begin
  //we need to pass the SSLOptions for the saocket from the server
    tmpIdCIOpenSSL.fxSSLOptions.Free;
    tmpIdCIOpenSSL.fxSSLOptions := fxSSLOptions;
    tmpIdCIOpenSSL.fSSLSocket := TIdSSLSocket.Create(self);
    tmpIdCIOpenSSL.fSSLContext := fSSLContext;
    result := tmpIdCIOpenSSL;
  end else begin
    result := nil;
    Sys.FreeAndNil(tmpIdCIOpenSSL);
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoStatusInfo(Msg: String);
begin
  if Assigned(fOnStatusInfo) then
    fOnStatusInfo(Msg);
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoGetPassword(var Password: String);
begin
  if Assigned(fOnGetPassword) then
    fOnGetPassword(Password);
end;

function TIdServerIOHandlerSSLOpenSSL.DoVerifyPeer(Certificate: TIdX509; AOk: Boolean): Boolean;
begin
  Result := True;
  if Assigned(fOnVerifyPeer) then
    Result := fOnVerifyPeer(Certificate, AOk);
end;

function TIdServerIOHandlerSSLOpenSSL.MakeFTPSvrPort : TIdSSLIOHandlerSocketBase;
var LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  LIO.PassThrough := true;
  LIO.SSLOptions.Assign(SSLOptions);
  LIO.OnGetPassword := OnGetPassword;
  LIO.SSLOptions.Mode:= sslmBoth;{doesn't really matter}
  LIO.IsPeer:=true;
  LIO.SSLContext:= SSLContext;
  Result := LIO;
end;

function TIdServerIOHandlerSSLOpenSSL.MakeFTPSvrPasv : TIdSSLIOHandlerSocketBase;
var LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  LIO.PassThrough := true;
  LIO.SSLOptions.Assign(SSLOptions);
  LIO.SSLContext := nil;
  LIO.OnGetPassword := OnGetPassword;
  LIO.SSLOptions.Mode:= sslmBoth;{or sslmServer}
  LIO.IsPeer:=true;
  Result := LIO;
end;



///////////////////////////////////////////////////////
//   TIdSSLIOHandlerSocketOpenSSL
///////////////////////////////////////////////////////

function TIdServerIOHandlerSSLOpenSSL.MakeClientIOHandler: TIdSSLIOHandlerSocketBase;
var LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  LIO.PassThrough := true;

//  LIO.SSLOptions.Free;
//  LIO.SSLOptions := SSLOptions;
//  LIO.SSLContext := SSLContext;
  LIO.SSLOptions.Assign(SSLOptions);
//  LIO.SSLContext := SSLContext;
  LIO.SSLContext := nil;//SSLContext.Clone; // BGO: clone does not work, it must be either NIL, or SSLContext
  LIO.OnGetPassword := OnGetPassword;
  Result := LIO;
end;

{ TIdSSLIOHandlerSocketOpenSSL }

procedure TIdSSLIOHandlerSocketOpenSSL.InitComponent;
begin
  inherited;
  fIsPeer := False;
  fxSSLOptions := TIdSSLOptions.Create;
  fSSLLayerClosed := True;
  fSSLContext := nil;
end;

destructor TIdSSLIOHandlerSocketOpenSSL.Destroy;
begin
  Sys.FreeAndNil(fSSLSocket);
  if not fIsPeer then begin
  //we do not destroy these in IsPeer equals true
  //because these do not belong to us when we are in a server.
    Sys.FreeAndNil(fSSLContext);
    Sys.FreeAndNil(fxSSLOptions);
  end;
  inherited Destroy;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.ConnectClient;
begin
  inherited ConnectClient;

  DoBeforeConnect(self);

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
  Sys.FreeAndNil(fSSLSocket);
  if not fIsPeer then begin
    Sys.FreeAndNil(fSSLContext);
  end;

  inherited Close;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.Open;
begin
  inherited Open;
end;

function TIdSSLIOHandlerSocketOpenSSL.Recv(var ABuf : TIdBytes): integer;
begin
  if fPassThrough then begin
   result := Binding.Receive(ABuf);
 //  Recv(ABuf, ALen, 0 );
  end
  else begin
    result := RecvEnc(ABuf);
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.Send(const ABuf : TIdBytes): integer;
begin
  if fPassThrough then begin
//    result := Binding.Send(ABuf, ALen, 0 );
    result := Binding.Send(ABuf,0);
  end
  else begin
    result := SendEnc(ABuf);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.SetPassThrough(const Value: Boolean);
begin
  if fPassThrough <> Value then begin
    if not Value then begin
      if BindingAllocated then begin
        if Assigned(fSSLContext) then begin
          OpenEncodedConnection;
        end
        else begin
          raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
        end;
      end;
    end;
    fPassThrough := Value;
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.RecvEnc(var ABuf : TIdBytes): integer;
begin
  Result := fSSLSocket.Recv(ABuf);
end;

function TIdSSLIOHandlerSocketOpenSSL.SendEnc(const ABuf : TIdBytes): integer;
begin
  Result := fSSLSocket.Send(ABuf);
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
begin
  if not Assigned(fSSLContext) then begin
    fSSLContext := TIdSSLContext.Create;
    with fSSLContext do begin
      Parent := self;
      RootCertFile := SSLOptions.RootCertFile;
      CertFile := SSLOptions.CertFile;
      KeyFile := SSLOptions.KeyFile;

      fVerifyDepth := SSLOptions.fVerifyDepth;
      fVerifyMode := SSLOptions.fVerifyMode;
      // fVerifyFile := SSLOptions.fVerifyFile;
      fVerifyDirs := SSLOptions.fVerifyDirs;
      fCipherList := SSLOptions.fCipherList;

      if Assigned(fOnVerifyPeer) then begin
        VerifyOn := True;
      end
      else begin
        VerifyOn := False;
      end;

      if Assigned(fOnStatusInfo) then begin
        StatusInfoOn := True;
      end
      else begin
        StatusInfoOn := False;
      end;

      {if Assigned(fOnGetPassword) then begin
        PasswordRoutineOn := True;
      end
      else begin
        PasswordRoutineOn := False;
      end;}


      fMethod :=  SSLOptions.Method;
      fMode := SSLOptions.Mode;
      fSSLContext.InitContext(sslCtxClient);
    end;


    {fSSLContext := TIdSSLContext.Create;
    with fSSLContext do begin
      Parent := self;
      RootCertFile := SSLOptions.RootCertFile;
      CertFile := SSLOptions.CertFile;
      KeyFile := SSLOptions.KeyFile;

      if Assigned(fOnStatusInfo) then begin
        StatusInfoOn := True;
      end
      else begin
        StatusInfoOn := False;
      end;

      if Assigned(fOnVerifyPeer) then begin
        VerifyOn := True;
      end
      else begin
        VerifyOn := False;
      end;

      // Must set mode after above props are set
      Method :=  SSLOptions.Method;
      Mode := axMode;
    end;}
  end;
end;

//}
{function TIdSSLIOHandlerSocketOpenSSL.GetPeerCert: TIdX509;
begin
  if fSSLContext <> nil then begin
    Result := fSSLSocket.PeerCert;
  end
  else begin
    Result := nil;
  end;
end;}

procedure TIdSSLIOHandlerSocketOpenSSL.DoStatusInfo(Msg: String);
begin
  if Assigned(fOnStatusInfo) then
    fOnStatusInfo(Msg);
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoGetPassword(var Password: String);
begin
  if Assigned(fOnGetPassword) then
    fOnGetPassword(Password);
end;

function TIdSSLIOHandlerSocketOpenSSL.DoVerifyPeer(Certificate: TIdX509; AOk: Boolean): Boolean;
begin
  Result := True;
  if Assigned(fOnVerifyPeer) then
    Result := fOnVerifyPeer(Certificate, AOk);
end;

procedure TIdSSLIOHandlerSocketOpenSSL.OpenEncodedConnection;
begin
  if FIsPeer then begin
    if not Assigned(fSSLSocket) then begin
      fSSLSocket := TIdSSLSocket.Create(self);
      fSSLSocket.fSSLContext := fSSLContext;
    end;
    fSSLSocket.Accept(Binding.Handle, fSSLContext);
  end else begin
    if not Assigned(fSSLSocket) then begin
      fSSLSocket := TIdSSLSocket.Create(self);
      fSSLSocket.fSSLContext := fSSLContext;
      fSSLSocket.Connect(Binding.Handle, fSSLContext);
    end;
  end;
  fPassThrough := false;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.DoBeforeConnect(ASender: TIdSSLIOHandlerSocketOpenSSL);
begin
  if Assigned(OnBeforeConnect) then begin
    OnBeforeConnect(Self);
  end;
end;

procedure TIdSSLIOHandlerSocketOpenSSL.WriteDirect(var
  ABuffer: TIdBytes
  );
var
  LBuffer: TIdBytes;
  LBufLen: Integer;
  LCount: Integer;
  LPos: Integer;
begin

  LPos := 0;
  repeat
    LBufLen := Length(ABuffer) - LPos;
    SetLength(LBuffer,LBufLen);
    Move(ABuffer[LPos],LBuffer[0],LBufLen);
      //we have to make sure we call the Intercept for logging
    if Intercept <> nil then begin
      Intercept.Send(LBuffer);
    end;
    LCount := Send(LBuffer);
    // TODO - Have a AntiFreeze param which allows the send to be split up so that process
    // can be called more. Maybe a prop of the connection, MaxSendSize?

    TIdAntiFreezeBase.DoProcess(False);

    FClosedGracefully := LCount = 0;

    // Check if other side disconnected
    CheckForDisconnect;
    //TODO: This relies on STack - make it abstract
    // Check to see if the error signifies disconnection

    if GBSDStack.CheckForSocketError(LCount, [ID_WSAESHUTDOWN, Id_WSAECONNABORTED
     , Id_WSAECONNRESET]) <> 0 then begin
      FClosedGracefully := True;
      Close;
      GBSDStack.RaiseSocketError(GBSDStack.WSGetLastError);
    end;

    DoWork(wmWrite, LCount);
    LPos := LPos + LCount;
  until LPos >= Length(ABuffer);
end;

function TIdSSLIOHandlerSocketOpenSSL.ReadFromSource(
 ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
 ARaiseExceptionOnTimeout: Boolean): Integer;
// Reads any data in tcp/ip buffer and puts it into Indy buffer
// This must be the ONLY raw read from Winsock routine
// This must be the ONLY call to RECV - all data goes thru this method
var
  LByteCount: Integer;
  LBuffer: TIdBytes;
  LLastError: Integer;
begin
  if ATimeout = IdTimeoutDefault then begin
    if ReadTimeOut = 0 then begin
      ATimeout := IdTimeoutInfinite;
    end else begin
      ATimeout := FReadTimeout;
    end;
  end;
  Result := 0;
  // Check here as this side may have closed the socket
  CheckForDisconnect(ARaiseExceptionIfDisconnected);
  if BindingAllocated then begin
    LByteCount := 0;
    repeat
      if Readable(ATimeout) then begin
        if Assigned(FRecvBuffer) then begin
          // No need to call AntiFreeze, the Readable does that.
          if BindingAllocated then begin
            SetLength(LBuffer,RecvBufferSize);
            try
              LByteCount := Recv(LBuffer);
              SetLength(LBuffer,LByteCount);
                if Intercept <> nil then begin
                  Intercept.Receive(LBuffer);
                  LByteCount := Length(LBuffer);
                end;
              FRecvBuffer.Write(LBuffer);
          //    WriteBuffer(LBuffer^,LByteCount);
            finally
              SetLength(LBuffer,0);
            end;
          end else begin
            raise EIdClosedSocket.Create(RSStatusDisconnected);
          end;
        end else begin
          LByteCount := 0;
          if ARaiseExceptionIfDisconnected then
            raise EIdException.Create(RSNotConnected);
        end;
        FClosedGracefully := LByteCount = 0;

        if not ClosedGracefully then begin
          LLastError := GBSDStack.CheckForSocketError(LByteCount, [Id_WSAESHUTDOWN
           , Id_WSAECONNABORTED]);
          if LLastError <> 0 then begin
            LByteCount := 0;
            Close;
            // Do not raise unless all data has been read by the user
            if InputBufferIsEmpty then begin
              GBSDStack.RaiseSocketError(LLastError);
            end;
          end;

          // InputBuffer.Size is modified above
          if LByteCount > 0 then begin

{            if Assigned(Intercept) then begin
              IOHandler.RecvBuffer.Position := 0;
              Intercept.Receive(IOHandler.RecvBuffer);
              LByteCount := IOHandler.RecvBuffer.Size;
            end;  }
//AsciiFilter - needs to go in TIdIOHandler
//            if ASCIIFilter then begin
//              for i := 1 to IOHandler.RecvBuffer.Size do begin
//                PChar(IOHandler.RecvBuffer.Memory)[i] := Chr(Ord(PChar(IOHandler.RecvBuffer.Memory)[i]) and $7F);
//              end;
//            end;
            FRecvBuffer.ExtractToIdBuffer(FInputBuffer,-1);
          end;
        end;
        // Check here as other side may have closed connection
        CheckForDisconnect(ARaiseExceptionIfDisconnected);
        Result := LByteCount;
      end else begin
        // Timeout
        if ARaiseExceptionOnTimeout then begin
          raise EIdReadTimeout.Create(RSReadTimeout);
        end;
        Result := -1;
        Break;
      end;
    until (LByteCount <> 0) or (Connected = False);
  end else begin
    if ARaiseExceptionIfDisconnected then begin
      raise EIdException.Create(RSNotConnected);
    end;
  end;
end;

function TIdSSLIOHandlerSocketOpenSSL.Clone: TIdSSLIOHandlerSocketBase;
var LIO : TIdSSLIOHandlerSocketOpenSSL;
begin
  LIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  LIO.SSLOptions.Assign( SSLOptions );
  LIO.OnStatusInfo := OnStatusInfo;
  LIO.OnGetPassword := OnGetPassword;
  LIO.OnVerifyPeer := OnVerifyPeer;
  Result := LIO;
end;

{ TIdSSLContext }

constructor TIdSSLContext.Create;
begin
  inherited Create;

  if DLLLoadCount <= 0 then begin
  	if not IdSSLOpenSSL.LoadOpenSLLibrary then begin
    	raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
    end;
  end;
  Inc(DLLLoadCount);

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
    IdSslCtxFree(fContext);
    fContext := nil;
  end;
end;

procedure TIdSSLContext.InitContext(CtxMode: TIdSSLCtxMode);
var
  SSLMethod: PSSL_METHOD;
  error: Integer;
  pCipherList, pRootCertFile: PChar;
//  pCAname: PSTACK_X509_NAME;
begin
  // Destroy the context first
  DestroyContext;

  if fMode = sslmUnassigned then begin
    if CtxMode = sslCtxServer then begin
      fMode := sslmServer;
    end
    else begin
      fMode := sslmClient;
    end
  end;

  // get SSL method function (SSL2, SSL23, SSL3, TLS)
  SSLMethod := SetSSLMethod;

  // create new SSL context
  fContext := IdSslCtxNew(SSLMethod);
  if fContext = nil then begin
    raise EIdOSSLCreatingContextError.Create(RSSSLCreatingContextError);
  end;

  // assign a password lookup routine
//  if PasswordRoutineOn then begin
    IdSslCtxSetDefaultPasswdCb(fContext, @PasswordCallback);
    IdSslCtxSetDefaultPasswdCbUserdata(fContext, self);
//  end;

  IdSSLCtxSetDefaultVerifyPaths(fContext);

  // load key and certificate files
  if RootCertFile <> '' then begin    {Do not Localize}
    if not LoadRootCert then begin
      raise EIdOSSLLoadingRootCertError.Create(RSSSLLoadingRootCertError);
    end;
  end;

  if CertFile <> '' then begin    {Do not Localize}
    if not LoadCert then begin
      raise EIdOSSLLoadingCertError.Create(RSSSLLoadingCertError);
    end;
  end;

  if KeyFile <> '' then begin    {Do not Localize}
    if not LoadKey then begin
      raise EIdOSSLLoadingKeyError.Create(RSSSLLoadingKeyError);
    end;
  end;

  if StatusInfoOn then begin
    IdSslCtxSetInfoCallback(fContext, PFunction(@InfoCallback));
  end;

//    f_SSL_CTX_set_tmp_rsa_callback(hSSLContext, @RSACallback);

  if fCipherList <> '' then begin    {Do not Localize}
    pCipherList := Sys.StrNew(PChar(fCipherList));
    error := IdSslCtxSetCipherList(fContext, pCipherList);
    Sys.StrDispose(pCipherList);
  end
  else begin
    error := IdSslCtxSetCipherList(fContext, OPENSSL_SSL_DEFAULT_CIPHER_LIST);
  end;
  if error <= 0 then begin
    raise EIdOSSLSettingCipherError.Create(RSSSLSettingCipherError);
  end;

  if fVerifyMode <> [] then begin
    SetVerifyMode(fVerifyMode, VerifyOn);
  end;

  if CtxMode = sslCtxServer then begin
    IdSSLCtxSetSessionIdContext(fContext, PChar(@fSessionId), SizeOf(fSessionId));
  end;

  // CA list
  if RootCertFile <> '' then begin    {Do not Localize}
    pRootCertFile := Sys.StrNew(PChar(RootCertFile));
    IdSSLCtxSetClientCAList(fContext, IdSSLLoadClientCAFile(pRootCertFile));
    Sys.StrDispose(pRootCertFile);
  end

end;

procedure TIdSSLContext.SetVerifyMode(Mode: TIdSSLVerifyModeSet; CheckRoutine: Boolean);
begin
  if fContext<>nil then begin
//    IdSSLCtxSetDefaultVerifyPaths(fContext);
    if CheckRoutine then begin
      IdSslCtxSetVerify(fContext, TranslateInternalVerifyToSLL(Mode), PFunction(@VerifyCallback));
    end
    else begin
      IdSslCtxSetVerify(fContext, TranslateInternalVerifyToSLL(Mode), nil);
    end;
    IdSslCtxSetVerifyDepth(fContext, fVerifyDepth);
  end;
end;

function TIdSSLContext.GetVerifyMode: TIdSSLVerifyModeSet;
begin
  Result := fVerifyMode;
end;
{
function TIdSSLContext.LoadVerifyLocations(FileName: String; Dirs: String): Boolean;
var
  pFileName, pDirs : PChar;
begin
  Result := False;

  pFileName := nil;
  pDirs := nil;
  if FileName <> '' then begin
    pFileName := StrNew(PChar(FileName));
  end;
  if Dirs <> '' then begin
    pDirs := StrNew(PChar(Dirs));
  end;

  If (pDirs<>nil) or (pFileName<>nil) Then begin
    If IdSslCtxLoadVerifyLocations(fContext, pFileName, pDirs)<=0 Then Begin
      raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
      exit;
    End;
  end;
  StrDispose(pFileName);
  StrDispose(pDirs);
  Result:=True;
End;
}
function TIdSSLContext.SetSSLMethod: PSSL_METHOD;
begin
  if fMode = sslmUnassigned then begin
  	raise EIdOSSLModeNotSet.create(RSOSSLModeNotSet);
  end;
  case fMethod of
    sslvSSLv2:
      case fMode of
        sslmServer : Result := IdSslMethodServerV2;
        sslmClient : Result := IdSslMethodClientV2;
        sslmBoth   : Result := IdSslMethodV2;
      else
        Result := IdSslMethodV2;
      end;

    sslvSSLv23:
      case fMode of
        sslmServer : Result := IdSslMethodServerV23;
        sslmClient : Result := IdSslMethodClientV23;
        sslmBoth   : Result := IdSslMethodV23;
      else
        Result := IdSslMethodV23;
      end;

    sslvSSLv3:
      case fMode of
        sslmServer : Result := IdSslMethodServerV3;
        sslmClient : Result := IdSslMethodClientV3;
        sslmBoth   : Result := IdSslMethodV3;
      else
        Result := IdSslMethodV3;
      end;

    sslvTLSv1:
      case fMode of
        sslmServer : Result := IdSslMethodServerTLSV1;
        sslmClient : Result := IdSslMethodClientTLSV1;
        sslmBoth   : Result := IdSslMethodTLSV1;
      else
        Result := IdSslMethodTLSV1;
      end;
  else
    raise EIdOSSLGetMethodError.Create(RSSSLGetMethodError);
  end;
end;

function TIdSSLContext.LoadRootCert: Boolean;
var
  pStr: PChar;
  error: Integer;
//  pDirs : PChar;
begin
  pStr := Sys.StrNew(PChar(RootCertFile));
{  if fVerifyDirs <> '' then begin
    pDirs := StrNew(PChar(fVerifyDirs));
    error := IdSslCtxLoadVerifyLocations(
                   fContext,
                   pStr,
                   pDirs);
    StrDispose(pDirs);
  end
  else begin
}
    error := IdSslCtxLoadVerifyLocations(
                   fContext,
                   pStr,
                   nil);
{  end;}
  if error <= 0 then begin
    Result := False
  end else begin
    Result := True;
  end;

  Sys.StrDispose(pStr);
end;

function TIdSSLContext.LoadCert: Boolean;
var
  pStr: PChar;
  error: Integer;
begin
  pStr := Sys.StrNew(PChar(CertFile));
  error := IdSslCtxUseCertificateFile(
                 fContext,
                 pStr,
                 OPENSSL_SSL_FILETYPE_PEM);
  if error <= 0 then
    Result := False
  else
    Result := True;

  Sys.StrDispose(pStr);
end;

function TIdSSLContext.LoadKey: Boolean;
var
  pStr: PChar;
  error: Integer;
begin
  Result := True;

  pStr := Sys.StrNew(PChar(fsKeyFile));
  error := IdSslCtxUsePrivateKeyFile(
                 fContext,
                 pStr,
                 OPENSSL_SSL_FILETYPE_PEM);

  if error <= 0 then begin
    Result := False;
  end else begin
    error := IdSslCtxCheckPrivateKeyFile(fContext);
    if error <= 0 then begin
      Result := False;
    end;
  end;

  Sys.StrDispose(pStr);
end;


//////////////////////////////////////////////////////////////

function TIdSSLContext.Clone: TIdSSLContext;
begin
  Result := TIdSSLContext.Create;
  Result.StatusInfoOn := StatusInfoOn;
//    property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
  Result.VerifyOn := VerifyOn;
  Result.Method:=Method;
  Result.Mode:=Mode;
  Result.RootCertFile:= RootCertFile;
  Result.CertFile:=CertFile;
  Result.KeyFile:=KeyFile;
  Result.VerifyMode:=VerifyMode;
  Result.VerifyDepth:= VerifyDepth;

end;

{ TIdSSLSocket }

constructor TIdSSLSocket.Create(Parent: TObject);
begin
  inherited Create;
  fParent := Parent;
  fSSLContext := nil;
end;

destructor TIdSSLSocket.Destroy;
begin
  if fSSL <> nil then begin
    //IdSslSetShutdown(fSSL, OPENSSL_SSL_SENT_SHUTDOWN);
    IdSslShutdown(fSSL);
    IdSslFree(fSSL);
    fSSL := nil;
  end;
  if fSSLCipher <> nil then begin
    Sys.FreeAndNil(fSSLCipher);
  end;
  inherited Destroy;
end;

function TIdSSLSocket.GetSSLError(retCode: Integer): Integer;
begin
  // COMMENT!!!
  // I found out that SSL layer should not interpret errors, cause they will pop up
  // on the socket layer. Only thing that the SSL layer should consider is key
  // or protocol renegotiation. This is done by loop in read and write

  Result := IdSslGetError(fSSL, retCode);
  case Result of
    OPENSSL_SSL_ERROR_NONE:
      Result := OPENSSL_SSL_ERROR_NONE;
    OPENSSL_SSL_ERROR_WANT_WRITE:
      Result := OPENSSL_SSL_ERROR_WANT_WRITE;
    OPENSSL_SSL_ERROR_WANT_READ:
      Result := OPENSSL_SSL_ERROR_WANT_READ;
    OPENSSL_SSL_ERROR_ZERO_RETURN:
      Result := OPENSSL_SSL_ERROR_ZERO_RETURN;
      //Result := OPENSSL_SSL_ERROR_NONE;
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
    // OPENSSL_SSL_ERROR_WANT_X509_LOOKUP:
        // raise EIdException.Create(RSOSSLCertificateLookup);
    OPENSSL_SSL_ERROR_SYSCALL:
      Result := OPENSSL_SSL_ERROR_SYSCALL;
      // Result := OPENSSL_SSL_ERROR_NONE;

        {//raise EIdException.Create(RSOSSLInternal);
        if (retCode <> 0) or (DataLen <> 0) then begin
          raise EIdException.Create(RSOSSLConnectionDropped);
        end
        else begin
          Result := 0;
        end;}

    OPENSSL_SSL_ERROR_SSL:
      // raise EIdException.Create(RSOSSLInternal);
      Result := OPENSSL_SSL_ERROR_SSL;
      // Result := OPENSSL_SSL_ERROR_NONE;
  end;
end;

procedure TIdSSLSocket.Accept(const pHandle: TIdStackSocketHandle; fSSLContext: TIdSSLContext);
var
  err: Integer;
  StatusStr: String;
begin
  fSSL := IdSslNew(fSSLContext.fContext);
  if fSSL = nil then exit;

  if IdSslSetAppData(fSSL, self) <= 0 then begin
    raise EIdOSSLDataBindingError.Create(RSSSLDataBindingError);
    exit;
  end;

  self.fSSLContext := fSSLContext;
  IdSslSetFd(fSSL, pHandle);
  err := IdSslAccept(fSSL);
  if err <= 0 then begin
    // err := GetSSLError(err);

    {if err <= -1 then
      raise EIdOSSLAcceptError.Create(RSSSLAcceptError)
    else}
    raise EIdOSSLAcceptError.Create(RSSSLAcceptError);
  end;

  StatusStr := 'Cipher: name = ' + Cipher.Name + '; ' +    {Do not Localize}
               'description = ' + Cipher.Description + '; ' +    {Do not Localize}
               'bits = ' + Sys.IntToStr(Cipher.Bits) + '; ' +    {Do not Localize}
               'version = ' + Cipher.Version + '; ';    {Do not Localize}

  if (fParent is TIdServerIOHandlerSSLOpenSSL) then begin
    (fParent as TIdServerIOHandlerSSLOpenSSL).DoStatusInfo(StatusStr);
  end;

end;

procedure TIdSSLSocket.Connect(const pHandle: TIdStackSocketHandle; fSSLContext: TIdSSLContext);
var
  error: Integer;
  StatusStr: String;
begin
  fSSL := IdSslNew(fSSLContext.fContext);
  if fSSL = nil then exit;

  if IdSslSetAppData(fSSL, self) <= 0 then begin
    raise EIdOSSLDataBindingError.Create(RSSSLDataBindingError);
    exit;
  end;

  IdSslSetFd(fSSL, pHandle);
  error := IdSslConnect(fSSL);
  if error <= 0 then begin
//    error2 := IdSslGetError(fSSL, error);
    raise EIdOSSLConnectError.Create(RSSSLConnectError);
  end;

  StatusStr := 'Cipher: name = ' + Cipher.Name + '; ' +    {Do not Localize}
               'description = ' + Cipher.Description + '; ' +    {Do not Localize}
               'bits = ' + Sys.IntToStr(Cipher.Bits) + '; ' +    {Do not Localize}
               'version = ' + Cipher.Version + '; ';    {Do not Localize}

  if (fParent is TIdSSLIOHandlerSocketOpenSSL) then begin
    (fParent as TIdSSLIOHandlerSocketOpenSSL).DoStatusInfo(StatusStr);
  end;

end;

function TIdSSLSocket.Recv(var ABuf : TIdBytes): integer;
var
  err: Integer;
begin
  Result := IdSslRead(fSSL, @ABuf[0], Length(ABuf));
  err := GetSSLError(Result);
  if (err = OPENSSL_SSL_ERROR_WANT_READ) or (err = OPENSSL_SSL_ERROR_WANT_WRITE) then begin
    Result := IdSslRead(fSSL, @ABuf[0], Length(ABuf));
  end;
end;

function TIdSSLSocket.Send(const ABuf : TIdBytes): integer;
var
  err: Integer;
begin
  Result := IdSslWrite(fSSL, @ABuf[0], Length(ABuf));
  err := GetSSLError(Result);
  if (err = OPENSSL_SSL_ERROR_WANT_READ) or (err = OPENSSL_SSL_ERROR_WANT_WRITE) then begin
    Result := IdSslWrite(fSSL, @ABuf[0], Length(ABuf));
  end;
end;

function TIdSSLSocket.GetPeerCert: TIdX509;
var
  X509: PX509;
begin
  if fPeerCert = nil then begin
    X509 := IdSslGetPeerCertificate(fSSL);
    if X509 <> nil then begin
      fPeerCert := TIdX509.Create(X509);
    end;
  end;
  Result := fPeerCert;
end;

function TIdSSLSocket.GetSSLCipher: TIdSSLCipher;
begin
  if (fSSLCipher = nil) and (fSSL<>nil) then begin
    fSSLCipher := TIdSSLCipher.Create(self);
  end;
  Result := fSSLCipher;
end;


function TIdSSLSocket.GetSessionID: TByteArray;
var
  pSession: PSSL_SESSION;
  tmpArray: TByteArray;
begin
  Result.Length := 0;
  FillChar(tmpArray, SizeOf(TByteArray), 0);
  if fSSL<>nil then begin
    pSession := IdSslGetSession(fSSL);
    if pSession <> nil then begin
      IdSslSessionGetId(pSession, @tmpArray.Data, @tmpArray.Length);
      Result := tmpArray;
    end;
  end;
end;

function  TIdSSLSocket.GetSessionIDAsString:String;
var
  Data: TByteArray;
  i: Integer;
begin
  Result := '';    {Do not Localize}
  Data := GetSessionID;
  for i := 0 to Data.Length-1 do begin
    Result := Result+Sys.Format('%.2x', [Byte(Data.Data[I])]);{do not localize}
  end;
end;

procedure TIdSSLSocket.SetCipherList(CipherList: String);
//var
//  tmpPStr: PChar;
begin
{
  fCipherList := CipherList;
  fCipherList_Ch:=True;
  aCipherList:=aCipherList+#0;
  If hSSL<>nil Then f_SSL_set_cipher_list(hSSL, @aCipherList[1]);
}
end;

///////////////////////////////////////////////////////////////
//  X509 Certificate
///////////////////////////////////////////////////////////////

{ TIdX509Name }

function TIdX509Name.CertInOneLine: String;
var
  OneLine: Array[0..2048] of Char;
begin
  if FX509Name = nil then begin
    Result := '';    {Do not Localize}
  end
  else begin
    Result := Sys.StrPas(IdSslX509NameOneline(FX509Name, PChar(@OneLine), sizeof(OneLine)));
  end;
end;

function TIdX509Name.GetHash: TULong;
begin
  if FX509Name = nil then begin
    FillChar(Result, SizeOf(Result), 0)
  end
  else begin
    Result.C1 := IdSslX509NameHash(FX509Name);
  end;
end;

function TIdX509Name.GetHashAsString: String;
begin
  Result := Sys.Format('%.8x', [Hash.L1]); {do not localize}
end;

constructor TIdX509Name.Create(aX509Name: PX509_NAME);
begin
  Inherited Create;

  FX509Name := aX509Name;
end;


///////////////////////////////////////////////////////////////
//  X509 Certificate
///////////////////////////////////////////////////////////////

{ TIdX509 }

constructor TIdX509.Create(aX509: PX509);
begin
  inherited Create;

  FX509 := aX509;
  FSubject := nil;
  FIssuer := nil;
end;

destructor TIdX509.Destroy;
begin
  if Assigned(FSubject) then FSubject.Destroy;
  if Assigned(FIssuer) then FIssuer.Destroy;

  inherited Destroy;
end;

function TIdX509.RSubject: TIdX509Name;
var
  x509_name: PX509_NAME;
Begin
  if not Assigned(FSubject) then begin
    if FX509<>nil then
      x509_name := IdSslX509GetSubjectName(FX509)
    else
      x509_name := nil;
    FSubject := TIdX509Name.Create(x509_name);
  end;
  Result := FSubject;
end;

function TIdX509.RIssuer: TIdX509Name;
var
  x509_name: PX509_NAME;
begin
  if not Assigned(FIssuer) then begin
    if FX509<>nil then
      x509_name := IdSslX509GetIssuerName(FX509)
    else
      x509_name := nil;
    FIssuer := TIdX509Name.Create(x509_name);
  End;
  Result := FIssuer;
end;

function TIdX509.RFingerprint: TEVP_MD;
begin
  IdSslX509Digest(FX509, IdSslEvpMd5, PChar(@Result.MD), @Result.Length);
end;

function TIdX509.RFingerprintAsString: String;
var
  I: Integer;
  EVP_MD: TEVP_MD;
begin
  Result := '';
  EVP_MD := Fingerprint;
  for I := 0 to EVP_MD.Length - 1 do begin
    if I <> 0 then
    begin
      Result := Result + ':';    {Do not Localize}
    end;
    Result := Result + Sys.Format('%.2x', [Byte(EVP_MD.MD[I])]);  {do not localize}
  end;
end;

function TIdX509.RnotBefore:TDateTime;
begin
  if FX509=nil then
  begin
    Result := 0
  end
  else
  begin
    Result := UTCTime2DateTime(IdSslX509GetNotBefore(FX509));
  end;
end;


function TIdX509.RnotAfter:TDateTime;
begin
  if FX509=nil then
  begin
    Result := 0;
  end
  else
  begin
    Result := UTCTime2DateTime(IdSslX509GetNotAfter(FX509));
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
  Buf: Array[0..1024] of Char;
begin
  Result := Sys.StrPas(IdSSLCipherDescription(IdSSLGetCurrentCipher(FSSLSocket.fSSL), @Buf[0], SizeOf(Buf)-1));
end;

function TIdSSLCipher.GetName:String;
begin
  Result := Sys.StrPas(IdSSLCipherGetName(IdSSLGetCurrentCipher(FSSLSocket.fSSL)));
end;

function TIdSSLCipher.GetBits:Integer;
begin
  IdSSLCipherGetBits(IdSSLGetCurrentCipher(FSSLSocket.fSSL), @Result);
end;

function TIdSSLCipher.GetVersion:String;
begin
  Result := Sys.StrPas(IdSSLCipherGetVersion(IdSSLGetCurrentCipher(FSSLSocket.fSSL)));
end;

initialization
  RegisterSSL('OpenSSL','Indy Pit Crew',                                  {do not localize}
    'Copyright © 1993 - 2004'#10#13 +                                     {do not localize}
    'Chad Z. Hower (Kudzu) and the Indy Pit Crew. All rights reserved.',  {do not localize}
    'Open SSL Support DLL Delphi and C++Builder interface',               {do not localize}
    'http://www.indyproject.org/',                                        {do not localize}
    TIdSSLIOHandlerSocketOpenSSL,
    TIdServerIOHandlerSSLOpenSSL);

  // Let's load the library
  //if DLLLoadCount <= 0 then begin
   {
  	if not LoadOpenSLLibrary then begin
    	raise EIdException.Create(RSOSSLCouldNotLoadSSLLibrary);
    end;
   }
  //end;
  //Inc(DLLLoadCount);

finalization
  // if DLLLoadCount = 0 then begin
  UnLoadOpenSLLibrary;
  // end;
end.

