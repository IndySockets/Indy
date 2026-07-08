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
  Rev 1.6    12/2/2004 4:23:54 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.5    1/21/2004 2:29:40 PM  JPMugaas
  InitComponent

  Rev 1.4    2/24/2003 08:41:24 PM  JPMugaas
  Should compile with new code.

  Rev 1.3    1/17/2003 05:35:02 PM  JPMugaas
  Now compiles with new design.

  Rev 1.2    1/9/2003 07:10:56 AM  JPMugaas
  Changed Finger server API so developers do not have to mess with the Context
  and Connnection objects.

  Rev 1.1    1-1-2003 20:13:02  BGooijen
  Changed to support the new TIdContext class

  Rev 1.0    11/14/2002 02:19:56 PM  JPMugaas

  2000-May-15  J. Peter Mugaas
    -Added verbose querry event to complement TIdFinger

  2000-Apr-22  J Peter Mugass
    -Ported to Indy

  2000-Jan-13  MTL
    -Moved to new Palette Scheme (Winshoes Servers)

  1999-Apr-13
    -Final Version
}


unit IdFingerServer;

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
  TIdFingerGetEvent = procedure (AContext:TIdContext; const AUserName: String; var VResponse : String) of object;

  TIdFingerServer = class ( TIdCustomTCPServer )
  protected
    FOnCommandFinger : TIdFingerGetEvent;
    FOnCommandVerboseFinger : TIdFingerGetEvent;
    //
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    {This event fires when you make a regular querry}
    property OnCommandFinger: TIdFingerGetEvent read FOnCommandFinger
      write FOnCommandFinger;
    { This event fires when you receive a VERBOSE finger request}
    property OnCommandVerboseFinger : TIdFingerGetEvent
      read FOnCommandVerboseFinger write FOnCommandVerboseFinger;
    property DefaultPort default IDPORT_Finger;
  end;

implementation

uses
  IdGlobal, SysUtils;

procedure TIdFingerServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_FINGER;
end;

function TIdFingerServer.DoExecute(AContext:TIdContext): boolean;
Var
  s, LResponse: String;
begin
  Result := True;
  {We use TrimRight in case there are spaces ending the query which are problematic
  for verbose queries.  CyberKit puts a space after the /W parameter}
  s := TrimRight(AContext.Connection.IOHandler.ReadLn);
  if Assigned(FOnCommandVerboseFinger) and TextEndsWith(s, '/W') then {Do not Localize}
  begin
    {we remove the /W switch before calling the event}
    s := Copy(s, 1, Length(s)-2);
    OnCommandVerboseFinger(AContext, s, LResponse);
    AContext.Connection.IOHandler.Write(LResponse);
  end
  else if Assigned(OnCommandFinger) then begin
    OnCommandFinger(AContext, s, LResponse);
    AContext.Connection.IOHandler.Write(LResponse);
  end;
  AContext.Connection.Disconnect;
end;

end.
