{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11958: IdRawFunctions.pas 
{
{   Rev 1.5    2004.02.03 4:16:50 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.4    2/1/2004 4:52:30 PM  JPMugaas
{ Removed the rest of the Todo; items.
}
{
{   Rev 1.3    2/1/2004 4:20:30 PM  JPMugaas
{ Should work in Win32.  TODO: See about DotNET.
}
{
{   Rev 1.2    2003.10.11 5:49:06 PM  czhower
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
{   Rev 1.0    11/13/2002 08:45:36 AM  JPMugaas
}
unit IdRawFunctions;

interface

uses
  IdStackBSDBase, IdRawHeaders, IdStack;

// ARP
function IdRawBuildArp(AHwAddressFormat, AProtocolFormat: word; AHwAddressLen, AProtocolLen: byte;
  AnOpType: word; ASenderHw: TIdEtherAddr; ASenderPr: TIdInAddr; ATargetHw: TIdEtherAddr; ATargetPr: TIdInAddr;
  const APayload; APayloadSize: integer; var ABuffer): boolean;

// DNS
function IdRawBuildDns(AnId, AFlags, ANumQuestions, ANumAnswerRecs, ANumAuthRecs, ANumAddRecs: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;

// Ethernet
function IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;

// ICMP
function IdRawBuildIcmpEcho(AType, ACode: byte; AnId, ASeq: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
function IdRawBuildIcmpMask(AType, ACode: byte; AnId, ASeq: word; AMask: longword;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
function IdRawBuildIcmpRedirect(AType, ACode: byte; AGateway: TIdInAddr;
  AnOrigLen: word; AnOrigTos: byte; AnOrigId, AnOrigFrag: word; AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload; APayloadSize: integer; var ABuffer): boolean;
function IdRawBuildIcmpTimeExceed(AType, ACode: byte; AnOrigLen: word; AnOrigTos: byte;
  AnOrigId, AnOrigFrag: word; AnOrigTtl: byte; AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload; APayloadSize: integer; var ABuffer): boolean;
function IdRawBuildIcmpTimestamp(AType, ACode: byte; AnId, ASeq: word;
  AnOtime, AnRtime, ATtime: TIdNetTime; const APayload; APayloadSize: integer; var ABuffer): boolean;
function IdRawBuildIcmpUnreach(AType, ACode: byte; AnOrigLen: word;
  AnOrigTos: byte; AnOrigId, AnOrigFrag: word; AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload, APayloadSize: integer; var ABuffer): boolean;

// IGMP
function IdRawBuildIgmp(AType, ACode: byte; AnIp: TIdInAddr;
  const APayload, APayloadSize: integer; var ABuffer): boolean;

// IP
function IdRawBuildIp(ALen: word; ATos: byte; AnId, AFrag: word; ATtl, AProtocol: byte;
  ASource, ADest: TIdInAddr; const APayload; APayloadSize: integer; var ABuffer): boolean;

// RIP
function IdRawBuildRip(ACommand, AVersion: byte; ARoutingDomain, AnAddressFamily,
  ARoutingTag: word; AnAddr, AMask, ANextHop, AMetric: longword;
  const APayload; APayloadSize: integer; var ABuffer): boolean;

// TCP
function IdRawBuildTcp(ASourcePort, ADestPort: word; ASeq, AnAck: longword;
  AControl: byte; AWindowSize, AnUrgent: word;
  const APayload, APayloadSize: integer; var ABuffer): boolean;

// UDP
function IdRawBuildUdp(ASourcePort, ADestPort: word; const APayload;
  APayloadSize: integer; var ABuffer): boolean;


implementation

uses
  IdGlobal;

function IdRawBuildArp(AHwAddressFormat, AProtocolFormat: word; AHwAddressLen, AProtocolLen: byte;
  AnOpType: word; ASenderHw: TIdEtherAddr; ASenderPr: TIdInAddr; ATargetHw: TIdEtherAddr; ATargetPr: TIdInAddr;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrArp: TIdArpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header

  HdrArp.arp_hrd := GBSDStack.HostToNetwork(AHwAddressFormat);
  HdrArp.arp_pro := GBSDStack.HostToNetwork(AProtocolFormat);
  HdrArp.arp_hln := AHwAddressLen;
  HdrArp.arp_pln := AProtocolLen;
  HdrArp.arp_op  := GBSDStack.HostToNetwork(AnOpType);
  Move(ASenderHw, HdrArp.arp_sha, AHwAddressLen);
  Move(ASenderPr, HdrArp.arp_spa, AProtocolLen);          
  Move(ATargetHw, HdrArp.arp_tha, AHwAddressLen);         
  Move(ATargetPr, HdrArp.arp_tpa, AProtocolLen);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_ARP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrArp, ABuffer, sizeof(HdrArp));

  Result := TRUE;
end;

function IdRawBuildDns(AnId, AFlags, ANumQuestions, ANumAnswerRecs, ANumAuthRecs, ANumAddRecs: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrDns: TIdDnsHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrDns.dns_id          := GBSDStack.HostToNetwork(AnId);

  HdrDns.dns_flags       := GBSDStack.HostToNetwork(AFlags);

  HdrDns.dns_num_q       := GBSDStack.HostToNetwork(ANumQuestions);

  HdrDns.dns_num_answ_rr := GBSDStack.HostToNetwork(ANumAnswerRecs);
  HdrDns.dns_num_auth_rr := GBSDStack.HostToNetwork(ANumAuthRecs);

  HdrDns.dns_num_addi_rr := GBSDStack.HostToNetwork(ANumAddRecs);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_DNS_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrDns, ABuffer, sizeof(HdrDns));

  Result := TRUE;
end;

function IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrEth: TIdEthernetHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  Move(ADest, HdrEth.ether_dhost, Id_ETHER_ADDR_LEN);
  Move(ASource, HdrEth.ether_shost, Id_ETHER_ADDR_LEN);
  HdrEth.ether_type := (GStack as TIdStackBSDBase).HostToNetwork(AType);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_ETH_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrEth, ABuffer, sizeof(HdrEth));

  Result := TRUE;
end;

// TODO: check nibbles in IP header
function IdRawBuildIp(ALen: word; ATos: byte; AnId, AFrag: word; ATtl, AProtocol: byte;
  ASource, ADest: TIdInAddr; const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIp: TIdIpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIp.ip_verlen := (4 shl 4) + (Id_IP_HSIZE div 4);     // IPv4 shl 4, 20 bytes div 4
  HdrIp.ip_tos    := ATos;
  HdrIp.ip_len    := GBSDStack.HostToNetwork(Id_IP_HSIZE + ALen);
  HdrIp.ip_id     := GBSDStack.HostToNetwork(AnId);
  HdrIp.ip_off    := GBSDStack.HostToNetwork(AFrag);
  HdrIp.ip_ttl    := ATtl;
  HdrIp.ip_p      := AProtocol;
  HdrIp.ip_sum    := 0;                                     // do checksum later
  HdrIp.ip_src    := ASource;
  HdrIp.ip_dst    := ADest;

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_IP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrIp, ABuffer, Id_IP_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpEcho(AType, ACode: byte; AnId, ASeq: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type := AType;
  HdrIcmp.icmp_code := ACode;
  HdrIcmp.icmp_hun.echo.id := GBSDStack.HostToNetwork(AnId);
  HdrIcmp.icmp_hun.echo.seq := GBSDStack.HostToNetwork(ASeq);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_ICMP_ECHO_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_ECHO_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpMask(AType, ACode: byte; AnId, ASeq: word; AMask: longword;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type := AType;
  HdrIcmp.icmp_code := ACode;
  HdrIcmp.icmp_hun.echo.id := GBSDStack.HostToNetwork(AnId);
  HdrIcmp.icmp_hun.echo.seq := GBSDStack.HostToNetwork(ASeq);
  HdrIcmp.icmp_dun.mask := GBSDStack.HostToNetwork(AMask);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_ICMP_MASK_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_MASK_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpUnreach(AType, ACode: byte; AnOrigLen: word;
  AnOrigTos: byte; AnOrigId, AnOrigFrag: word; AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload, APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type := AType;
  HdrIcmp.icmp_code := ACode;
  HdrIcmp.icmp_hun.echo.id := 0;
  HdrIcmp.icmp_hun.echo.seq := 0;

  // attach original header
  IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
    AnOrigSource, AnOrigDest, AnOrigPayload, APayloadSize,
    pointer(integer(@ABuffer) + Id_ICMP_UNREACH_HSIZE)^);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_UNREACH_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpTimeExceed(AType, ACode: byte; AnOrigLen: word; AnOrigTos: byte;
  AnOrigId, AnOrigFrag: word; AnOrigTtl: byte; AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type := AType;
  HdrIcmp.icmp_code := ACode;
  HdrIcmp.icmp_hun.echo.id := 0;
  HdrIcmp.icmp_hun.echo.seq := 0;

  // attach original header
  IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
    AnOrigSource, AnOrigDest, AnOrigPayload, APayloadSize,
    pointer(integer(@ABuffer) + Id_ICMP_TIMEXCEED_HSIZE)^);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_TIMEXCEED_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpTimestamp(AType, ACode: byte; AnId, ASeq: word;
  AnOtime, AnRtime, ATtime: TIdNetTime; const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type             := AType;
  HdrIcmp.icmp_code             := ACode;
  HdrIcmp.icmp_hun.echo.id      := (GStack as TIdStackBSDBase).HostToNetwork(AnId);
  HdrIcmp.icmp_hun.echo.seq     := (GStack as TIdStackBSDBase).HostToNetwork(ASeq);
  HdrIcmp.icmp_dun.ts.otime     := (GStack as TIdStackBSDBase).HostToNetwork(AnOtime);      // original timestamp
  HdrIcmp.icmp_dun.ts.rtime     := (GStack as TIdStackBSDBase).HostToNetwork(AnRtime);      // receive timestamp
  HdrIcmp.icmp_dun.ts.ttime     := (GStack as TIdStackBSDBase).HostToNetwork(ATtime);       // transmit timestamp

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_ICMP_TS_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_TS_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIcmpRedirect(AType, ACode: byte; AGateway: TIdInAddr;
  AnOrigLen: word; AnOrigTos: byte; AnOrigId, AnOrigFrag: word; AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrIcmp: TIdIcmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIcmp.icmp_type           := AType;
  HdrIcmp.icmp_code           := ACode;
  HdrIcmp.icmp_hun.gateway    := AGateway;      // gateway address

  // attach original header
  IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
    AnOrigSource, AnOrigDest, AnOrigPayload, APayloadSize,
    pointer(integer(@ABuffer) + Id_ICMP_REDIRECT_HSIZE)^);

  // copy header
  Move(HdrIcmp, ABuffer, Id_ICMP_REDIRECT_HSIZE);

  Result := TRUE;
end;

function IdRawBuildIgmp(AType, ACode: byte; AnIp: TIdInAddr;
  const APayload, APayloadSize: integer; var ABuffer): boolean;
var
  HdrIgmp: TIdIgmpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrIgmp.igmp_type         := AType;
  HdrIgmp.igmp_code         := ACode;
  HdrIgmp.igmp_sum          := 0;
  HdrIgmp.igmp_group        := AnIp;      // group address or 0

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_IGMP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrIgmp, ABuffer, sizeof(HdrIgmp));

  Result := TRUE;
end;

function IdRawBuildRip(ACommand, AVersion: byte; ARoutingDomain, AnAddressFamily,
  ARoutingTag: word; AnAddr, AMask, ANextHop, AMetric: longword;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
var
  HdrRip: TIdRipHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrRip.rip_cmd      := ACommand;
  HdrRip.rip_ver      := AVersion;
  HdrRip.rip_rd       := GBSDStack.HostToNetwork(ARoutingDomain);
  HdrRip.rip_af       := GBSDStack.HostToNetwork(AnAddressFamily);
  HdrRip.rip_rt       := GBSDStack.HostToNetwork(ARoutingTag);
  HdrRip.rip_addr     := GBSDStack.HostToNetwork(AnAddr);
  HdrRip.rip_mask     := GBSDStack.HostToNetwork(AMask);
  HdrRip.rip_next_hop := GBSDStack.HostToNetwork(ANextHop);
  HdrRip.rip_metric   := GBSDStack.HostToNetwork(AMetric);

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_RIP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrRip, ABuffer, sizeof(HdrRip));

  Result := TRUE;
end;

// TODO: check nibbles in TCP header
function IdRawBuildTcp(ASourcePort, ADestPort: word; ASeq, AnAck: longword;
  AControl: byte; AWindowSize, AnUrgent: word;
  const APayload, APayloadSize: integer; var ABuffer): boolean;
var
  HdrTcp: TIdTcpHdr;
begin
  // init result
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrTcp.tcp_sport    := GBSDStack.HostToNetwork(ASourcePort);
  HdrTcp.tcp_dport    := GBSDStack.HostToNetwork(ADestPort);
  HdrTcp.tcp_seq      := GBSDStack.HostToNetwork(ASeq);
  HdrTcp.tcp_ack      := GBSDStack.HostToNetwork(AnAck);                // acknowledgement number
  HdrTcp.tcp_flags    := AControl;                              // control flags
  HdrTcp.tcp_x2off    := ((Id_TCP_HSIZE div 4) shl 4) + 0;      // 20 bytes div 4, x2 unused
  HdrTcp.tcp_win      := GBSDStack.HostToNetwork(AWindowSize);          // window size
  HdrTcp.tcp_sum      := 0;
  HdrTcp.tcp_urp      := AnUrgent;                              // urgent pointer

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_TCP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrTcp, ABuffer, sizeof(HdrTcp));

  Result := TRUE;
end;

function IdRawBuildUdp(ASourcePort, ADestPort: word; const APayload;
  APayloadSize: integer; var ABuffer): boolean;
var
  HdrUdp: TIdUdpHdr;
begin
  Result := FALSE;

  // check input
	if (@ABuffer = nil) then
    Exit;

  // construct header
  HdrUdp.udp_dport    := GBSDStack.HostToNetwork(ASourcePort);
  HdrUdp.udp_dport    := GBSDStack.HostToNetwork(ADestPort);
  HdrUdp.udp_ulen     := GBSDStack.HostToNetwork(Id_UDP_HSIZE + APayloadSize);
  HdrUdp.udp_sum      := 0;

  // copy payload
  if ((@APayload <> nil) and (APayloadSize > 0)) then
    Move(APayload, pointer(integer(@ABuffer) + Id_UDP_HSIZE)^, APayloadSize);

  // copy header
  Move(HdrUdp, ABuffer, sizeof(HdrUdp));

  Result := TRUE;
end;


end.
