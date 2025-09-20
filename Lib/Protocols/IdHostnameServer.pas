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
  Rev 1.2    12/2/2004 4:23:54 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.1    4/12/2003 10:24:08 PM  GGrieve
  Fix to Compile

  Rev 1.0    11/13/2002 07:54:06 AM  JPMugaas

2000-May-18: J. Peter Mugaas
  -Ported to Indy

2000-Jan-13: MTL
  -13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)

1999-May-13: Ozz Nixon
  -Final version
}

unit IdHostnameServer;

interface

{$i IdCompilerDefines.inc}

{
  Original Author: Ozz Nixon
Based on RFC 953
}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Const
   KnownCommands: array [0..8] of string =
      (
      'HNAME',    {Do not Localize}
      'HADDR',    {Do not Localize}
      'ALL',    {Do not Localize}
      'HELP',    {Do not Localize}
      'VERSION',    {Do not Localize}
      'ALL-OLD',    {Do not Localize}
      'DOMAINS',    {Do not Localize}
      'ALL-DOM',    {Do not Localize}
      'ALL-INGWAY'    {Do not Localize}
      );

Type
  THostNameOneParmEvent = procedure(AThread: TIdContext; const AParam: String) of object;

  TIdHostNameServer = class(TIdCustomTCPServer)
  protected
    FOnCommandHNAME: THostNameOneParmEvent;
    FOnCommandHADDR: THostNameOneParmEvent;
    FOnCommandALL: TIdContextEvent;
    FOnCommandHELP: TIdContextEvent;
    FOnCommandVERSION: TIdContextEvent;
    FOnCommandALLOLD: TIdContextEvent;
    FOnCommandDOMAINS: TIdContextEvent;
    FOnCommandALLDOM: TIdContextEvent;
    FOnCommandALLINGWAY: TIdContextEvent;
    //
    function DoExecute(AContext: TIdContext): Boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_HOSTNAME;
    property OnCommandHNAME: THostNameOneParmEvent read fOnCommandHNAME write fOnCommandHNAME;
    property OnCommandHADDR: THostNameOneParmEvent read fOnCommandHADDR write fOnCommandHADDR;
    property OnCommandALL: TIdContextEvent read fOnCommandALL write fOnCommandALL;
    property OnCommandHELP: TIdContextEvent read fOnCommandHELP write fOnCommandHELP;
    property OnCommandVERSION: TIdContextEvent read fOnCommandVERSION write fOnCommandVERSION;
    property OnCommandALLOLD: TIdContextEvent read fOnCommandALLOLD write fOnCommandALLOLD;
    property OnCommandDOMAINS: TIdContextEvent read fOnCommandDOMAINS write fOnCommandDOMAINS;
    property OnCommandALLDOM: TIdContextEvent read fOnCommandALLDOM write fOnCommandALLDOM;
    property OnCommandALLINGWAY: TIdContextEvent read fOnCommandALLINGWAY write fOnCommandALLINGWAY;
  end;

implementation

uses
  IdGlobalCore,
  IdGlobal;

procedure TIdHostNameServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_HOSTNAME;
end;

function TIdHostNameServer.DoExecute(AContext: TIdContext): Boolean;
var
  S: String;
begin
  Result := True;
  while AContext.Connection.Connected do
  begin
    S := AContext.Connection.IOHandler.ReadLn;
    case PosInStrArray(Fetch(S, CHAR32), KnownCommands, False) of
      0 : {hname}
          if Assigned(OnCommandHNAME) then
            OnCommandHNAME(AContext, S);
      1 : {haddr}
          if Assigned(OnCommandHADDR) then
            OnCommandHADDR(AContext, S);
      2 : {all}
          if Assigned(OnCommandALL) then
            OnCommandALL(AContext);
      3 : {help}
          if Assigned(OnCommandHELP) then
            OnCommandHELP(AContext);
      4 : {version}
          if Assigned(OnCommandVERSION) then
            OnCommandVERSION(AContext);
      5 : {all-old}
          if Assigned(OnCommandALLOLD) then
            OnCommandALLOLD(AContext);
      6 : {domains}
          if Assigned(OnCommandDOMAINS) then
            OnCommandDOMAINS(AContext);
      7 : {all-dom}
          if Assigned(OnCommandALLDOM) then
            OnCommandALLDOM(AContext);
      8 : {all-ingway}
          if Assigned(OnCommandALLINGWAY) then
            OnCommandALLINGWAY(AContext);
    end;
  end;
  AContext.Connection.Disconnect;
end;

end.
