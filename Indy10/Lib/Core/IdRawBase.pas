{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11954: IdRawBase.pas 
{
{   Rev 1.15    7/9/04 4:26:28 PM  RLebeau
{ Removed TIdBytes local variable from Send()
}
{
{   Rev 1.14    09/06/2004 00:28:00  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.13    4/25/2004 7:54:26 AM  JPMugaas
{ Fix for AV.
}
{
{   Rev 1.12    2/8/2004 12:58:42 PM  JPMugaas
{ Should now compile in DotNET.
}
{
{   Rev 1.11    2004.02.03 4:16:48 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.10    2/1/2004 6:10:14 PM  JPMugaas
{ Should compile better.
}
{
{   Rev 1.9    2/1/2004 4:52:34 PM  JPMugaas
{ Removed the rest of the Todo; items.
}
{
{   Rev 1.8    2004.01.20 10:03:30 PM  czhower
{ InitComponent
}
{
{   Rev 1.7    2004.01.02 9:38:46 PM  czhower
{ Removed warning
}
{
{   Rev 1.6    2003.10.24 10:09:54 AM  czhower
{ Compiles
}
{
{   Rev 1.5    2003.10.20 12:03:08 PM  czhower
{ Added IdStackBSDBase to make it compile again.
}
{
{   Rev 1.4    10/19/2003 10:41:12 PM  BGooijen
{ Compiles in DotNet and D7 again
}
{
{   Rev 1.3    10/19/2003 9:34:28 PM  BGooijen
{ SetSocketOption
}
{
{   Rev 1.2    2003.10.11 5:48:58 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.1    2003.09.30 1:23:00 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.0    11/13/2002 08:45:24 AM  JPMugaas
}
unit IdRawBase;

interface
{We need to selectively disable some functionality in DotNET with buffers as
we don't want to impact anything else such as TIdICMPClient.
}
{$I IdCompilerDefines.inc}
uses
  Classes,
  IdComponent, IdGlobal, IdSocketHandle, IdStack,
  {$IFDEF MSWINDOWS}
  IdWship6,
  {$ENDIF}
  IdStackConsts;

const
  Id_TIdRawBase_Port = 0;
  Id_TIdRawBase_BufferSize = 8192;
  GReceiveTimeout = 0;
  GFTTL = 128;
  
type
  TIdRawBase = class(TIdComponent)
  protected
    FBinding: TIdSocketHandle;
    FBuffer: TMemoryStream;
    FHost: string;
    FPort: integer;
    FReceiveTimeout: integer;
    FProtocol: TIdSocketProtocol;
    FIPVersion : TIdIPVersion;
    FTTL: Integer;
    FPkt : TIdPacketInfo;
    //
    function GetBinding: TIdSocketHandle;
    function GetBufferSize: Integer;
    procedure InitComponent; override;
    procedure SetBufferSize(const AValue: Integer);
    procedure SetTTL(const Value: Integer);
  public
    destructor Destroy; override;
    // TODO: figure out which ReceiveXXX functions we want
    function ReceiveBuffer(var VBuffer : TIdBytes; ATimeOut: integer = -1): integer;
    procedure Send(AData: string); overload;
    procedure Send(AHost: string; const APort: Integer; AData: string); overload;
    procedure Send(AHost: string; const APort: integer; const ABuffer : TIdBytes); overload;
    //
    property TTL: Integer read FTTL write SetTTL default GFTTL;
    property Binding: TIdSocketHandle read GetBinding;
    property ReceiveTimeout: integer read FReceiveTimeout write FReceiveTimeout Default GReceiveTimeout;
  published
    property BufferSize: Integer read GetBufferSize write SetBufferSize default Id_TIdRawBase_BufferSize;
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort default Id_TIdRawBase_Port;
    property Protocol: TIdSocketProtocol read FProtocol write FProtocol default Id_IPPROTO_RAW;
  end;


const
//header sizes----------------------------------------------------------------//
  Id_ARP_HSIZE            = $1C;      // ARP header:             28 bytes
  Id_DNS_HSIZE            = $0C;      // DNS header base:        12 bytes
  Id_ETH_HSIZE            = $0E;      // Etherner header:        14 bytes
  Id_ICMP_HSIZE           = $04;      // ICMP header base:        4 bytes
  Id_ICMP_ECHO_HSIZE      = $08;      // ICMP_ECHO header:        8 bytes
  Id_ICMP_MASK_HSIZE      = $0C;      // ICMP_MASK header:       12 bytes
  Id_ICMP_UNREACH_HSIZE   = $08;      // ICMP_UNREACH header:     8 bytes
  Id_ICMP_TIMEXCEED_HSIZE = $08;      // ICMP_TIMXCEED header:    8 bytes
  Id_ICMP_REDIRECT_HSIZE  = $08;      // ICMP_REDIRECT header:    8 bytes
  Id_ICMP_TS_HSIZE        = $14;      // ICMP_TIMESTAMP header:  20 bytes
  Id_IGMP_HSIZE           = $08;      // IGMP header:             8 bytes
  Id_IP_HSIZE             = $14;      // IP header:              20 bytes
  Id_RIP_HSIZE            = $18;      // RIP header base:        24 bytes
  Id_TCP_HSIZE            = $14;      // TCP header:             20 bytes
  Id_UDP_HSIZE            = $08;      // UDP header:              8 bytes

//fragmentation flags---------------------------------------------------------//
  Id_IP_RF                = $8000;    // reserved fragment flag
  Id_IP_DF                = $4000;    // dont fragment flag
  Id_IP_MF                = $2000;    // more fragments flag
  Id_IP_OFFMASK           = $1FFF;    // mask for fragmenting bits

//TCP control flags-----------------------------------------------------------//
  Id_TCP_FIN              = $01;
  Id_TCP_SYN              = $02;
  Id_TCP_RST              = $04;
  Id_TCP_PUSH             = $08;
  Id_TCP_ACK              = $10;
  Id_TCP_URG              = $20;

//ICMP types------------------------------------------------------------------//
  Id_ICMP_ECHOREPLY       = 0;
  Id_ICMP_UNREACH         = 3;
  Id_ICMP_SOURCEQUENCH    = 4;
  Id_ICMP_REDIRECT        = 5;
  Id_ICMP_ECHO            = 8;
  Id_ICMP_ROUTERADVERT    = 9;
  Id_ICMP_ROUTERSOLICIT   = 10;
  Id_ICMP_TIMXCEED        = 11;
  Id_ICMP_PARAMPROB       = 12;
  Id_ICMP_TSTAMP          = 13;
  Id_ICMP_TSTAMPREPLY     = 14;
  Id_ICMP_IREQ            = 15;
  Id_ICMP_IREQREPLY       = 16;
  Id_ICMP_MASKREQ         = 17;
  Id_ICMP_MASKREPLY       = 18;

//ICMP codes------------------------------------------------------------------//
  Id_ICMP_UNREACH_NET               = 0;
  Id_ICMP_UNREACH_HOST              = 1;
  Id_ICMP_UNREACH_PROTOCOL          = 2;
  Id_ICMP_UNREACH_PORT              = 3;
  Id_ICMP_UNREACH_NEEDFRAG          = 4;
  Id_ICMP_UNREACH_SRCFAIL           = 5;
  Id_ICMP_UNREACH_NET_UNKNOWN       = 6;
  Id_ICMP_UNREACH_HOST_UNKNOWN      = 7;
  Id_ICMP_UNREACH_ISOLATED          = 8;
  Id_ICMP_UNREACH_NET_PROHIB        = 9;
  Id_ICMP_UNREACH_HOST_PROHIB       = 10;
  Id_ICMP_UNREACH_TOSNET            = 11;
  Id_ICMP_UNREACH_TOSHOST           = 12;
  Id_ICMP_UNREACH_FILTER_PROHIB     = 13;
  Id_ICMP_UNREACH_HOST_PRECEDENCE   = 14;
  Id_ICMP_UNREACH_PRECEDENCE_CUTOFF = 15;
  Id_ICMP_REDIRECT_NET              = 0;
  Id_ICMP_REDIRECT_HOST             = 1;
  Id_ICMP_REDIRECT_TOSNET           = 2;
  Id_ICMP_REDIRECT_TOSHOST          = 3;
  Id_ICMP_TIMXCEED_INTRANS          = 0;
  Id_ICMP_TIMXCEED_REASS            = 1;
  Id_ICMP_PARAMPROB_OPTABSENT       = 1;

  ICMP_MIN                          = 8;

//IGMP types------------------------------------------------------------------//
  Id_IGMP_MEMBERSHIP_QUERY          = $11;    // membership query
  Id_IGMP_V1_MEMBERSHIP_REPORT      = $12;    // v1 membership report
  Id_IGMP_V2_MEMBERSHIP_REPORT      = $16;    // v2 membership report
  Id_IGMP_LEAVE_GROUP               = $17;    // leave-group message

//ethernet packet types-------------------------------------------------------//
  Id_ETHERTYPE_PUP                  = $0200;    // PUP protocol
  Id_ETHERTYPE_IP                   = $0800;    // IP protocol
  Id_ETHERTYPE_ARP                  = $0806;    // ARP protocol
  Id_ETHERTYPE_REVARP               = $8035;    // reverse ARP protocol
  Id_ETHERTYPE_VLAN                 = $8100;    // IEEE 802.1Q VLAN tagging
  Id_ETHERTYPE_LOOPBACK             = $9000;    // used to test interfaces

//hardware address formats----------------------------------------------------//
  Id_ARPHRD_ETHER                   = 1;        // ethernet hardware format

//ARP operation types---------------------------------------------------------//
  Id_ARPOP_REQUEST                  = 1;        // req to resolve address
  Id_ARPOP_REPLY                    = 2;        // resp to previous request
  Id_ARPOP_REVREQUEST               = 3;        // req protocol address given hardware
  Id_ARPOP_REVREPLY                 = 4;        // resp giving protocol address
  Id_ARPOP_INVREQUEST               = 8;        // req to identify peer
  Id_ARPOP_INVREPLY                 = 9;        // resp identifying peer

//RIP commands----------------------------------------------------------------//
  Id_RIPCMD_REQUEST                 = 1;        // want info
  Id_RIPCMD_RESPONSE                = 2;        // responding to request
  Id_RIPCMD_TRACEON                 = 3;        // turn tracing on
  Id_RIPCMD_TRACEOFF                = 4;        // turn it off
  Id_RIPCMD_POLL                    = 5;        // like request, but anyone answers
  Id_RIPCMD_POLLENTRY               = 6;        // like poll, but for entire entry
  Id_RIPCMD_MAX                     = 7;

//RIP versions----------------------------------------------------------------//
  Id_RIPVER_0                       = 0;
  Id_RIPVER_1                       = 1;
  Id_RIPVER_2                       = 2;

//----------------------------------------------------------------------------//
  Id_MAX_IPOPTLEN                   = 40;
  Id_IP_MAXPACKET                   = 65535;
  Id_ETHER_ADDR_LEN                 = 6;
implementation

uses
  IdSys;

{ TIdRawBase }

destructor TIdRawBase.Destroy;
begin
  Sys.FreeAndNil(FBinding);
  Sys.FreeAndNil(FBuffer);
  Sys.FreeAndNil(FPkt);
  inherited;
end;

function TIdRawBase.GetBinding: TIdSocketHandle;
begin
  if not FBinding.HandleAllocated then begin
    FBinding.IPVersion := Self.FIPVersion;
{$IFDEF LINUX}
    FBinding.AllocateSocket(Integer(Id_SOCK_RAW), FProtocol);
{$ELSE}
    FBinding.AllocateSocket(Id_SOCK_RAW, FProtocol);
{$ENDIF}
  end;
  if Self.FIPVersion = Id_IPv4 then
  begin
    GStack.SetSocketOption(FBinding.Handle, Id_SOL_IP, Id_SO_IP_TTL, FTTL);
  end
  else
  begin

    //indicate we want packet information with RecvMsg (or WSARecvMsg) calls
    GStack.SetSocketOption(FBinding.Handle,Id_SOL_IPv6,Id_IPV6_PKTINFO,1);
    //set hop limit (or TTL as it was called in IPv4
    GStack.SetSocketOption(FBinding.Handle,Id_SOL_IPv6,Id_IPV6_UNICAST_HOPS,FTTL);
  end;
  Result := FBinding;
end;

function TIdRawBase.GetBufferSize: Integer;
begin
  Result := FBuffer.Size;
end;

procedure TIdRawBase.SetBufferSize(const AValue: Integer);
begin
  if (FBuffer = nil) then
    FBuffer := TMemoryStream.Create;
  FBuffer.Size := AValue;
end;

function TIdRawBase.ReceiveBuffer(var VBuffer : TIdBytes; ATimeOut: integer = -1): integer;
var 
  LIP : String;
  LPort : Integer;
begin
  Result := 0;
    // TODO: pass flags to recv()
    if ATimeOut < 0 then
    begin
      ATimeOut := FReceiveTimeout;
    end;
    if Length(VBuffer)>0 then
    begin
      if Binding.Readable(ATimeOut) then begin
        if FIPVersion = Id_IPv4 then
        begin
          Result := Binding.RecvFrom(VBuffer,LIP,LPort,FIPVersion);
        end
        else
        begin
        {
        IMPORTANT!!!!

        Do NOT call GStack.ReceiveMsg unless it is absolutely necessary.
        The reasons are:

        1) WSARecvMsg is only supported on WindowsXP or later.  I think Linux
        might have a RecvMsg function as well but I'm not sure.
        2) GStack.ReceiveMsg is not supported in the Microsoft NET framework 1.1.
        It may be supported in later versions.

          For IPv4
        and raw sockets, it usually isn't because we get the raw header itself.

        For IPv6 and raw sockets, we call this to get information about the destination
        IP address and hopefully, the TTL (hop count).
        }
          Result := GStack.ReceiveMsg(Binding.Handle,VBuffer,FPkt,Id_IPv6);
        end;
      end;
    end;
end;

procedure TIdRawBase.Send(AHost: string; const APort: Integer; AData: string);
begin
  AHost := GStack.ResolveHost(AHost,FIPVersion);
  Binding.SendTo(AHost, APort, ToBytes(AData),FIPVersion);
end;

procedure TIdRawBase.Send(AData: string);
begin
  Send(Host, Port, AData);
end;

procedure TIdRawBase.Send(AHost: string; const APort: integer; const ABuffer : TIdBytes);
begin
  AHost := GStack.ResolveHost(AHost,FIPVersion);
  Binding.SendTo(AHost, APort, ABuffer,FIPVersion);
end;

procedure TIdRawBase.SetTTL(const Value: Integer);
begin
  FTTL := Value;
  if FIPVersion = Id_IPv4 then
  begin
     GStack.SetSocketOption(Binding.Handle,Id_SOL_IP,Id_SO_IP_TTL, FTTL);
  end
  else
  begin
    GStack.SetSocketOption(Binding.Handle,Id_SOL_IPv6,Id_IPV6_UNICAST_HOPS,FTTL);
  end;
end;

procedure TIdRawBase.InitComponent;
begin
  inherited;
  FBinding := TIdSocketHandle.Create(nil);
  FPkt := TIdPacketInfo.Create;
  BufferSize := Id_TIdRawBase_BufferSize;
  ReceiveTimeout := GReceiveTimeout;
  FPort := Id_TIdRawBase_Port;
  FProtocol := Id_IPPROTO_RAW;
  FIPVersion := Id_IPv4;
  FTTL := GFTTL;

end;

end.
