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
  Rev 1.8    10/26/2004 8:12:30 PM  JPMugaas
  Now uses TIdStrings and TIdStringList for portability.

  Rev 1.7    6/11/2004 8:28:56 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.6    5/14/2004 12:14:50 PM  BGooijen
  Fix for weird dotnet bug when querying the local binding

  Rev 1.5    4/18/04 2:45:54 PM  RLebeau
  Conversion support for Int64 values

  Rev 1.4    2004.03.07 11:45:26 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.3    3/6/2004 5:16:30 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.2    2/10/2004 7:33:26 PM  JPMugaas
  I had to move the wrapper exception here for DotNET stack because Borland's
  update 1 does not permit unlisted units from being put into a package.  That
  now would report an error and I didn't want to move IdExceptionCore into the
  System package.

  Rev 1.1    2/4/2004 8:48:30 AM  JPMugaas
  Should compile.

  Rev 1.0    2004.02.03 3:14:46 PM  czhower
  Move and updates

  Rev 1.32    2/1/2004 6:10:54 PM  JPMugaas
  GetSockOpt.

  Rev 1.31    2/1/2004 3:28:32 AM  JPMugaas
  Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
  that will work the same in the DotNET as elsewhere.  This is required to
  reenable IPWatch.

  Rev 1.30    1/31/2004 1:12:54 PM  JPMugaas
  Minor stack changes required as DotNET does support getting all IP addresses
  just like the other stacks.

  Rev 1.29    2004.01.22 2:46:52 PM  czhower
  Warning fixed.

  Rev 1.28    12/4/2003 3:14:54 PM  BGooijen
  Added HostByAddress

  Rev 1.27    1/3/2004 12:22:14 AM  BGooijen
  Added function SupportsIPv6

  Rev 1.26    1/2/2004 4:24:08 PM  BGooijen
  This time both IPv4 and IPv6 work

  Rev 1.25    02/01/2004 15:58:00  HHariri
  fix for bind

  Rev 1.24    12/31/2003 9:52:00 PM  BGooijen
  Added IPv6 support

  Rev 1.23    10/28/2003 10:12:36 PM  BGooijen
  DotNet

  Rev 1.22    10/26/2003 10:31:16 PM  BGooijen
  oops, checked in debug version <g>, this is the right one

  Rev 1.21    10/26/2003 5:04:26 PM  BGooijen
  UDP Server and Client

  Rev 1.20    10/21/2003 11:03:50 PM  BGooijen
  More SendTo, ReceiveFrom

  Rev 1.19    10/21/2003 9:24:32 PM  BGooijen
  Started on SendTo, ReceiveFrom

  Rev 1.18    10/19/2003 5:21:30 PM  BGooijen
  SetSocketOption

  Rev 1.17    10/11/2003 4:16:40 PM  BGooijen
  Compiles again

  Rev 1.16    10/5/2003 9:55:28 PM  BGooijen
  TIdTCPServer works on D7 and DotNet now

  Rev 1.15    10/5/2003 3:10:42 PM  BGooijen
  forgot to clone the Sockets list in some Select methods, + added Listen and
  Accept

  Rev 1.14    10/5/2003 1:52:14 AM  BGooijen
  Added typecasts with network ordering calls, there are required for some
  reason

  Rev 1.13    10/4/2003 10:39:38 PM  BGooijen
  Renamed WSXXX functions in implementation section too

  Rev 1.12    04/10/2003 22:32:00  HHariri
  moving of WSNXXX method to IdStack and renaming of the DotNet ones

  Rev 1.11    04/10/2003 21:28:42  HHariri
  Netowkr ordering functions

  Rev 1.10    10/3/2003 11:02:02 PM  BGooijen
  fixed calls to Socket.Select

  Rev 1.9    10/3/2003 11:39:38 PM  GGrieve
  more work

  Rev 1.8    10/3/2003 12:09:32 AM  BGooijen
  DotNet

  Rev 1.7    10/2/2003 8:23:52 PM  BGooijen
  .net

  Rev 1.6    10/2/2003 8:08:52 PM  BGooijen
  .Connect works not in .net

  Rev 1.5    10/2/2003 7:31:20 PM  BGooijen
  .net

  Rev 1.4    10/2/2003 6:12:36 PM  GGrieve
  work in progress (hardly started)

  Rev 1.3    2003.10.01 9:11:24 PM  czhower
  .Net

  Rev 1.2    2003.10.01 5:05:18 PM  czhower
  .Net

  Rev 1.1    2003.10.01 1:12:40 AM  czhower
  .Net

  Rev 1.0    2003.09.30 10:35:40 AM  czhower
  Initial Checkin
}

unit IdStackDotNet;

interface
{$i IdCompilerDefines.inc}
uses
  Classes,
  IdGlobal, IdStack, IdStackConsts,
  System.Collections;

type
  TIdSocketListDotNet = class(TIdSocketList)
  protected
     Sockets:ArrayList;

     function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function Contains(AHandle: TIdStackSocketHandle): boolean; override;
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
     AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean;
     override;
    function SelectReadList(var VSocketList: TIdSocketList;
     const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackDotNet = class(TIdStack)
  protected
    function ReadHostName: string; override;
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function GetLocalAddress: string; override;
    function GetLocalAddresses: TStrings; override;
    procedure PopulateLocalAddresses; override;
    //internal IP Mutlicasting membership stuff
    procedure MembershipSockOpt(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const ASockOpt : TIdSocketOption; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
  public
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
                    const APort: TIdPort;
                    const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
                    const APort: TIdPort;
                    const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
                    var VPort: TIdPort); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
                    var VPort: TIdPort); override;
    function  NewSocketHandle(const ASocketType:TIdSocketType;
                    const AProtocol: TIdSocketProtocol;
                    const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
                    const AOverlapped: Boolean = False) : TIdStackSocketHandle; override;
    // Result:
    // > 0: Number of bytes received
    //   0: Connection closed gracefully
    // Will raise exceptions in other cases
    function Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes) : Integer; override;
    function Send(
      ASocket: TIdStackSocketHandle;
      const ABuffer: TIdBytes;
      AOffset: Integer = 0;
      ASize: Integer = -1
      ): Integer; override;
    function IOControl(const s:  TIdStackSocketHandle; const cmd: cardinal; var arg: cardinal ): Integer; override;
    function ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
             var VIP: string; var VPort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle;
      var VBuffer: TIdBytes;
      APkt :  TIdPacketInfo;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Cardinal; override;

    function SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
             const AOffset: Integer; const AIP: string; const APort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): Integer; override;

    function HostToNetwork(AValue: Word): Word; override;
    function NetworkToHost(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    function HostByAddress(const AAddress: string;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;

    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);override;
    function Accept(ASocket: TIdStackSocketHandle;
             var VIP: string; var VPort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ):TIdStackSocketHandle; override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel:TIdSocketOptionLevel;
             AOptName: TIdSocketOption; AOptVal: Integer); overload;override;
    function SupportsIPv6:boolean; override;
    //multicast stuff Kudzu permitted me to add here.
    procedure SetMulticastTTL(AHandle: TIdStackSocketHandle;
      const AValue : Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure DropMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure AddMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure WriteChecksum(s : TIdStackSocketHandle;
      var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
  end;


implementation

uses
  IdException,
  System.Net,
  System.Net.Sockets;

const
  IdIPFamily : array[TIdIPVersion] of AddressFamily = (AddressFamily.InterNetwork, AddressFamily.InterNetworkV6 );

{ TIdStackDotNet }

function BuildException(AException : System.Exception) : Exception;
var
  LSocketError : System.Net.Sockets.SocketException;
begin
  if AException is System.Net.Sockets.SocketException then
    begin
    LSocketError := AException as System.Net.Sockets.SocketException;
    result := EIdSocketError.createError(LSocketError.ErrorCode, LSocketError.Message)
    end
  else
    begin
    result := EIdWrapperException.create(AException.Message, AException);
    end;
end;

procedure TIdStackDotNet.Bind(ASocket: TIdStackSocketHandle; const AIP: string;
  const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LEndPoint : IPEndPoint;
  LIP:String;
begin
  try
    LIP := AIP;
    if LIP='' then begin
      if (AIPVersion=Id_IPv4) then begin
        LIP := '0.0.0.0'; {do not localize}
      end else if (AIPVersion=Id_IPv6) then begin
        LIP := '::'; {do not localize}
      end;
    end;
    LEndPoint := IPEndPoint.Create(IPAddress.Parse(LIP), APort);
    ASocket.Bind(LEndPoint);
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

procedure TIdStackDotNet.Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
  const APort: TIdPort;const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LEndPoint : IPEndPoint;
begin
  try
    LEndPoint := IPEndPoint.Create(IPAddress.Parse(AIP), APort);
    ASocket.Connect(LEndPoint);
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

procedure TIdStackDotNet.Disconnect(ASocket: TIdStackSocketHandle);
begin
  try
    ASocket.Close;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

procedure TIdStackDotNet.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  try
    ASocket.Listen(ABackLog);
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdStackDotNet.Accept(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
  ):TIdStackSocketHandle;
begin
  try
    result := ASocket.Accept();
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

procedure TIdStackDotNet.GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort);
var
  LEndPoint : EndPoint;
begin
  try
    LEndPoint := ASocket.remoteEndPoint;
    VIP := (LEndPoint as IPEndPoint).Address.ToString;
    VPort := (LEndPoint as IPEndPoint).Port;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

procedure TIdStackDotNet.GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort);
var
  LEndPoint : EndPoint;
begin
  try
    if ASocket.Connected or (VIP<>'') then begin
      LEndPoint := ASocket.localEndPoint;
      VIP := (LEndPoint as IPEndPoint).Address.ToString;
      VPort := (LEndPoint as IPEndPoint).Port;
    end;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdStackDotNet.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LIP : array of IPAddress;
  a:integer;
begin
  try
    {
    [Warning] IdStackDotNet.pas(417): W1000 Symbol 'Resolve' is deprecated:
    'Resolve is obsoleted for this type, please use GetHostEntry instead.
    http://go.microsoft.com/fwlink/?linkid=14202'
    }
    {$IFDEF DOTNET2}
    LIP := Dns.GetHostEntry(AHostName).AddressList;
    {$ENDIF}
    {$IFDEF DOTNET1}
    LIP := Dns.Resolve(AHostName).AddressList;
    {$ENDIF}
    for a:=low(LIP) to high(LIP) do begin
      if LIP[a].AddressFamily=IdIPFamily[AIPVersion] then begin
        result := LIP[a].toString;
        exit;
      end;
    end;
    raise System.Net.Sockets.SocketException.Create(11001);
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdStackDotNet.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
begin
  try
    {$IFDEF DOTNET2}
    result := Dns.GetHostEntry(AAddress).HostName;
    {$ENDIF}
    {$IFDEF DOTNET1}
    result := Dns.GetHostByAddress(AAddress).HostName;
    {$ENDIF}
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;


function TIdStackDotNet.NewSocketHandle(const ASocketType:TIdSocketType;
  const AProtocol: TIdSocketProtocol; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION; const AOverlapped: Boolean = false): TIdStackSocketHandle;
begin
  try
    case AIPVersion of
      Id_IPv4: result := Socket.Create(AddressFamily.InterNetwork, ASocketType, AProtocol);
      Id_IPv6: result := Socket.Create(AddressFamily.InterNetworkV6, ASocketType, AProtocol);
      else
        raise EIdException.Create('Invalid socket type'); {do not localize}
    end;
  except
    on E: Exception do begin
      raise BuildException(E);
    end;
  end;
end;

function TIdStackDotNet.ReadHostName: string;
begin
  try
    result := System.Net.DNS.GetHostName;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdStackDotNet.Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes): Integer;
begin
  try
    result := ASocket.Receive(VBuffer,length(VBuffer),SocketFlags.None);
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdStackDotNet.Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
  AOffset: Integer = 0; ASize: Integer = -1): Integer;
begin
  ASize := IndyLength(ABuffer, ASize, AOffset);
  if ASize > 0 then begin
    try
      Result := ASocket.Send(ABuffer, AOffset, ASize, SocketFlags.None);
    except
      on E: Exception do begin
        raise BuildException(E);
      end;
    end;
  end else begin
    Result := 0;
  end;
end;

function TIdStackDotNet.ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
             var VIP: string; var VPort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
var
  LEndPoint : EndPoint;
begin
  Result := 0; // to make the compiler happy
  LEndPoint := IPEndPoint.Create(IPAddress.Any, 0);
  try
    try
      Result := ASocket.ReceiveFrom(VBuffer,SocketFlags.None,LEndPoint);
    except
      on e:exception do begin
        raise BuildException(e);
      end;
    end;
    VIP := IPEndPoint(LEndPoint).Address.ToString;
    VPort := IPEndPoint(LEndPoint).Port;
  finally
    LEndPoint.free;
  end;
end;

function TIdStackDotNet.SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
             const AOffset: Integer; const AIP: string; const APort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): Integer;
var
  LEndPoint : EndPoint;
begin
  Result := 0; // to make the compiler happy
  LEndPoint := IPEndPoint.Create(IPAddress.Parse(AIP), APort);
  try
    try
      Result := ASocket.SendTo(ABuffer,SocketFlags.None,LEndPoint);
    except
      on e:exception do begin
        raise BuildException(e);
      end;
    end;
  finally
    LEndPoint.free;
  end;
end;


//////////////////////////////////////////////////////////////



constructor TIdSocketListDotNet.Create;
begin
  inherited Create;
  Sockets:=ArrayList.Create;
end;

destructor TIdSocketListDotNet.Destroy;
begin
  Sockets.free;
  inherited Destroy;
end;

procedure TIdSocketListDotNet.Add(AHandle: TIdStackSocketHandle);
begin
  Sockets.Add(AHandle);
end;

procedure TIdSocketListDotNet.Clear;
begin
  Sockets.Clear;
end;

function TIdSocketListDotNet.Contains(AHandle: TIdStackSocketHandle): Boolean;
begin
  result:=Sockets.Contains(AHandle);
end;

function TIdSocketListDotNet.Count: Integer;
begin
  result:=Sockets.Count;
end;

function TIdSocketListDotNet.GetItem(AIndex: Integer): TIdStackSocketHandle;
begin
  result:=(Sockets.Item[AIndex]) as TIdStackSocketHandle;
end;

procedure TIdSocketListDotNet.Remove(AHandle: TIdStackSocketHandle);
begin
  Sockets.Remove(AHandle);
end;

function TIdSocketListDotNet.SelectRead(const ATimeout: Integer): Boolean;
var
  LTempSockets:ArrayList;
begin
  try
    // DotNet updates this object on return, so we need to copy it each time we need it
    LTempSockets:=ArrayList(Sockets.Clone);
    try
      if ATimeout=IdTimeoutInfinite then begin
        Socket.Select(LTempSockets,nil,nil,-1);
      end else begin
        Socket.Select(LTempSockets,nil,nil,ATimeout*1000);
      end;
      result := LTempSockets.Count > 0;
    finally
      LTempSockets.free;
    end;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdSocketListDotNet.SelectReadList(var VSocketList: TIdSocketList; const ATimeout: Integer): Boolean;
var
  LTempSockets:ArrayList;
begin
  try
    // DotNet updates this object on return, so we need to copy it each time we need it
    LTempSockets:=ArrayList(Sockets.Clone);
    try
      if ATimeout=IdTimeoutInfinite then begin
        Socket.Select(LTempSockets,nil,nil,-1);
      end else begin
        Socket.Select(LTempSockets,nil,nil,ATimeout*1000);
      end;
      result := LTempSockets.Count > 0;
      if result then
      begin
        if not Assigned(VSocketList) then
        begin
          VSocketList := TIdSocketListDotNet.CreateSocketList;
        end;
        TIdSocketListDotNet(VSocketList).Sockets:=ArrayList(Sockets.Clone);
      end;
    finally
      LTempSockets.free;
    end;
  except
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

class function TIdSocketListDotNet.Select(AReadList, AWriteList,
 AExceptList: TIdSocketList; const ATimeout: Integer): Boolean;
begin
  try
    if ATimeout=IdTimeoutInfinite then begin
      Socket.Select(
        TIdSocketListDotNet(AReadList).Sockets,
        TIdSocketListDotNet(AWriteList).Sockets,
        TIdSocketListDotNet(AExceptList).Sockets,-1);
    end else begin
      Socket.Select(
        TIdSocketListDotNet(AReadList).Sockets,
        TIdSocketListDotNet(AWriteList).Sockets,
        TIdSocketListDotNet(AExceptList).Sockets,ATimeout*1000);
    end;
    result:=
      (TIdSocketListDotNet(AReadList).Sockets.Count>0) or
      (TIdSocketListDotNet(AWriteList).Sockets.Count>0) or
      (TIdSocketListDotNet(AExceptList).Sockets.Count>0);
  except
    on e:ArgumentNullException do begin
      result:=false;
    end;
    on e:exception do begin
      raise BuildException(e);
    end;
  end;
end;

function TIdSocketListDotNet.Clone: TIdSocketList;
begin
  Result:=TIdSocketListDotNet.Create; //BGO: TODO: make prettier
  TIdSocketListDotNet(Result).Sockets.Free;
  TIdSocketListDotNet(Result).Sockets:=ArrayList(Sockets.Clone);
end;

function TIdStackDotNet.HostToNetwork(AValue: Word): Word;
begin
  Result := Word(IPAddress.HostToNetworkOrder(SmallInt(AValue)));
end;

function TIdStackDotNet.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := LongWord(IPAddress.HostToNetworkOrder(integer(AValue)));
end;

function TIdStackDotNet.HostToNetwork(AValue: Int64): Int64;
begin
  Result := IPAddress.HostToNetworkOrder(AValue);
end;

function TIdStackDotNet.NetworkToHost(AValue: Word): Word;
begin
  Result := Word(IPAddress.NetworkToHostOrder(SmallInt(AValue)));
end;

function TIdStackDotNet.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := LongWord(IPAddress.NetworkToHostOrder(integer(AValue)));
end;

function TIdStackDotNet.NetworkToHost(AValue: Int64): Int64;
begin
  Result := IPAddress.NetworkToHostOrder(AValue);
end;

procedure TIdStackDotNet.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
  out AOptVal: Integer);
var L : System.Object;
begin
  L := ASocket.GetSocketOption(ALevel,AoptName);
  AOptVal := Integer(L);
end;

procedure TIdStackDotNet.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel:TIdSocketOptionLevel; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  ASocket.SetSocketOption(ALevel, AOptName, AOptVal);
end;

function TIdStackDotNet.SupportsIPv6:boolean;
begin
{
[Warning] IdStackDotNet.pas(734): W1000 Symbol 'SupportsIPv6' is deprecated:
'SupportsIPv6 is obsoleted for this type, please use OSSupportsIPv6 instead.
http://go.microsoft.com/fwlink/?linkid=14202'
}
  {$IFDEF DOTNET2}
  result := Socket.OSSupportsIPv6;
  {$ENDIF}
  {$IFDEF DOTNET1}
  result := Socket.SupportsIPv6;
  {$ENDIF}
end;

function TIdStackDotNet.GetLocalAddresses: TStrings;
begin
  if FLocalAddresses = nil then
  begin
    FLocalAddresses := TStringList.Create;
  end;
  PopulateLocalAddresses;
  Result := FLocalAddresses;

end;

procedure TIdStackDotNet.PopulateLocalAddresses;
var
   {$IFDEF DOTNET1}
  LAddr : IPAddress;
  {$ENDIF}
  LHost : IPHostEntry;
  i : Integer;

begin
 FLocalAddresses.Clear;

  {$IFDEF DOTNET2}
  LHost := DNS.GetHostEntry( DNS.GetHostName );
  {$ENDIF}
  {$IFDEF DOTNET1}
  LAddr := IPAddress.Any;
  LHost := DNS.GetHostByAddress(LAddr);
  {$ENDIF}
  if Length(LHost.AddressList)>0 then
  begin
    for i := Low(LHost.AddressList) to High(LHost.AddressList) do
    begin
      //This may be returning various types of addresses.
      if LHost.AddressList[i].AddressFamily = AddressFamily.InterNetwork then
      begin
        FLocalAddresses.Add(LHost.AddressList[i].ToString);
      end;
    end;
  end;
end;

function TIdStackDotNet.GetLocalAddress: string;
begin
  Result := LocalAddresses[0];
end;

procedure TIdStackDotNet.SetLoopBack(AHandle: TIdStackSocketHandle;
  const AValue: Boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var LVal : Integer;
begin
  //necessary because SetSocketOption only accepts an integer
  //see: http://groups-beta.google.com/group/microsoft.public.dotnet.languages.csharp/browse_thread/thread/6a35c6d9052cfc2b/f01fea11f9a24508?q=SetSocketOption+DotNET&rnum=2&hl=en#f01fea11f9a24508
  if AValue then
  begin
    LVal := 1;
  end
  else
  begin
    LVal := 0;
  end;
  AHandle.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastLoopback , LVal);
end;

procedure TIdStackDotNet.DropMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);

begin
  MembershipSockOpt(AHandle,AGroupIP,ALocalIP,SocketOptionName.DropMembership );
end;

procedure TIdStackDotNet.AddMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  MembershipSockOpt(AHandle,AGroupIP,ALocalIP,SocketOptionName.AddMembership);
end;

procedure TIdStackDotNet.SetMulticastTTL(AHandle: TIdStackSocketHandle;
  const AValue: Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  if AIPVersion=Id_IPv4 then
  begin
    AHandle.SetSocketOption(SocketOptionLevel.IP,
	   	SocketOptionName.MulticastTimeToLive,AValue);
  end
  else
  begin
    AHandle.SetSocketOption(SocketOptionLevel.IPv6 ,
     SocketOptionName.MulticastTimeToLive,AValue);
  end;
end;

procedure TIdStackDotNet.MembershipSockOpt(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const ASockOpt: TIdSocketOption; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var LM4 : MulticastOption;
   LM6 : IPv6MulticastOption;
  LGroupIP, LLocalIP : System.Net.IPAddress;

begin

  LGroupIP := IPAddress.Parse(AGroupIP);
  if LGroupIP.AddressFamily = AddressFamily.InterNetworkV6 then
  begin
    LM6  := IPv6MulticastOption.Create(LGroupIP);
    AHandle.SetSocketOption(SocketOptionLevel.IPv6 , SocketOptionName.AddMembership , LM6);
  end
  else
  begin
    if ALocalIP.Length =0 then
    begin
      LM4 :=  System.Net.Sockets.MulticastOption.Create(LGroupIP);
    end
    else
    begin
      LLocalIP := IPAddress.Parse(ALocalIP);

      LM4 :=  System.Net.Sockets.MulticastOption.Create(LGroupIP,LLocalIP);
    end;
    AHandle.SetSocketOption(SocketOptionLevel.IP, ASockOpt, LM4);
   end;
end;

function TIdStackDotNet.ReceiveMsg(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; APkt: TIdPacketInfo;
  const AIPVersion: TIdIPVersion): Cardinal;
var LIP : String;
  LPort : TIdPort;
begin
  Result := ReceiveFrom(ASocket,VBuffer,LIP,LPort,AIPVersion);
  APkt.SourceIP := LIP;
  APkt.SourcePort := LPort;
end;

procedure TIdStackDotNet.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort; const AIPVersion: TIdIPVersion);

begin
  if AIPVersion = Id_IPv4 then
  begin
    CopyTIdWord(CalcCheckSum(VBuffer),VBuffer,AOffset);
  end
  else
  begin
{This is a todo because to do a checksum for ICMPv6, you need to obtain
the address for the IP the packet will come from (querry the network interfaces).
You then have to make a IPv6 pseudo header.  About the only other alternative is
to have the kernal (or DotNET Framework generate the checksum but we don't have
an API for it.

I'm not sure if we have an API for it at all.  Even if we did, would it be worth
doing when you consider that Microsoft's NET Framework 1.1 does not support ICMPv5
in its enumerations.
}
    Todo;
  end;

end;

function TIdStackDotNet.IOControl(const s: TIdStackSocketHandle;
  const cmd: cardinal; var arg: cardinal): Integer;
var LTmp : TIdBytes;

begin
  LTmp := ToBytes(arg);
  s.IOControl(cmd, ToBytes(arg), LTmp);
  arg := BytesToLongWord(LTmp);
  Result := 0;
end;

initialization
  GSocketListClass := TIdSocketListDotNet;
end.
