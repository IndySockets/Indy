unit IdSSLDotNET;

interface
uses
  Classes,
  IdException,
  IdGlobal,
  IdStackDotNet,
  IdSSL,
  System.Collections,
  System.IO,
  System.Net.Sockets,
  System.Net.Security,
  System.Security.Authentication,
  System.Security.Cryptography.X509Certificates;
  
type
  TOnValidatePeerCertificate = procedure (ASender : TObject;
    ACertificate : X509Certificate; AChain : X509Chain;
    AsslPolicyErrors : SslPolicyErrors; var VValid : Boolean) of object;
  TIdSSLIOHandlerSocketNET = class(TIdSSLIOHandlerSocketBase)
  protected
    FEnabledProtocols: System.Security.Authentication.SslProtocols;
    FOnValidatePeerCertificate : TOnValidatePeerCertificate;
    FSSL : SslStream;
    FSocketStream: Stream;
    FActiveStream: Stream;
    FServerCertificate : X509Certificate;
    FClientCertificates : X509CertificateCollection;
    FOnSSLHandshakeDone : TNotifyEvent;
    procedure OpenEncodedConnection; virtual;

    //Ssl certificate validation callback
    function ValidatePeerCertificate(
              sender : System.&Object;
              certificate : X509Certificate;
              chain : X509Chain;
              sslPolicyErrors : SslPolicyErrors) : Boolean;

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
  published
  published
  public
    procedure Close; override;
    procedure Open; override;
    procedure StartSSL; override;
    function Clone : TIdSSLIOHandlerSocketBase; override;
    function GetSslProtocol: SslProtocols;

    property EnabledProtocols : System.Security.Authentication.SslProtocols read FEnabledProtocols write FEnabledProtocols;
    property ServerCertificate : X509Certificate read FServerCertificate write FServerCertificate;
    property ClientCertificates : X509CertificateCollection read FClientCertificates write FClientCertificates;

    property OnSSLHandshakeDone : TNotifyEvent read FOnSSLHandshakeDone write FOnSSLHandshakeDone;

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
  end;

  EIdSSLNetException = class(EIdException);
  EIdSSLCertRequiredForSvr = class(EIdSSLNetException);
  EIdSSLNotAuthenticated = class(EIdSSLNetException);

implementation
uses
  IdStack, SysUtils;

{ TIdSSLIOHandlerSocketNET }

function TIdSSLIOHandlerSocketNET.Clone: TIdSSLIOHandlerSocketBase;
begin

end;

procedure TIdSSLIOHandlerSocketNET.Close;
begin
{  if not PassThrough then
  begin
    FSSL.Close;
    FSSL := nil;
  end;         }
  if Assigned(FSocketStream) then
  begin
    FSocketStream.Close;
    FreeAndNil(FSocketStream);
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
 // DoBeforeConnect(Self);
  // CreateSSLContext(sslmClient);
  // CreateSSLContext(SSLOptions.fMode);
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
  FEnabledProtocols := System.Security.Authentication.SslProtocols.Default;
end;

procedure TIdSSLIOHandlerSocketNET.Open;
begin
  inherited;

  if not Passthrough then
  begin
    OpenEncodedConnection;
  end;
end;

procedure TIdSSLIOHandlerSocketNET.OpenEncodedConnection;
begin
  FSocketStream :=  System.Net.Sockets.NetworkStream.Create(FBinding.Handle,False);
//  FSocketStream := TIdSocketStream.Create(Binding.Handle);
  FSSL := System.Net.Security.SslStream.Create(FSocketStream,True,
     ValidatePeerCertificate);
 // FSSL.ReadTimeout := ReadTimeout;
  if IsPeer then
  begin
     if Assigned(FServerCertificate) then
     begin
       FSSL.AuthenticateAsServer(FServerCertificate);
     end
     else
     begin
       raise EIdSSLCertRequiredForSvr.Create('Certificate required for servers');
     end;
  end
  else
  begin
     if Assigned(FClientCertificates) then
     begin
       FSSL.AuthenticateAsClient(FHost,FClientCertificates,FEnabledProtocols,True);
       if not FSSL.IsMutuallyAuthenticated then
       begin
         raise EIdSSLNotAuthenticated.Create('Not authenticated');
       end;
     end
     else
     begin
       FSSL.AuthenticateAsClient(FHost,nil,FEnabledProtocols,True);
       if not FSSL.IsAuthenticated then
       begin
         raise EIdSSLNotAuthenticated.Create('Not authenticated');
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
   //     if Assigned(fSSLContext) then begin
          OpenEncodedConnection;
    //    end else begin
        //  raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
    //    end;
      end;
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
    if sslPolicyErrors = System.Net.Security.SslPolicyErrors.None then
    begin
      Result := True;
    end;
  end;
  Result := True;
end;

end.
