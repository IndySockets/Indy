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
  Rev 1.4    12/2/2004 4:23:50 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.3    1/21/2004 2:12:40 PM  JPMugaas
  InitComponent

  Rev 1.2    1/17/2003 05:35:18 PM  JPMugaas
  Now compiles with new design.

  Rev 1.1    1-1-2003 20:12:48  BGooijen
  Changed to support the new TIdContext class

  Rev 1.0    11/14/2002 02:17:06 PM  JPMugaas

2000-Apr-22: J Peter Mugass
  -Ported to Indy

1999-Apr-13
  -Final Version

2000-JAN-13 MTL
  -Moved to new Palette Scheme (Winshoes Servers)
}

unit IdDayTimeServer;

{
Original Author: Ozz Nixon
}

interface
{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdDayTimeServer = class(TIdCustomTCPServer)
  protected
    FTimeZone: String;
    //
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  published
    property TimeZone: String read FTimeZone write FTimeZone;
    property DefaultPort default IdPORT_DAYTIME;
  end;

implementation

uses
  IdGlobal, SysUtils;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDayTimeServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDayTimeServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DAYTIME;
  FTimeZone := 'EST';  {Do not Localize}
end;

function TIdDayTimeServer.DoExecute(AContext:TIdContext ): boolean;
begin
  Result := True;
  AContext.Connection.IOHandler.WriteLn(FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss', Now) + '-' + FTimeZone);    {Do not Localize}
  AContext.Connection.Disconnect;
end;

end.
