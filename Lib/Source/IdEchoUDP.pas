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
  Rev 1.3    2004.02.03 5:45:06 PM  czhower
  Name changes

  Rev 1.2    1/21/2004 3:27:50 PM  JPMugaas
  InitComponent

  Rev 1.1    1/3/2004 12:59:52 PM  JPMugaas
  These should now compile with Kudzu's change in IdCoreGlobal.

  Rev 1.0    11/14/2002 02:19:34 PM  JPMugaas
}

unit IdEchoUDP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdAssignedNumbers, IdUDPBase, IdUDPClient;

type
  TIdEchoUDP = class(TIdUDPClient)
  protected
    FEchoTime: UInt32;
  public
    constructor Create(AOwner: TComponent); override;
  public
    {This sends Text to the peer and returns the reply from the peer}
    Function Echo(AText: String): String;
    {Time taken to send and receive data}
    Property EchoTime: UInt32 read FEchoTime;
  published
    property Port default IdPORT_ECHO;
  end;

implementation

{$IF DEFINED(USE_VCL_POSIX) AND DEFINED(OSX)}
uses
  Macapi.CoreServices;
{$IFEND}

{ TIdIdEchoUDP }

constructor TIdEchoUDP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := IdPORT_ECHO;
end;

function TIdEchoUDP.Echo(AText: String): String;
var
  StartTime: TIdTicks;
  LEncoding: IIdTextEncoding;
begin
  StartTime := Ticks64;
  LEncoding := IndyTextEncoding_8Bit; // TODO: use UTF-8 instead
  Send(AText, LEncoding);
  Result := ReceiveString(IdTimeoutDefault, LEncoding);
  {This is just in case the TickCount rolled back to zero}
  FEchoTime := GetElapsedTicks(StartTime);
end;

end.
