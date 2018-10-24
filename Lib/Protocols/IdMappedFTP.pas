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
  Rev 1.13    2004.02.03 5:43:58 PM  czhower
  Name changes

  Rev 1.12    2/2/2004 4:56:26 PM  JPMugaas
  DotNET with fries and a Coke :-)

  Rev 1.11    1/21/2004 3:11:28 PM  JPMugaas
  InitComponent

  Rev 1.10    2003.11.29 10:18:56 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.9    2003.10.21 9:13:10 PM  czhower
  Now compiles.

  Rev 1.8    9/19/2003 03:30:02 PM  JPMugaas
  Now should compile again.

  Rev 1.7    3/6/2003 5:08:50 PM  SGrobety
  Updated the read buffer methodes to fit the new core (InputBuffer ->
  InputBufferAsString + call to CheckForDataOnSource)

    Rev 1.6    4/3/2003 7:56:56 PM  BGooijen
  Added TODO item.

  Rev 1.5    2/24/2003 09:14:32 PM  JPMugaas

  Rev 1.4    1/17/2003 06:52:42 PM  JPMugaas
  Now compiles with new framework.

  Rev 1.3    1-8-2003 22:20:38  BGooijen
  these compile (TIdContext)

  Rev 1.2    12/16/2002 06:59:08 PM  JPMugaas
  MLSD added as a command requiring a data command.

  Rev 1.1    12/7/2002 06:43:06 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 07:56:34 AM  JPMugaas

  2001.12.14 - beta preview (but FTPVC work fine ;-)
}
{
 Author:    Andrew P.Rybin [magicode@mail.ru]

 Th (rfc959):

  1) EOL = #13#10  [#10 last char]
  2) reply = IntCode (three digit number) ' ' text
  3) PORT h1,h2,h3,h4,p1,p2 -> Client Listen >>'200 Port command successful.'    
  4) PASV -> Server Listen >>'227 Entering Passive Mode (%d,%d,%d,%d,%d,%d).'

 Err:
   426 RSFTPDataConnClosedAbnormally
}

//BGO: TODO: convert TIdMappedFtpDataThread to a context.

unit IdMappedFTP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdContext, IdAssignedNumbers, IdMappedPortTCP, IdStack, IdYarn,
  IdTCPConnection,IdTCPServer, IdThread, IdGlobal;

type
  TIdMappedFtpDataThread = class;

  TIdMappedFtpContext = class(TIdMappedPortContext)
  protected
    FFtpCommand: string;
    FFtpParams: string;
    FHost, FoutboundHost: string; //local,remote(mapped)
    FPort, FoutboundPort: TIdPort;
    FDataChannelThread: TIdMappedFtpDataThread;
    //
    procedure HandleLocalClientData; override;
    //
    function GetFtpCmdLine: string; //Cmd+' '+Params    {Do not Localize}
    procedure CreateDataChannelThread;
    //procedure FreeDataChannelThread;
    function ProcessFtpCommand: Boolean; virtual;
    procedure ProcessOutboundDc(const APASV: Boolean); virtual;
    procedure ProcessDataCommand; virtual;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdContextThreadList = nil
      ); override;
    property FtpCommand: string read FFtpCommand write FFtpCommand;
    property FtpParams: string read FFtpParams write FFtpParams;
    property FtpCmdLine: string read GetFtpCmdLine;

    property Host: string read FHost write FHost;
    property OutboundHost: string read FOutboundHost write FOutboundHost;
    property Port: TIdPort read FPort write FPort;
    property OutboundPort: TIdPort read FOutboundPort write FOutboundPort;

    property DataChannelThread: TIdMappedFtpDataThread read FDataChannelThread;
  end;

  TIdMappedFtpDataThread = class(TIdThread)
  protected
    FMappedFtpThread: TIdMappedFtpContext;
    FConnection: TIdTcpConnection;
    FOutboundClient: TIdTCPConnection;
    FReadList: TIdSocketList;
    FNetData: TIdBytes;
    //
    procedure BeforeRun; override;
    procedure Run; override;
  public
    constructor Create(AMappedFtpThread: TIdMappedFtpContext); reintroduce;
    destructor Destroy; override;

    property MappedFtpThread: TIdMappedFtpContext read FMappedFtpThread;
    property Connection: TIdTcpConnection read FConnection; //local
    property OutboundClient: TIdTCPConnection read FOutboundClient; //remote(mapped)
    property NetData: TIdBytes read FNetData write FNetData;
  end;

  TIdMappedFtpOutboundDcMode = (fdcmClient, fdcmPort, fdcmPasv);

  TIdMappedFTP = class(TIdMappedPortTCP)
  protected
    FOutboundDcMode: TIdMappedFtpOutboundDcMode;

    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_FTP;
    property MappedPort default IdPORT_FTP;
    property OutboundDcMode: TIdMappedFtpOutboundDcMode read FOutboundDcMode
      write FOutboundDcMode default fdcmClient;
  end;

//=============================================================================

implementation

uses
  IdGlobalProtocols, IdIOHandlerSocket, IdException,
  IdResourceStringsProtocols, IdTcpClient, IdSimpleServer, IdStackConsts,
  SysUtils;

const
  //  iLastGetCmd = 2;
  saDataCommands: array[0..6] of string = (
    {GET}'RETR', 'LIST', 'NLST',    {Do not Localize}
    {PUT}'STOU', 'APPE', 'STOR',    {Do not localize}
    'MLSD');    {Do not Localize}

{ TIdMappedFTP }

procedure TIdMappedFTP.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_FTP;
  MappedPort := IdPORT_FTP;
  FContextClass := TIdMappedFtpContext;
  FOutboundDcMode := fdcmClient;
end;

{ TIdMappedFtpContext }

constructor TIdMappedFtpContext.Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FHost := '';    {Do not Localize}
  FoutboundHost := '';    {Do not Localize}
  FPort := 0; //system choice
  FoutboundPort := 0;
end;

procedure TIdMappedFtpContext.HandleLocalClientData;
var
  s: String;
begin
  repeat
    s := Connection.IOHandler.ReadLn;  //USeR REQuest
    if Length(s) > 0 then
    begin
      FFtpParams := s;
      FFtpCommand := UpperCase(Fetch(FFtpParams, ' ', True));    {Do not Localize}

      FNetData := ToBytes(FtpCmdLine, Connection.IOHandler.DefStringEncoding);
      TIdMappedFTP(Server).DoLocalClientData(Self); //bServer

      if not ProcessFtpCommand then
      begin
        FOutboundClient.IOHandler.WriteLn(FtpCmdLine); //send USRREQ to FtpServer
        ProcessDataCommand;
      end;
    end;
  until Connection.IOHandler.InputBufferIsEmpty;
end;

procedure TIdMappedFtpContext.CreateDataChannelThread;
begin
  FDataChannelThread := TIdMappedFtpDataThread.Create(Self);
  //FDataChannelThread.OnException := TIdTCPServer(FConnection.Server).OnException;
end;

procedure TIdMappedFtpContext.ProcessDataCommand;
begin
  if PosInStrArray(FFtpCommand, saDataCommands) > -1 then begin
    FDataChannelThread.Start;
  end;
end;

function TIdMappedFtpContext.ProcessFtpCommand: Boolean;

  procedure ParsePort;
  var
    LLo, LHi: Integer;
    LParm: string;
    LDataChannel: TIdTCPClient;
  begin
    //1.setup local
    LParm := FtpParams;
    Host := Fetch(LParm, ',') + '.' + //h1    {Do not Localize}
            Fetch(LParm, ',') + '.' + //h2    {Do not Localize}
            Fetch(LParm, ',') + '.' + //h3    {Do not Localize}
            Fetch(LParm, ',');        //h4    {Do not Localize}

    LLo := IndyStrToInt(Fetch(LParm, ',')); //p1    {Do not Localize}
    LHi := IndyStrToInt(LParm); //p2
    Port := (LLo * 256) + LHi;

    CreateDataChannelThread;
    DataChannelThread.FConnection := TIdTCPClient.Create(nil);

    LDataChannel := TIdTCPClient(DataChannelThread.FConnection);
    LDataChannel.Host := Host;
    LDataChannel.Port := Port;

    //2.setup remote (mapped)
    ProcessOutboundDc(False);

    //3. send ack to client
    Connection.IOHandler.WriteLn('200 ' + IndyFormat(RSFTPCmdSuccessful, ['PORT']));    {Do not Localize}
  end;

  procedure ParsePasv;
  var
    LParm: string;
    LDataChannel: TIdSimpleServer;
  begin
    //1.setup local
    Host := Connection.Socket.Binding.IP;

    CreateDataChannelThread;
    DataChannelThread.FConnection := TIdSimpleServer.Create(nil);

    LDataChannel := TIdSimpleServer(DataChannelThread.FConnection);
    LDataChannel.BoundIP := Self.Host;
    LDataChannel.BoundPort := Self.Port;
    LDataChannel.BeginListen;
    Host := LDataChannel.Binding.IP;
    Port := LDataChannel.Binding.Port;

    LParm := ReplaceAll(Host, '.', ',');    {Do not Localize}
    LParm := LParm + ',' + IntToStr(Port div 256) + ',' + IntToStr(Port mod 256);    {Do not Localize}

    //2.setup remote (mapped)
    ProcessOutboundDc(True);

    //3. send ack to client
    Connection.IOHandler.WriteLn('227 ' + IndyFormat(RSFTPPassiveMode, [LParm]));    {Do not Localize}
  end;

begin
  if FFtpCommand = 'PORT' then    {Do not Localize}
  begin
    ParsePort;
    Result := True;
  end
  else if FFtpCommand = 'PASV' then    {Do not Localize}
  begin
    ParsePasv;
    Result := True;
  end else begin
    Result := False; //command NOT processed
  end;
end;

procedure TIdMappedFtpContext.ProcessOutboundDc(const APASV: Boolean);
var
  Mode: TIdMappedFtpOutboundDcMode;

  procedure SendPort;
  var
    LDataChannel: TIdSimpleServer;
  begin
    OutboundHost := OutboundClient.Socket.Binding.IP;

    DataChannelThread.FOutboundClient := TIdSimpleServer.Create(nil);

    LDataChannel := TIdSimpleServer(DataChannelThread.FOutboundClient);
    LDataChannel.BoundIP := Self.OutboundHost;
    LDataChannel.BoundPort := Self.OutboundPort;
    LDataChannel.BeginListen;
    OutboundHost := LDataChannel.Binding.IP;
    OutboundPort := LDataChannel.Binding.Port;

    OutboundClient.SendCmd('PORT ' + ReplaceAll(OutboundHost, '.', ',')+    {Do not Localize}
      ',' + IntToStr(OutboundPort div 256) + ',' +    {Do not Localize}
      IntToStr(OutboundPort mod 256), [200]);
  end;

  procedure SendPasv;
  var
    i, bLeft, bRight: integer;
    s: string;
    LDataChannel: TIdTCPClient;
  begin
    OutboundClient.SendCmd('PASV', 227);    {Do not Localize}
    s := Trim(OutboundClient.LastCmdResult.Text[0]);

    // Case 1 (Normal)
    // 227 Entering passive mode(100,1,1,1,23,45)
    bLeft := IndyPos('(', s);    {Do not Localize}
    bRight := IndyPos(')', s);    {Do not Localize}
    if (bLeft = 0) or (bRight = 0) then
    begin
      // Case 2
      // 227 Entering passive mode on 100,1,1,1,23,45
      bLeft := RPos(#32, s);
      s := Copy(s, bLeft + 1, Length(s) - bLeft);
    end
    else
    begin
      s := Copy(s, bLeft + 1, bRight - bLeft - 1);
    end;
    FOutboundHost := '';    {Do not Localize}
    for i := 1 to 4 do
    begin
      FOutboundHost := FOutboundHost + '.' + Fetch(s, ',');    {Do not Localize}
    end;
    IdDelete(FOutboundHost, 1, 1);
    // Determine port
    FOutboundPort := IndyStrToInt(Fetch(s, ',')) * 256;    {Do not Localize}
    FOutboundPort := FOutboundPort + IndyStrToInt(Fetch(s, ','));    {Do not Localize}

    DataChannelThread.FOutboundClient := TIdTCPClient.Create(nil);

    LDataChannel := TIdTCPClient(DataChannelThread.FOutboundClient);
    LDataChannel.Host := OutboundHost;
    LDataChannel.Port := OutboundPort;
  end;

begin
  Mode := TIdMappedFtp(Server).OutboundDcMode;
  if Mode = fdcmClient then
  begin
    if APASV then begin
      Mode := fdcmPasv;
    end else begin
      Mode := fdcmPort;
    end;
  end;

  if Mode = fdcmPasv then begin
    //PASV (IfFtp.pas)
    SendPasv;
  end else begin
    //PORT
    SendPort;
  end;
end;

{TODO: procedure TIdMappedFtpContext.FreeDataChannelThread;
Begin
  if Assigned(FDataChannelThread) then begin
    //TODO: здесь надо Disconnect
    FDataChannelThread.Terminate;
    FDataChannelThread:=NIL;
  end;
End;}

function TIdMappedFtpContext.GetFtpCmdLine: string;
begin
  if Length(FFtpParams) > 0 then begin
    Result := FFtpCommand + ' ' + FFtpParams;    {Do not Localize}
  end else begin
    Result := FFtpCommand;
  end;
end;

{ TIdMappedFtpDataThread }

procedure TIdMappedFtpDataThread.BeforeRun;
begin
  inherited BeforeRun;

  //? Is it normal code?
  // TODO: check error. Send reply to client, send abort to server

  //1.Outbound PASV => connect
  if FOutboundClient is TIdTCPClient then
  begin
    TIdTCPClient(FOutboundClient).Connect;
    TIdSimpleServer(FConnection).Listen;
  end

  //2.Local PORT => Connect
  else if FOutboundClient is TIdSimpleServer then
  begin
    TIdTCPClient(FConnection).Connect;
    TIdSimpleServer(FOutboundClient).Listen;
  end;

end;

constructor TIdMappedFtpDataThread.Create(AMappedFtpThread: TIdMappedFtpContext);
begin
  inherited Create(True);
  FMappedFtpThread := AMappedFtpThread; //owner
  StopMode := smTerminate;
  FreeOnTerminate := True;
  FReadList := TIdSocketList.CreateSocketList;
end;

destructor TIdMappedFtpDataThread.Destroy;
begin
  FreeAndNil(FOutboundClient);
  FreeAndNil(FConnection);
  FreeAndNil(FReadList);
  inherited Destroy;
end;

procedure TIdMappedFtpDataThread.Run;
var
  LConnectionHandle, LOutBoundHandle: TIdStackSocketHandle;
  LReadList: TIdSocketList;
begin
  try
    try
      LConnectionHandle := (Connection.IOHandler as TIdIOHandlerSocket).Binding.Handle;
      LOutBoundHandle := (FOutboundClient.IOHandler as TIdIOHandlerSocket).Binding.Handle;

      FReadList.Clear;
      FReadList.Add(LConnectionHandle);
      FReadList.Add(LOutBoundHandle);

      LReadList := nil;
      if FReadList.SelectReadList(LReadList, IdTimeoutInfinite) then
      begin
        try
          if LReadList.ContainsSocket(LConnectionHandle) then
          begin
            Connection.IOHandler.CheckForDataOnSource(0);
            SetLength(FNetData, 0);
            Connection.IOHandler.InputBuffer.ExtractToBytes(FNetData);
            if Length(FNetData) > 0 then
            begin
              // TODO: DoLocalClientData(TIdMappedPortThread(AThread));//bServer
              FOutboundClient.IOHandler.Write(FNetData);
            end;
          end;
          if LReadList.ContainsSocket(LOutBoundHandle) then
          begin
            Connection.IOHandler.CheckForDataOnSource(0);
            SetLength(FNetData, 0);
            FOutboundClient.IOHandler.InputBuffer.ExtractToBytes(FNetData);
            if Length(FNetData) > 0 then
            begin
              // TODO: DoOutboundClientData(TIdMappedPortThread(AThread));
              FConnection.IOHandler.Write(FNetData);
            end;
          end;
        finally
          LReadList.Free;
        end;
      end;
    finally
      if not FOutboundClient.Connected then
      begin
        // TODO: DoOutboundDisconnect(TIdMappedPortThread(AThread));
        FConnection.Disconnect; //disconnect local
        Stop;
      end;
      if not FConnection.Connected then
      begin
        // TODO: ^^^
        FOutboundClient.Disconnect;
        Stop;
      end;
    end;
  except
    FConnection.Disconnect;
    FOutboundClient.Disconnect;
    Stop;
  end;
end;

end.

