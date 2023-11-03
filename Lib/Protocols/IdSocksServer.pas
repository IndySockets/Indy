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
  Rev 1.15    12/2/2004 4:23:58 PM  JPMugaas
  Adjusted for changes in Core.

    Rev 1.14    5/30/2004 7:50:44 PM  DSiders
  Corrected case in ancestor for TIdCustomSocksServer.

  Rev 1.13    2004.03.03 10:28:48 AM  czhower
  Removed warnings.

  Rev 1.12    2004.02.03 5:44:24 PM  czhower
  Name changes

  Rev 1.11    1/21/2004 4:03:44 PM  JPMugaas
  InitComponent

  Rev 1.10    2003.10.21 9:13:14 PM  czhower
  Now compiles.

  Rev 1.9    2003.10.12 7:23:52 PM  czhower
  Compile todos

  Rev 1.8    9/19/2003 04:27:04 PM  JPMugaas
  Removed IdFTPServer so Indy can compile with Kudzu's new changes.

  Rev 1.7    9/16/2003 11:59:16 PM  JPMugaas
  Should compile.

    Rev 1.6    1/20/2003 1:15:38 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes

  Rev 1.5    1/17/2003 07:10:54 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.4    1/9/2003 06:09:36 AM  JPMugaas
  Updated for IdContext API change.

  Rev 1.3    1/8/2003 05:53:50 PM  JPMugaas
  Switched stuff to IdContext.

  Rev 1.2    12-8-2002 18:08:56  BGooijen
  Changed to use TIdIOHandlerStack for the .IPVersion

  Rev 1.1    12/7/2002 06:43:26 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 08:01:18 AM  JPMugaas
}

{*****************************************************************************}
{*                              IdSocksServer.pas                            *}
{*****************************************************************************}

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen (bas_gooijen@yahoo.com)                          *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*  Indy SOCKS 4/5 Server                                                    *}
{*                                                                           *}
{* QUICK NOTES:                                                              *}
{*   Socks5 GSSAPI-authentication is NOT supported.                          *}
{*   UDP ASSOCIATE is NOT supported                                          *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 19/05/2002    1.0   Bas Gooijen  Initial start                            *}
{* 24/05/2002    1.0   Bas Gooijen  Added socks 5 authentication             *}
{* 08/06/2002    1.0   Bas Gooijen  Revised code                             *}
{* 08/09/2002    1.0   Bas Gooijen  Added Socks 5 IPv6 Support               *}
{*****************************************************************************}

unit IdSocksServer;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer,
  IdException,
  IdGlobal,
  IdTCPConnection,
  IdYarn,
  SysUtils;

const
  IdSocksAuthNoAuthenticationRequired = 0;
  IdSocksAuthGSSApi = 1;
  IdSocksAuthUsernamePassword = 2;
  IdSocksAuthNoAcceptableMethods = $FF;

  IdSocks5ReplySuccess = 0;
  IdSocks5ReplyGeneralFailure = 1;
  IdSocks5ReplyConnNotAllowed = 2;
  IdSocks5ReplyNetworkUnreachable = 3;
  IdSocks5ReplyHostUnreachable = 4;
  IdSocks5ReplyConnRefused = 5;
  IdSocks5ReplyTTLExpired = 6;
  IdSocks5ReplyCmdNotSupported = 7;
  IdSocks5ReplyAddrNotSupported = 8;

type
  EIdSocksSvrException = class(EIdException);
  EIdSocksSvrNotSupported = class(EIdSocksSvrException);
  EIdSocksSvrInvalidLogin = class(EIdSocksSvrException);
  EIdSocksSvrSocks5WrongATYP = class(EIdSocksSvrException);
  EIdSocksSvrWrongSocksVer = class(EIdSocksSvrException);
  EIdSocksSvrWrongSocksCmd = class(EIdSocksSvrException);
  EIdSocksSvrAccessDenied = class(EIdSocksSvrException);
  EIdSocksSvrUnexpectedClose = class(EIdSocksSvrException);
  EIdSocksSvrPeerMismatch = class(EIdSocksSvrException);

  TIdSocksServerContext = class(TIdServerContext)
  protected
    FIPVersion: TIdIPVersion;
    FUsername: string;
    FPassword: string;
    FSocksVersion: Byte; // either 4 or 5, or 0 when version not known yet
  public
    constructor Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil); override;
    property IPVersion: TIdIPVersion read FIPVersion;
    property Username: string read FUsername;
    property Password: string read FPassword;
    property SocksVersion: Byte read FSocksVersion;
  end;

  TIdOnAuthenticate = procedure(AContext: TIdSocksServerContext; var AAuthenticated: Boolean) of object;
  TIdOnBeforeEvent = procedure(AContext: TIdSocksServerContext; var VHost: string; var VPort: TIdPort; var VAllowed: Boolean) of object;
  TIdOnVerifyEvent = procedure(AContext: TIdSocksServerContext; const AHost, APeer: string; var VAllowed: Boolean) of object;

  TIdCustomSocksServer = class(TIdCustomTCPServer)
  protected
    FNeedsAuthentication: Boolean;
    FAllowSocks4: Boolean;
    FAllowSocks5: Boolean;
    FOnAuthenticate: TIdOnAuthenticate;
    FOnBeforeSocksConnect: TIdOnBeforeEvent;
    FOnBeforeSocksBind: TIdOnBeforeEvent;
    FOnVerifyBoundPeer: TIdOnVerifyEvent;

    function DoExecute(AContext: TIdContext) : Boolean; override;

    procedure CommandConnect(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort); virtual; abstract;
    procedure CommandBind(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort); virtual; abstract;

    function DoAuthenticate(AContext: TIdSocksServerContext): Boolean; virtual;
    function DoBeforeSocksConnect(AContext: TIdSocksServerContext; var VHost: string; var VPort: TIdPort): Boolean; virtual;
    function DoBeforeSocksBind(AContext: TIdSocksServerContext; var VHost: string; var VPort: TIdPort): Boolean; virtual;
    function DoVerifyBoundPeer(AContext: TIdSocksServerContext; const AExpected, AActual: string): Boolean; virtual;
    procedure HandleConnectV4(AContext: TIdSocksServerContext; var VCommand: Byte; var VHost: string; var VPort: TIdPort); virtual;
    procedure HandleConnectV5(AContext: TIdSocksServerContext; var VCommand: Byte; var VHost: string; var VPort: TIdPort); virtual;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_SOCKS;
    property AllowSocks4: Boolean read FAllowSocks4 write FAllowSocks4;
    property AllowSocks5: Boolean read FAllowSocks5 write FAllowSocks5;
    property NeedsAuthentication: Boolean read FNeedsAuthentication write FNeedsAuthentication;

    property OnAuthenticate: TIdOnAuthenticate read FOnAuthenticate write FOnAuthenticate;
    property OnBeforeSocksConnect: TIdOnBeforeEvent read FOnBeforeSocksConnect write FOnBeforeSocksConnect;
    property OnBeforeSocksBind: TIdOnBeforeEvent read FOnBeforeSocksBind write FOnBeforeSocksBind;
    property OnVerifyBoundPeer: TIdOnVerifyEvent read FOnVerifyBoundPeer write FOnVerifyBoundPeer;
  end;

  TIdSocksServer = class(TIdCustomSocksServer)
  protected
    procedure CommandConnect(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort); override;
    procedure CommandBind(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort); override;
  end;

  TIdOnCommandEvent = procedure(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort) of object;

  TIdEventSocksServer = class(TIdCustomSocksServer)
  protected
    FOnCommandConnect: TIdOnCommandEvent;
    FOnCommandBind: TIdOnCommandEvent;
    procedure CommandConnect(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort) ; override;
    procedure CommandBind(AContext: TIdSocksServerContext; const AHost: string; const APort: TIdPort); override;
  published
    property OnCommandConnect: TIdOnCommandEvent read FOnCommandConnect write FOnCommandConnect;
    property OnCommandBind: TIdOnCommandEvent read FOnCommandBind write FOnCommandBind;
  end;

implementation

uses
  IdGlobalProtocols,
  IdIOHandlerStack,
  IdIPAddress,
  IdResourceStringsProtocols,
  IdTcpClient,
  IdSimpleServer,
  IdSocketHandle,
  IdStack;

function IPToBytes(AIP: string; const AIPVersion: TIdIPVersion): TIdBytes;
var
  LIP: TIdIPAddress;
begin
  if AIPVersion = Id_IPv4 then begin
    SetLength(Result, 4);
  end else begin
    SetLength(Result, 16);
  end;
  LIP := TIdIPAddress.MakeAddressObject(AIP, AIPVersion);
  try
    if Assigned(LIP) then begin
      CopyTIdBytes(LIP.HToNBytes, 0, Result, 0, Length(Result));
    end else begin
      FillBytes(Result, Length(Result), 0);
    end;
  finally
    FreeAndNil(LIP);
  end;
end;

procedure TransferData(const FromConn, ToConn: TIdTCPConnection);
const
  cMaxBufSize: Integer = 4096;
var
  LBuffer: TMemoryStream;
  LAmount: Integer;

  function ReadFrom(AFrom: TIdTCPConnection): Integer;
  begin
    AFrom.IOHandler.CheckForDataOnSource(25);
    Result := IndyMin(AFrom.IOHandler.InputBuffer.Size, cMaxBufSize);
    if Result > 0 then begin
      LBuffer.Position := 0;
      AFrom.IOHandler.InputBuffer.ExtractToStream(LBuffer, Result);
    end;
  end;

begin
  LBuffer := TMemoryStream.Create;
  try
    LBuffer.Size := cMaxBufSize;
    while FromConn.Connected and ToConn.Connected do
    begin
      // TODO: use TIdSocketList here
      LAmount := ReadFrom(FromConn);
      if LAmount > 0 then begin
        LBuffer.Position := 0;
        ToConn.IOHandler.Write(LBuffer, LAmount);
      end;
      LAmount := ReadFrom(ToConn);
      if LAmount > 0 then begin
        LBuffer.Position := 0;
        FromConn.IOHandler.Write(LBuffer, LAmount);
      end;
    end;
  finally
    FreeAndNil(LBuffer);
  end;
end;

function TIdCustomSocksServer.DoAuthenticate(AContext: TIdSocksServerContext): Boolean;
begin
  Result := Assigned(OnAuthenticate);
  if Result then begin
    OnAuthenticate(AContext, Result);
  end;
end;

function TIdCustomSocksServer.DoBeforeSocksConnect(AContext: TIdSocksServerContext;
  var VHost: string; var VPort: TIdPort): Boolean;
begin
  Result := True;
  if Assigned(OnBeforeSocksConnect) then begin
    OnBeforeSocksConnect(AContext, VHost, VPort, Result);
  end;
end;

function TIdCustomSocksServer.DoBeforeSocksBind(AContext: TIdSocksServerContext;
  var VHost: string; var VPort: TIdPort): Boolean;
begin
  Result := True;
  if Assigned(OnBeforeSocksBind) then begin
    OnBeforeSocksBind(AContext, VHost, VPort, Result);
  end;
end;

function TIdCustomSocksServer.DoVerifyBoundPeer(AContext: TIdSocksServerContext;
  const AExpected, AActual: string): Boolean;
begin
  Result := True;
  if Assigned(OnVerifyBoundPeer) then begin
    OnVerifyBoundPeer(AContext, AExpected, AActual, Result);
  end;
end;


procedure SendV4Response(AContext: TIdSocksServerContext; const AStatus: Byte;
  const AIP: String = ''; const APort: TIdPort = 0);
var
  LResponse: TIdBytes;
begin
  SetLength(LResponse, 8);
  LResponse[0] := 0; // SOCKS version, null in SOCKS 4/4A
  LResponse[1] := AStatus;
  CopyTIdUInt16(GStack.HostToNetwork(APort), LResponse, 2);
  CopyTIdBytes(IPToBytes(AIP, Id_IPv4), 0, LResponse, 4, 4);
  AContext.Connection.IOHandler.Write(LResponse);
end;

procedure SendV5MethodResponse(AContext: TIdSocksServerContext; const AMethod: Byte);
var
  LResponse: TIdBytes;
begin
  SetLength(LResponse, 2);
  LResponse[0] := 5; // SOCKS version
  LResponse[1] := AMethod;
  AContext.Connection.IOHandler.Write(LResponse);
end;

procedure SendV5AuthResponse(AContext: TIdSocksServerContext; const AStatus: Byte);
var
  LResponse: TIdBytes;
begin
  SetLength(LResponse, 2);
  LResponse[0] := 1; // AUTH version
  LResponse[1] := AStatus;
  AContext.Connection.IOHandler.Write(LResponse);
end;

procedure SendV5Response(AContext: TIdSocksServerContext; const AStatus: Byte;
  const AIP: String = ''; const APort: TIdPort = 0);
const
  LTypes: array[TIdIPVersion] of Byte = ($1, $4);
var
  LResponse, LIP: TIdBytes;
begin
  LIP := IPToBytes(AIP, AContext.IPVersion);
  SetLength(LResponse, 4 + Length(LIP) + 2);

  LResponse[0] := 5; // SOCKS version
  LResponse[1] := AStatus;
  LResponse[2] := 0;
  LResponse[3] := LTypes[AContext.IPVersion];
  CopyTIdBytes(LIP, 0, LResponse, 4, Length(LIP));
  CopyTIdUInt16(GStack.HostToNetwork(APort), LResponse, 4+Length(LIP));

  AContext.Connection.IOHandler.Write(LResponse);
end;

procedure TIdCustomSocksServer.HandleConnectV4(AContext: TIdSocksServerContext;
  var VCommand: Byte; var VHost: string; var VPort: TIdPort);
var
  LData: TIdBytes;
  LBinding: TIdSocketHandle;
  LUserId: string;
begin
  AContext.Connection.IOHandler.ReadBytes(LData, 7);
  VCommand := LData[0];
  VPort := GStack.NetworkToHost(BytesToUInt16(LData, 1));
  VHost := BytesToIPv4Str(LData, 3);
  LUserId := AContext.Connection.IOHandler.ReadLn(#0);

  // According to the Socks 4a spec:
  //
  // "For version 4A, if the client cannot resolve the destination
  // host's domain name to find its IP address, it should set the first
  // three bytes of DSTIP to NULL and the last byte to a non-zero value.
  //
  // In other words, do not check for '0.0.0.1' specifically, but '0.0.0.x' generically.

  // if VHost = '0.0.0.1' then begin
  if (LData[3] = 0) and (LData[4] = 0) and (LData[5] = 0) and (LData[6] <> 0) then begin
    VHost := AContext.Connection.IOHandler.ReadLn(#0);
    LBinding := AContext.Binding;
    if LBinding <> nil then begin
      AContext.FIPVersion := LBinding.IPVersion;
    end else begin
      AContext.FIPVersion := ID_DEFAULT_IP_VERSION;
    end;
  end else begin
    AContext.FIPVersion := Id_IPv4;
  end;

  if not NeedsAuthentication then begin
    AContext.FUsername := '';
    AContext.FPassword := '';
  end else begin
    AContext.FUsername := LUserId;
    AContext.FPassword := '';
    if not DoAuthenticate(AContext) then begin
      SendV4Response(AContext, 93);
      AContext.Connection.Disconnect;
      raise EIdSocksSvrInvalidLogin.Create(RSSocksSvrInvalidLogin);
    end;
  end;
end;

procedure TIdCustomSocksServer.HandleConnectV5(AContext: TIdSocksServerContext;
  var VCommand: Byte; var VHost: string; var VPort: TIdPort);
var
  LType: Byte;
  LMethods, LData: TIdBytes;
  LIP6: TIdIPv6Address;
  I: Integer;
  LBinding: TIdSocketHandle;
begin
  AContext.Connection.IOHandler.ReadBytes(LMethods, AContext.Connection.IOHandler.ReadByte);
  if not NeedsAuthentication then begin
    AContext.FUsername := '';
    AContext.FPassword := '';
    SendV5MethodResponse(AContext, IdSocksAuthNoAuthenticationRequired);
  end else begin
    if ByteIndex(IdSocksAuthUsernamePassword, LMethods) = -1 then begin
      SendV5MethodResponse(AContext, IdSocksAuthNoAcceptableMethods);
      AContext.Connection.Disconnect; // not sure the server has to disconnect
      raise EIdSocksSvrNotSupported.Create(RSSocksSvrNotSupported);
    end;
    SendV5MethodResponse(AContext, IdSocksAuthUsernamePassword);
    AContext.Connection.IOHandler.ReadByte; //subversion, we don't need it.
    AContext.FUsername := AContext.Connection.IOHandler.ReadString(AContext.Connection.IOHandler.ReadByte);
    AContext.FPassword := AContext.Connection.IOHandler.ReadString(AContext.Connection.IOHandler.ReadByte);
    if not DoAuthenticate(AContext) then begin
      SendV5AuthResponse(AContext, IdSocks5ReplyGeneralFailure);
      AContext.Connection.Disconnect;
      raise EIdSocksSvrInvalidLogin.Create(RSSocksSvrInvalidLogin);
    end;
    SendV5AuthResponse(AContext, IdSocks5ReplySuccess);
  end;

  AContext.Connection.IOHandler.ReadByte; // socks version, should be 5
  VCommand := AContext.Connection.IOHandler.ReadByte;
  AContext.Connection.IOHandler.ReadByte; // reserved, should be 0
  LType := AContext.Connection.IOHandler.ReadByte;

  case LType of
    1:
      begin
        AContext.Connection.IOHandler.ReadBytes(LData, 6);
        VHost := BytesToIPv4Str(LData);
        VPort := GStack.NetworkToHost(BytesToUInt16(LData, 4));
        AContext.FIPVersion := Id_IPv4;
      end;
    3:
      begin
        AContext.Connection.IOHandler.ReadBytes(LData, AContext.Connection.IOHandler.ReadByte+2);
        VHost := BytesToString(LData, 0, Length(LData)-2);
        VPort := GStack.NetworkToHost(BytesToUInt16(LData, Length(LData)-2));
        LBinding := AContext.Binding;
        if LBinding <> nil then begin
          AContext.FIPVersion := LBinding.IPVersion;
        end else begin
          AContext.FIPVersion := ID_DEFAULT_IP_VERSION;
        end;
      end;
    4:
      begin
        AContext.Connection.IOHandler.ReadBytes(LData, 18);
        BytesToIPv6(LData, LIP6);
        for I := 0 to 7 do begin
          LIP6[I] := GStack.NetworkToHost(LIP6[I]);
        end;
        VHost := IPv6AddressToStr(LIP6);
        VPort := GStack.NetworkToHost(BytesToUInt16(LData, 16));
        AContext.FIPVersion := Id_IPv6;
      end;
    else
      begin
        SendV5Response(AContext, IdSocks5ReplyAddrNotSupported);
        AContext.Connection.Disconnect;
        raise EIdSocksSvrSocks5WrongATYP.Create(RSSocksSvrWrongATYP);
      end;
  end;
end;

function TIdCustomSocksServer.DoExecute(AContext: TIdContext): Boolean;
var
  LCommand: Byte;
  LHost: string;
  LPort: TIdPort;
  LContext: TIdSocksServerContext;
begin
  //just to keep the compiler happy
  Result := True;
  LContext := AContext as TIdSocksServerContext;

  LContext.FSocksVersion := AContext.Connection.IOHandler.ReadByte;

  if not (
    ((LContext.SocksVersion = 4) and AllowSocks4) or
    ((LContext.SocksVersion = 5) and AllowSocks5)
    ) then
  begin
    case LContext.SocksVersion of
      4: SendV4Response(LContext, 91);
      5: SendV5MethodResponse(LContext, IdSocksAuthNoAcceptableMethods);
    end;
    AContext.Connection.Disconnect;
    raise EIdSocksSvrWrongSocksVer.Create(RSSocksSvrWrongSocksVersion);
  end;

  case LContext.SocksVersion of
    4: HandleConnectV4(LContext, LCommand, LHost, LPort);
    5: HandleConnectV5(LContext, LCommand, LHost, LPort);
  end;

  case LCommand of
    1: CommandConnect(LContext, LHost, LPort);
    2: CommandBind(LContext, LHost, LPort);
    //3: //udp bind
  else
    begin
      case LContext.SocksVersion of
        4: SendV4Response(LContext, 91);
        5: SendV5Response(LContext, IdSocks5ReplyCmdNotSupported);
      end;
      AContext.Connection.Disconnect;
      raise EIdSocksSvrWrongSocksCmd.Create(RSSocksSvrWrongSocksCommand);
    end;
  end;
end;

procedure TIdSocksServer.CommandConnect(AContext: TIdSocksServerContext;
  const AHost: string; const APort: TIdPort);
var
  LClient: TIdTCPClient;
  LHost: String;
  LPort: TIdPort;
begin
  LHost := AHost;
  LPort := APort;

  if not DoBeforeSocksConnect(AContext, LHost, LPort) then begin
    case AContext.SocksVersion of
      4: SendV4Response(AContext, 91);
      5: SendV5Response(AContext, IdSocks5ReplyConnNotAllowed);
    end;
    AContext.Connection.Disconnect;
    raise EIdSocksSvrAccessDenied.Create(RSSocksSvrAccessDenied);
  end;

  LClient := nil;
  try
    try
      LClient := TIdTCPClient.Create(nil);
      LClient.Port := LPort;
      LClient.Host := LHost;
      LClient.IPVersion := AContext.IPVersion;
      LClient.ConnectTimeout := 120000; // 2 minutes
      // TODO: fire an event here so the user can customize the LClient as
      // needed (enable SSL, etc) before connecting to the target Host...
      LClient.Connect;
    except
      // TODO: for v5, check the socket error and send an appropriate reply
      // (Network unreachable, Host unreachable, Connection refused, etc)...
      case AContext.SocksVersion of
        4: SendV4Response(AContext, 91);
        5: SendV5Response(AContext, IdSocks5ReplyHostUnreachable);
      end;
      AContext.Connection.Disconnect;
      raise;
    end;

    case AContext.SocksVersion of
      4: SendV4Response(AContext, 90, LClient.Socket.Binding.IP, LClient.Socket.Binding.Port);
      5: SendV5Response(AContext, IdSocks5ReplySuccess, LClient.Socket.Binding.IP, LClient.Socket.Binding.Port);
    end;

    TransferData(AContext.Connection, LClient);
    LClient.Disconnect;
    AContext.Connection.Disconnect;
  finally
    FreeAndNil(LClient);
  end;
end;

procedure TIdSocksServer.CommandBind(AContext: TIdSocksServerContext;
  const AHost: string; const APort: TIdPort);
var
  LServer: TIdSimpleServer;
  LHost: String;
  LPort: TIdPort;
begin
  LHost := AHost;
  LPort := APort;

  if not DoBeforeSocksBind(AContext, LHost, LPort) then begin
    case AContext.SocksVersion of
      4: SendV4Response(AContext, 91);
      5: SendV5Response(AContext, IdSocks5ReplyConnNotAllowed);
    end;
    AContext.Connection.Disconnect;
    raise EIdSocksSvrAccessDenied.Create(RSSocksSvrAccessDenied);
  end;

  LServer := nil;
  try
    try
      LServer := TIdSimpleServer.Create(nil);
      LServer.IPVersion := AContext.IPVersion;
      LServer.BeginListen;
    except
      case AContext.SocksVersion of
        4: SendV4Response(AContext, 91);
        5: SendV5Response(AContext, IdSocks5ReplyGeneralFailure);
      end;
      AContext.Connection.Disconnect;
      raise;
    end;

    case AContext.SocksVersion of
      4: SendV4Response(AContext, 90, LServer.Binding.IP, LServer.Binding.Port);
      5: SendV5Response(AContext, IdSocks5ReplySuccess, LServer.Binding.IP, LServer.Binding.Port);
    end;

    try
      LServer.Listen(120000); // 2 minutes
    except
      case AContext.SocksVersion of
        4: SendV4Response(AContext, 91);
        5: SendV5Response(AContext, IdSocks5ReplyGeneralFailure);
      end;
      AContext.Connection.Disconnect;
      raise;
    end;

    // verify that the connected host is the one actually expected
    if not DoVerifyBoundPeer(AContext, LHost, LServer.Binding.PeerIP) then begin
      LServer.Disconnect;
      case AContext.SocksVersion of
        4: SendV4Response(AContext, 91);
        5: SendV5Response(AContext, IdSocks5ReplyGeneralFailure);
      end;
      AContext.Connection.Disconnect;
      raise EIdSocksSvrPeerMismatch.Create(RSSocksSvrPeerMismatch);
    end;

    case AContext.SocksVersion of
      4: SendV4Response(AContext, 90, LServer.Binding.PeerIP, LServer.Binding.PeerPort);
      5: SendV5Response(AContext, IdSocks5ReplySuccess, LServer.Binding.PeerIP, LServer.Binding.PeerPort);
    end;

    TransferData(AContext.Connection, LServer);
    LServer.Disconnect;
    AContext.Connection.Disconnect;
  finally
    FreeAndNil(LServer);
  end;
end;

procedure TIdEventSocksServer.CommandConnect(AContext: TIdSocksServerContext;
  const AHost: string; const APort: TIdPort);
begin
  if Assigned(FOnCommandConnect) then begin
    FOnCommandConnect(AContext, AHost, APort);
  end;
end;

procedure TIdEventSocksServer.CommandBind(AContext: TIdSocksServerContext;
  const AHost: string; const APort: TIdPort);
begin
  if Assigned(FOnCommandBind) then begin
    FOnCommandBind(AContext, AHost, APort);
  end;
end;

{ Constructor / Destructors }

procedure TIdCustomSocksServer.InitComponent;
begin
  inherited InitComponent;
  FContextClass := TIdSocksServerContext;
  DefaultPort := IdPORT_SOCKS;
  AllowSocks4 := True;
  AllowSocks5 := True;
  NeedsAuthentication := False;
end;

{ TIdSocksServerContext }

constructor TIdSocksServerContext.Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FIPVersion := ID_DEFAULT_IP_VERSION;
  FUsername := '';
  FPassword := '';
  FSocksVersion := 0;
end;

end.

