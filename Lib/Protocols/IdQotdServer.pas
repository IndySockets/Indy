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
  Rev 1.5    12/2/2004 4:23:58 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.4    1/21/2004 3:27:14 PM  JPMugaas
  InitComponent

  Rev 1.3    2/24/2003 09:29:30 PM  JPMugaas

  Rev 1.2    1/17/2003 07:10:48 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.1    1/8/2003 05:53:46 PM  JPMugaas
  Switched stuff to IdContext.

  Rev 1.0    11/13/2002 07:58:40 AM  JPMugaas

2000-May-15  J. Peter Mugaas
 -renamed events to have Id prefix

2000-Apr-22  J Peter Mugaas
  Ported to Indy

2000-Jan-13 MTL
  Moved to new Palette Scheme (Winshoes Servers)

1999-May-13
  Final Version
}

unit IdQotdServer;

interface

{$i IdCompilerDefines.inc}

{
Original Author: Ozz Nixon
  (RFC 865) [less than 512 characters total, multiple lines OK!]
}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdQOTDGetEvent = procedure(AContext: TIdContext; var AQuote: String) of object;

  TIdQOTDServer = class(TIdCustomTCPServer)
  protected
    FOnCommandQOTD : TIdQOTDGetEvent;
    //
    function DoExecute(AContext: TIdContext): Boolean; override;
    procedure InitComponent; override;
  published
    property OnCommandQOTD : TIdQOTDGetEvent read fOnCommandQOTD write fOnCommandQOTD;
    property DefaultPort default IdPORT_QOTD;
  end;

implementation

procedure TIdQOTDServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_QOTD;
end;

function TIdQOTDServer.DoExecute(AContext:TIdContext) : Boolean;
var
  LQuote : String;
begin
  Result := True;
  if Assigned(OnCommandQOTD) then
  begin
    OnCommandQOTD(AContext, LQuote);
    AContext.Connection.IOHandler.Write(LQuote);
  end;
  AContext.Connection.Disconnect;
end;

end.
