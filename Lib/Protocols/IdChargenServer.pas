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
  Rev 1.4    12/2/2004 4:23:48 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.3    1/21/2004 1:49:34 PM  JPMugaas
  InitComponent

  Rev 1.2    1/17/2003 05:35:28 PM  JPMugaas
  Now compiles with new design.

  Rev 1.1    1-1-2003 20:12:40  BGooijen
  Changed to support the new TIdContext class

  Rev 1.0    11/14/2002 02:14:02 PM  JPMugaas

  2000-Apr-17 Kudzu
    Converted to Indy
    Improved efficiency
}

unit IdChargenServer;

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
  TIdChargenServer = class(TIdCustomTCPServer)
  protected
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_CHARGEN;
  end;

implementation

uses
 IdIOHandler;

{ TIdChargenServer }

procedure TIdChargenServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_CHARGEN;
end;

function TIdChargenServer.DoExecute(AContext:TIdContext): boolean;
var
  Counter, Width, Base: integer;
  LIOHandler: TIdIOHandler;
begin
  Result := true;
  Base := 0;
  Counter := 1;
  Width := 1;
  LIOHandler := AContext.Connection.IOHandler;
  while LIOHandler.Connected do begin
    LIOHandler.Write(Chr(Counter + 31));
    Inc(Counter);
    Inc(Width);
    if Width = 72 then begin
      LIOHandler.WriteLn;  {Do not Localize}
      Width := 1;
      Inc(Base);
      if Base = 95 then begin
        Base := 1;
      end;
      Counter := Base;
    end;
    if Counter = 95 then begin
      Counter := 1;
    end;
  end;
end;

end.
