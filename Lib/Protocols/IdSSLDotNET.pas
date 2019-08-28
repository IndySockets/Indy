unit IdSSLDotNET;

interface
{$i IdCompilerDefines.inc}
{*******************************************************}
{                                                       }
{       Indy SSL Support for Microsoft.NET 2.0          }
{                                                       }
{       Copyright (C) 2007 Indy Pit Crew                }
{       Original author J. Peter Mugaas                 }
{       2007-Aug-22                                     }
{                                                       }
{*******************************************************}

uses
  Classes,
  IdException,
  IdGlobal,
  IdIOHandler,
  IdSocketHandle,
  IdSSL,
  IdThread,
  IdYarn,
  System.Collections,
  System.IO,
  System.Net.Sockets,
  System.Net.Security,
  System.Security.Authentication,
  System.Security.Cryptography.X509Certificates;

const
  DEF_clientCertificateRequired = False;
  DEF_checkCertificateRevocation = True;
  
type
  TOnValidatePeerCertificate = procedure (ASender : TObject;
    ACertificate : X509Certificate; AChain : X509Chain;
    AsslPolicyErrors : SslPolicyErrors; var VValid : Boolean) of object;

  TOnLocalCertificateSelectionCallback = procedure (ASender : TObject;
      AtargetHost : String;
      AlocalCertificates : X509CertificateCollection;
      AremoteCertificate : X509Certificate;
      AacceptableIssuers : array of String;
      VCert : X509Certificate) of object;

  TIdSSLIOHandlerSocketNET = class(TIdSSLIOHandlerSocketBase)
  protected
    FenabledSslProtocols: System.Security.Authentication.SslProtocols;
    FOnValidatePeerCertificate : TOnValidatePeerCertificate;
    FOnLocalCertificateSelection : TOnLocalCertificateSelectionCallback;
    FSSL : SslStream;
    FServerCertificate : X509Certificate;
    FClientCertificates : X509CertificateCollection;
    FOnSSLHandshakeDone : TNotifyEvent;
    FclientCertificateRequired : Boolean;
    FcheckCertificateRevocation : Boolean;
    procedure OpenEncodedConnection; virtual;

    //Ssl certificate validation callback
    function ValidatePeerCertificate(
              sender : System.&Object;
              certificate : X509Certificate;
              chain : X509Chain;
              sslPolicyErrors : SslPolicyErrors) : Boolean;
    function LocalCertificateSelectionCallback (
     	sender : System.&Object;
      targetHost : String;
      localCertificates : X509CertificateCollection;
      remoteCertificate : X509Certificate;
      acceptableIssuers : array of String) : X509Certificate;
    function RecvEnc(var VBuffer: TIdBytes): Integer; override;
    function SendEnc(const ABuffer: TIdBytes; const AOffset, ALength: Integer): Integer; override;
    procedure SetPassThrough(const Value: Boolean); override;
    procedure InitComponent; override;

    procedure ConnectClient; override;
    //
    function GetCipherAlgorithm: CipherAlgorithmType;
    function GetCipherStrength: Integer;
    function GetHashAlgorithm: HashAlgorithmType;
    function GetHashStrength: Integer;
    function GetIsEncrypted: Boolean;
    function GetIsSigned: Boolean;
    function GetKeyExchangeAlgorithm: ExchangeAlgorithmType;
    function GetKeyExchangeStrength: Integer;
    function GetRemoteCertificate: X509Certificate;
    function GetSslProtocol: SslProtocols;

  public
    procedure Close; override;
    procedure StartSSL; override;
    function Clone : TIdSSLIOHandlerSocketBase; override;

    property CipherAlgorithm : CipherAlgorithmType read GetCipherAlgorithm;
    property CipherStrength : Integer read GetCipherStrength;
    property HashAlgorithm : HashAlgorithmType read GetHashAlgorithm;
    property HashStrength : Integer read GetHashStrength;
    property IsEncrypted : Boolean read GetIsEncrypted;
    property IsSigned : Boolean read GetIsSigned;
    property KeyExchangeAlgorithm : ExchangeAlgorithmType read GetKeyExchangeAlgorithm;
    property KeyExchangeStrength : Integer read GetKeyExchangeStrength;
    property RemoteCertificate : X509Certificate read GetRemoteCertificate;
    property SslProtocol : SslProtocols read GetSslProtocol;
  published
    property enabledSslProtocols : System.Security.Authentication.SslProtocols read FenabledSslProtocols write FenabledSslProtocols;
    property ServerCertificate : X509Certificate read FServerCertificate write FServerCertificate;
    property ClientCertificates : X509CertificateCollection read FClientCertificates write FClientCertificates;
    property clientCertificateRequired : Boolean read FclientCertificateRequired write FclientCertificateRequired;
    property checkCertificateRevocation : Boolean read FcheckCertificateRevocation write FcheckCertificateRevocation;
    property OnSSLHandshakeDone : TNotifyEvent read FOnSSLHandshakeDone write FOnSSLHandshakeDone;
    property OnLocalCertificateSelection : TOnLocalCertificateSelectionCallback
      read FOnLocalCertificateSelection write FOnLocalCertificateSelection;
    property OnValidatePeerCertificate : TOnValidatePeerCertificate
      read FOnValidatePeerCertificate write FOnValidatePeerCertificate;
  end;

  TIdServerIOHandlerSSLNET = class(TIdServerIOHandlerSSLBase)
  protected
    FOnValidatePeerCertificate : TOnValidatePeerCertificate;
    FOnLocalCertificateSelection : TOnLocalCertificateSelectionCallback;
    FOnSSLHandshakeDone : TNotifyEvent;
    FenabledSslProtocols : System.Security.Authentication.SslProtocols;
    FServerCertificate : X509Certificate;
    FclientCertificateRequired : Boolean;
    FcheckCertificateRevocation : Boolean;
    procedure InitComponent; override;
    procedure SetIOHandlerValues(AIO : TIdSSLIOHandlerSocketNET);
  published
  public
    destructor Destroy; override;
    procedure Init; override;
    procedure Shutdown; override;
    function MakeClientIOHandler : TIdSSLIOHandlerSocketBase; override;
    //
    function MakeFTPSvrPort : TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPasv : TIdSSLIOHandlerSocketBase; override;
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler; override;
  published
    property enabledSslProtocols : System.Security.Authentication.SslProtocols read FenabledSslProtocols write FenabledSslProtocols;
    property ServerCertificate : X509Certificate read FServerCertificate write FServerCertificate;
    property clientCertificateRequired : Boolean read FclientCertificateRequired write FclientCertificateRequired;
    property checkCertificateRevocation : Boolean read FcheckCertificateRevocation write FcheckCertificateRevocation;
    property OnSSLHandshakeDone : TNotifyEvent read FOnSSLHandshakeDone write FOnSSLHandshakeDone;
    property OnLocalCertificateSelection : TOnLocalCertificateSelectionCallback
      read FOnLocalCertificateSelection write FOnLocalCertificateSelection;
    property OnValidatePeerCertificate : TOnValidatePeerCertificate
      read FOnValidatePeerCertificate write FOnValidatePeerCertificate;

  end;
  EIdSSLNetException = class(EIdException);
  EIdSSLCertRequiredForSvr = class(EIdSSLNetException);
  EIdSSLNotAuthenticated = class(EIdSSLNetException);

implementation

uses
  IdResourceStringsSSLDotNet,
  IdStack,
  SysUtils;

{ TIdSSLIOHandlerSocketNET }

function TIdSSLIOHandlerSocketNET.Clone: TIdSSLIOHandlerSocketBase;
begin
  Result := TIdSSLIOHandlerSocketNET.Create(nil);
  TIdSSLIOHandlerSocketNET(Result).FenabledSslProtocols := FenabledSslProtocols;
  TIdSSLIOHandlerSocketNET(Result).FOnValidatePeerCertificate := FOnValidatePeerCertificate;
  TIdSSLIOHandlerSocketNET(Result).FOnLocalCertificateSelection := FOnLocalCertificateSelection;
  TIdSSLIOHandlerSocketNET(Result).FServerCertificate :=  FServerCertificate;
  TIdSSLIOHandlerSocketNET(Result).FClientCertificates :=  FClientCertificates;
  TIdSSLIOHandlerSocketNET(Result).FOnSSLHandshakeDone :=  FOnSSLHandshakeDone;

end;

procedure TIdSSLIOHandlerSocketNET.Close;
begin
  if Assigned(FSSL) then
  begin
    FSSL.Close;
    FreeAndNil(FSSL);
  end;
  inherited;
end;

procedure TIdSSLIOHandlerSocketNET.ConnectClient;
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
  StartSSL;
end;

function TIdSSLIOHandlerSocketNET.GetCipherAlgorithm: CipherAlgorithmType;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.CipherAlgorithm;
  end
  else
  begin
    Result := System.Security.Authentication.CipherAlgorithmType.None;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetCipherStrength: Integer;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.CipherStrength;
  end
  else
  begin
    Result := 0;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetHashAlgorithm: HashAlgorithmType;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.HashAlgorithm;
  end
  else
  begin
    Result := HashAlgorithmType.None;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetHashStrength: Integer;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.HashStrength;
  end
  else
  begin
    Result := 0;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetIsEncrypted: Boolean;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.IsEncrypted;
  end
  else
  begin
    Result := False;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetIsSigned: Boolean;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.IsSigned;
  end
  else
  begin
    Result := False;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetKeyExchangeAlgorithm: ExchangeAlgorithmType;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.KeyExchangeAlgorithm;
  end
  else
  begin
    Result := ExchangeAlgorithmType.None;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetKeyExchangeStrength: Integer;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.KeyExchangeStrength;
  end
  else
  begin
    Result := 0;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetRemoteCertificate: X509Certificate;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.RemoteCertificate;
  end
  else
  begin
    Result := nil;
  end;
end;

function TIdSSLIOHandlerSocketNET.GetSslProtocol: SslProtocols;
begin
  if Assigned(FSSL) then
  begin
    Result := FSSL.SslProtocol;
  end
  else
  begin
    Result := SslProtocols.None;
  end;
end;

procedure TIdSSLIOHandlerSocketNET.InitComponent;
begin
  inherited;
  FenabledSslProtocols := System.Security.Authentication.SslProtocols.Default;
  FclientCertificateRequired := DEF_clientCertificateRequired;
  FcheckCertificateRevocation := DEF_checkCertificateRevocation;
end;

function TIdSSLIOHandlerSocketNET.LocalCertificateSelectionCallback(
  sender: TObject; targetHost: String;
  localCertificates: X509CertificateCollection;
  remoteCertificate: X509Certificate;
  acceptableIssuers: array of String): X509Certificate;
var i : Integer;
  LIssuer : String;
begin
  Result := nil;
  if Assigned(FOnLocalCertificateSelection) then
  begin
    FOnLocalCertificateSelection(Self,targetHost,localCertificates,remoteCertificate,Acceptableissuers,Result);
  end
  else
  begin
    if Assigned(acceptableIssuers) and
      (Length(acceptableIssuers)>0) and
      Assigned(localCertificates) and
      (localCertificates.Count > 0) then
    begin
       // Use the first certificate that is from an acceptable issuer.

      for I := 0 to LocalCertificates.Count -1 do
      begin
        LIssuer := LocalCertificates[i].Issuer;
        if (System.Array.IndexOf(acceptableIssuers, Lissuer)>-1) then
        begin
          Result := LocalCertificates[i];
          Exit;
        end;
      end;
    end;
  end;
  if (localCertificates <> nil) and
   (localCertificates.Count > 0) then
  begin
    Result :=  localCertificates[0];
  end;
end;

procedure TIdSSLIOHandlerSocketNET.OpenEncodedConnection;
begin
  FSSL := System.Net.Security.SslStream.Create(
     System.Net.Sockets.NetworkStream.Create(FBinding.Handle,False),True,
     ValidatePeerCertificate,LocalCertificateSelectionCallback);
  if IsPeer then
  begin
     if Assigned(FServerCertificate) then
     begin
       FSSL.AuthenticateAsServer(FServerCertificate,FclientCertificateRequired,FenabledSslProtocols,FcheckCertificateRevocation);
     end
     else
     begin
       raise EIdSSLCertRequiredForSvr.Create(RSSSLNETCertificateRequired);
     end;
  end
  else
  begin
     if Assigned(FClientCertificates) then
     begin
       FSSL.AuthenticateAsClient(FHost,FClientCertificates,FenabledSslProtocols,True);
       if not FSSL.IsMutuallyAuthenticated then
       begin
         raise EIdSSLNotAuthenticated.Create(RSSSLNETNotAuthenticated);
       end;
     end
     else
     begin
       FSSL.AuthenticateAsClient(FHost,nil,FenabledSslProtocols,True);
       if not FSSL.IsAuthenticated then
       begin
         raise EIdSSLNotAuthenticated.Create(RSSSLNETNotAuthenticated);
       end;
     end;
  end;
  if Assigned(FOnSSLHandshakeDone) then
  begin
    FOnSSLHandshakeDone(Self);
  end;
end;

function TIdSSLIOHandlerSocketNET.RecvEnc(var VBuffer: TIdBytes): Integer;
begin
  Result := FSSL.Read(VBuffer,0,Length(VBuffer));
end;

function TIdSSLIOHandlerSocketNET.SendEnc(const ABuffer: TIdBytes;
  const AOffset, ALength: Integer): Integer;
begin
  FSSL.Write(ABuffer,AOffset,ALength);
  Result := ALength;
end;

procedure TIdSSLIOHandlerSocketNET.SetPassThrough(const Value: Boolean);
begin
  if fPassThrough <> Value then begin
    if not Value then begin
      if BindingAllocated then begin
        OpenEncodedConnection;
      end;
    end
    else if FSSL <> nil then begin
      FSSL.Close;
      FreeAndNil(FSSL);
    end;
    fPassThrough := Value;
  end;
end;

procedure TIdSSLIOHandlerSocketNET.StartSSL;
begin
  if not PassThrough then begin
    OpenEncodedConnection;
  end;
end;

function TIdSSLIOHandlerSocketNET.ValidatePeerCertificate(sender: TObject;
  certificate: X509Certificate; chain: X509Chain;
  sslPolicyErrors: SslPolicyErrors): Boolean;
begin
  if Assigned(FOnValidatePeerCertificate) then
  begin
    FOnValidatePeerCertificate(sender,certificate,chain,sslPolicyErrors, Result);
  end
  else
  begin
{
This is a workaround for a quirk.  If using this as a server, the validation routine
may be called even though there may not be a client certificate and
FclientCertificateRequired was set to false.  It might be by design though.
}
    case sslPolicyErrors of
      System.Net.Security.SslPolicyErrors.None : Result := True;
      System.Net.Security.SslPolicyErrors.RemoteCertificateNotAvailable :
      begin
        if IsPeer and (not FclientCertificateRequired) then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
        end;
      end;
    else
      Result := False;
    end;
  end;
end;

{ TIdServerIOHandlerSSLNET }

function TIdServerIOHandlerSSLNET.Accept(ASocket: TIdSocketHandle;
  AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler;
var
  LIO : TIdSSLIOHandlerSocketNET;
begin
  LIO := TIdSSLIOHandlerSocketNET.Create(nil);
  LIO.PassThrough := True;
  LIO.IsPeer := True;
  LIO.Open;
  if LIO.Binding.Accept(ASocket.Handle) then begin
    SetIOHandlerValues(LIO);
  end else begin
    FreeAndNil(LIO);
  end;
  Result := LIO;
end;

destructor TIdServerIOHandlerSSLNET.Destroy;
begin
  inherited;
end;

procedure TIdServerIOHandlerSSLNET.Init;
begin
  inherited;
end;

procedure TIdServerIOHandlerSSLNET.InitComponent;
begin
  inherited InitComponent;
  FenabledSslProtocols := System.Security.Authentication.SslProtocols.Default;
  FclientCertificateRequired := DEF_clientCertificateRequired;
  FcheckCertificateRevocation := DEF_checkCertificateRevocation;
end;

function TIdServerIOHandlerSSLNET.MakeClientIOHandler: TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketNET;
begin
  LIO := TIdSSLIOHandlerSocketNET.Create(nil);
  LIO.PassThrough := True;
  LIO.IsPeer := False;
  SetIOHandlerValues(LIO); 
  Result := LIO;
end;

function TIdServerIOHandlerSSLNET.MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketNET;
begin
  LIO := TIdSSLIOHandlerSocketNET.Create(nil);
  LIO.PassThrough := True;
  LIO.IsPeer := True;
  SetIOHandlerValues(LIO);
  Result := LIO;
end;

function TIdServerIOHandlerSSLNET.MakeFTPSvrPort: TIdSSLIOHandlerSocketBase;
var
  LIO : TIdSSLIOHandlerSocketNET;
begin
  LIO := TIdSSLIOHandlerSocketNET.Create(nil);
  LIO.PassThrough := True;
  LIO.IsPeer := True;
  SetIOHandlerValues(LIO);
  Result := LIO;
end;

procedure TIdServerIOHandlerSSLNET.SetIOHandlerValues(
  AIO: TIdSSLIOHandlerSocketNET);
begin
  AIO.FServerCertificate := FServerCertificate;
  AIO.FclientCertificateRequired := FclientCertificateRequired;
//  AIO.FClientCertificates :=  FClientCertificates;
  AIO.FcheckCertificateRevocation := FcheckCertificateRevocation;
  AIO.FOnSSLHandshakeDone := FOnSSLHandshakeDone;
  AIO.FenabledSslProtocols := FenabledSslProtocols;
  AIO.FOnLocalCertificateSelection := FOnLocalCertificateSelection;
  AIO.FOnValidatePeerCertificate := FOnValidatePeerCertificate;
end;

procedure TIdServerIOHandlerSSLNET.Shutdown;
begin
  inherited;
end;

initialization

  RegisterSSL('Indy SSL Support for Microsoft.NET 2.0','Indy Pit Crew',                                  {do not localize}
    'Copyright © 1993 - 2007'#10#13 +                                     {do not localize}
    'Chad Z. Hower (Kudzu) and the Indy Pit Crew. All rights reserved.',  {do not localize}
    'Open SSL Support DLL Delphi and C++Builder interface',               {do not localize}
    'http://www.indyproject.org/'#10#13 +                                 {do not localize}
    'Original Author - J. Peter Mugaas',                               {do not localize}
    TIdSSLIOHandlerSocketNET,
    TIdServerIOHandlerSSLNET);
  TIdSSLIOHandlerSocketNET.RegisterIOHandler;
end.
