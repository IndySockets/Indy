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
  Rev 1.5    2004.02.03 4:16:50 PM  czhower
  For unit name changes.

  Rev 1.4    2/1/2004 4:52:30 PM  JPMugaas
  Removed the rest of the Todo; items.

  Rev 1.3    2/1/2004 4:20:30 PM  JPMugaas
  Should work in Win32.  TODO: See about DotNET.

  Rev 1.2    2003.10.11 5:49:06 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.1    2003.09.30 1:23:00 PM  czhower
  Stack split for DotNet

  Rev 1.0    11/13/2002 08:45:36 AM  JPMugaas
}

unit IdRawFunctions;

interface

{$i IdCompilerDefines.inc}

uses
   IdGlobal, IdRawHeaders, IdStack;

// ARP
procedure IdRawBuildArp(const AHwAddressFormat, AProtocolFormat: Word;
  const AHwAddressLen, AProtocolLen: Byte; const AnOpType: Word;
  ASenderHw: TIdEtherAddr; ASenderPr: TIdInAddr; ATargetHw: TIdEtherAddr;
  ATargetPr: TIdInAddr; const APayload: TIdBytes; var VBuffer: TIdBytes);

// DNS
procedure IdRawBuildDns(const AnId, AFlags, ANumQuestions, ANumAnswerRecs, ANumAuthRecs, ANumAddRecs: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);

// Ethernet
procedure IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);

// ICMP
procedure IdRawBuildIcmpEcho(AType, ACode: Byte; AnId, ASeq: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
procedure IdRawBuildIcmpMask(AType, ACode: Byte; AnId, ASeq: Word; AMask: LongWord;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
procedure IdRawBuildIcmpRedirect(const AType, ACode: Byte; AGateway: TIdInAddr;
  const AnOrigLen: Word; const AnOrigTos: Byte; const AnOrigId, AnOrigFrag: Word;
  const AnOrigTtl, AnOrigProtocol: Byte; AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload: TIdBytes; var VBuffer: TIdBytes);
procedure IdRawBuildIcmpTimeExceed(const AType, ACode: Byte; const AnOrigLen: Word;
  const AnOrigTos: Byte; const AnOrigId, AnOrigFrag: Word;
  const AnOrigTtl, AnOrigProtocol: Byte; const AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload: TIdBytes; var VBuffer: TIdBytes);
procedure IdRawBuildIcmpTimestamp(const AType, ACode: Byte; const AnId, ASeq: Word;
  const AnOtime, AnRtime, ATtime: TIdNetTime; const APayload: TIdBytes;
  var VBuffer: TIdBytes);
procedure IdRawBuildIcmpUnreach(AType, ACode: Byte; AnOrigLen: Word;
  AnOrigTos: Byte; AnOrigId, AnOrigFrag: Word;  AnOrigTtl, AnOrigProtocol: Byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload, APayloadSize: Integer;
  var VBuffer: TIdBytes);

// IGMP
procedure IdRawBuildIgmp(AType, ACode: Byte; AnIp: TIdInAddr;
  const APayload: Word; var VBuffer: TIdBytes);

// IP
procedure IdRawBuildIp(ALen: Word; ATos: Byte; AnId, AFrag: Word;
  ATtl, AProtocol: Byte; ASource, ADest: TIdInAddr; const APayload: TIdBytes;
  var VBuffer: TIdBytes; const AIdx: Integer = 0);

// RIP
procedure IdRawBuildRip(const ACommand, AVersion: Byte;
  const ARoutingDomain, AnAddressFamily, ARoutingTag: Word;
  const AnAddr, AMask, ANextHop, AMetric: LongWord;
  const APayload: TIdBytes; var VBuffer: TIdBytes);

// TCP
procedure IdRawBuildTcp(const ASourcePort, ADestPort: Word;
  const ASeq, AnAck: LongWord; const AControl: Byte;
  const AWindowSize, AnUrgent: Word; const APayload: TIdBytes;
  var VBuffer: TIdBytes);

// UDP
procedure IdRawBuildUdp(const ASourcePort, ADestPort: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);

implementation

uses
  SysUtils;

procedure IdRawBuildArp(const AHwAddressFormat, AProtocolFormat: Word;
  const AHwAddressLen, AProtocolLen: Byte; const AnOpType: Word;
  ASenderHw: TIdEtherAddr; ASenderPr: TIdInAddr; ATargetHw: TIdEtherAddr;
  ATargetPr: TIdInAddr; const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrArp: TIdArpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ARP_HSIZE + Length(VBuffer);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrArp := TIdArpHdr.Create;
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
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_ICMP_ECHO_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrArp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrArp);
  end;
end;

procedure IdRawBuildDns(const AnId, AFlags, ANumQuestions, ANumAnswerRecs,
  ANumAuthRecs, ANumAddRecs: Word; const APayload: TIdBytes;
  var VBuffer: TIdBytes);
var
  HdrDns: TIdDnsHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Length(APayload) + Id_DNS_HSIZE;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrDns := TIdDnsHdr.Create;
  try
    HdrDns.dns_id          := GStack.HostToNetwork(AnId);
    HdrDns.dns_flags       := GStack.HostToNetwork(AFlags);
    HdrDns.dns_num_q       := GStack.HostToNetwork(ANumQuestions);
    HdrDns.dns_num_answ_rr := GStack.HostToNetwork(ANumAnswerRecs);
    HdrDns.dns_num_auth_rr := GStack.HostToNetwork(ANumAuthRecs);
    HdrDns.dns_num_addi_rr := GStack.HostToNetwork(ANumAddRecs);

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_DNS_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrDns.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrDns);
  end;
end;

procedure IdRawBuildEthernet(ADest, ASource: TIdEtherAddr; AType: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrEth: TIdEthernetHdr;
  LIdx: Integer;
begin
  // make sure VBuffer will be long enough
  LIdx := Length(ASource.Data) + Length(ADest.Data) + 2 + Length(APayload);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrEth := TIdEthernetHdr.Create;
  try
    HdrEth.ether_dhost.CopyFrom(ADest);
    HdrEth.ether_shost.CopyFrom(ASource);
    HdrEth.ether_type := GStack.HostToNetwork(AType);

    // copy header
    LIdx := 0;
    HdrEth.WriteStruct(VBuffer, LIdx);

    // copy payload if present
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, LIdx, Length(APayload));
    end;
  finally
    FreeAndNil(HdrEth);
  end;
end;

// TODO: check nibbles in IP header
procedure IdRawBuildIp(ALen: Word; ATos: Byte; AnId, AFrag: Word; ATtl, AProtocol: Byte;
  ASource, ADest: TIdInAddr; const APayload: TIdBytes; var VBuffer: TIdBytes;
  const AIdx: Integer = 0);
var
  HdrIp: TIdIpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_IP_HSIZE + Length(APayload) + AIdx;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIp := TIdIpHdr.Create;
  try
    HdrIp.ip_verlen := (4 shl 4) + (Id_IP_HSIZE div 4);     // IPv4 shl 4, 20 bytes div 4
    HdrIp.ip_tos    := ATos;
    HdrIp.ip_len    := GStack.HostToNetwork(Id_IP_HSIZE + ALen);
    HdrIp.ip_id     := GStack.HostToNetwork(AnId);
    HdrIp.ip_off    := GStack.HostToNetwork(AFrag);
    HdrIp.ip_ttl    := ATtl;
    HdrIp.ip_p      := AProtocol;
    HdrIp.ip_sum    := 0;                                     // do checksum later
    HdrIp.ip_src.CopyFrom(ASource);
    HdrIp.ip_dst.CopyFrom(ADest);

    // copy header
    LIdx := AIdx;
    HdrIp.WriteStruct(VBuffer, LIdx);

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, LIdx, Length(APayload));
    end;
  finally
    FreeANdNil(HdrIp);
  end;
end;

procedure IdRawBuildIcmpEcho(AType, ACode: Byte; AnId, ASeq: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_ECHO_HSIZE + Length(APayload);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type := AType;
    HdrIcmp.icmp_code := ACode;
    HdrIcmp.icmp_hun.echo_id := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq := GStack.HostToNetwork(ASeq);

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_ICMP_ECHO_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIcmpMask(AType, ACode: Byte; AnId, ASeq: Word; AMask: LongWord;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_ECHO_HSIZE + Length(APayload);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type         := AType;
    HdrIcmp.icmp_code         := ACode;
    HdrIcmp.icmp_hun.echo_id  := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq := GStack.HostToNetwork(ASeq);
    HdrIcmp.icmp_dun.mask     := GStack.HostToNetwork(AMask);

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_ICMP_MASK_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIcmpUnreach(AType, ACode: Byte; AnOrigLen: Word;
  AnOrigTos: Byte; AnOrigId, AnOrigFrag: Word; AnOrigTtl, AnOrigProtocol: Byte;
  AnOrigSource, AnOrigDest: TIdInAddr; const AnOrigPayload, APayloadSize: Integer;
  var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_UNREACH_HSIZE + Id_IP_HSIZE + 2;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type         := AType;
    HdrIcmp.icmp_code         := ACode;
    HdrIcmp.icmp_hun.echo_id  := 0;
    HdrIcmp.icmp_hun.echo_seq := 0;

    // attach original header
    IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
      AnOrigSource, AnOrigDest, ToBytes(AnOrigPayload), VBuffer, Id_ICMP_UNREACH_HSIZE);

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIcmpTimeExceed(const AType, ACode: Byte; const AnOrigLen: Word;
  const AnOrigTos: Byte; const AnOrigId, AnOrigFrag: Word;
  const AnOrigTtl, AnOrigProtocol: Byte; const AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_TIMEXCEED_HSIZE + Length(AnOrigPayload) + Id_IP_HSIZE;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type         := AType;
    HdrIcmp.icmp_code         := ACode;
    HdrIcmp.icmp_hun.echo_id  := 0;
    HdrIcmp.icmp_hun.echo_seq := 0;

    // attach original header
    IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
      AnOrigSource, AnOrigDest, AnOrigPayload, VBuffer, Id_ICMP_TIMEXCEED_HSIZE);

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIcmpTimestamp(const AType, ACode: Byte; const AnId, ASeq: Word;
  const AnOtime, AnRtime, ATtime: TIdNetTime; const APayload: TIdBytes;
  var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_UNREACH_HSIZE + Id_IP_HSIZE + Length(APayload);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type             := AType;
    HdrIcmp.icmp_code             := ACode;
    HdrIcmp.icmp_hun.echo_id      := GStack.HostToNetwork(AnId);
    HdrIcmp.icmp_hun.echo_seq     := GStack.HostToNetwork(ASeq);
    HdrIcmp.icmp_dun.ts_otime     := GStack.HostToNetwork(AnOtime);      // original timestamp
    HdrIcmp.icmp_dun.ts_rtime     := GStack.HostToNetwork(AnRtime);      // receive timestamp
    HdrIcmp.icmp_dun.ts_ttime     := GStack.HostToNetwork(ATtime);       // transmit timestamp

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_ICMP_TS_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIcmpRedirect(const AType, ACode: Byte; AGateway: TIdInAddr;
  const AnOrigLen: Word; const AnOrigTos: Byte; const AnOrigId, AnOrigFrag: Word;
  const AnOrigTtl, AnOrigProtocol: Byte; AnOrigSource, AnOrigDest: TIdInAddr;
  const AnOrigPayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrIcmp: TIdIcmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_ICMP_REDIRECT_HSIZE + Length(AnOrigPayload) + Id_IP_HSIZE;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIcmp := TIdIcmpHdr.Create;
  try
    HdrIcmp.icmp_type             := AType;
    HdrIcmp.icmp_code             := ACode;
    HdrIcmp.icmp_hun.gateway_s_b1 := AGateway.s_l;      // gateway address

    // attach original header
    IdRawBuildIp(0, AnOrigTos, AnOrigId, AnOrigFrag, AnOrigTtl, AnOrigProtocol,
      AnOrigSource, AnOrigDest, AnOrigPayload, VBuffer, Id_ICMP_REDIRECT_HSIZE);

    // copy header
    LIdx := 0;
    HdrIcmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIcmp);
  end;
end;

procedure IdRawBuildIgmp(AType, ACode: Byte; AnIp: TIdInAddr;
  const APayload: Word; var VBuffer: TIdBytes);
var
  HdrIgmp: TIdIgmpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := 2 + Id_IGMP_HSIZE;
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrIgmp := TIdIgmpHdr.Create;
  try
    HdrIgmp.igmp_type         := AType;
    HdrIgmp.igmp_code         := ACode;
    HdrIgmp.igmp_sum          := 0;
    HdrIgmp.igmp_group.s_l    := AnIp.s_l;      // group address or 0

    // copy payload
    CopyTIdWord(APayload, VBuffer, Id_IGMP_HSIZE);

    // copy header
    LIdx := 0;
    HdrIgmp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrIgmp);
  end;
end;

procedure IdRawBuildRip(const ACommand, AVersion: Byte;
  const ARoutingDomain, AnAddressFamily, ARoutingTag: Word;
  const AnAddr, AMask, ANextHop, AMetric: LongWord;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrRip: TIdRipHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_RIP_HSIZE + Length(APayload);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrRip := TIdRipHdr.Create;
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
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_RIP_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrRip.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrRip);
  end;
end;

// TODO: check nibbles in TCP header
procedure IdRawBuildTcp(const ASourcePort, ADestPort: Word;
  const ASeq, AnAck: LongWord; const AControl: Byte;
  const AWindowSize, AnUrgent: Word; const APayload: TIdBytes;
  var VBuffer: TIdBytes);
var
  HdrTcp: TIdTcpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_TCP_HSIZE + Length(VBuffer);
  if Length(VBuffer) < LIdx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrTcp := TIdTcpHdr.Create;
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
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_TCP_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrTcp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrTcp);
  end;
end;

procedure IdRawBuildUdp(const ASourcePort, ADestPort: Word;
  const APayload: TIdBytes; var VBuffer: TIdBytes);
var
  HdrUdp: TIdUdpHdr;
  LIdx: Integer;
begin
  // check input
  LIdx := Id_UDP_HSIZE + Length(APayload);
  if Length(VBuffer) < Lidx then begin
    SetLength(VBuffer, LIdx);
  end;

  // construct header
  HdrUdp := TIdUdpHdr.Create;
  try
    HdrUdp.udp_dport    := GStack.HostToNetwork(ASourcePort);
    HdrUdp.udp_dport    := GStack.HostToNetwork(ADestPort);
    //LIdx should be okay here since we set that to the packet length earlier
    HdrUdp.udp_ulen     := GStack.HostToNetwork(LIdx);
    HdrUdp.udp_sum      := 0;

    // copy payload
    if Length(APayload) > 0 then begin
      CopyTIdBytes(APayload, 0, VBuffer, Id_UDP_HSIZE, Length(APayload));
    end;

    // copy header
    LIdx := 0;
    HdrUdp.WriteStruct(VBuffer, LIdx);
  finally
    FreeAndNil(HdrUdp);
  end;
end;

end.
