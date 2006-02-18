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

// BGO: TODO: convert TIdMappedFtpDataThread to a context.

unit IdMappedFTP;

interface

uses
  IdContext, IdAssignedNumbers, IdMappedPortTCP, IdStack, IdYarn,
  IdTCPConnection,IdTCPServer, IdThread, IdObjs;

type
  TIdMappedFtpDataThread = class;

  TIdMappedFtpContext = class(TIdMappedPortContext)
  protected
    FFtpCommand: string;
    FFtpParams: string;
    FHost, FoutboundHost: string; //local,remote(mapped)
    FPort, FoutboundPort: Integer;
    FDataChannelThread: TIdMappedFtpDataThread;
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
      AList: TIdThreadList = nil
      ); override;
    property FtpCommand: string read FFtpCommand write FFtpCommand;
    property FtpParams: string read FFtpParams write FFtpParams;
    property FtpCmdLine: string read GetFtpCmdLine;

    property Host: string read FHost write FHost;
    property OutboundHost: string read FOutboundHost write FOutboundHost;
    property Port: Integer read FPort write FPort;
    property OutboundPort: Integer read FOutboundPort write FOutboundPort;

    property DataChannelThread: TIdMappedFtpDataThread read FDataChannelThread;
  end; //TIdMappedFtpContext

  TIdMappedFtpDataThread = class(TIdThread)
  protected
    FMappedFtpThread: TIdMappedFtpContext;
    FConnection: TIdTcpConnection;
    FOutboundClient: TIdTCPConnection;
    FReadList: TIdSocketList;
    FNetData: string;
    //
    procedure BeforeRun; override;
    procedure Run; override;
  public
    constructor Create(AMappedFtpThread: TIdMappedFtpContext); reintroduce;
    destructor Destroy; override;

    property MappedFtpThread: TIdMappedFtpContext read FMappedFtpThread;
    property Connection: TIdTcpConnection read FConnection; //local
    property OutboundClient: TIdTCPConnection read FOutboundClient;
      //remote(mapped)
    property NetData: string read FNetData write FNetData;
  end; //TIdMappedFtpDataThread

  TIdMappedFtpOutboundDcMode = (fdcmClient, fdcmPort, fdcmPasv);

  TIdMappedFTP = class(TIdMappedPortTCP)
  protected
    FOutboundDcMode: TIdMappedFtpOutboundDcMode;

    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_FTP;
    property MappedPort default IdPORT_FTP;
    property OutboundDcMode: TIdMappedFtpOutboundDcMode read FOutboundDcMode
      write FOutboundDcMode default fdcmClient;
  end; //TIdMappedFTP

//=============================================================================

implementation

uses
  IdGlobal, IdGlobalProtocols, IdIOHandlerSocket, IdException, IdResourceStringsProtocols,
  IdTcpClient, IdSimpleServer, IdStackConsts, IdSys;

const
  //  iLastGetCmd = 2;
  saDataCommands: array[0..6] of string = (
    {GET}'RETR', 'LIST', 'NLST',    {Do not Localize}
    {PUT}'STOU', 'APPE', 'STOR',    {Do not localize}
    'MLSD');    {Do not Localize}

function IsDataCommand(const upcaseCmd: string): Boolean;
var
  i: Integer;
begin
  for i := Low(saDataCommands) to High(saDataCommands) do
  begin
    if upcaseCmd = saDataCommands[i] then
    begin
      Result := TRUE;
      EXIT;
    end; //if
  end; //for
  Result := FALSE; //not found
end; //

{ TIdMappedFTP }

procedure TIdMappedFTP.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_FTP;
  MappedPort := IdPORT_FTP;
  FContextClass := TIdMappedFtpContext;
  FOutboundDcMode := fdcmClient;
end; //TIdMappedFTP.Create

function TIdMappedFTP.DoExecute(AContext:TIdContext): boolean;
var
  LConnectionHandle: TIdStackSocketHandle;
  LOutBoundHandle: TIdStackSocketHandle;
  LTmp : String;
begin
  Result := TRUE;
  try
    LConnectionHandle := //local client
      (AContext.Connection.IOHandler as TIdIOHandlerSocket).Binding.Handle;
    LOutBoundHandle := //remote (mapped) server
      (TIdMappedFtpContext(AContext).FOutboundClient.IOHandler as
        TIdIOHandlerSocket).Binding.Handle;
    with TIdMappedFtpContext(AContext).FReadList do
    begin
      Clear;
      Add(LConnectionHandle);
      Add(LOutBoundHandle);

      if TIdMappedFtpContext(AContext).FReadList.SelectRead(IdTimeoutInfinite) then
      begin
        if Contains(LOutBoundHandle) then
        begin
          repeat
            TIdMappedFtpContext(AContext).FNetData :=
              TIdMappedFtpContext(AContext).FOutboundClient.IOHandler.ReadLn; //Reply
            if Length(TIdMappedFtpContext(AContext).FNetData) > 0 then
            begin
              DoOutboundClientData(AContext);
              AContext.Connection.IOHandler.WriteLn(TIdMappedFtpContext(AContext).FNetData);
            end; //if
          until TIdMappedFtpContext(AContext).FOutboundClient.IOHandler.InputBufferIsEmpty;
       //   InputBuffer.Size <= 0;
        end; //if >-1  chance for server (passive side)
        //FTP Client:
        if Contains(LConnectionHandle) then
        begin
          repeat
            TIdMappedFtpContext(AContext).FNetData := AContext.Connection.IOHandler.ReadLn;  //USeR REQuest
            if Length(TIdMappedFtpContext(AContext).FNetData) > 0 then
            begin
              TIdMappedFtpContext(AContext).FFtpParams := TIdMappedFtpContext(AContext).FNetData;
              LTmp := TIdMappedFtpContext(AContext).FFtpParams;
              TIdMappedFtpContext(AContext).FFtpCommand := Fetch(LTmp, ' ', TRUE);    {Do not Localize}
              TIdMappedFtpContext(AContext).FFtpParams := LTmp;
              if TIdMappedFtpContext(AContext).ProcessFtpCommand then
              begin
                DoLocalClientData(AContext); //bServer
              end
              else
              begin
                DoLocalClientData(AContext); //bServer
                TIdMappedFtpContext(AContext).FOutboundClient.IOHandler.WriteLn(TIdMappedFtpContext(AContext).FtpCmdLine); //send USRREQ to FtpServer
                TIdMappedFtpContext(AContext).ProcessDataCommand;
              end;
            end;
          until  AContext.Connection.IOHandler.InputBufferIsEmpty;
          //AContext.Connection.IOHandler.InputBuffer.Size <= 0;
        end; //if >-1
      end; //if select
    end; //with
  finally
    if not TIdMappedFtpContext(AContext).FOutboundClient.Connected then
    begin
      DoOutboundDisconnect(AContext);
    end; //if
  end; //tryf
end; //TIdMappedPortTCP.DoExecute

{ TIdMappedFtpContext }

constructor TIdMappedFtpContext.Create(
  AConnection: TIdTCPConnection;
  AYarn: TIdYarn;
  AList: TIdThreadList = nil
  );
begin
  inherited Create(AConnection, AYarn, AList);
  FHost := '';    {Do not Localize}
  FoutboundHost := '';    {Do not Localize}
  FPort := 0; //system choice
  FoutboundPort := 0;
end; //TIdMappedFtpContext.Create

procedure TIdMappedFtpContext.CreateDataChannelThread;
begin
  FDataChannelThread := TIdMappedFtpDataThread.Create(SELF);
  //  FDataChannelThread.OnException := TIdTCPServer(FConnection.Server).OnException;
end; //

procedure TIdMappedFtpContext.ProcessDataCommand;
begin
  if IsDataCommand(FFtpCommand) then
  begin
    FDataChannelThread.Start;
  end;
end; //

function TIdMappedFtpContext.ProcessFtpCommand: Boolean;
  procedure ParsePort;
  var
    LLo, LHi: Integer;
    LParm: string;
  begin
    //1.setup local
    LParm := FtpParams;
    Host := '';    {Do not Localize}
    Host := Host + Fetch(LParm, ',') + '.'; //h1    {Do not Localize}
    Host := Host + Fetch(LParm, ',') + '.'; //h2    {Do not Localize}
    Host := Host + Fetch(LParm, ',') + '.'; //h3    {Do not Localize}
    Host := Host + Fetch(LParm, ','); //h4    {Do not Localize}

    LLo := Sys.StrToInt(Fetch(LParm, ',')); //p1    {Do not Localize}
    LHi := Sys.StrToInt(LParm); //p2
    Port := (LLo * 256) + LHi;

    CreateDataChannelThread;
    DataChannelThread.FConnection := TIdTcpClient.Create(nil);
    with TIdTcpClient(DataChannelThread.FConnection) do
    begin
      Host := Self.Host;
      Port := Self.Port;
    end;

    //2.setup remote (mapped)
    ProcessOutboundDc(FALSE);

    //3. send ack to client
    Connection.IOHandler.WriteLn('200 ' + Sys.Format(RSFTPCmdSuccessful, ['PORT']));    {Do not Localize}
  end; //ParsePort

  procedure ParsePasv;
  var
    LParm: string;
  begin
    //1.setup local
    Host := TIdIOHandlerSocket(Connection.IOHandler).Binding.IP;

    CreateDataChannelThread;
    DataChannelThread.FConnection := TIdSimpleServer.Create(nil);
    with TIdSimpleServer(DataChannelThread.FConnection) do
    begin
      BoundIP := Self.Host;
      BoundPort := Self.Port;
      BeginListen;
      Self.Host := Binding.IP;
      Self.Port := Binding.Port;
      LParm := Sys.StringReplace(Self.Host, '.', ',');    {Do not Localize}
      LParm := LParm + ',' + Sys.IntToStr(Self.Port div 256) + ',' + Sys.IntToStr(Self.Port mod 256);    {Do not Localize}
    end;

    //2.setup remote (mapped)
    ProcessOutboundDc(TRUE);

    //3. send ack to client
    Connection.IOHandler.WriteLn('227 ' + Sys.Format(RSFTPPassiveMode, [LParm]));    {Do not Localize}
  end; //ParsePasv

begin //===ProcessFtpCommand
  Result := FALSE; //comamnd NOT processed
  FFtpCommand := Sys.UpperCase(FFtpCommand);
  if FFtpCommand = 'PORT' then    {Do not Localize}
  begin
    ParsePort;
    Result := TRUE;
  end
  else if FFtpCommand = 'PASV' then    {Do not Localize}
  begin
    ParsePasv;
    Result := TRUE;
  end;
end; //ProcessFtpCommand

procedure TIdMappedFtpContext.ProcessOutboundDc(const APASV: Boolean);
var
  Mode: TIdMappedFtpOutboundDcMode;

  procedure SendPort;
  begin
    OutboundHost := (OutboundClient.IOHandler as TIdIOHandlerSocket).Binding.IP;

    DataChannelThread.FOutboundClient := TIdSimpleServer.Create(nil);
    with TIdSimpleServer(DataChannelThread.FOutboundClient) do
    begin
      BoundIP := Self.OutboundHost;
      BoundPort := Self.OutboundPort;
      BeginListen;
      Self.OutboundHost := Binding.IP;
      Self.OutboundPort := Binding.Port;
    end; //with
    OutboundClient.SendCmd('PORT ' + Sys.StringReplace(OutboundHost, '.', ',')+    {Do not Localize}
      ',' + Sys.IntToStr(OutboundPort div 256) + ',' +    {Do not Localize}
      Sys.IntToStr(OutboundPort mod 256), [200]);
  end; //SendPort

  procedure SendPasv;
  var
    i, bLeft, bRight: integer;
    s: string;
  begin
    OutboundClient.SendCmd('PASV', 227);    {Do not Localize}
    s := Sys.Trim(OutboundClient.LastCmdResult.Text[0]);

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
    FOutboundPort := Sys.StrToInt(Fetch(s, ',')) * 256;    {Do not Localize}
    FOutboundPort := FOutboundPort + Sys.StrToInt(Fetch(s, ','));    {Do not Localize}

    DataChannelThread.FOutboundClient := TIdTcpCLient.Create(nil);
    with TIdTcpCLient(DataChannelThread.FOutboundClient) do
    begin
      Host := Self.FOutboundHost;
      Port := Self.OutboundPort;
    end; //with
  end; //SendPasv

begin //===ProcessOutboundDc
  Mode := TIdMappedFtp(Server).OutboundDcMode;
  if Mode = fdcmClient then
  begin
    if APASV then
      Mode := fdcmPasv
    else
      Mode := fdcmPort;
  end; //if

  if Mode = fdcmPasv then
  begin //PASV (IfFtp.pas)
    SendPasv;
  end
  else
  begin //PORT
    SendPort;
  end;
end; //TIdMappedFtpContext.ProcessOutboundDc

{TODO: procedure TIdMappedFtpContext.FreeDataChannelThread;
Begin
  if Assigned(FDataChannelThread) then begin
    //TODO: здесь надо Disconnect
    FDataChannelThread.Terminate;
    FDataChannelThread:=NIL;
  end;
End;//FreeDataChannelThread}

function TIdMappedFtpContext.GetFtpCmdLine: string;
begin
  if Length(FFtpParams) > 0 then
    Result := FFtpCommand + ' ' + FFtpParams    {Do not Localize}
  else
    Result := FFtpCommand;
end; //TIdMappedFtpContext.GetFtpCmdLine

{ TIdMappedFtpDataThread }

procedure TIdMappedFtpDataThread.BeforeRun;
begin
  inherited BeforeRun;
  //? Is it normal code?
  // TODO: check error. Send reply to client, send abort to server
  //1.Outbound PASV => connect
  try
    if FOutboundClient is TIdTcpClient then
      TIdTcpClient(FOutboundClient).Connect;
  except
    raise;
  end; //trye

  //2.Local PORT => Connect
  try
    if FConnection is TIdTcpClient then
      TIdTcpClient(FConnection).Connect;
  except
    raise;
  end; //trye

  try
    if FConnection is TIdSimpleServer then
      TIdSimpleServer(FConnection).Listen;
  except
    raise;
  end; //trye

  try
    if FOutboundClient is TIdSimpleServer then
      TIdSimpleServer(FOutboundClient).Listen;
  except
    on E: Exception do
    begin

      raise;
    end; //
  end; //trye
end; //TIdMappedFtpDataThread.BeforeRun

constructor TIdMappedFtpDataThread.Create(AMappedFtpThread: TIdMappedFtpContext);
begin
  inherited Create(TRUE);
  FMappedFtpThread := AMappedFtpThread; //owner
  StopMode := smTerminate;
  FreeOnTerminate := TRUE;
  FReadList := TIdSocketList.CreateSocketList;
end; //TIdMappedFtpDataThread.Create

destructor TIdMappedFtpDataThread.Destroy;
begin
  Sys.FreeAndNIL(FOutboundClient);
  Sys.FreeAndNIL(FConnection);
  Sys.FreeAndNIL(FReadList);
  inherited Destroy;
end; //TIdMappedFtpDataThread.Destroy

procedure TIdMappedFtpDataThread.Run;
var
  LConnectionHandle: TIdStackSocketHandle;
  LOutBoundHandle: TIdStackSocketHandle;
begin
  try
    try
      LConnectionHandle :=
        (Connection.IOHandler as TIdIOHandlerSocket).Binding.Handle;
      LOutBoundHandle :=
        (FOutboundClient.IOHandler as TIdIOHandlerSocket).Binding.Handle;
      with FReadList do
      begin
        Clear;
        Add(LConnectionHandle);
        Add(LOutBoundHandle);

        if FReadList.SelectRead(IdTimeoutInfinite) then
        begin
          if Contains(LConnectionHandle) then
          begin
            Connection.IOHandler.CheckForDataOnSource;
            FNetData := Connection.IOHandler.InputBufferAsString;
            //CurrentReadBuffer;
            if Length(FNetData) > 0 then
            begin
              // TODO: DoLocalClientData(TIdMappedPortThread(AThread));//bServer
              FOutboundClient.IOHandler.Write(FNetData);
            end; //if
          end;
          if Contains(LOutBoundHandle) then
          begin
            Connection.IOHandler.CheckForDataOnSource;
            FNetData := FOutboundClient.IOHandler.InputBufferAsString;
            //CurrentReadBuffer;
            if Length(FNetData) > 0 then
            begin
              // TODO: DoOutboundClientData(TIdMappedPortThread(AThread));
              FConnection.IOHandler.Write(FNetData);
            end; //if
          end;
        end; //if select
      end; //with
    finally
      if not FOutboundClient.Connected then
      begin
        // TODO: DoOutboundDisconnect(TIdMappedPortThread(AThread));
        FConnection.Disconnect; //disconnect local
        Stop;
      end; //if

      if not FConnection.Connected then
      begin
        // TODO: ^^^
        FOutboundClient.Disconnect;
        Stop;
      end; //if
    end; //tryf
  except
    FConnection.Disconnect;
    FOutboundClient.Disconnect;
    Stop;
  end; //trye
end; //TIdMappedFtpDataThread.Run

end.

