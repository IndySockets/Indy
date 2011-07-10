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
  IdAssignedNumbers, IdUDPBase, IdUDPClient;

type
  TIdEchoUDP = class(TIdUDPClient)
  protected
    FEchoTime: Cardinal;
    procedure InitComponent; override;
  public
    {This sends Text to the peer and returns the reply from the peer}
    Function Echo(AText: String): String;
    {Time taken to send and receive data}
    Property EchoTime: Cardinal read FEchoTime;
  published
    property Port default IdPORT_ECHO;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
	  {$IFDEF DARWIN}
  Macapi.CoreServices,
	  {$ENDIF}
  {$ENDIF}
  IdGlobal;

{ TIdIdEchoUDP }

procedure TIdEchoUDP.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_ECHO;
end;

function TIdEchoUDP.Echo(AText: String): String;
var
  StartTime: Cardinal;
begin
  StartTime := Ticks;
  Send(AText, Indy8BitEncoding{$IFDEF STRING_IS_ANSI}, Indy8BitEncoding{$ENDIF});
  Result := ReceiveString(IdTimeoutDefault, Indy8BitEncoding{$IFDEF STRING_IS_ANSI}, Indy8BitEncoding{$ENDIF});
  {This is just in case the TickCount rolled back to zero}
  FEchoTime :=  GetTickDiff(StartTime,Ticks);
end;

end.
