{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13892: IdHTTPProxyServer.pas
{
{   Rev 1.24    10/14/2004 1:45:32 PM  BGooijen
{ Beauty fixes ;)
}
{
{   Rev 1.23    10/14/2004 1:05:48 PM  BGooijen
{ set PerformReply to false, else "200 OK" was added behind the document body
}
{
{   Rev 1.22    09.08.2004 09:30:00  OMonien
{ changed disconnect handling. Previous implementation failed when exceptions
{ ocured in command handler.
}
{
{   Rev 1.21    08.08.2004 10:35:56  OMonien
{ Greeting removed
}
{
    Rev 1.20    6/11/2004 9:36:28 AM  DSiders
  Added "Do not Localize" comments.
}
{
{   Rev 1.19    2004.05.20 1:39:24 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.18    2004.05.20 11:37:20 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.17    4/19/2004 7:07:38 PM  BGooijen
{ the remote headers are now passed to the OnHTTPDocument event
}
{
{   Rev 1.16    4/18/2004 11:31:26 PM  BGooijen
{ Fixed POST
{ Build CONNECT
{ fixed some bugs where chars were replaced when that was not needed ( thus
{ causing corrupt data )
}
{
{   Rev 1.15    2004.04.13 10:24:24 PM  czhower
{ Bug fix for when user changes stream.
}
{
{   Rev 1.14    2004.02.03 5:45:12 PM  czhower
{ Name changes
}
{
{   Rev 1.13    1/21/2004 2:42:52 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.12    10/25/2003 06:52:12 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.
}
{
{   Rev 1.11    2003.10.24 10:43:10 AM  czhower
{ TIdSTream to dos
}
{
    Rev 1.10    10/17/2003 12:10:08 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.9    2003.10.12 3:50:44 PM  czhower
{ Compile todos
}
{
{   Rev 1.8    7/13/2003 7:57:38 PM  SPerry
{ fixed problem with commandhandlers
}
{
{   Rev 1.6    5/25/2003 03:54:42 AM  JPMugaas
}
{
{   Rev 1.5    2/24/2003 08:56:50 PM  JPMugaas
}
{
    Rev 1.4    1/20/2003 1:15:44 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes
}
{
{   Rev 1.3    1-14-2003 19:19:22  BGooijen
{ The first line of the header was sent to the server twice, fixed that.
}
{
{   Rev 1.2    1-1-2003 21:52:06  BGooijen
{ Changed for TIdContext
}
{
{   Rev 1.1    12-29-2002 13:00:02  BGooijen
{ - Works on Indy 10 now
{ - Cleaned up some code
}
{
{   Rev 1.0    2002.11.22 8:37:50 PM  czhower
}
{
{   Rev 1.0    2002.11.22 8:37:16 PM  czhower
}
unit IdHTTPProxyServer;

interface

{
 Indy HTTP proxy Server

 Original Programmer: Bas Gooijen (bas_gooijen@yahoo.com)
 Current Maintainer:  Bas Gooijen
   Code is given to the Indy Pit Crew.

 Modifications by Chad Z. Hower (Kudzu)

 Quick Notes:

 Revision History:
 10-May-2002: Created Unit.
}

uses
//  Classes,
  IdObjs,
  IdAssignedNumbers,
  IdGlobal,
  IdHeaderList,
  IdTCPConnection,
  IdCmdTCPServer,
  IdCommandHandlers;

const
  IdPORT_HTTPProxy = 8080;

type
{ not needed (yet)
  TIdHTTPProxyServerThread = class( TIdPeerThread )
  protected
    // what needs to be stored...
    fUser: string;
    fPassword: string;
  public
    constructor Create( ACreateSuspended: Boolean = True ) ; override;
    destructor Destroy; override;
    // Any functions for vars
    property Username: string read fUser write fUser;
    property Password: string read fPassword write fPassword;
  end;
}
  TIdHTTPProxyServer = class;
  TOnHTTPDocument = procedure(ASender: TIdHTTPProxyServer; const ADocument: string;
   var VStream: TIdStream2; const AHeaders: TIdHeaderList) of object;

  TIdHTTPProxyServer = class(TIdCmdTCPServer)
  protected
    FOnHTTPDocument: TOnHTTPDocument;
    // CommandHandlers
    procedure CommandGET(ASender: TIdCommand);
    procedure CommandPOST(ASender: TIdCommand);
    procedure CommandHEAD(ASender: TIdCommand);
    procedure CommandConnect(ASender: TIdCommand); // for ssl
    procedure DoHTTPDocument(const ADocument: string; var VStream: TIdStream2; const AHeaders: TIdHeaderList);
    procedure InitializeCommandHandlers; override;
    procedure TransferData(ASrc: TIdTCPConnection; ADest: TIdTCPConnection; const ADocument: string;
      const ASize: Integer; const AHeaders: TIdHeaderList);
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_HTTPProxy;
    property OnHTTPDocument: TOnHTTPDocument read FOnHTTPDocument write FOnHTTPDocument;
  end;

implementation

uses
  IdResourceStrings, IdStreamVCL, IdReplyRFC, IdSYs, IdTCPClient, IdURI, IdGlobalProtocols;

procedure TIdHTTPProxyServer.InitializeCommandHandlers;
begin
  inherited;
  with CommandHandlers.Add do begin
    Command := 'GET';             {do not localize}
    OnCommand := CommandGet;
    ParseParams := True;
    Disconnect := true;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'POST';            {do not localize}
    OnCommand := CommandPOST;
    ParseParams := True;
    Disconnect := true;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'HEAD';            {do not localize}
    OnCommand := CommandHEAD;
    ParseParams := True;
    Disconnect := true;
  end;
  with CommandHandlers.Add do 
  begin
    Command := 'CONNECT';         {do not localize}
    OnCommand := Commandconnect;
    ParseParams := True;
    Disconnect := true;
  end;
  //HTTP Servers/Proxies do not send a greeting
  Greeting.Clear;
end;

procedure TIdHTTPProxyServer.TransferData(
  ASrc: TIdTCPConnection;
  ADest: TIdTCPConnection;
  const ADocument: string;
  const ASize: Integer;
  const AHeaders: TIdHeaderList
  );
//TODO: This captures then sends. This is great and we need this as an option for proxies that
// modify data. However we also need another option that writes as it captures.
// Two modes? Intercept and not?
var
  LStream: TIdStream2;
  LS : TIdStreamVCL;
begin
  //TODO: Have an event to let the user perform stream creation
  LStream := TIdMemoryStream.Create; try
    LS := TIdStreamVCL.Create(LStream); try
      ASrc.IOHandler.ReadStream(LS, ASize, ASize = -1);
    finally Sys.FreeAndNil(LS); end;
    LStream.Position := 0;
    DoHTTPDocument(ADocument, LStream, AHeaders);
    // Need to recreate IdStream, DoHTTPDocument passes it as a var and user can change the
    // stream that is returned
    LS := TIdStreamVCL.Create(LStream); try
      ADest.IOHandler.Write(LS);
    finally Sys.FreeAndNil(LS); end;
  finally Sys.FreeAndNil(LStream); end;
end;

procedure TIdHTTPProxyServer.CommandGET( ASender: TIdCommand ) ;
var
  LClient: TIdTCPClient;
  LDocument: string;
  LHeaders: TIdHeaderList;
  LRemoteHeaders: TIdHeaderList;
  LURI: TIdURI;
  LPageSize: Integer;
begin
  ASender.PerformReply := false;
  LHeaders := TIdHeaderList.Create; try
    ASender.Context.Connection.IOHandler.Capture(LHeaders, '');
    LClient := TIdTCPClient.Create(nil); try
      LURI := TIdURI.Create(ASender.Params.Strings[0]); try
        LClient.Port := Sys.StrToInt(LURI.Port, 80);
        LClient.Host := LURI.Host;
        //We have to remove the host and port from the request
        LDocument := LURI.Path + LURI.Document + LURI.Params;
      finally Sys.FreeAndNil(LURI); end;
      LClient.Connect; try
        LClient.IOHandler.WriteLn('GET ' + LDocument + ' HTTP/1.0'); {Do not Localize}
        LClient.IOHandler.Write(LHeaders);
        LClient.IOHandler.WriteLn('');
        LRemoteHeaders := TIdHeaderList.Create; try
          LClient.IOHandler.Capture(LRemoteHeaders, '');
          ASender.Context.Connection.IOHandler.Write(LRemoteHeaders);
          ASender.Context.Connection.IOHandler.WriteLn('');
          LPageSize := Sys.StrToInt(LRemoteHeaders.Values['Content-Length'], -1) ; {Do not Localize}
          TransferData(LClient, ASender.Context.Connection, LDocument, LPageSize, LRemoteHeaders);
        finally Sys.FreeAndNil(LRemoteHeaders); end;
      finally LClient.Disconnect; end;
    finally Sys.FreeAndNil(LClient); end;
  finally Sys.FreeAndNil(LHeaders); end;
end;

procedure TIdHTTPProxyServer.CommandPOST( ASender: TIdCommand ) ;
var
  LClient: TIdTCPClient;
  LDocument: string;
  LHeaders: TIdHeaderList;
  LRemoteHeaders: TIdHeaderList;
  LURI: TIdURI;
  LPageSize: Integer;
  LPostStream: TIdMemoryStream;
  LS : TIdStreamVCL;
begin
  ASender.PerformReply := false;
  LHeaders := TIdHeaderList.Create; try
    ASender.Context.Connection.IOHandler.Capture(LHeaders, '');
    LPostStream:= TIdMemorystream.Create; LS:= TIdStreamVCL.Create(LPostStream,False); try
      LPostStream.size:=Sys.StrToInt( LHeaders.Values['Content-Length'], 0 ); {Do not Localize}
      ASender.Context.Connection.IOHandler.ReadStream(LS,LPostStream.Size,false);
      LClient := TIdTCPClient.Create(nil); try
        LURI := TIdURI.Create(ASender.Params.Strings[0]); try
          LClient.Port := Sys.StrToInt(LURI.Port, 80);
          LClient.Host := LURI.Host;
          //We have to remove the host and port from the request
          LDocument := LURI.Path + LURI.Document + LURI.Params;
        finally Sys.FreeAndNil(LURI); end;
        LClient.Connect; try
          LClient.IOHandler.WriteLn('POST ' + LDocument + ' HTTP/1.0'); {Do not Localize}
          LClient.IOHandler.Write(LHeaders);
          LClient.IOHandler.WriteLn('');
          LClient.IOHandler.Write(LS,0,false);
          LRemoteHeaders := TIdHeaderList.Create; try
            LClient.IOHandler.Capture(LRemoteHeaders, '');
            ASender.Context.Connection.IOHandler.Write(LRemoteHeaders);
            ASender.Context.Connection.IOHandler.Writeln('');
            LPageSize := Sys.StrToInt(LRemoteHeaders.Values['Content-Length'], -1) ; {Do not Localize}
            TransferData(LClient, ASender.Context.Connection, LDocument, LPageSize, LRemoteHeaders);
          finally Sys.FreeAndNil(LRemoteHeaders); end;
        finally LClient.Disconnect; end;
      finally Sys.FreeAndNil(LClient); end;
    finally Sys.FreeAndNil(LPostStream); Sys.FreeAndNil(LS); end;
  finally Sys.FreeAndNil(LHeaders); end;
end;

procedure TIdHTTPProxyServer.CommandConnect( ASender: TIdCommand ) ;
var
  LHeaders: tidheaderlist;
  LClient: TIdTCPClient;
  LRemoteHost: string;
  LBuffer:TIdBytes;
begin
  ASender.PerformReply := false;
  LHeaders := TIdHeaderList.Create; try
    ASender.Context.Connection.IOHandler.Capture(LHeaders, '');
    LRemoteHost := ASender.Params.Strings[0];
    LClient := TIdTCPClient.Create(nil); try
      LClient.Host := Fetch(LRemoteHost,':',True);
      LClient.Port := Sys.StrToInt(LRemoteHost, 443);
      LClient.Connect; try
        ASender.Context.Connection.IOHandler.WriteLn('');
        ASender.Context.Connection.IOHandler.WriteLn('HTTP/1.0 200 Connection established'); {do not localize}
        ASender.Context.Connection.IOHandler.WriteLn('Proxy-agent: Indy-Proxy/1.1'); {do not localize}
        ASender.Context.Connection.IOHandler.WriteLn('');
        ASender.Context.Connection.IOHandler.ReadTimeout:=100;
        LClient.IOHandler.ReadTimeout:=100;
        while ASender.Context.Connection.Connected and LClient.Connected do begin
          ASender.Context.Connection.IOHandler.ReadBytes(LBuffer,-1,true);
          LClient.IOHandler.Write(LBuffer);
          SetLength(LBuffer,0);
          LClient.IOHandler.ReadBytes(LBuffer,-1,true);
          ASender.Context.Connection.IOHandler.Write(LBuffer);
          SetLength(LBuffer,0);
        end;
      finally LClient.Disconnect; end;
    finally Sys.FreeAndNil(LClient); end;
  finally Sys.FreeAndNil(LHeaders); end;
end;

procedure TIdHTTPProxyServer.CommandHEAD( ASender: TIdCommand ) ;
begin
end;

procedure TIdHTTPProxyServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_HTTPProxy;
  Greeting.Text.Text := ''; // RS
  ReplyUnknownCommand.Text.Text := ''; // RS
end;

procedure TIdHTTPProxyServer.DoHTTPDocument(const ADocument: string; var VStream: TIdStream2; const AHeaders: TIdHeaderList);
begin
  if Assigned(OnHTTPDocument) then begin
    OnHTTPDocument(Self, ADocument, VStream, AHeaders);
  end;
end;

end.


