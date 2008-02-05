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
  Rev 1.4    10/26/2004 10:49:20 PM  JPMugaas
  Updated ref.

  Rev 1.3    1/21/2004 4:04:04 PM  JPMugaas
  InitComponent

  Rev 1.2    2/24/2003 10:29:46 PM  JPMugaas

  Rev 1.1    12/6/2002 05:30:38 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 08:02:24 AM  JPMugaas
}

unit IdSystat;

{

  Indy Systat Client TIdSystat

  Copyright (C) 2002 Winshoes Working Group
  Original author J. Peter Mugaas
  2002-August-13
  Based on RFC 866
  Note that this protocol is officially called Active User
}

interface
{$i IdCompilerDefines.inc}
uses
  Classes,
  IdAssignedNumbers,
  IdTCPConnection,
  IdTCPClient;

type
  TIdSystat = class(TIdTCPClientCustom)
  protected
    procedure InitComponent; override;
  public
    procedure GetStat(ADest : TStrings);
  published
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

{ TIdSystat }

procedure TIdSystat.InitComponent;
begin
  inherited;
  Port := IdPORT_SYSTAT;
end;

procedure TIdSystat.GetStat(ADest: TStrings);
begin
  Connect;
  try
    ADest.Text := IOHandler.AllData;
  finally
    Disconnect;
  end;
end;

end.
