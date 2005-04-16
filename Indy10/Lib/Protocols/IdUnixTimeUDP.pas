{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  115739: IdUnixTimeUDP.pas 
{
{   Rev 1.0    2/10/2005 2:26:38 PM  JPMugaas
{ New UnixTime Service (port 519) components.
}
unit IdUnixTimeUDP;

interface
uses IdAssignedNumbers, IdTimeUDP, IdUDPClient;
{
This is based on a description at
http://amo.net/AtomicTimeZone/help/ATZS_Protocols.htm#Unix

UnixTime and UnixTime Protocol
Unix is an operating system developed in 1969 by Ken Thompson. UnixTime counts "epochs" or seconds since the Year 1970. UnixTime recently hit it's billionth birthday.

Because Unix is widely used in many environments, UnixTime was developed into a loose simple time protocol in the late 80's and early 90's. No formal UnixTime protocol has ever been officially published as an internet protocol - until now.

UnixTime operates on the same UnixTime port - 519. Once a connection is
requested on this port, exactly like in Time Protocol, the UnixTime value
is sent back by either tcp/ip or udp/ip. When UDP/IP is used, a small packet
of data must be received by the server in order to respond in the exact same
fashion as Time Protocol. The UnixTime is then sent as an unsigned
"unformatted" integer on the same port.

}
type
  TIdUnixTimeUDP = class(TIdCustomTimeUDP)
  protected
    procedure InitComponent; override;
  published
    property Port default IdPORT_utime;
  end;
implementation
uses IdGlobalProtocols;

{ TIdTUniximeUDP }

procedure TIdUnixTimeUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_utime;
  FBaseDate := UnixStartDate;
end;

end.
