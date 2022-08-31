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
  IdCustomTCPServer, //for TIdServerContext
  IdCmdTCPServer,
  IdCommandHandlers,
  IdContext,
  IdYarn;

const
  IdPORT_HTTPProxy = 8080;

type
  TIdHTTPProxyTransferMode = ( tmFullDocument, tmStreaming );
  TIdHTTPProxyTransferSource = ( tsClient, tsServer );

  TIdHTTPProxyServerContext = class(TIdServerContext)
  protected
    FHeaders: TIdHeaderList;
    FCommand: String;
    FDocument: String;
    FOutboundClient: TIdTCPConnection;
    FTarget: String;
    FTransferMode: TIdHTTPProxyTransferMode;
    FTransferSource: TIdHTTPProxyTransferSource;
  public
    constructor Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil); override;
    destructor Destroy; override;
    property Headers: TIdHeaderList read FHeaders;
    property Command: String read FCommand;
    property Document: String read FDocument;
    property OutboundClient: TIdTCPConnection read FOutboundClient;
    property Target: String read FTarget;
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
  IdResourceStrings, IdResourceStringsProtocols, IdReplyRFC, IdIOHandler, IdTCPClient,
  IdURI, IdGlobalProtocols, IdStack, IdStackConsts, IdTCPStream, IdException, SysUtils;

constructor TIdHTTPProxyServerContext.Create(AConnection: TIdTCPConnection;
  AYarn: TIdYarn; AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FHeaders := TIdHeaderList.Create(QuoteHTTP);
end;

destructor TIdHTTPProxyServerContext.Destroy;
begin
  FreeAndNil(FHeaders);
  inherited Destroy;
end;

{ TIdHTTPProxyServer }

procedure TIdHTTPProxyServer.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  inherited;
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'GET';             {do not localize}
  LCommandHandler.OnCommand := CommandPassThrough;
  LCommandHandler.ParseParams := True;
  LCommandHandler.Disconnect := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'POST';            {do not localize}
  LCommandHandler.OnCommand := CommandPassThrough;
  LCommandHandler.ParseParams := True;
  LCommandHandler.Disconnect := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'HEAD';            {do not localize}
  LCommandHandler.OnCommand := CommandPassThrough;
  LCommandHandler.ParseParams := True;
  LCommandHandler.Disconnect := True;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CONNECT';         {do not localize}
  LCommandHandler.OnCommand := CommandCONNECT;
  LCommandHandler.ParseParams := True;
  LCommandHandler.Disconnect := True;

  //HTTP Servers/Proxies do not send a greeting
  Greeting.Clear;
end;

procedure TIdHTTPProxyServer.TransferData(AContext: TIdHTTPProxyServerContext;
  ASrc, ADest: TIdTCPConnection);
var
  LStream: TStream;
  LSize: TIdStreamSize;
  S: String;
begin
  // RLebeau: TODO - support chunked, gzip, and deflate transfers.
  
  // RLebeau: determine how many bytes to read
  S := AContext.Headers.Values['Content-Length']; {Do not Localize}
  if S <> '' then
  begin
    LSize := IndyStrToStreamSize(S, -1) ; {Do not Localize}
    if LSize < 0 then begin
      // Write HTTP error status response
      if AContext.TransferSource = tsClient then begin
        ASrc.IOHandler.WriteLn('HTTP/1.0 400 Bad Request');    {Do not Localize}
      end else begin
        ASrc.IOHandler.WriteLn('HTTP/1.0 502 Bad Gateway');    {Do not Localize}
      end;
      ASrc.IOHandler.WriteLn;
      Exit;
    end;
  end else begin
    LSize := -1;
  end;

  if AContext.TransferSource = tsClient then begin
    ADest.IOHandler.WriteLn(AContext.Command + ' ' + AContext.Document + ' HTTP/1.0'); {Do not Localize}
  end;

  if (AContext.TransferSource = tsServer) or (LSize > 0) then
  begin
    LStream := nil;
    try
      if AContext.TransferMode = tmFullDocument then
      begin
        //TODO: Have an event to let the user perform stream creation
        LStream := TMemoryStream.Create;
        // RLebeau: do not write the source headers until the OnHTTPDocument
        // event has had a chance to update them if it alters the document data...
        ASrc.IOHandler.ReadStream(LStream, LSize, LSize < 0);
        LStream.Position := 0;
        DoHTTPDocument(AContext, LStream);
        ADest.IOHandler.Write(AContext.Headers);
        ADest.IOHandler.WriteLn;
        ADest.IOHandler.Write(LStream);
      end else
      begin
        // RLebeau: direct pass-through, send everything as-is...
        LStream := TIdTCPStream.Create(ADest);
        ADest.IOHandler.Write(AContext.Headers);
        ADest.IOHandler.WriteLn;
        ASrc.IOHandler.ReadStream(LStream, LSize, LSize < 0);
      end;
    finally
      FreeAndNil(LStream);
    end;
  end else
  begin
    // RLebeau: the client sent a document with no data in it, so just pass
    // along the headers by themselves ...
    ADest.IOHandler.Write(AContext.Headers);
    ADest.IOHandler.WriteLn;
  end;
end;

procedure TIdHTTPProxyServer.CommandPassThrough(ASender: TIdCommand);
var
  LURI: TIdURI;
  LContext: TIdHTTPProxyServerContext;
  LConnection: string;

  function IsVersionAtLeast11(const AVersionStr: string): Boolean;
  var
    s: string;
    LMajor, LMinor: Integer;
  begin
    s := AVersionStr;
    Fetch(s, '/');  {Do not localize}
    LMajor := IndyStrToInt(Fetch(s, '.'), -1);  {Do not Localize}
    LMinor := IndyStrToInt(S, -1);
    Result := (LMajor > 1) or ((LMajor = 1) and (LMinor >= 1));
  end;

begin
  ASender.PerformReply := False;

  LContext := TIdHTTPProxyServerContext(ASender.Context);
  LContext.FCommand := ASender.CommandHandler.Command;
  LContext.FTarget := ASender.Params.Strings[0];

  LContext.FOutboundClient := TIdTCPClient.Create(nil);
  try
    LURI := TIdURI.Create(LContext.Target);
    try
      TIdTCPClient(LContext.FOutboundClient).Host := LURI.Host;

      if LURI.Port <> '' then begin
        TIdTCPClient(LContext.FOutboundClient).Port := IndyStrToInt(LURI.Port, 80);
      end
      else if TextIsSame(LURI.Protocol, 'http') then begin     {do not localize}
        TIdTCPClient(LContext.FOutboundClient).Port := IdPORT_HTTP;
      end
      else if TextIsSame(LURI.Protocol, 'https') then begin  {do not localize}
        TIdTCPClient(LContext.FOutboundClient).Port := IdPORT_https;
      end else begin
        raise EIdException.Create(RSHTTPUnknownProtocol); // TODO: create a new Exception class for this
      end;

      //We have to remove the host and port from the request
      LContext.FDocument := LURI.GetPathAndParams;
    finally
      FreeAndNil(LURI);
    end;

    LContext.Headers.Clear;
    LContext.Connection.IOHandler.Capture(LContext.Headers, '', False);
    LContext.FTransferMode := FDefTransferMode;
    LContext.FTransferSource := tsClient;
    DoHTTPBeforeCommand(LContext);

    LConnection := LContext.Headers.Values['Proxy-Connection'];           {do not localize}
    if LConnection <> '' then begin
      ASender.Disconnect := TextIsSame(LConnection, 'close');             {do not localize}
    end else begin
      LConnection := LContext.Headers.Values['Connection'];               {do not localize}
      if IsVersionAtLeast11(ASender.Params.Strings[1]) then begin
        ASender.Disconnect := TextIsSame(LConnection, 'close');           {do not localize}
      end else begin
        ASender.Disconnect := not TextIsSame(LConnection, 'keep-alive');  {do not localize}
      end;
    end;

    // TODO: If the client requests a keep-alive with the target server, don't disconnect the
    // TIdTCPClient below, so it can be reused for subsequent requests.  Disconnect it only
    // when the requesting client disconnects, the keep-alive times out, or a different
    // host/port is requested...

    TIdTCPClient(LContext.FOutboundClient).Connect;
    try
      // TODO: if FDefTransferMode is tmStreaming, send the request and receive the response
      // in parallel, similar to how CommandCONNECT() does.  This would also facilitate the
      // server being able to send back an error reponse while the client is still sending
      // its request...

      LContext.Headers.Values['Connection'] := 'close'; {do not localize}
      TransferData(LContext, LContext.Connection, LContext.FOutboundClient);

      LContext.Headers.Clear;
      LContext.FOutboundClient.IOHandler.Capture(LContext.Headers, '', False);
      LContext.FTransferMode := FDefTransferMode;
      LContext.FTransferSource := tsServer;
      DoHTTPResponse(LContext);

      LContext.Headers.Values['Proxy-Connection'] := iif(ASender.Disconnect, 'close', 'keep-alive'); {do not localize}
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
  LContext: TIdHTTPProxyServerContext;
  LReadList, LDataAvailList: TIdSocketList;
  LClientToServerStream, LServerToClientStream: TStream;
  LConnectionHandle, LOutBoundHandle: TIdStackSocketHandle;
  LConnectionIO, LOutboundIO: TIdIOHandler;

  procedure CheckForData(DoRead: Boolean);
  begin
    if DoRead and LConnectionIO.InputBufferIsEmpty and LOutboundIO.InputBufferIsEmpty then
    begin
      if LReadList.SelectReadList(LDataAvailList, IdTimeoutInfinite) then
      begin
        if LDataAvailList.ContainsSocket(LConnectionHandle) then
        begin
          LConnectionIO.CheckForDataOnSource(0);
        end;
        if LDataAvailList.ContainsSocket(LOutBoundHandle) then
        begin
          LOutboundIO.CheckForDataOnSource(0);
        end;
      end;
    end;
    if not LConnectionIO.InputBufferIsEmpty then
    begin
      LConnectionIO.InputBuffer.ExtractToStream(LClientToServerStream);
    end;
    if not LOutboundIO.InputBufferIsEmpty then
    begin
      LOutboundIO.InputBuffer.ExtractToStream(LServerToClientStream);
    end;
    LConnectionIO.CheckForDisconnect;
    LOutboundIO.CheckForDisconnect;
  end;

begin
  // RLebeau 7/31/09: we can't make any assumptions about the contents of
  // the data being exchanged after the connection has been established.
  // It may not (and likely will not) be HTTP data at all.  We must pass
  // it along as-is in both directions, in as near-realtime as we can...

  ASender.PerformReply := False;

  LContext := TIdHTTPProxyServerContext(ASender.Context);
  LContext.FCommand := ASender.CommandHandler.Command;
  LContext.FTarget := ASender.Params.Strings[0];
 
  LContext.FOutboundClient := TIdTCPClient.Create(nil);
  try
    LClientToServerStream := TIdTCPStream.Create(LContext.FOutboundClient);
    try
      LServerToClientStream := TIdTCPStream.Create(LContext.Connection);
      try
        LRemoteHost := LContext.Target;
        TIdTCPClient(LContext.FOutboundClient).Host := Fetch(LRemoteHost, ':', True);
        TIdTCPClient(LContext.FOutboundClient).Port := IndyStrToInt(LRemoteHost, 443);

        LConnectionIO := LContext.Connection.IOHandler;

        LContext.Headers.Clear;
        LConnectionIO.Capture(LContext.Headers, '', False);
        LContext.FTransferMode := FDefTransferMode; // TODO: should this be forced to tmStreaming instead?
        LContext.FTransferSource := tsClient;
        DoHTTPBeforeCommand(LContext);

        TIdTCPClient(LContext.FOutboundClient).Connect;
        try
          LOutboundIO := LContext.FOutboundClient.IOHandler;

          LConnectionHandle := LContext.Binding.Handle;
          LOutBoundHandle := LContext.FOutboundClient.Socket.Binding.Handle;

          LReadList := TIdSocketList.CreateSocketList;
          try
            LReadList.Add(LConnectionHandle);
            LReadList.Add(LOutBoundHandle);

            LDataAvailList := TIdSocketList.CreateSocketList;
            try
              LConnectionIO.WriteLn('HTTP/1.0 200 Connection established'); {do not localize}
              LConnectionIO.WriteLn('Proxy-agent: Indy-Proxy/1.1'); {do not localize}
              LConnectionIO.WriteLn;

              CheckForData(False);
              while LContext.Connection.Connected and LContext.FOutboundClient.Connected do
              begin
                CheckForData(True);
              end;

              if LContext.FOutboundClient.Connected and (not LConnectionIO.InputBufferIsEmpty) then
              begin
                LConnectionIO.InputBuffer.ExtractToStream(LClientToServerStream);
              end;
              if LContext.Connection.Connected and (not LOutboundIO.InputBufferIsEmpty) then
              begin
                LOutboundIO.InputBuffer.ExtractToStream(LServerToClientStream);
              end;
            finally
              FreeAndNil(LDataAvailList);
            end;
          finally
            FreeAndNil(LReadList);
          end;
        finally
          LContext.FOutboundClient.Disconnect;
          LOutboundIO := nil;
        end;
      finally
        FreeAndNil(LServerToClientStream);
        LConnectionIO := nil;
      end;
    finally
      FreeAndNil(LClientToServerStream);
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


