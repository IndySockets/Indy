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
  Rev 1.8    2004-04-25 12:08:24  Mattias
  Fixed multithreading issue

  Rev 1.7    2004.02.03 4:16:42 PM  czhower
  For unit name changes.

  Rev 1.6    2/1/2004 4:53:30 PM  JPMugaas
  Removed Todo;

  Rev 1.5    2004.01.20 10:03:24 PM  czhower
  InitComponent

  Rev 1.4    2003.12.31 10:37:54 PM  czhower
  GetTickcount --> Ticks

  Rev 1.3    10/16/2003 11:06:14 PM  SPerry
  Moved ICMP_MIN to IdRawHeaders

  Rev 1.2    2003.10.11 5:48:04 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.1    2003.09.30 1:22:56 PM  czhower
  Stack split for DotNet

  Rev 1.0    11/13/2002 08:44:30 AM  JPMugaas

  25/1/02: SGrobety:
  Modified the component to support multithreaded PING and traceroute
  NOTE!!!
  The component no longer use the timing informations contained
  in the packet to compute the roundtrip time. This is because
  that information is only correctly set in case of ECHOREPLY
  In case of TTL, it is incorrect.
}

unit IdIcmpClient;

{
  Note that we can NOT remove the DotNET IFDEFS from this unit.   The reason is
  that Microsoft NET Framework 1.1 does not support ICMPv6 and that's required
  for IPv6.  In Win32 and Linux, we definately can and want to support IPv6.

  If we support a later version of the NET framework that has a better API, I may
  consider revisiting this.
}

{$I IdCompilerDefines.inc}

interface

uses
  IdGlobal,
  IdObjs,
  IdRawBase,
  IdRawClient,
  IdStackConsts,
  IdBaseComponent,
  IdSys;

const
  DEF_PACKET_SIZE = 32;
  MAX_PACKET_SIZE = 1024;
  iDEFAULTPACKETSIZE = 128;
  iDEFAULTREPLYBUFSIZE = 1024;
  Id_TIDICMP_ReceiveTimeout = 5000;

type
  TReplyStatusTypes = (rsEcho,
    rsError, rsTimeOut, rsErrorUnreachable,
    rsErrorTTLExceeded,rsErrorPacketTooBig,
    rsErrorParameter,
    rsErrorDatagramConversion,
    rsErrorSecurityFailure,
    rsSourceQuench,
    rsRedirect,
    rsTimeStamp,
    rsInfoRequest,
    rsAddressMaskRequest,
    rsTraceRoute,
    rsMobileHostReg,
    rsMobileHostRedir,
    rsIPv6WhereAreYou,
    rsIPv6IAmHere,
    rsSKIP);

  TReplyStatus = class(TObject)
  protected
    FBytesReceived: integer; // number of bytes in reply from host
    FFromIpAddress: string;  // IP address of replying host
    FToIpAddress : string;   //who receives it (i.e., us.  This is for multihorned machines
    FMsgType: byte;
    FMsgCode : Byte;
    FSequenceId: word;       // sequence id of ping reply
    // TODO: roundtrip time in ping reply should be float, not byte
    FMsRoundTripTime: longword; // ping round trip time in milliseconds
    FTimeToLive: byte;       // time to live
    FReplyStatusType: TReplyStatusTypes;
    FPacketNumber : Integer;//number in packet for TraceRoute
    FHostName : String; //Hostname of computer that replied, used with TraceRoute
    FMsg : String;
    FRedirectTo : String; // valid only for rsRedirect
  public
    property RedirectTo : String read FRedirectTo write FRedirectTo;
    property Msg : String read FMsg write FMsg;
    property BytesReceived: integer read FBytesReceived write FBytesReceived; // number of bytes in reply from host
    property FromIpAddress: string read FFromIpAddress write FFromIpAddress;  // IP address of replying host
    property ToIpAddress : string read FToIpAddress write FToIpAddress;   //who receives it (i.e., us.  This is for multihorned machines
    property MsgType: byte read FMsgType write FMsgType;
    property MsgCode : Byte read FMsgCode write FMsgCode;
    property SequenceId: word read FSequenceId write FSequenceId;       // sequence id of ping reply
    // TODO: roundtrip time in ping reply should be float, not byte
    property MsRoundTripTime: longword read FMsRoundTripTime write FMsRoundTripTime; // ping round trip time in milliseconds
    property TimeToLive: byte read FTimeToLive write FTimeToLive;       // time to live
    property ReplyStatusType: TReplyStatusTypes read FReplyStatusType write FReplyStatusType;
    property HostName : String read FHostName write FHostName;
    property PacketNumber : Integer read FPacketNumber write FPacketNumber;
  end;

  TOnReplyEvent = procedure(ASender: TIdNativeComponent; const AReplyStatus: TReplyStatus) of object;

  TIdCustomIcmpClient = class(TIdRawClient)
  protected
    FStartTime : Cardinal; //this is a fallabk if no packet is returned
    FPacketSize : Integer;
    FbufReceive: TIdBytes;
    FbufIcmp: TIdBytes;
    wSeqNo: word;
    iDataSize: integer;
    FReplyStatus: TReplyStatus;
    FOnReply: TOnReplyEvent;
    FReplydata: String;
    //
    {$IFNDEF DOTNET}
    function DecodeIPv6Packet(BytesRead: Cardinal; var AReplyStatus: TReplyStatus): boolean;
    {$ENDIF}
    function DecodeIPv4Packet(BytesRead: Cardinal; var AReplyStatus: TReplyStatus): boolean;

    function DecodeResponse(BytesRead: Cardinal; var AReplyStatus: TReplyStatus): boolean;
    procedure DoReply(const AReplyStatus: TReplyStatus); virtual;
    procedure GetEchoReply;
    procedure InitComponent; override;
    {$IFNDEF DOTNET}
    procedure PrepareEchoRequestIPv6(Buffer: String);
    {$ENDIF}
    procedure PrepareEchoRequestIPv4(Buffer : String='');
    procedure PrepareEchoRequest(Buffer: string = '');    {Do not Localize}
    procedure SendEchoRequest;   overload;
    procedure SendEchoRequest(const AIP : String); overload;
    function GetPacketSize: Integer;
    procedure SetPacketSize(const AValue: Integer);

    //these are made public in the client
    procedure InternalPing(const AIP : String; const ABuffer: String = ''; SequenceID: Word = 0); overload; {Do not Localize}
    //
    property PacketSize : Integer read GetPacketSize write SetPacketSize;
    property ReplyData: string read FReplydata;
    property ReplyStatus: TReplyStatus read FReplyStatus;

  public
    destructor Destroy; override;
    procedure Send(const AHost: string; const APort: integer; const ABuffer : TIdBytes); override;
    procedure Send(const ABuffer : TIdBytes); override;
    function Receive(ATimeOut: Integer): TReplyStatus;
  end;

  TIdIcmpClient = class(TIdCustomIcmpClient)
  public
    procedure Ping(const ABuffer: String = ''; SequenceID: Word = 0);    {Do not Localize}
    property ReplyData;
    property ReplyStatus;
  published
    property Host;
    {$IFNDEF DOTNET}
    property IPVersion;
    {$ENDIF}
    property PacketSize;
    property ReceiveTimeout default Id_TIDICMP_ReceiveTimeout;
    property OnReply: TOnReplyEvent read FOnReply write FOnReply;
  end;

implementation

uses
  IdExceptionCore, IdRawHeaders, IdResourceStringsCore,
  IdStack;

resourcestring
  RSICMPTimeout = 'Timeout';
//Destination Address -3
  RSICMPNetUnreachable  = 'net unreachable;';
  RSICMPHostUnreachable = 'host unreachable;';
  RSICMPProtUnreachable = 'protocol unreachable;';
  RSICMPPortUnreachable = 'Port Unreachable';
  RSICMPFragmentNeeded = 'Fragmentation Needed and Don''t Fragment was Set';
  RSICMPSourceRouteFailed = 'Source Route Failed';
  RSICMPDestNetUnknown = 'Destination Network Unknown';
  RSICMPDestHostUnknown = 'Destination Host Unknown';
  RSICMPSourceIsolated = 'Source Host Isolated';
  RSICMPDestNetProhibitted = 'Communication with Destination Network is Administratively Prohibited';
  RSICMPDestHostProhibitted = 'Communication with Destination Host is Administratively Prohibited';
  RSICMPTOSNetUnreach =  'Destination Network Unreachable for Type of Service';
  RSICMPTOSHostUnreach = 'Destination Host Unreachable for Type of Service';
  RSICMPAdminProhibitted = 'Communication Administratively Prohibited';
  RSICMPHostPrecViolation = 'Host Precedence Violation';
  RSICMPPrecedenceCutoffInEffect =  'Precedence cutoff in effect';
//for IPv6
  RSICMPNoRouteToDest = 'no route to destination';
  RSICMPAAdminDestProhibitted =  'communication with destination administratively prohibited';
  RSICMPSourceFilterFailed = 'source address failed ingress/egress policy';
  RSICMPRejectRoutToDest = 'reject route to destination';
  // Destination Address - 11
  RSICMPTTLExceeded     = 'time to live exceeded in transit';
  RSICMPHopLimitExceeded = 'hop limit exceeded in transit';
  RSICMPFragAsmExceeded = 'fragment reassembly time exceeded.';
//Parameter Problem - 12
  RSICMPParamError      = 'Parameter Problem (offset %d)';
  //IPv6
  RSICMPParamHeader = 'erroneous header field encountered (offset %d)';
  RSICMPParamNextHeader = 'unrecognized Next Header type encountered (offset %d)';
  RSICMPUnrecognizedOpt = 'unrecognized IPv6 option encountered (offset %d)';
//Source Quench Message -4
  RSICMPSourceQuenchMsg = 'Source Quench Message';
//Redirect Message
  RSICMPRedirNet =        'Redirect datagrams for the Network.';
  RSICMPRedirHost =       'Redirect datagrams for the Host.';
  RSICMPRedirTOSNet =     'Redirect datagrams for the Type of Service and Network.';
  RSICMPRedirTOSHost =    'Redirect datagrams for the Type of Service and Host.';
//echo
  RSICMPEcho = 'Echo';
//timestamp
  RSICMPTimeStamp = 'Timestamp';
//information request
  RSICMPInfoRequest = 'Information Request';
//mask request
  RSICMPMaskRequest = 'Address Mask Request';
// Traceroute
  RSICMPTracePacketForwarded = 'Outbound Packet successfully forwarded';
  RSICMPTraceNoRoute = 'No route for Outbound Packet; packet discarded';
//conversion errors


  RSICMPConvUnknownUnspecError = 'Unknown/unspecified error';
  RSICMPConvDontConvOptPresent = 'Don''t Convert option present';
  RSICMPConvUnknownMandOptPresent =  'Unknown mandatory option present';
  RSICMPConvKnownUnsupportedOptionPresent = 'Known unsupported option present';
  RSICMPConvUnsupportedTransportProtocol = 'Unsupported transport protocol';
  RSICMPConvOverallLengthExceeded = 'Overall length exceeded';
  RSICMPConvIPHeaderLengthExceeded = 'IP header length exceeded';
  RSICMPConvTransportProtocol_255 = 'Transport protocol > 255';
  RSICMPConvPortConversionOutOfRange = 'Port conversion out of range';
  RSICMPConvTransportHeaderLengthExceeded = 'Transport header length exceeded';
  RSICMPConv32BitRolloverMissingAndACKSet = '32 Bit Rollover missing and ACK set';
  RSICMPConvUnknownMandatoryTransportOptionPresent =      'Unknown mandatory transport option present';
//mobile host redirect
  RSICMPMobileHostRedirect = 'Mobile Host Redirect';
//IPv6 - Where are you
  RSICMPIPv6WhereAreYou    = 'IPv6 Where-Are-You';
//IPv6 - I am here
  RSICMPIPv6IAmHere        = 'IPv6 I-Am-Here';
// Mobile Regestration request
  RSICMPMobReg             = 'Mobile Registration Request';
//Skip
  RSICMPSKIP               = 'SKIP';
//Security
  RSICMPSecBadSPI          = 'Bad SPI';
  RSICMPSecAuthenticationFailed = 'Authentication Failed';
  RSICMPSecDecompressionFailed = 'Decompression Failed';
  RSICMPSecDecryptionFailed = 'Decryption Failed';
  RSICMPSecNeedAuthentication = 'Need Authentication';
  RSICMPSecNeedAuthorization = 'Need Authorization';
//IPv6 Packet Too Big
  RSICMPPacketTooBig = 'Packet Too Big (MTU = %d)';
{ TIdCustomIcmpClient }

procedure TIdCustomIcmpClient.PrepareEchoRequest(Buffer: string = '');    {Do not Localize}
begin
  {$IFNDEF DOTNET}
  if IPVersion = Id_IPv4 then begin
    PrepareEchoRequestIPv4(Buffer);
  end else begin
    PrepareEchoRequestIPv6(Buffer);
  end;
  {$ELSE}
  PrepareEchoRequestIPv4(Buffer);
  {$ENDIF}
end;

procedure TIdCustomIcmpClient.SendEchoRequest;
begin
  Send(FbufIcmp);
end;

function TIdCustomIcmpClient.DecodeResponse(BytesRead: Cardinal; var AReplyStatus: TReplyStatus): Boolean;
begin
  if BytesRead = 0 then begin
    // Timed out
    AReplyStatus.MsRoundTripTime := GetTickDiff(FStartTime, Ticks);
    if IPVersion = Id_IPv4 then
    begin
      AReplyStatus.BytesReceived   := 0;
      AReplyStatus.FromIpAddress   := '0.0.0.0';
      AReplyStatus.ToIpAddress     := '0.0.0.0';
      AReplyStatus.MsgType         := 0;
      AReplyStatus.SequenceId      := wSeqNo;
      AReplyStatus.TimeToLive      := 0;
      AReplyStatus.ReplyStatusType := rsTimeOut;
    end else
    begin
      AReplyStatus.BytesReceived   := 0;
      AReplyStatus.FromIpAddress   := '::0';
      AReplyStatus.ToIpAddress     := '::0';
      AReplyStatus.MsgType         := 0;
      AReplyStatus.SequenceId      := wSeqNo;
      AReplyStatus.TimeToLive      := 0;
      AReplyStatus.ReplyStatusType := rsTimeOut;
    end;
    Result := True;
  end else begin
    AReplyStatus.ReplyStatusType := rsError;
    {$IFNDEF DOTNET}
    if IPVersion = Id_IPv4 then begin
      Result := DecodeIPv4Packet(BytesRead, AReplyStatus);
    end else begin
      Result := DecodeIPv6Packet(BytesRead, AReplyStatus);
    end;
    {$ELSE}
     Result := DecodeIPv4Packet(BytesRead, AReplyStatus);
    {$ENDIF}
  end;
end;

procedure TIdCustomIcmpClient.GetEchoReply;
begin
  FReplyStatus := Receive(FReceiveTimeout);
end;

function TIdCustomIcmpClient.Receive(ATimeOut: Integer): TReplyStatus;
var
  BytesRead : Integer;
  TripTime: Cardinal;
begin
  Result := FReplyStatus;
  FillBytes(FbufReceive, SizeOf(FbufReceive), 0);
  FStartTime := Ticks;
  repeat
    BytesRead := ReceiveBuffer(FbufReceive, ATimeOut);
    if DecodeResponse(BytesRead, Result) then
    begin
      Break;
    end;
    TripTime := GetTickDiff(FStartTime, Ticks);
    ATimeOut := Cardinal(ATimeOut) - TripTime; // compute new timeout value
    FReplyStatus.MsRoundTripTime := TripTime;
    FReplyStatus.Msg := RSICMPTimeout;
    // We caught a response that wasn't meant for this thread - so we must
    // make sure we don't report it as such in case we time out after this
    if IPVersion = Id_IPv4 then
    begin
      FReplyStatus.BytesReceived   := 0;
      FReplyStatus.FromIpAddress   := '0.0.0.0';
      FReplyStatus.ToIpAddress     := '0.0.0.0';
      FReplyStatus.MsgType         := 0;
      FReplyStatus.SequenceId      := wSeqNo;
      FReplyStatus.TimeToLive      := 0;
      FReplyStatus.ReplyStatusType := rsTimeOut;
    end
    else
    begin
      FReplyStatus.BytesReceived   := 0;
      FReplyStatus.FromIpAddress   := '::0';
      FReplyStatus.ToIpAddress     := '::0';
      FReplyStatus.MsgType         := 0;
      FReplyStatus.SequenceId      := wSeqNo;
      FReplyStatus.TimeToLive      := 0;
      FReplyStatus.ReplyStatusType := rsTimeOut;
    end;
  until ATimeOut <= 0;
end;

procedure TIdCustomIcmpClient.DoReply(const AReplyStatus: TReplyStatus);
begin
  if Assigned(FOnReply) then begin
    FOnReply(Self, AReplyStatus);
  end;
end;

procedure TIdCustomIcmpClient.InitComponent;
begin
  inherited InitComponent;
  FReplyStatus:= TReplyStatus.Create;
  FProtocol := Id_IPPROTO_ICMP;
  {$IFNDEF DOTNET}
  ProtocolIPv6 := Id_IPPROTO_ICMPv6;
  {$ENDIF}
  wSeqNo := 3489; // SG 25/1/02: Arbitrary Constant <> 0
  FReceiveTimeOut := Id_TIDICMP_ReceiveTimeout;
  PacketSize := MAX_PACKET_SIZE;
end;

destructor TIdCustomIcmpClient.Destroy;
begin
  Sys.FreeAndNil(FReplyStatus);
  inherited Destroy;
end;

function TIdCustomIcmpClient.DecodeIPv4Packet(BytesRead: Cardinal; var AReplyStatus: TReplyStatus): boolean;
var
  LIPHeaderLen:Cardinal;
  RTTime: Cardinal;
  LActualSeqID: word;
  LIdx : Integer;
  LIPv4 : TIdIPHdr;
  LIcmp : TIdICMPHdr;
begin
  Result := False;
  LIdx := 0;
  LIPv4 := TIdIPHdr.Create;
  LIcmp := TIdICMPHdr.Create;
  try
    LIpHeaderLen := (FBufReceive[0] and $0F) * 4;
    if (BytesRead < LIpHeaderLen + ICMP_MIN) then begin
      raise EIdIcmpException.Create(RSICMPNotEnoughtBytes);
    end;
    LIPv4.ReadStruct(FBufReceive, LIdx);
    LIdx := LIpHeaderLen;

    {$IFDEF LINUX}
    // TODO: baffled as to why linux kernel sends back echo from localhost
    {$ENDIF}
    case FBufReceive[LIpHeaderLen] of
      Id_ICMP_ECHOREPLY, Id_ICMP_ECHO:
      begin
        AReplyStatus.ReplyStatusType := rsEcho;
        //                                                    SizeOf(picmp^)
        FReplydata := BytesToString(FBufReceive,LIpHeaderLen + 8, Length(FbufReceive));
        //Copy(FbufReceive, iIpHeaderLen + SizeOf(picmp^) + 1, Length(FbufReceive));
        // result is only valid if the seq. number is correct
      end;
      Id_ICMP_UNREACH:
        AReplyStatus.ReplyStatusType := rsErrorUnreachable;
      Id_ICMP_TIMXCEED:
        AReplyStatus.ReplyStatusType := rsErrorTTLExceeded;
      Id_ICMP_PARAMPROB :
        AReplyStatus.ReplyStatusType := rsErrorParameter;
      Id_ICMP_REDIRECT :
        AReplyStatus.ReplyStatusType := rsRedirect;
      Id_ICMP_TSTAMP, Id_ICMP_TSTAMPREPLY :
        AReplyStatus.ReplyStatusType := rsTimeStamp;
      Id_ICMP_IREQ, Id_ICMP_IREQREPLY :
        AReplyStatus.ReplyStatusType := rsInfoRequest;
      Id_ICMP_MASKREQ, Id_ICMP_MASKREPLY :
        AReplyStatus.ReplyStatusType := rsAddressMaskRequest;
      Id_ICMP_TRACEROUTE :
        AReplyStatus.ReplyStatusType := rsTraceRoute;
      Id_ICMP_DATAGRAM_CONV :
        AReplyStatus.ReplyStatusType := rsErrorDatagramConversion;
      Id_ICMP_MOB_HOST_REDIR :
        AReplyStatus.ReplyStatusType := rsMobileHostRedir;
      Id_ICMP_IPv6_WHERE_ARE_YOU :
        AReplyStatus.ReplyStatusType := rsIPv6WhereAreYou;
      Id_ICMP_IPv6_I_AM_HERE :
        AReplyStatus.ReplyStatusType := rsIPv6IAmHere;
      Id_ICMP_MOB_REG_REQ, Id_ICMP_MOB_REG_REPLY :
        AReplyStatus.ReplyStatusType := rsMobileHostReg;
      Id_ICMP_PHOTURIS :
        AReplyStatus.ReplyStatusType := rsErrorSecurityFailure;
      else
        raise EIdICMPException.Create(RSICMPNonEchoResponse);// RSICMPNonEchoResponse = 'Non-echo type response received'
    end;    // case
    // check if we got a reply to the packet that was actually sent
    if AReplyStatus.ReplyStatusType = rsEcho then
    begin
      LActualSeqID := BytesToWord( FBufReceive,LIpHeaderLen+6);
      RTTime := GetTickDiff( BytesToCardinal( FBufReceive,LIpHeaderLen+8),Ticks); //picmp^.icmp_dun.ts.otime;
    end else
    begin
      // not an echo reply: the original IP frame is contained withing the DATA section of the packet
      // pOriginalIP := PIdIPHdr(@picmp^.icmp_dun.data);
      LActualSeqID := BytesToWord( FBufReceive,LIpHeaderLen+6+8);//pOriginalICMP^.icmp_hun.echo.seq;
      RTTime := GetTickDiff( BytesToCardinal( FBufReceive,LIpHeaderLen+8+8),Ticks); //pOriginalICMP^.icmp_dun.ts.otime;

      // move to offset
      // pOriginalICMP := Pointer(Cardinal(pOriginalIP) + (iIpHeaderLen));
      // extract information from original ICMP frame
      // ActualSeqID := pOriginalICMP^.icmp_hun.echo.seq;
      // RTTime := Ticks - pOriginalICMP^.icmp_dun.ts.otime;
      // Result := pOriginalICMP^.icmp_hun.echo.seq = wSeqNo;
    end;

    Result := LActualSeqID = wSeqNo;//;picmp^.icmp_hun.echo.seq  = wSeqNo;
    if Result then
    begin
      with AReplyStatus do
      begin
        BytesReceived := BytesRead;

        FromIpAddress := IdGlobal.MakeDWordIntoIPv4Address ( GStack.NetworkToHOst( BytesToCardinal( FBufReceive,12)));
        ToIpAddress   := IdGlobal.MakeDWordIntoIPv4Address ( GStack.NetworkToHOst( BytesToCardinal( FBufReceive,16)));
        MsgType := FBufReceive[LIpHeaderLen]; //picmp^.icmp_type;
        SequenceId := LActualSeqID;
        MsRoundTripTime := RTTime;
        TimeToLive := FBufReceive[8];
        // TimeToLive := pip^.ip_ttl;
        // now process our message stuff

        case AReplyStatus.FMsgType of
          Id_ICMP_UNREACH:
          begin
            case AReplyStatus.FMsgCode of
              Id_ICMP_UNREACH_NET                : AReplyStatus.Msg := RSICMPNetUnreachable;
              Id_ICMP_UNREACH_HOST               : AReplyStatus.Msg := RSICMPHostUnreachable;
              Id_ICMP_UNREACH_PROTOCOL           : AReplyStatus.Msg := RSICMPProtUnreachable;
              Id_ICMP_UNREACH_NEEDFRAG           : AReplyStatus.Msg := RSICMPFragmentNeeded;
              Id_ICMP_UNREACH_SRCFAIL            : AReplyStatus.Msg := RSICMPSourceRouteFailed;
              Id_ICMP_UNREACH_NET_UNKNOWN        : AReplyStatus.Msg := RSICMPDestNetUnknown;
              Id_ICMP_UNREACH_HOST_UNKNOWN       : AReplyStatus.Msg := RSICMPDestHostUnknown;
              Id_ICMP_UNREACH_ISOLATED           : AReplyStatus.Msg := RSICMPSourceIsolated;
              Id_ICMP_UNREACH_NET_PROHIB         : AReplyStatus.Msg := RSICMPDestNetProhibitted;
              Id_ICMP_UNREACH_HOST_PROHIB        : AReplyStatus.Msg := RSICMPDestHostProhibitted;
              Id_ICMP_UNREACH_TOSNET             : AReplyStatus.Msg := RSICMPTOSNetUnreach;
              Id_ICMP_UNREACH_TOSHOST            : AReplyStatus.Msg := RSICMPTOSHostUnreach;
              Id_ICMP_UNREACH_FILTER_PROHIB      : AReplyStatus.Msg := RSICMPAdminProhibitted;
              Id_ICMP_UNREACH_HOST_PRECEDENCE    : AReplyStatus.Msg := RSICMPHostPrecViolation;
              Id_ICMP_UNREACH_PRECEDENCE_CUTOFF  : AReplyStatus.Msg := RSICMPPrecedenceCutoffInEffect;
            end;
          end;
          Id_ICMP_TIMXCEED:
          begin
            case AReplyStatus.MsgCode of
              0 : AReplyStatus.Msg :=  RSICMPTTLExceeded;
              1 : AReplyStatus.Msg :=  RSICMPFragAsmExceeded;
            end;
          end;
          Id_ICMP_PARAMPROB:
            AReplyStatus.Msg := Sys.Format(RSICMPParamError,[ReplyStatus.MsgCode]);
          Id_ICMP_REDIRECT :
          begin
            AReplyStatus.RedirectTo := MakeDWordIntoIPv4Address ( GStack.NetworkToHOst( LIcmp.icmp_hun.gateway_s_l));
            case AReplyStatus.MsgCode of
              0 :  AReplyStatus.Msg :=  RSICMPRedirNet;
              1 :  AReplyStatus.Msg := RSICMPRedirHost;
              2 :  AReplyStatus.Msg :=  RSICMPRedirTOSNet;
              3 :  AReplyStatus.Msg :=  RSICMPRedirTOSHost;
            end;
          end;
          Id_ICMP_SOURCEQUENCH :
            AReplyStatus.Msg := RSICMPSourceQuenchMsg;
          Id_ICMP_ECHOREPLY, Id_ICMP_ECHO :
            AReplyStatus.Msg := RSICMPEcho;
          Id_ICMP_TSTAMP, Id_ICMP_TSTAMPREPLY:
            AReplyStatus.Msg := RSICMPTimeStamp;
          Id_ICMP_IREQ, Id_ICMP_IREQREPLY :
            AReplyStatus.Msg := RSICMPTimeStamp;
          Id_ICMP_MASKREQ, Id_ICMP_MASKREPLY :
            AReplyStatus.Msg := RSICMPMaskRequest;
          Id_ICMP_TRACEROUTE :
          begin
            case AReplyStatus.MsgCode of
              Id_ICMP_TRACEROUTE_PACKET_FORWARDED : AReplyStatus.Msg := RSICMPTracePacketForwarded;
              Id_ICMP_TRACEROUTE_NO_ROUTE : AReplyStatus.Msg := RSICMPTraceNoRoute;
            end;
          end;
          Id_ICMP_DATAGRAM_CONV :
          begin
            case AReplyStatus.MsgCode of
              Id_ICMP_CONV_UNSPEC                    : AReplyStatus.Msg := RSICMPTracePacketForwarded;
              Id_ICMP_CONV_DONTCONV_OPTION           : AReplyStatus.Msg := RSICMPTraceNoRoute;
              Id_ICMP_CONV_UNKNOWN_MAN_OPTION        : AReplyStatus.Msg := RSICMPConvUnknownMandOptPresent;
              Id_ICMP_CONV_UNKNWON_UNSEP_OPTION      : AReplyStatus.Msg := RSICMPConvKnownUnsupportedOptionPresent;
              Id_ICMP_CONV_UNSEP_TRANSPORT           : AReplyStatus.Msg := RSICMPConvUnsupportedTransportProtocol;
              Id_ICMP_CONV_OVERALL_LENGTH_EXCEEDED   : AReplyStatus.Msg := RSICMPConvOverallLengthExceeded;
              Id_ICMP_CONV_IP_HEADER_LEN_EXCEEDED    : AReplyStatus.Msg := RSICMPConvIPHeaderLengthExceeded;
              Id_ICMP_CONV_TRANS_PROT_255            : AReplyStatus.Msg := RSICMPConvTransportProtocol_255;
              Id_ICMP_CONV_PORT_OUT_OF_RANGE         : AReplyStatus.Msg := RSICMPConvPortConversionOutOfRange;
              Id_ICMP_CONV_TRANS_HEADER_LEN_EXCEEDED : AReplyStatus.Msg := RSICMPConvTransportHeaderLengthExceeded;
              Id_ICMP_CONV_32BIT_ROLLOVER_AND_ACK    : AReplyStatus.Msg := RSICMPConv32BitRolloverMissingAndACKSet;
              Id_ICMP_CONV_UNKNOWN_MAN_TRANS_OPTION  : AReplyStatus.Msg := RSICMPConvUnknownMandatoryTransportOptionPresent;
            end;
          end;
          Id_ICMP_MOB_HOST_REDIR :
            AReplyStatus.Msg :=  RSICMPMobileHostRedirect;
          Id_ICMP_IPv6_WHERE_ARE_YOU :
            AReplyStatus.Msg :=  RSICMPIPv6WhereAreYou;
          Id_ICMP_IPv6_I_AM_HERE :
            AReplyStatus.Msg := RSICMPIPv6IAmHere;
          Id_ICMP_MOB_REG_REQ, Id_ICMP_MOB_REG_REPLY :
            AReplyStatus.Msg := RSICMPIPv6IAmHere;
          Id_ICMP_SKIP :
            AReplyStatus.Msg := RSICMPSKIP;
          Id_ICMP_PHOTURIS :
          begin
            case AReplyStatus.MsgCode of
              Id_ICMP_BAD_SPI : AReplyStatus.Msg := RSICMPSecBadSPI;
              Id_ICMP_AUTH_FAILED : AReplyStatus.Msg := RSICMPSecAuthenticationFailed;
              Id_ICMP_DECOMPRESS_FAILED : AReplyStatus.Msg :=  RSICMPSecDecompressionFailed;
              Id_ICMP_DECRYPTION_FAILED : AReplyStatus.Msg := RSICMPSecDecryptionFailed;
              Id_ICMP_NEED_AUTHENTICATION : AReplyStatus.Msg := RSICMPSecNeedAuthentication;
              Id_ICMP_NEED_AUTHORIZATION  : AReplyStatus.Msg := RSICMPSecNeedAuthorization;
            end;
          end;
        end;
      end;
    end;
  finally
    Sys.FreeAndNil(LIcmp);
    Sys.FreeAndNil(LIPv4);
  end;
end;

procedure TIdCustomIcmpClient.PrepareEchoRequestIPv4(Buffer: String);
begin
  iDataSize := DEF_PACKET_SIZE + 8;
  FillBytes(FbufIcmp, iDataSize, 0);
  //icmp_type
  FBufIcmp[0] := Id_ICMP_ECHO;
  //icmp_code := 0;
  FBufIcmp[1] := 0;
  //skip checksum for now

  //icmp_hun.echo.id := word(CurrentProcessId);
  IdGlobal.CopyTIdWord(CurrentProcessId, FBufIcmp, 4);
  //icmp_hun.echo.seq := wSeqNo;
  IdGlobal.CopyTIdWord(wSeqNo, FBufIcmp, 6);
  // icmp_dun.ts.otime := Ticks; - not an official thing but for Indy internal use
  IdGlobal.CopyTIdCardinal(Ticks, FBufIcmp, 8);
  //data
  if Length(Buffer) > 0 then begin
    IdGlobal.CopyTIdString(Buffer, FBufIcmp, 12);
  end;
  //the checksum is done in a send override
end;

{$IFNDEF DOTNET}
procedure TIdCustomIcmpClient.PrepareEchoRequestIPv6(Buffer: String);
var
  LIPv6 : TIdicmp6_hdr;
  LIdx : Integer;
begin
  LIPv6 := TIdicmp6_hdr.create;
  try
    LIdx := 0;
    LIPv6.icmp6_type := ICMP6_ECHO_REQUEST;
    LIPv6.icmp6_code := 0;
    LIPv6.data.icmp6_un_data16[0] := word(CurrentProcessId);
    LIPv6.data.icmp6_un_data16[1] := wSeqNo;
    LIPv6.icmp6_cksum := 0;
    LIPv6.WriteStruct(FBufIcmp,LIdx);
    IdGlobal.CopyTIdCardinal(Ticks, FBufIcmp,LIdx);
    Inc(LIdx,4);
    if Length(Buffer) > 0 then begin
      CopyTIdString(Buffer, FBufIcmp, LIdx, Length(Buffer));
    end;
  finally
    Sys.FreeAndNil(LIPv6);
  end;
end;

function TIdCustomIcmpClient.DecodeIPv6Packet(BytesRead: Cardinal;
  var AReplyStatus: TReplyStatus): boolean;
var
  LIdx : Integer;
  LIcmp : TIdicmp6_hdr;
  RTTime : Cardinal;
  LActualSeqID : Word;
begin
  LIdx := 0;
  LIcmp := TIdicmp6_hdr.Create;
  try
    //NOte that IPv6 raw headers are not being returned.
    LIcmp.ReadStruct(FBufReceive, LIdx);
    case LIcmp.icmp6_type of
      ICMP6_ECHO_REQUEST,
      ICMP6_ECHO_REPLY :
        AReplyStatus.ReplyStatusType := rsEcho;
      //group membership messages
      ICMP6_MEMBERSHIP_QUERY : ;
      ICMP6_MEMBERSHIP_REPORT : ;
      ICMP6_MEMBERSHIP_REDUCTION :;
      //errors
      ICMP6_DST_UNREACH :    AReplyStatus.ReplyStatusType := rsErrorUnreachable;
      ICMP6_PACKET_TOO_BIG : AReplyStatus.ReplyStatusType := rsErrorPacketTooBig;
      ICMP6_TIME_EXCEEDED :  AReplyStatus.ReplyStatusType :=  rsErrorTTLExceeded;
      ICMP6_PARAM_PROB :     AReplyStatus.ReplyStatusType := rsErrorParameter;
    else
      AReplyStatus.ReplyStatusType := rsError;
    end;
    AReplyStatus.MsgType := LIcmp.icmp6_type; //picmp^.icmp_type;
    AReplyStatus.MsgCode := LIcmp.icmp6_code;
    //errors are values less than ICMP6_INFOMSG_MASK
    if LIcmp.icmp6_type < ICMP6_INFOMSG_MASK then
    begin
      //read info from the original packet part
      LIcmp.ReadStruct(FBufReceive, LIdx);
    end;
    LActualSeqID := LIcmp.data.icmp6_seq;
    Result := LActualSeqID = wSeqNo;

    RTTime := GetTickDiff(BytesToCardinal(FBufReceive, LIdx), Ticks);
    if Result then
    begin
      AReplyStatus.BytesReceived := BytesRead;
      AReplyStatus.SequenceId := LActualSeqID;
      AReplyStatus.MsRoundTripTime := RTTime;
      // TimeToLive := FBufReceive[8];
      // TimeToLive := pip^.ip_ttl;
      AReplyStatus.TimeToLive := FPkt.TTL;
      AReplyStatus.FromIpAddress := FPkt.SourceIP;
      AReplyStatus.ToIpAddress := FPkt.DestIP;
      case LIcmp.icmp6_type of
        ICMP6_ECHO_REQUEST,
        ICMP6_ECHO_REPLY :
          AReplyStatus.Msg := RSICMPEcho;
        ICMP6_TIME_EXCEEDED :
        begin
          case LIcmp.icmp6_code of
            ICMP6_TIME_EXCEED_TRANSIT :     AReplyStatus.Msg := RSICMPHopLimitExceeded;
            ICMP6_TIME_EXCEED_REASSEMBLY :  AReplyStatus.Msg := RSICMPFragAsmExceeded;
          end;
        end;
        ICMP6_DST_UNREACH :
        begin
          case LIcmp.icmp6_code of
            ICMP6_DST_UNREACH_NOROUTE :           AReplyStatus.Msg := RSICMPNoRouteToDest;
            ICMP6_DST_UNREACH_ADMIN :             AReplyStatus.Msg := RSICMPAdminProhibitted;
            ICMP6_DST_UNREACH_ADDR :              AReplyStatus.Msg :=  RSICMPHostUnreachable;
            ICMP6_DST_UNREACH_NOPORT  :           AReplyStatus.Msg := RSICMPProtUnreachable;
            ICMP6_DST_UNREACH_SOURCE_FILTERING :  AReplyStatus.Msg := RSICMPSourceFilterFailed;
            ICMP6_DST_UNREACH_REJCT_DST :         AReplyStatus.Msg := RSICMPRejectRoutToDest;
          end;
        end;
        ICMP6_PACKET_TOO_BIG :
          AReplyStatus.Msg := Sys.Format(RSICMPPacketTooBig, [LIcmp.data.icmp6_mtu]);
        ICMP6_PARAM_PROB :
        begin
          case LIcmp.icmp6_code of
            ICMP6_PARAMPROB_HEADER :
              AReplyStatus.Msg := Sys.Format(RSICMPParamHeader, [LIcmp.data.icmp6_pptr]);
            ICMP6_PARAMPROB_NEXTHEADER :
              AReplyStatus.Msg := Sys.Format(RSICMPParamNextHeader, [LIcmp.data.icmp6_pptr]);
            ICMP6_PARAMPROB_OPTION :
              AReplyStatus.Msg :=  Sys.Format(RSICMPUnrecognizedOpt, [LIcmp.data.icmp6_pptr]);
          end;
        end;
        ICMP6_MEMBERSHIP_QUERY : ;
        ICMP6_MEMBERSHIP_REPORT : ;
        ICMP6_MEMBERSHIP_REDUCTION :;
      end;
    end;
  finally
    Sys.FreeAndNil(LIcmp);
  end;
end;

{$ENDIF}
procedure TIdCustomIcmpClient.Send(const AHost: string; const APort: integer;
  const ABuffer: TIdBytes);
var
  LBuffer : TIdBytes;
  LIP : String;
begin
  LBuffer := ABuffer;
  LIP := GStack.ResolveHost(AHost, IPVersion);
  GStack.WriteChecksum(Binding.Handle, LBuffer, 2, LIP, APort, IPVersion);
  FBinding.SendTo(LIP, APort, LBuffer, IPVersion);
end;

procedure TIdCustomIcmpClient.Send(const ABuffer: TIdBytes);
var
  LBuffer : TIdBytes;
  LIP : String;
begin
  LBuffer := ABuffer;
  LIP := GStack.ResolveHost(Host, IPVersion);
  GStack.WriteChecksum(Binding.Handle, LBuffer, 2, LIP, Port, IPVersion);
  FBinding.SendTo(LIP, Port, LBuffer, IPVersion);
end;

function TIdCustomIcmpClient.GetPacketSize: Integer;
begin
  Result := FPacketSize;
end;

procedure TIdCustomIcmpClient.SetPacketSize(const AValue: Integer);
begin
  FPacketSize := AValue;
end;

procedure TIdCustomIcmpClient.InternalPing(const AIP, ABuffer: String; SequenceID: Word);
begin
  if SequenceID <> 0 then begin
    wSeqNo := SequenceID;
  end;
  SetLength(FbufIcmp, FPacketSize);
  if IPVersion = Id_IPv4 then begin
    SetLength(FbufReceive, FPacketSize+Id_IP_HSIZE);
  end else begin
    SetLength(FbufReceive, FPacketSize+(Id_IPv6_HSIZE*2));
  end;
  PrepareEchoRequest(ABuffer);
  SendEchoRequest(AIP);
  GetEchoReply;
  Binding.CloseSocket;

  DoReply(FReplyStatus);
  Inc(wSeqNo); // SG 25/1/02: Only incread sequence number when finished.
end;

procedure TIdCustomIcmpClient.SendEchoRequest(const AIP: String);
begin
  Send(AIP, 0, FbufIcmp);
end;

{ TIdIcmpClient }

procedure TIdIcmpClient.Ping(const ABuffer: String; SequenceID: Word);
var
  LIP : String;
begin
  LIP := GStack.ResolveHost(Host, IPVersion);
  InternalPing(LIP, ABuffer, SequenceID);
end;

end.
