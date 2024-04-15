unit testserver;

{$IFDEF MSWINDOWS}
{$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF CPU386}
{$DEFINE CPU32}
{$ENDIF}

{$IFDEF CPUX64}
{$DEFINE CPU64}
{$ENDIF}

{$IFDEF FPC}
{$mode delphi}
{$codepage utf8}
{$ENDIF}

interface

uses
  Classes, SysUtils, {$IFDEF FPC}CustApp,{$ENDIF}IdIOHandler, IdHTTP,
  IdSSL, IdSSLOpenSSL, IdSSLOpenSSLLoader, IdHeaderList, IdContext,
  IdCustomHTTPServer, IdHTTPServer, IdServerIOHandler, IdGlobal;

const
  SSLServerPort = 8080;
  remoteSource = 'https://localhost:8080/openssltest.txt';
  sGetException = 'Error: Status = %d returned when GETting %s';
  rcAccept = 'Application/txt';
  {$if not declared(DirectorySeparator)}
  DirectorySeparator = '\';
  {$ifend}
  {$if not declared(LineEnding))}
  LineEnding = #$0D#$0A;
  {$ifend}

  {Certificates}
  myPassword = 'mypassword';
  MyRootCertFile = 'cacerts' + DirectorySeparator + 'ca.pem';
  MyCertFile = 'certs' + DirectorySeparator+ 'myserver.pem';
  MyKeyFile = 'certs' + DirectorySeparator + 'myserverkey.pem';
  MyClientCertPackage = 'certs' + DirectorySeparator + 'myclient.p12';
  RootCertificatesDir = 'cacerts';


type
   {$if not declared(TCustomApplication)}
   {$DEFINE LOCAL_TCUSTOMAPP}
   TCustomApplication = class(TComponent)
   private
     FTitle: string;
   protected
     procedure DoRun; virtual; abstract;
   public
     function Exename: string;
     procedure Run;
     procedure Terminate;
     property Title: string read FTitle write FTitle;
   end;
   {$IFEND}

  { TOpenSSLServerTest }

  TOpenSSLServerTest = class(TCustomApplication)
  private
    FSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    FServer: TIdHTTPServer;
    FClientVerification: boolean;
    FPromptOnExit: boolean;
    FOpenSSLLibDir: string;
    function DoTest: integer;
    function GetSSLClientHandler(AOwner: TComponent): TIdIOHandler;
    function GetSSLServerHandler(AOwner: TComponent): TIdServerIOHandler;
    function IsDirectoryEmpty(Path: string): boolean;
    procedure HandleCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure GetMyPassword(var Password: String);
    procedure QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    function CertificateType(Certificate: TIdX509): string;
    function ClientVerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
    function ServerVerifyPeer(Certificate: TIdX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
    procedure ShowCertificate(Certificate : TIdX509);
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

   { TResponseTextBuffer }

   TResponseTextBuffer = class(TMemoryStream)
    private
      function GetDataString: AnsiString;
    public
      property DataString: AnsiString read GetDataString;
    end;


implementation

{$IFDEF LOCAL_TCUSTOMAPP}
function TCustomApplication.Exename: string;
begin
  Result := ParamStr(0);
end;

procedure TCustomApplication.Run;
begin
  try
    DoRun;
  except on E: Exception do
    writeln(E.Message);
  end;
end;

procedure TCustomApplication.Terminate;
begin

end;
{$ENDIF}

{ TResponseTextBuffer }

function TResponseTextBuffer.GetDataString: AnsiString;
begin
  SetLength(Result,Size);
  Position := 0;
  Read(Result[1],Size);
  SetCodePage(RawByteString(Result), DefaultSystemCodePage, False);
end;


{ TOpenSSLServerTest }

function TOpenSSLServerTest.DoTest: integer;
var httpClient: TIdHttp;
    ResponseStream: TResponseTextBuffer;
begin
  httpClient := TIdHTTP.Create(nil);
  try
    httpClient.HTTPOptions := httpClient.HTTPOptions + [hoNoProtocolErrorException,
                                                        hoKeepOrigProtocol,
                                                        hoWantProtocolErrorContent];
    httpClient.ProtocolVersion := pv1_1;
    httpClient.Request.CustomHeaders.Clear;
    httpClient.Request.Accept := rcAccept;
    httpClient.Request.BasicAuthentication:= false;
    httpClient.HandleRedirects := true;

    httpClient.Request.UserAgent :=' Mozilla/5.0 (compatible; Indy Library)';
    httpClient.Request.ContentType := 'text/html; charset=utf-8';
    httpClient.IOHandler := GetSSLClientHandler(httpClient);

    httpClient.ConnectTimeout := 5000;
    httpClient.ReadTimeout := 20000;
    ResponseStream := TResponseTextBuffer.Create;
    try
      httpClient.Get(remoteSource,ResponseStream);
      if assigned (FSSLHandler.SSLSocket) then
        writeln('Using SSL/TLS Version ' + FSSLHandler.SSLSocket.SSLProtocolVersionStr, ' with cipher ',FSSLHandler.SSLSocket.Cipher.Name);
      Result := httpClient.ResponseCode;
      if Result = 200 then
      begin
        writeln('Remote Source returned:');
        writeln(ResponseStream.DataString);
      end
      else
        writeln(Format(sGetException,[Result,remoteSource]));
    finally
      ResponseStream.Free;
    end;
  finally
    httpClient.Free;
  end;
end;

function TOpenSSLServerTest.GetSSLClientHandler(AOwner: TComponent
  ): TIdIOHandler;
var IOHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(AOwner);
  IOHandler.SSLOptions.Mode:= sslmClient;
  IOHandler.SSLOptions.VerifyMode := [sslvrfPeer,sslvrfFailIfNoPeerCert];
  IOHandler.SSLOptions.VerifyDepth := 100;
  IOHandler.SSLOptions.RootCertFile := MyRootCertFile;
  IOHandler.SSLOptions.UseSystemRootCertificateStore := false;
  IOHandler.SSLOptions.VerifyDirs := GetCurrentDir + DirectorySeparator + RootCertificatesDir;
  IOHandler.OnVerifyPeer := ClientVerifyPeer;
  IOHandler.OnGetPassword := GetMyPassword;
  if FClientVerification then
  begin
    IOHandler.SSLOptions.CertFile := MyClientCertPackage;
    IOHandler.SSLOptions.KeyFile := MyClientCertPackage;
  end;
  FSSLHandler := IOHandler;
  Result := IOHandler;
end;

function TOpenSSLServerTest.GetSSLServerHandler(AOwner : TComponent
  ) : TIdServerIOHandler;
var IOHandler: TIdServerIOHandlerSSLOpenSSL;
begin
  IOHandler := TIdServerIOHandlerSSLOpenSSL.Create(AOwner);
  IOHandler.SSLOptions.Mode:= sslmServer;
  IOHandler.SSLOptions.RootCertFile := MyRootCertFile;
  IOHandler.SSLOptions.CertFile := MyCertFile;
  IOHandler.SSLOptions.KeyFile := MyKeyFile;
  IOHandler.OnGetPassword := GetMyPassword;
  IOHandler.OnVerifyPeer := ServerVerifyPeer;
  if FClientVerification then
  begin
    IOHandler.SSLOptions.VerifyMode := [sslvrfPeer,sslvrfFailIfNoPeerCert];
    IOHandler.SSLOptions.VerifyDepth := 100;
    IOHandler.SSLOptions.UseSystemRootCertificateStore := false;
    IOHandler.SSLOptions.VerifyDirs := GetCurrentDir + DirectorySeparator + RootCertificatesDir;
  end;
  Result := IOHandler;
end;

function TOpenSSLServerTest.IsDirectoryEmpty(Path: string): boolean;
var Rslt: TSearchRec;
begin
  Result := true;
  if FindFirst(Path + DirectorySeparator + '*',faNormal or faSymLink,Rslt) = 0 then
  begin
    Result := false;
    FindClose(Rslt);
  end;
end;

procedure TOpenSSLServerTest.HandleCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var S: TStringStream;
begin
  S := TStringStream.Create('Server Response' + LineEnding);
  S.WriteString('Command: ' + ARequestInfo.RawHTTPCommand + LineEnding);
  S.WriteString('Remote IP: ' + ARequestInfo.RemoteIP + LineEnding);
  S.WriteString('Success!' + LineEnding);
  AResponseInfo.ContentStream := S;
  AResponseInfo.ContentType := 'text/html';
  AResponseInfo.ContentEncoding := 'UTF-8';
  AResponseInfo.CharSet := 'UTF-8';
  AResponseInfo.CloseConnection := true;
  AResponseInfo.ContentStream.Position := 0;
end;

procedure TOpenSSLServerTest.GetMyPassword(var Password : String);
begin
  Password := myPassword;
end;

procedure TOpenSSLServerTest.QuerySSLPort(APort : TIdPort; var VUseSSL : Boolean
  );
begin
  VUseSSL := (APort = SSLServerPort);
end;

function TOpenSSLServerTest.CertificateType(Certificate : TIdX509) : string;
begin
  if Certificate.Issuer.Hash.C1 = Certificate.Subject.Hash.C1 then
    Result := 'Root'
  else
    Result := 'Remote';
end;

function TOpenSSLServerTest.ClientVerifyPeer(Certificate : TIdX509;
  AOk : Boolean; ADepth , AError : Integer) : Boolean;
begin
  writeln;
  writeln('Client Side Verification');
  if AOK then
   writeln(CertificateType(Certificate),' Certificate verification succeeded')
  else
   writeln(CertificateType(Certificate),' Certificate verification failed');
  ShowCertificate(certificate);
  Result := AOK;
end;

function TOpenSSLServerTest.ServerVerifyPeer(Certificate : TIdX509;
  AOk : Boolean; ADepth , AError : Integer) : Boolean;
begin
  writeln;
  writeln('Server Side Verification');
  if AOK then
   writeln(CertificateType(Certificate),' Certificate verification succeeded')
  else
   writeln(CertificateType(Certificate),' Certificate verification failed');
  ShowCertificate(certificate);
  Result := AOK;
end;

procedure TOpenSSLServerTest.ShowCertificate(Certificate : TIdX509);
begin
  writeln;
  writeln('X.509 Certificate Details');
  writeln('Subject: ', Certificate.Subject.OneLine);
  writeln('Issuer: ', Certificate.Issuer.OneLine);
  writeln('Not Before: ',DateTimeToStr(Certificate.notBefore));
  writeln('Not After: ',DateTimeToStr(Certificate.notAfter));
  writeln;
end;

procedure TOpenSSLServerTest.DoRun;

  procedure RunTest;
  begin
    FServer.Active := true;
    Sleep(1000); {let server get going}
    writeln('Using ',OpenSSLVersion);
    writeln('Getting ',remoteSource,' with verification');
    writeln;

    try
      DoTest;
    except on E:Exception do
      writeln(E.Message);
    end;
    FClientVerification := true;
    FServer.Active := false;
    FServer.IOHandler := GetSSLServerHandler(self);
    FServer.Active := true;
    writeln('Getting ',remoteSource,' with verification and client verification');
    writeln;
    try
      DoTest;
    except on E:Exception do
      writeln(E.Message);
    end;
end;

var i: integer;

begin
  FPromptOnExit := true;
  try
    i := 1;
    while i <= ParamCount do
    begin
      if ParamStr(i) = '-h' then
      begin
        WriteHelp;
        Terminate;
        Exit;
      end;

      if ParamStr(i) = '-n' then
        FPromptOnExit := false
      else
      if DirectoryExists(ParamStr(i)) then
         FOpenSSLLibDir := ParamStr(i)
      else
        raise Exception.CreateFmt('Unrecognised option - %s',[ParamStr(i)]);
      Inc(i);
   end;

    if GetOpenSSLLoader <> nil then
    begin
      if (FOpenSSLLibDir = '') or not IsDirectoryEmpty(FOpenSSLLibDir) then
      begin
        GetOpenSSLLoader.OpenSSLPath := FOpenSSLLibDir;
        RunTest;
      end
      else
        writeln('Directory ',FOpenSSLLibDir,' is empty!');
    end
    else
      RunTest;


    {$IFDEF WINDOWS}
    if FPromptOnExit then
    begin
      write('Press Return to continue');
      readln; //stop console disappearing until user presses return}
    end;
    {$ENDIF}

  except on E: Exception do
    writeln('Error: ', E.Message);
  end;
  Terminate;
end;

constructor TOpenSSLServerTest.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  FServer := TIdHTTPServer.Create(self);
  FServer.IOHandler := GetSSLServerHandler(self);
  FServer.OnQuerySSLPort := QuerySSLPort;
  FServer.DefaultPort := SSLServerPort;
  FServer.OnCommandGet := HandleCommandGet;
end;

destructor TOpenSSLServerTest.Destroy;
begin
  if FServer <> nil then
    FServer.Free;
  inherited Destroy;
end;

procedure TOpenSSLServerTest.WriteHelp;
begin
  { add your help code here }
  writeln('OpenSSL Https Server Test');
  writeln('Gets text file from ' + remoteSource + ' and prints it');
  writeln('Usage: ', ExtractFileName(ExeName), ' [-h] [-n] [OpenSSL lib Dir]')
end;


end.

