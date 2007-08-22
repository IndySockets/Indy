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
  Rev 1.24    10/14/2004 1:45:32 PM  BGooijen
  Beauty fixes ;)

  Rev 1.23    10/14/2004 1:05:48 PM  BGooijen
  set PerformReply to false, else "200 OK" was added behind the document body

  Rev 1.22    09.08.2004 09:30:00  OMonien
  changed disconnect handling. Previous implementation failed when exceptions
  ocured in command handler.

  Rev 1.21    08.08.2004 10:35:56  OMonien
  Greeting removed

    Rev 1.20    6/11/2004 9:36:28 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.19    2004.05.20 1:39:24 PM  czhower
  Last of the IdStream updates

  Rev 1.18    2004.05.20 11:37:20 AM  czhower
  IdStreamVCL

  Rev 1.17    4/19/2004 7:07:38 PM  BGooijen
  the remote headers are now passed to the OnHTTPDocument event

  Rev 1.16    4/18/2004 11:31:26 PM  BGooijen
  Fixed POST
  Build CONNECT
  fixed some bugs where chars were replaced when that was not needed ( thus
  causing corrupt data )

  Rev 1.15    2004.04.13 10:24:24 PM  czhower
  Bug fix for when user changes stream.

  Rev 1.14    2004.02.03 5:45:12 PM  czhower
  Name changes

  Rev 1.13    1/21/2004 2:42:52 PM  JPMugaas
  InitComponent

  Rev 1.12    10/25/2003 06:52:12 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.11    2003.10.24 10:43:10 AM  czhower
  TIdSTream to dos

    Rev 1.10    10/17/2003 12:10:08 AM  DSiders
  Added localization comments.

  Rev 1.9    2003.10.12 3:50:44 PM  czhower
  Compile todos

  Rev 1.8    7/13/2003 7:57:38 PM  SPerry
  fixed problem with commandhandlers

  Rev 1.6    5/25/2003 03:54:42 AM  JPMugaas

  Rev 1.5    2/24/2003 08:56:50 PM  JPMugaas

    Rev 1.4    1/20/2003 1:15:44 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes

  Rev 1.3    1-14-2003 19:19:22  BGooijen
  The first line of the header was sent to the server twice, fixed that.

  Rev 1.2    1-1-2003 21:52:06  BGooijen
  Changed for TIdContext

  Rev 1.1    12-29-2002 13:00:02  BGooijen
  - Works on Indy 10 now
  - Cleaned up some code

  Rev 1.0    2002.11.22 8:37:50 PM  czhower

  Rev 1.0    2002.11.22 8:37:16 PM  czhower

 10-May-2002: Created Unit.
}

unit IdHTTPProxyServer;

interface

{$i IdCompilerDefines.inc}

{
 Indy HTTP proxy Server

 Original Programmer: Bas Gooijen (bas_gooijen@yahoo.com)
 Current Maintainer:  Bas Gooijen
   Code is given to the Indy Pit Crew.

 Modifications by Chad Z. Hower (Kudzu)
}

uses
  Classes,
  IdAssignedNumbers,
  IdGlobal,
  IdHeaderList,
  IdTCPConnection,
  IdCmdTCPServer,
  IdCommandHandlers,
  IdContext,
  IdYarn;

const
  IdPORT_HTTPProxy = 8080;

type
  TIdHTTPProxyTransferMode = ( tmFullDocument, tmStreaming );
  TIdHTTPProxyTransferSource = ( tsClient, tsServer );

  TIdHTTPProxyServerContext = class(TIdContext)
  protected
    FHeaders: TIdHeaderList;
    FCommand: String;
    FDocument: String;
    FOutboundClient: TIdTCPConnection;
    FTransferMode: TIdHTTPProxyTransferMode;
    FTransferSource: TIdHTTPProxyTransferSource;
  public
    constructor Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TThreadList = nil); override;
    destructor Destroy; override;
    property Headers: TIdHeaderList read FHeaders;
    property Command: String read FCommand;
    property Document: String read FDocument;
    property OutboundClient: TIdTCPConnection read FOutboundClient;
    property TransferMode: TIdHTTPProxyTransferMode read FTransferMode write FTransferMode;
    property TransferSource: TIdHTTPProxyTransferSource read FTransferSource;
  end;

  TIdHTTPProxyServer = class;

  TOnHTTPContextEvent = procedure(AContext: TIdHTTPProxyServerContext) of object;
  TOnHTTPDocument = procedure(AContext: TIdHTTPProxyServerContext; var VStream: TStream) of object;

  TIdHTTPProxyServer = class(TIdCmdTCPServer)
  protected
    FDefTransferMode: TIdHTTPProxyTransferMode;
    FOnHTTPBeforeCommand: TOnHTTPContextEvent;
    FOnHTTPResponse: TOnHTTPContextEvent;
    FOnHTTPDocument: TOnHTTPDocument;
    // CommandHandlers
    procedure CommandPassThrough(ASender: TIdCommand);
    procedure CommandCONNECT(ASender: TIdCommand); // for ssl
    procedure DoHTTPBeforeCommand(AContext: TIdHTTPProxyServerContext);
    procedure DoHTTPDocument(AContext: TIdHTTPProxyServerContext; var VStream: TStream);
    procedure DoHTTPResponse(AContext: TIdHTTPProxyServerContext);
    procedure InitializeCommandHandlers; override;
    procedure TransferData(AContext: TIdHTTPProxyServerContext; ASrc, ADest: TIdTCPConnection);
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_HTTPProxy;
    property DefaultTransferMode: TIdHTTPProxyTransferMode read FDefTransferMode write FDefTransferMode default tmFullDocument;
    property OnHTTPBeforeCommand: TOnHTTPContextEvent read FOnHTTPBeforeCommand write FOnHTTPBeforeCommand;
    property OnHTTPResponse: TOnHTTPContextEvent read FOnHTTPResponse write FOnHTTPResponse;
    property OnHTTPDocument: TOnHTTPDocument read FOnHTTPDocument write FOnHTTPDocument;
  end;

implementation

uses
  IdResourceStrings, IdReplyRFC, IdTCPClient, IdURI, IdGlobalProtocols, IdTCPStream, SysUtils;

constructor TIdHTTPProxyServerContext.Create(AConnection: TIdTCPConnection;
  AYarn: TIdYarn; AList: TThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FHeaders := TIdHeaderList.Create;
end;

destructor TIdHTTPProxyServerContext.Destroy;
begin
  FreeAndNil(FHeaders);
end;

{ TIdHTTPProxyServer }

procedure TIdHTTPProxyServer.InitializeCommandHandlers;
begin
  inherited;
  with CommandHandlers.Add do begin
    Command := 'GET';             {do not localize}
    OnCommand := CommandPassThrough;
    ParseParams := True;
    Disconnect := True;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'POST';            {do not localize}
    OnCommand := CommandPassThrough;
    ParseParams := True;
    Disconnect := True;
  end;
  with CommandHandlers.Add do
  begin
    Command := 'HEAD';            {do not localize}
    OnCommand := CommandPassThrough;
    ParseParams := True;
    Disconnect := True;
  end;
  with CommandHandlers.Add do 
  begin
    Command := 'CONNECT';         {do not localize}
    OnCommand := CommandCONNECT;
    ParseParams := True;
    Disconnect := True;
  end;
  //HTTP Servers/Proxies do not send a greeting
  Greeting.Clear;
end;

procedure TIdHTTPProxyServer.TransferData(AContext: TIdHTTPProxyServerContext;
  ASrc, ADest: TIdTCPConnection);
var
  LStream: TStream;
  LSize: Integer;
begin
  if AContext.TransferSource = tsClient then begin
    ADest.IOHandler.WriteLn(AContext.Command + ' ' + AContext.Document + ' HTTP/1.0'); {Do not Localize}
  end;
  ADest.IOHandler.Write(AContext.Headers);
  ADest.IOHandler.WriteLn('');

  LSize := IndyStrToInt(AContext.Headers.Values['Content-Length'], -1) ; {Do not Localize}

  if (AContext.TransferSource = tsServer) or (LSize > 0) then
  begin
    if AContext.TransferMode = tmFullDocument then begin
      //TODO: Have an event to let the user perform stream creation
      LStream := TMemoryStream.Create;
    end else begin
      LStream := TIdTCPStream.Create(ADest);
    end;

    try
      ASrc.IOHandler.ReadStream(LStream, LSize, LSize < 0);
      if AContext.TransferMode = tmFullDocument then begin
        LStream.Position := 0;
        DoHTTPDocument(AContext, LStream);
        ADest.IOHandler.Write(LStream);
      end;
    finally
      FreeAndNil(LStream);
    end;
  end;
end;

procedure TIdHTTPProxyServer.CommandPassThrough(ASender: TIdCommand);
var
  LURI: TIdURI;
  LContext: TIdHTTPProxyServerContext;
begin
  ASender.PerformReply := False;

  LContext := TIdHTTPProxyServerContext(ASender.Context);
  LContext.FCommand := ASender.CommandHandler.Command;

  LContext.Headers.Clear;
  LContext.Connection.IOHandler.Capture(LContext.Headers, '');

  LContext.FOutboundClient := TIdTCPClient.Create(nil);
  try
    LURI := TIdURI.Create(ASender.Params.Strings[0]);
    try
      TIdTCPClient(LContext.FOutboundClient).Host := LURI.Host;
      TIdTCPClient(LContext.FOutboundClient).Port := IndyStrToInt(LURI.Port, 80);
      //We have to remove the host and port from the request
      LContext.FDocument := LURI.GetPathAndParams;
    finally
      FreeAndNil(LURI);
    end;

    LContext.FTransferMode := FDefTransferMode;
    LContext.FTransferSource := tsClient;
    DoHTTPBeforeCommand(LContext);

    TIdTCPClient(LContext.FOutboundClient).Connect;
    try
      TransferData(LContext, LContext.Connection, LContext.FOutboundClient);
      
      LContext.Headers.Clear;
      LContext.FOutboundClient.IOHandler.Capture(LContext.Headers, '');

      LContext.FTransferMode := FDefTransferMode;
      LContext.FTransferSource := tsServer;
      DoHTTPResponse(LContext);

      TransferData(LContext, LContext.FOutboundClient, LContext.Connection);
    finally
      LContext.FOutboundClient.Disconnect;
    end;
  finally
    FreeAndNil(LContext.FOutboundClient);
  end;
end;

procedure TIdHTTPProxyServer.CommandCONNECT(ASender: TIdCommand);
var
  LRemoteHost: string;
  LBuffer: TIdBytes;
  LContext: TIdHTTPProxyServerContext;
begin
  ASender.PerformReply := False;

  LContext := TIdHTTPProxyServerContext(ASender.Context);
  LContext.FCommand := 'CONNECT';

  LContext.Headers.Clear;
  LContext.Connection.IOHandler.Capture(LContext.Headers, '');

  LContext.FOutboundClient := TIdTCPClient.Create(nil);
  try
    LRemoteHost := ASender.Params.Strings[0];
    TIdTCPClient(LContext.FOutboundClient).Host := Fetch(LRemoteHost, ':', True);
    TIdTCPClient(LContext.FOutboundClient).Port := IndyStrToInt(LRemoteHost, 443);

    LContext.FTransferMode := FDefTransferMode;
    LContext.FTransferSource := tsClient;
    DoHTTPBeforeCommand(LContext);

    TIdTCPClient(LContext.FOutboundClient).Connect;
    try
      LContext.Connection.IOHandler.WriteLn('HTTP/1.0 200 Connection established'); {do not localize}
      LContext.Connection.IOHandler.WriteLn('Proxy-agent: Indy-Proxy/1.1'); {do not localize}
      LContext.Connection.IOHandler.WriteLn('');

      LContext.Connection.IOHandler.ReadTimeout := 100;
      LContext.FOutboundClient.IOHandler.ReadTimeout := 100;

      while LContext.Connection.Connected and LContext.FOutboundClient.Connected do
      begin
        SetLength(LBuffer, 0);
        LContext.Connection.IOHandler.ReadBytes(LBuffer, -1, True);
        LContext.FOutboundClient.IOHandler.Write(LBuffer);
        SetLength(LBuffer, 0);
        LContext.FOutboundClient.IOHandler.ReadBytes(LBuffer, -1, True);
        LContext.Connection.IOHandler.Write(LBuffer);
      end;
    finally
      LContext.FOutboundClient.Disconnect;
    end;
  finally
    FreeAndNil(LContext.FOutboundClient);
  end;
end;

procedure TIdHTTPProxyServer.InitComponent;
begin
  inherited InitComponent;
  ContextClass := TIdHTTPProxyServerContext;
  DefaultPort := IdPORT_HTTPProxy;
  FDefTransferMode := tmFullDocument;
  Greeting.Text.Text := ''; // RS
  ReplyUnknownCommand.Text.Text := ''; // RS
end;

procedure TIdHTTPProxyServer.DoHTTPBeforeCommand(AContext: TIdHTTPProxyServerContext);
begin
  if Assigned(OnHTTPBeforeCommand) then begin
    OnHTTPBeforeCommand(AContext);
  end;
end;

procedure TIdHTTPProxyServer.DoHTTPDocument(AContext: TIdHTTPProxyServerContext;
  var VStream: TStream);
begin
  if Assigned(OnHTTPDocument) then begin
    OnHTTPDocument(AContext, VStream);
  end;
end;

procedure TIdHTTPProxyServer.DoHTTPResponse(AContext: TIdHTTPProxyServerContext);
begin
  if Assigned(OnHTTPResponse) then begin
    OnHTTPResponse(AContext);
  end;
end;

end.


