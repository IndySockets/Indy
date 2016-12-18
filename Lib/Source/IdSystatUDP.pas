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
  Rev 1.3    10/26/2004 10:49:20 PM  JPMugaas
  Updated ref.

  Rev 1.2    2004.02.03 5:44:30 PM  czhower
  Name changes

  Rev 1.1    1/21/2004 4:04:06 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:02:36 AM  JPMugaas
}

unit IdSystatUDP;

{
  Indy Systat Client TIdSystatUDP

  Copyright (C) 2002 Winshoes Working Group
  Original author J. Peter Mugaas
  2002-August-13
  Based on RFC 866
  Note that this protocol is officially called Active User
}

interface
{$i IdCompilerDefines.inc}
uses Classes, IdAssignedNumbers, IdUDPBase, IdUDPClient;

const DefIdSysUDPTimeout =  1000; //one second
type
  TIdSystatUDP = class(TIdUDPClient)
  protected
    procedure InitComponent; override;
  public
    procedure GetStat(ADest : TStrings);
  published
    property ReceiveTimeout default DefIdSysUDPTimeout;   //Infinite Timeout can not be used for UDP reads
    property Port default IdPORT_SYSTAT;
  end;

{
Note that no result parsing is done because RFC 866 does not specify a syntax for
a user list.

Quoted from RFC 866:

   There is no specific syntax for the user list.  It is recommended
   that it be limited to the ASCII printing characters, space, carriage
   return, and line feed.  Each user should be listed on a separate
   line.
}

implementation

uses
  IdGlobal, SysUtils;

{ TIdSystatUDP }

procedure TIdSystatUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_SYSTAT;
  ReceiveTimeout := DefIdSysUDPTimeout;
end;

procedure TIdSystatUDP.GetStat(ADest: TStrings);
var
  s : String;
  LTimeout : Integer;
  LEncoding: IIdTextEncoding;
begin
  //we do things this way so that IdTimeoutInfinite can never be used.
  // Necessary because that will hang the code.

  // RLebeau 1/5/2011: this does not make sense. If ReceiveTimeout is
  // IdTimeoutInfinite, then LTimeout will end up still being IdTimeoutInfinite
  // because ReceiveTimeout is being read a second time.  Shouldn't this
  // be specifying a real timeout value instead?

  LTimeout := ReceiveTimeout;
  if LTimeout = IdTimeoutInfinite then
  begin
    LTimeout := ReceiveTimeout;
  end;

  ADest.BeginUpdate;
  try
    ADest.Clear;
    //The string can be anything - The RFC says the server should discard packets
    Send(' ');    {Do not Localize}
    {  We do things this way because RFC 866 says:

    If the list does not fit in one datagram then send a sequence of
     datagrams but don't break the information for a user (a line) across
     a datagram.
    }
    LEncoding := IndyTextEncoding_8Bit;
    repeat
      s := ReceiveString(LTimeout, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      if s = '' then begin
        Break;
      end;
      ADest.Add(s);
    until False;
  finally
    ADest.EndUpdate;
  end;
end;

end.
