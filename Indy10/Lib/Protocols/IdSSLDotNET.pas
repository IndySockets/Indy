unit IdSSLDotNET;

interface
uses
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
    FOnValidatePeerCertificate : TOnValidatePeerCertificate;
    FSSL : SslStream;
    FSocketStream: Stream;
    FActiveStream: Stream;
    FServerCertificate : X509Certificate;
    FClientCertificates : X509CertificateCollection;
    FEnabledProtocols : System.Security.Authentication.SslProtocols;
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
  public
    procedure Close; override;
    procedure Open; override;
    procedure StartSSL; override;
    function Clone : TIdSSLIOHandlerSocketBase; override;
    property EnabledProtocols : System.Security.Authentication.SslProtocols read FEnabledProtocols write FEnabledProtocols;
    property ServerCertificate : X509Certificate read FServerCertificate write FServerCertificate;
    property ClientCertificates : X509CertificateCollection read FClientCertificates write FClientCertificates;
  end;

  EIdSSLNetException = class(EIdException);
  EIdSSLCertRequiredForSvr = class(EIdSSLNetException);
  
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

procedure TIdSSLIOHandlerSocketNET.InitComponent;
begin
  inherited;
  FEnabledProtocols := System.Security.Authentication.SslProtocols.Default;
end;

procedure TIdSSLIOHandlerSocketNET.Open;
begin
  inherited;

  if Passthrough then
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
     end
     else
     begin
       FSSL.AuthenticateAsClient(FHost,nil,FEnabledProtocols,True);
     end;  

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
end;

end.
