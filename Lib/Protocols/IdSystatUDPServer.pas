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
  Rev 1.5    10/26/2004 10:49:20 PM  JPMugaas
  Updated ref.

  Rev 1.4    2004.02.03 5:44:30 PM  czhower
  Name changes

  Rev 1.3    1/21/2004 4:04:08 PM  JPMugaas
  InitComponent

  Rev 1.2    10/24/2003 02:54:58 PM  JPMugaas
  These should now work with the new code.

  Rev 1.1    2003.10.24 10:38:30 AM  czhower
  UDP Server todos

  Rev 1.0    11/13/2002 08:02:44 AM  JPMugaas
}

unit IdSystatUDPServer;

{
  Indy Systat Client TIdSystatUDPServer

  Copyright (C) 2002 Winshoes Working Group
  Original author J. Peter Mugaas
  2002-August-13
  Based on RFC 866
  Note that this protocol is officially called Active User.
}

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
  TIdUDPSystatEvent = procedure (ABinding: TIdSocketHandle; AResults : TStrings) of object;
type
  TIdSystatUDPServer = class(TIdUDPServer)
  protected
    FOnSystat : TIdUDPSystatEvent;
    procedure DoUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle); override;
    procedure InitComponent; override;
  published
    property OnSystat : TIdUDPSystatEvent read FOnSystat write FOnSystat;
    property DefaultPort default IdPORT_SYSTAT;
  end;

implementation

uses
  SysUtils;

{
According to the "Programming UNIX Sockets in C - Frequently Asked Questions"

This has to do with the maximum size of a datagram on the two machines involved.
This depends on the sytems involved, and the MTU (Maximum Transmission Unit).
According to "UNIX Network Programming", all TCP/IP implementations must support
a minimum IP datagram size of 576 bytes, regardless of the MTU. Assuming a 20
byte IP header and 8 byte UDP header, this leaves 548 bytes as a safe maximum
size for UDP messages. The maximum size is 65516 bytes. Some platforms support
IP fragmentation which will allow datagrams to be broken up (because of MTU
values) and then re-assembled on the other end, but not all implementations
support this.

URL:
http://www.manualy.sk/sock-faq/unix-socket-faq-5.html
}
const Max_UDPPacket = 548;
      Max_Line_Len  = Max_UDPPacket - 2; //EOL deliniator

{ TIdSystatUDPServer }

procedure TIdSystatUDPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_SYSTAT;
end;

procedure TIdSystatUDPServer.DoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s, s2 : String;
  LResults : TStrings;
  i : Integer;

  function MaxLenStr(const AStr : String): String;
  begin
    Result := AStr;
    if Length(Result)>Max_Line_Len then
    begin
      SetLength(Result, Max_Line_Len);
    end;
  end;

begin
  inherited DoUDPRead(AThread, AData, ABinding);
  if Assigned(FOnSystat) then
  begin
    LResults := TStringList.Create;
    try
      FOnSystat(ABinding, LResults);
      s := '';
      for i := 0 to LResults.Count - 1 do
      begin
        {enure that one line will never exceed the maximum packet size }
        s2 := s + EOL + MaxLenStr(LResults[i]);
        if Length(s2) > Max_UDPPacket then
        begin
          s := TrimLeft(s);
          ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(s), ABinding.IPVersion);
          s := MaxLenStr(LResults[i]);
        end else
        begin
          s := s2;
        end;
      end;
      if s <> '' then
      begin
        s := TrimLeft(s);
        ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, ToBytes(s), ABinding.IPVersion);
      end;
    finally
      FreeAndNil(LResults);
    end;
  end;
end;

end.
