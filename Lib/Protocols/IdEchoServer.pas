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


  $Log$


  Rev 1.7    12/2/2004 4:23:52 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.6    1/21/2004 3:27:48 PM  JPMugaas
  InitComponent

  Rev 1.5    2003.11.29 10:18:54 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.4    3/6/2003 5:08:50 PM  SGrobety
  Updated the read buffer methodes to fit the new core (InputBuffer ->
  InputBufferAsString + call to CheckForDataOnSource)

  Rev 1.3    2/24/2003 08:41:32 PM  JPMugaas
  Should compile with new code.

  Rev 1.2    1/17/2003 05:35:06 PM  JPMugaas
  Now compiles with new design.

  Rev 1.1    1-1-2003 20:13:00  BGooijen
  Changed to support the new TIdContext class

  Rev 1.0    11/14/2002 02:19:30 PM  JPMugaas

2000-Apr=22 J Peter Mugaas
  Ported to Indy

1999-May-13
  Final Version

2000-Jan-13 MTL
  Moved to new Palette Scheme (Winshoes Servers)
}

unit IdEchoServer;

{
Original Author: Ozz Nixon
}

interface
{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdECHOServer = class ( TIdCustomTCPServer )
  protected
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_ECHO;
  end;

implementation

uses
  IdGlobal, IdIOHandler;
  
procedure TIdECHOServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_ECHO;
end;

function TIdECHOServer.DoExecute(AContext: TIdContext): Boolean;
var
  LBuffer: TIdBytes;
  LIOHandler: TIdIOHandler;
begin
  Result := True;
  SetLength(LBuffer, 0);
  LIOHandler := AContext.Connection.IOHandler;
  LIOHandler.ReadBytes(LBuffer, -1);
  LIOHandler.Write(LBuffer);
end;

end.
