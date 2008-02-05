{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17161: FileSYstemTestMain.pas 
{
{   Rev 1.0    3/14/2003 06:59:18 PM  JPMugaas
{ FTPFileSystem Test program.
}
unit FileSYstemTestMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdFTPBaseFileSystem, IdFTPFileSystem, IdBaseComponent,
  IdComponent, IdTCPServer, IdCmdTCPServer, IdFTPServer, IdUserAccounts,
  StdCtrls, ComCtrls, IdSync, IdContext, IdTCPConnection,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL;

type
  TfrmServer = class(TForm)
    IdFTPServer1: TIdFTPServer;
    IdUserManager1: TIdUserManager;
    IdFTPFileSystem1: TIdFTPFileSystem;
    redtLog: TRichEdit;
    IdSSLServer: TIdServerIOHandlerSSLOpenSSL;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdFTPServer1Connect(AContext: TIdContext);
    procedure IdFTPServer1BeforeCommandHandler(ASender: TIdTCPServer;
      const AData: String; AContext: TIdContext);
    procedure IdFTPServer1Exception(AContext: TIdContext;
      AException: Exception);
    procedure IdFTPServer1Disconnect(AContext: TIdContext);
    procedure IdSSLServerGetPassword(var Password: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServer: TfrmServer;


implementation
uses IdIOHandlerStack;

{$R *.dfm}

type
  TConnectSync = class(TIdSync)
  protected
    FIPConnect : String;
    FPortConnect : Cardinal;
    procedure DoSynchronize; override;
  public
    class procedure CreateSync(const AIP : String; const APort : Cardinal);
  end;
  TDisconnectSync = class(TConnectSync)
  protected
    procedure DoSynchronize; override;
  end;
  TCmdLoggerSync = class(TIdSync)
  protected
    FIPConnect : String;
    FPortConnect : Cardinal;
    FMsg : String;
    procedure DoSynchronize; override;
  public
    class procedure CreateSync(const AIP : String; const APort : Cardinal; const AMsg : String);
  end;
  TExceptionLoggerSync = class(TIdSync)
    FIPConnect : String;
    FPortConnect : Cardinal;
    FMsg : String;
    FExceptionName : String;
    procedure DoSynchronize; override;
  public
    class procedure CreateSync(const AIP : String; const APort : Cardinal; const AExceptionName, AMsg : String);
  end;


function MakePathStr(const APath : String): String;
begin
  {$IFDEF VCL6ORABOVE}
  Result := SysUtils.IncludeTrailingPathDelimiter(APath);
  {$ELSE}
  Result := IncludeTrailingBackSlash(APath);
  {$ENDIF}
end;

function GetSSLCertPath : String;
begin
  Result := MakePathStr(ExtractFilePath(ParamStr(0))+'cert');
end;


procedure TfrmServer.FormDestroy(Sender: TObject);
begin
  IdFTPFileSystem1.SaveFileSystem(ChangeFileExt( ParamStr(0),'.ini'));
end;

procedure TfrmServer.FormCreate(Sender: TObject);
begin
  IdFTPFileSystem1.LoadFileSystem(ChangeFileExt( ParamStr(0),'.ini'));
  IdSSLServer.SSLOptions.RootCertFile := GetSSLCertPath + 'CAcert.crt';
  IdSSLServer.SSLOptions.CertFile := GetSSLCertPath + 'WSScert.pem';
  IdSSLServer.SSLOptions.KeyFile := GetSSLCertPath + 'WSSkey.pem';
  IdSSLServer.SSLOptions.Method :=sslvSSLv23 ;
  IdSSLServer.SSLOptions.Mode:= sslmUnassigned;
  IdFTPServer1.Active := True;

end;

{ TConnectSync }

class procedure TConnectSync.CreateSync(const AIP: String;
  const APort: Cardinal);
var LCon : TConnectSync;
begin
  LCon := Create;
  LCon.FIPConnect := AIP;
  LCon.FPortConnect := APort;
  LCon.Synchronize;
end;

procedure TConnectSync.DoSynchronize;
begin
  frmServer.redtLog.Lines.Add( Format('Connect:  IP - %s  Port - %d',[FIPConnect,FPortConnect]));
end;

procedure TfrmServer.IdFTPServer1Connect(AContext: TIdContext);
var LStck : TIdIOHandlerStack;
begin
  LStck := AContext.Connection.IOHandler as TIdIOHandlerStack;
  TConnectSync.CreateSync(LStck.Binding.PeerIP,LStck.Binding.PeerPort);
end;

{ TCmdLoggerSync }

class procedure TCmdLoggerSync.CreateSync(const AIP: String;
  const APort: Cardinal; const AMsg: String);
var LCon : TCmdLoggerSync;
begin
 LCon := TCmdLoggerSync.Create;
 LCon.FIPConnect := AIP;
 LCon.FPortConnect := APort;
 LCon.FMsg := AMsg;
 LCon.Synchronize;
end;

procedure TCmdLoggerSync.DoSynchronize;
begin
  frmServer.redtLog.Lines.Add( Format('Command:    IP - %s  Port - %d : [%s]',[FIPConnect,FPortConnect,FMsg]));
end;                                               

procedure TfrmServer.IdFTPServer1BeforeCommandHandler(
  ASender: TIdTCPServer; const AData: String; AContext: TIdContext);
var LStck : TIdIOHandlerStack;
begin
  LStck := AContext.Connection.IOHandler as TIdIOHandlerStack;
  TCmdLoggerSync.CreateSync(LStck.Binding.PeerIP,LStck.Binding.PeerPort,AData);
end;

{ TExceptionLoggerSync }

class procedure TExceptionLoggerSync.CreateSync(const AIP: String;
  const APort: Cardinal; const AExceptionName, AMsg: String);
var LCon : TExceptionLoggerSync;
begin
  LCon := TExceptionLoggerSync.Create;
  LCon.FIPConnect := AIP;
  LCon.FPortConnect := APort;
  LCon.FExceptionName := AExceptionName;
  LCon.FMsg := AMsg;
  LCon.Synchronize;
end;

procedure TExceptionLoggerSync.DoSynchronize;
begin
  frmServer.redtLog.Lines.Add( Format('Exception:  IP - %s  Port - %d Type [%s]',[FIPConnect,FPortConnect,FExceptionName ]));
  frmServer.redtLog.Lines.Add( Format('Command:    IP - %s  Port - %d Message [%s]',[FIPConnect,FPortConnect,FMsg]));
end;

procedure TfrmServer.IdFTPServer1Exception(AContext: TIdContext;
  AException: Exception);
var LStck : TIdIOHandlerStack;
begin
  LStck := AContext.Connection.IOHandler as TIdIOHandlerStack;
  TExceptionLoggerSync.CreateSync(LStck.Binding.PeerIP,LStck.Binding.PeerPort,AException.ClassName,AException.Message );

end;

{ TDisconnectSync }

procedure TDisconnectSync.DoSynchronize;
begin
  frmServer.redtLog.Lines.Add( Format('Disconnect: IP - %s  Port - %d',[FIPConnect,FPortConnect]));
end;

procedure TfrmServer.IdFTPServer1Disconnect(AContext: TIdContext);
var LStck : TIdIOHandlerStack;
begin
  LStck := AContext.Connection.IOHandler as TIdIOHandlerStack;
  if Assigned(LStck) then
  begin
    TDisconnectSync.CreateSync(LStck.Binding.PeerIP,LStck.Binding.PeerPort);
  end;
end;

procedure TfrmServer.IdSSLServerGetPassword(var Password: String);
begin
  Password := 'aaaa';
end;

end.
