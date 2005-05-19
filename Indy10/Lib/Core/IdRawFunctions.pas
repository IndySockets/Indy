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
   IdGlobal, IdRawHeaders, IdStack;

// ARP
function IdRawBuildArp(const AHwAddressFormat, AProtocolFormat: word;
  const AHwAddressLen, AProtocolLen: byte;
  const AnOpType: word;
  ASenderHw: TIdEtherAddr;
  ASenderPr: TIdInAddr;
  ATargetHw: TIdEtherAddr;
  ATargetPr: TIdInAddr;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
// DNS
{function IdRawBuildDns(AnId, AFlags, ANumQuestions, ANumAnswerRecs, ANumAuthRecs, ANumAddRecs: word;
  const APayload; APayloadSize: integer; var ABuffer): boolean;
}
// Ethernet
function IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: word;
  const APayload : TIdBytes;  var VBuffer : TIdBytes): boolean;


// ICMP
function IdRawBuildIcmpEcho(AType, ACode: byte; AnId, ASeq: word;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
function IdRawBuildIcmpMask(AType, ACode: byte; AnId, ASeq: word; AMask: longword;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
function IdRawBuildIcmpRedirect(const AType, ACode: byte;
  AGateway: TIdInAddr;
  const AnOrigLen: word;
  const AnOrigTos: byte;
  const AnOrigId, AnOrigFrag: word;
  const AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
function IdRawBuildIcmpTimeExceed(const AType, ACode: byte;
  const AnOrigLen: word;
  const AnOrigTos: byte;
  const AnOrigId, AnOrigFrag: word;
  const AnOrigTtl: byte;
  const AnOrigProtocol: byte;
  const AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
function IdRawBuildIcmpTimestamp(const AType, ACode: byte;
  const AnId, ASeq: word;
  const AnOtime, AnRtime, ATtime: TIdNetTime;
  const APayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
function IdRawBuildIcmpUnreach(AType, ACode: byte;
  AnOrigLen: word;
  AnOrigTos: byte; AnOrigId, AnOrigFrag: word;
  AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload, APayloadSize: integer;
  var VBuffer : TIdBytes): boolean;

// IGMP
function IdRawBuildIgmp(AType, ACode: byte;
  AnIp: TIdInAddr;
  const APayload, APayloadSize: integer;
  var VBuffer : TIdBytes): boolean;

// IP

function IdRawBuildIp(ALen: word; ATos: byte; AnId, AFrag: word; ATtl, AProtocol: byte;
  ASource, ADest: TIdInAddr; const APayload : TIdBytes; var VBuffer : TIdBytes; const AIdx : Integer = 0): boolean;

// RIP
function IdRawBuildRip(const ACommand, AVersion: byte;
  const ARoutingDomain, AnAddressFamily, ARoutingTag: word;
  const AnAddr, AMask, ANextHop, AMetric: longword;
  const APayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
// TCP
function IdRawBuildTcp(const ASourcePort, ADestPort: word;
  const ASeq, AnAck: longword;
  const AControl: byte;
  const AWindowSize, AnUrgent: word;
  const APayload  : TIdBytes;
  var VBuffer : TIdBytes): boolean;

// UDP
function IdRawBuildUdp(const ASourcePort, ADestPort: word;
  const APayload :TIdBytes;
  var VBuffer :TIdBytes): boolean;
  
implementation
 uses IdSys;

function IdRawBuildArp(const AHwAddressFormat, AProtocolFormat: word;
  const AHwAddressLen, AProtocolLen: byte;
  const AnOpType: word;
  ASenderHw: TIdEtherAddr;
  ASenderPr: TIdInAddr;
  ATargetHw: TIdEtherAddr;
  ATargetPr: TIdInAddr;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
var
  HdrArp: TIdArpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input

  LIdx := Id_ARP_HSIZE + Length(VBuffer);
    if Length(VBuffer)<LIdx then
    begin
      SetLength(VBuffer,LIdx);
    end;
  // construct header
  HdrArp:= TIdArpHdr.Create;
  try
    HdrArp.arp_hrd := GStack.HostToNetwork(AHwAddressFormat);
    HdrArp.arp_pro := GStack.HostToNetwork(AProtocolFormat);
    HdrArp.arp_hln := AHwAddressLen;
    HdrArp.arp_pln := AProtocolLen;
    HdrArp.arp_op  := GStack.HostToNetwork(AnOpType);
    HdrArp.arp_sha.CopyFrom(ASenderHw);
    HdrArp.arp_spa.s_l := ASenderPr.s_l;
    HdrArp.arp_tha.CopyFrom(ATargetHw);
    HdrArp.arp_tpa.CopyFrom(ATargetPr);

  // copy payload
    if  (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer,Id_ICMP_ECHO_HSIZE,Length(APayload));
    end;

  // copy header
    LIdx := 0;
    HdrArp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrArp);
  end;
  Result := TRUE;
end;

function IdRawBuildDns(const AnId, AFlags, ANumQuestions, ANumAnswerRecs, ANumAuthRecs, ANumAddRecs: word;
  const APayload : TIdBytes;
  var VBuffer : TIdBytes) : boolean;
var
  HdrDns: TIdDnsHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
    LIdx := Length(APayload) +Id_DNS_HSIZE;
    if Length(VBuffer)<LIdx then
    begin
      SetLength(VBuffer,LIdx);
    end;

  // construct header
  HdrDns:= TIdDnsHdr.Create;
  try
    HdrDns.dns_id          := GStack.HostToNetwork(AnId);

    HdrDns.dns_flags       := GStack.HostToNetwork(AFlags);

    HdrDns.dns_num_q       := GStack.HostToNetwork(ANumQuestions);

    HdrDns.dns_num_answ_rr := GStack.HostToNetwork(ANumAnswerRecs);
    HdrDns.dns_num_auth_rr := GStack.HostToNetwork(ANumAuthRecs);

    HdrDns.dns_num_addi_rr := GStack.HostToNetwork(ANumAddRecs);

  // copy payload
    if Length(APayload)>0 then
    begin
      CopyTIdBytes(APayload,0,VBuffer,Id_DNS_HSIZE,Length(APayload));
    end;
  // copy header
    LIdx := 0;
    HdrDns.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrDns);
  end;
  Result := TRUE;
end;

function IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: word;
  const APayload : TIdBytes;  var VBuffer : TIdBytes): boolean;
var
  HdrEth: TIdEthernetHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;
  HdrEth:= TIdEthernetHdr.create;
  try
  // make sure VBuffer will be long enough
    LIdx := Length(ASource.Data)+ Length(ADest.Data)+2+Length(APayload);
    if Length(VBuffer)<LIdx then
    begin
      SetLength(VBuffer,LIdx);
    end;
    // construct header
    HdrEth.ether_dhost.CopyFrom(ADest);
   // Move(ADest, HdrEth.ether_dhost, Id_ETHER_ADDR_LEN);
    HdrEth.ether_shost.CopyFrom(ASource);
    //  Move(ASource, HdrEth.ether_shost, Id_ETHER_ADDR_LEN);
    HdrEth.ether_type := GStack.HostToNetwork(AType);

    // copy header
    LIdx := 0;
   // Move(HdrEth, ABuffer, sizeof(HdrEth));
    HdrEth.WriteStruct(VBuffer,LIdx);
     // copy payload if present
    if Length(APayload)>0 then
    begin
      CopyTIdBytes(APayload,0,VBuffer,LIdx,Length(APayload));
    end;
  finally
    Sys.FreeAndNil(HdrEth);
  end;
  Result := TRUE;
end;

// TODO: check nibbles in IP header
function IdRawBuildIp(ALen: word; ATos: byte; AnId, AFrag: word; ATtl, AProtocol: byte;
  ASource, ADest: TIdInAddr; const APayload : TIdBytes; var VBuffer : TIdBytes; const AIdx : Integer = 0): boolean;
var
  HdrIp: TIdIpHdr;
   LIdx : Integer;
begin
  // init result
  Result := FALSE;
  HdrIp :=  TIdIpHdr.create;
  // check input
  try
    LIdx := Id_IP_HSIZE+Length(APayload)+AIdx;
    if Length(VBuffer)<LIdx then
    begin
      SetLength(VBuffer,LIdx);
    end;
    // construct header
    HdrIp.ip_verlen := (4 shl 4) + (Id_IP_HSIZE div 4);     // IPv4 shl 4, 20 bytes div 4
    HdrIp.ip_tos    := ATos;
    HdrIp.ip_len    := GStack.HostToNetwork(Id_IP_HSIZE + ALen);
    HdrIp.ip_id     := GStack.HostToNetwork(AnId);
    HdrIp.ip_off    := GStack.HostToNetwork(AFrag);
    HdrIp.ip_ttl    := ATtl;
    HdrIp.ip_p      := AProtocol;
    HdrIp.ip_sum    := 0;                                     // do checksum later
    HdrIp.ip_src.CopyFrom( ASource );
    HdrIp.ip_dst.CopyFrom( ADest );

   //copy header
    LIdx := AIdx;
    HdrIp.WriteStruct(VBuffer,LIdx);
  // copy payload
    if Length(APayload)>0 then
    begin
      CopyTIdBytes(APayload,0,VBuffer,LIdx,Length(APayload));
    end;
  finally
    Sys.FreeANdNil(HdrIp);
  end;

  Result := TRUE;
end;

function IdRawBuildIcmpEcho(AType, ACode: byte; AnId, ASeq: word;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
   LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  if Length(VBuffer)<Id_ICMP_ECHO_HSIZE+Length(APayload) then
  begin
      SetLength(VBuffer,Id_ICMP_ECHO_HSIZE+Length(APayload));
  end;
  HdrIcmp:= TIdIcmpHdr.Create;
  try
    // construct header
    HdrIcmp.icmp_type := AType;
    HdrIcmp.icmp_code := ACode;
    HdrIcmp.icmp_hun.echo_id := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq := GStack.HostToNetwork(ASeq);

  // copy payload

    if  (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer,Id_ICMP_ECHO_HSIZE,Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIcmpMask(AType, ACode: byte; AnId, ASeq: word; AMask: longword;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  if Length(VBuffer)<Id_ICMP_ECHO_HSIZE+Length(APayload) then
  begin
      SetLength(VBuffer,Id_ICMP_ECHO_HSIZE+Length(APayload));
  end;

  // construct header
  HdrIcmp:= TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type := AType;
    HdrIcmp.icmp_code := ACode;
    HdrIcmp.icmp_hun.echo_id := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq := GStack.HostToNetwork(ASeq);
    HdrIcmp.icmp_dun.mask := GStack.HostToNetwork(AMask);

  // copy payload
    if  (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer, Id_ICMP_MASK_HSIZE,Length(APayload));
    end;
    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeANdNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIcmpUnreach(AType, ACode: byte;
  AnOrigLen: word;
  AnOrigTos: byte;
  AnOrigId, AnOrigFrag: word;
  AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload, APayloadSize: integer;
  var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
 if Length(VBuffer)<Id_ICMP_UNREACH_HSIZE+Id_IP_HSIZE+2 then
  begin
      SetLength(VBuffer,Id_ICMP_UNREACH_HSIZE+Id_IP_HSIZE+2);
  end;
  // construct header
  HdrIcmp:= TIdIcmpHdr.create;
  try
    HdrIcmp.icmp_type := AType;
    HdrIcmp.icmp_code := ACode;
    HdrIcmp.icmp_hun.echo_id := 0;
    HdrIcmp.icmp_hun.echo_seq := 0;

  // attach original header
  IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
    AnOrigSource, AnOrigDest, ToBytes(AnOrigPayload), 
    VBuffer, Id_ICMP_UNREACH_HSIZE);

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIcmpTimeExceed(const AType, ACode: byte;
  const AnOrigLen: word;
  const AnOrigTos: byte;
  const AnOrigId, AnOrigFrag: word;
  const AnOrigTtl: byte;
  const AnOrigProtocol: byte;
  const AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  LIdx := Id_ICMP_TIMEXCEED_HSIZE+Length(AnOrigPayload)+Id_IP_HSIZE;
   if Length(VBuffer)<LIdx then
  begin
      SetLength(VBuffer,LIdx);
  end;

  // construct header
  HdrIcmp:= TIdIcmpHdr.create;
  try
    HdrIcmp.icmp_type := AType;
    HdrIcmp.icmp_code := ACode;
    HdrIcmp.icmp_hun.echo_id := 0;
    HdrIcmp.icmp_hun.echo_seq := 0;

    // attach original header
    LIdx := Id_ICMP_TIMEXCEED_HSIZE;
    IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
      AnOrigSource, AnOrigDest, AnOrigPayload,
      VBuffer,LIdx);

  // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIcmpTimestamp(const AType, ACode: byte;
  const AnId, ASeq: word;
  const AnOtime, AnRtime, ATtime: TIdNetTime;
  const APayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  LIdx := Id_ICMP_UNREACH_HSIZE + Id_IP_HSIZE + Length(APayload);
  if Length(VBuffer)<LIdx then
  begin
      SetLength(VBuffer,LIdx);
  end;

  // construct header
  HdrIcmp:= TIdIcmpHdr.create;
  try
    HdrIcmp.icmp_type             := AType;
    HdrIcmp.icmp_code             := ACode;
    HdrIcmp.icmp_hun.echo_id      := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq     := GStack.HostToNetwork(ASeq);
    HdrIcmp.icmp_dun.ts_otime     := GStack.HostToNetwork(AnOtime);      // original timestamp
    HdrIcmp.icmp_dun.ts_rtime     := GStack.HostToNetwork(AnRtime);      // receive timestamp
    HdrIcmp.icmp_dun.ts_ttime     := GStack.HostToNetwork(ATtime);       // transmit timestamp
    // copy payload
    if (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer, Id_ICMP_TS_HSIZE,Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);

  finally
    Sys.FreeAndNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIcmpRedirect(const AType, ACode: byte;
  AGateway: TIdInAddr;
  const AnOrigLen: word;
  const AnOrigTos: byte;
  const AnOrigId, AnOrigFrag: word;
  const AnOrigTtl, AnOrigProtocol: byte;
  AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload : TIdBytes;
  var VBuffer : TIdBytes): boolean;
var
  HdrIcmp: TIdIcmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  LIdx := Id_ICMP_REDIRECT_HSIZE+Length(AnOrigPayload)+Id_IP_HSIZE;
   if Length(VBuffer)<LIdx then
  begin
      SetLength(VBuffer,LIdx);
  end;


  // construct header
  HdrIcmp:= TIdIcmpHdr.create;
  try
    HdrIcmp.icmp_type           := AType;
    HdrIcmp.icmp_code           := ACode;
    HdrIcmp.icmp_hun.gateway_s_b1 := AGateway.s_l;      // gateway address

    // attach original header
    IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
      AnOrigSource, AnOrigDest, AnOrigPayload,
      VBuffer, Id_ICMP_REDIRECT_HSIZE);

  // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrIcmp);
  end;
  Result := TRUE;
end;

function IdRawBuildIgmp(AType, ACode: byte;
  AnIp: TIdInAddr;
  const APayload, APayloadSize: integer;
  var VBuffer : TIdBytes): boolean;
var
  HdrIgmp: TIdIgmpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
   LIdx := 2+Id_IGMP_HSIZE;
   if Length(VBuffer)<LIdx then
  begin
      SetLength(VBuffer,LIdx);
  end;

  // construct header
  HdrIgmp:= TIdIgmpHdr.create;
  try
    HdrIgmp.igmp_type         := AType;
    HdrIgmp.igmp_code         := ACode;
    HdrIgmp.igmp_sum          := 0;
    HdrIgmp.igmp_group.s_l    := AnIp.s_l;      // group address or 0

  // copy payload

      CopyTIdWord(APayload,VBuffer, Id_IGMP_HSIZE);


    // copy header
    LIdx := 0;
    HdrIgmp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrIgmp);
  end;
  Result := TRUE;
end;

function IdRawBuildRip(const ACommand, AVersion: byte;
  const ARoutingDomain, AnAddressFamily, ARoutingTag: word;
  const AnAddr, AMask, ANextHop, AMetric: longword;
  const APayload : TIdBytes; var VBuffer : TIdBytes): boolean;
var
  HdrRip: TIdRipHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input

   LIdx := Id_RIP_HSIZE+Length(APayload);
   if Length(VBuffer)<LIdx then
  begin
      SetLength(VBuffer,LIdx);
  end;
  // construct header
  HdrRip:= TIdRipHdr.create;
  try
    HdrRip.rip_cmd      := ACommand;
    HdrRip.rip_ver      := AVersion;
    HdrRip.rip_rd       := GStack.HostToNetwork(ARoutingDomain);
    HdrRip.rip_af       := GStack.HostToNetwork(AnAddressFamily);
    HdrRip.rip_rt       := GStack.HostToNetwork(ARoutingTag);
    HdrRip.rip_addr     := GStack.HostToNetwork(AnAddr);
    HdrRip.rip_mask     := GStack.HostToNetwork(AMask);
    HdrRip.rip_next_hop := GStack.HostToNetwork(ANextHop);
    HdrRip.rip_metric   := GStack.HostToNetwork(AMetric);

    // copy payload
    if (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer, Id_RIP_HSIZE,Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrRip.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrRip);
  end;
  Result := TRUE;
end;

// TODO: check nibbles in TCP header
function IdRawBuildTcp(const ASourcePort, ADestPort: word;
  const ASeq, AnAck: longword;
  const AControl: byte;
  const AWindowSize, AnUrgent: word;
  const APayload  : TIdBytes;
  var VBuffer : TIdBytes): boolean;
var
  HdrTcp: TIdTcpHdr;
  LIdx : Integer;
begin
  // init result
  Result := FALSE;

  // check input
  LIdx := Id_TCP_HSIZE + Length(VBuffer);
  if Length(VBuffer)<LIdx then
  begin
    SetLength(VBuffer,LIdx);
  end;

  // construct header
  HdrTcp:= TIdTcpHdr.create;
  try
    HdrTcp.tcp_sport    := GStack.HostToNetwork(ASourcePort);
    HdrTcp.tcp_dport    := GStack.HostToNetwork(ADestPort);
    HdrTcp.tcp_seq      := GStack.HostToNetwork(ASeq);
    HdrTcp.tcp_ack      := GStack.HostToNetwork(AnAck);                // acknowledgement number
    HdrTcp.tcp_flags    := AControl;                              // control flags
    HdrTcp.tcp_x2off    := ((Id_TCP_HSIZE div 4) shl 4) + 0;      // 20 bytes div 4, x2 unused
    HdrTcp.tcp_win      := GStack.HostToNetwork(AWindowSize);          // window size
    HdrTcp.tcp_sum      := 0;
    HdrTcp.tcp_urp      := AnUrgent;                              // urgent pointer

  // copy payload
    if (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer, Id_TCP_HSIZE,Length(APayload));
    end;

  // copy header
    LIdx := 0;
    HdrTcp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrTcp);
  end;
  Result := TRUE;
end;

function IdRawBuildUdp(const ASourcePort, ADestPort: word;
  const APayload :TIdBytes;
  var VBuffer :TIdBytes): boolean;
var
  HdrUdp: TIdUdpHdr;
  LIdx : Integer;
begin
  Result := FALSE;

  // check input
  LIdx := Id_UDP_HSIZE + Length(APayload);
  if Length(VBuffer)< Lidx then
  begin
    SetLength(VBuffer,LIdx);
  end;

  // construct header
  HdrUdp:= TIdUdpHdr.create;
  try
    HdrUdp.udp_dport    := GStack.HostToNetwork(ASourcePort);
    HdrUdp.udp_dport    := GStack.HostToNetwork(ADestPort);
    //LIdx should be okay here since we set that to the packet length earlier
    HdrUdp.udp_ulen     := GStack.HostToNetwork(LIdx);
    HdrUdp.udp_sum      := 0;

  // copy payload
    if (Length(APayload) > 0) then
    begin
      CopyTIdBytes(APayload,0,VBuffer, Id_UDP_HSIZE,Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrUdp.WriteStruct(VBuffer,LIdx);
  finally
    Sys.FreeAndNil(HdrUdp);
  end;
  Result := TRUE;
end;


end.
