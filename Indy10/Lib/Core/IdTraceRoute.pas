unit IdTraceRoute;

interface
uses IdICMPClient, IdRawBase, IdRawClient, IdThread;

type

  TIdTraceRoute = class(TIdCustomICMPClient)
  protected
    FResolveHostNames : Boolean;
    procedure DoReply(const AReplyStatus: TReplyStatus); override;
  public
    procedure Trace;
  published
    property ResolveHostNames : Boolean read FResolveHostNames write FResolveHostNames;
    property OnReply: TOnReplyEvent read FOnReply write FOnReply;
  end;

implementation
uses IdStack;
{ TIdTraceRoute }

procedure TIdTraceRoute.DoReply(const AReplyStatus: TReplyStatus);
begin
  if FResolveHostNames and (AReplyStatus.FromIpAddress<>'0.0.0.0') and
  (AReplyStatus.FromIpAddress<>'::0') then
  begin
    //resolve IP to hostname
    try
      AReplyStatus.HostName := GStack.HostByAddress(AReplyStatus.FromIpAddress,FIPversion);
    except
{
We do things this way because we are likely have a reverse DNS
failure if you have a computer with IP address and no DNS name at all.

}
      AReplyStatus.HostName := AReplyStatus.FromIpAddress;
    end;
  end;
  inherited;

end;

procedure TIdTraceRoute.Trace;
//In traceroute, there are a maximum of thirty echo request packets.  You start
//requests with a TTL of one and keep sending them until you get to thirty or you
//get an echo response (whatever comes sooner).
var i : Integer;
  lSeq : Cardinal;
  LTTL : Integer;
 // LIP : String;
begin
   //LIP := GStack.ResolveHost(AHost,FIPVersion)
  PacketSize := 64;
  Connect;
  try

   LSeq := $100;
   LTTL := 1;
   TTL := LTTL;
   for i := 1 to 30 do
   begin
     ReplyStatus.PacketNumber := i;
     InternalPing('',LSeq);
     case ReplyStatus.ReplyStatusType of
       rsEcho : Break;
       rsErrorTTLExceeded :
       begin
         Inc(LTTL);
         TTL := LTTL;

       end;
     end;
     LSeq := LSeq * 2;
   end;
  finally
    Disconnect;
  end;
end;

end.
