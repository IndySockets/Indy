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
  Rev 1.10    6/11/2004 6:16:50 AM  DSiders
  Corrected spelling in class names, properties, and methods.

  Rev 1.9    2004.02.03 5:45:06 PM  czhower
  Name changes

  Rev 1.8    1/21/2004 2:12:44 PM  JPMugaas
  InitComponent

  Rev 1.7    10/19/2003 11:51:16 AM  DSiders
  Added localization comments.

  Rev 1.6    2003.10.18 9:42:08 PM  czhower
  Boatload of bug fixes to command handlers.

  Rev 1.5    7/18/2003 4:24:48 PM  SPerry
  New DICT server using command handlers

  Rev 1.4    2/24/2003 08:22:52 PM  JPMugaas
  SHould compile with new code.

  Rev 1.3    1/17/2003 05:35:14 PM  JPMugaas
  Now compiles with new design.

  Rev 1.2    1-1-2003 20:12:52  BGooijen
  Changed to support the new TIdContext class

  Rev 1.1    12/6/2002 02:17:42 PM  JPMugaas
  Now compiles with Indy 10.

  Rev 1.0    11/14/2002 02:17:24 PM  JPMugaas

  2000-15-May: J. Peter Mugaas - renamed events to have Id prefix

  2000-22-Apr: J. Peter Mugaas
    Ported to Indy

  2000-23-JanL MTL Moved to new Palette Scheme

  1999-23-Apr: Final Version
}

unit IdDICTServer;

{
  RFC 2229 - Dictionary Protocol (Structure).
  Original Author: Ozz Nixon
}

interface
{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdGlobalProtocols, IdResourceStringsProtocols,
  IdAssignedNumbers, IdCommandHandlers, IdCmdTCPServer;

type
  TIdDICTGetEvent = procedure (AContext:TIdCommand) of object;
  TIdDICTOtherEvent = procedure (AContext:TIdCommand; Command, Parm:String) of object;
  TIdDICTDefineEvent = procedure (AContext:TIdCommand; Database, WordToFind : String) of object;
  TIdDICTMatchEvent = procedure (AContext:TIdCommand; Database, Strategy,WordToFind : String) of object;
  TIdDICTShowEvent = procedure (AContext:TIdCommand; Command : String) of object;
  TIdDICTAuthEvent = procedure (AContext:TIdCommand; Username, authstring : String) of object;

  TIdDICTServer = class(TIdCmdTCPServer)
  protected
    fOnCommandHELP:TIdDICTGetEvent;
    fOnCommandDEFINE:TIdDICTDefineEvent;
    fOnCommandMATCH:TIdDICTMatchEvent;
    fOnCommandQUIT:TIdDICTGetEvent;
    fOnCommandSHOW:TIdDICTShowEvent;
    fOnCommandAUTH, fOnCommandSASLAuth:TIdDICTAuthEvent;
    fOnCommandOption:TIdDICTOtherEvent;
    fOnCommandSTAT:TIdDICTGetEvent;
    fOnCommandCLIENT:TIdDICTShowEvent;
    fOnCommandOther:TIdDICTOtherEvent;
    //
    procedure DoOnCommandHELP(ASender: TIdCommand);
    procedure DoOnCommandDEFINE(ASender: TIdCommand);
    procedure DoOnCommandMATCH(ASender: TIdCommand);
    procedure DoOnCommandQUIT(ASender: TIdCommand);
    procedure DoOnCommandSHOW(ASender: TIdCommand);
    procedure DoOnCommandAUTH(ASender: TIdCommand);
    procedure DoOnCommandSASLAuth(ASender: TIdCommand);
    procedure DoOnCommandOption(ASender: TIdCommand);
    procedure DoOnCommandSTAT(ASender: TIdCommand);
    procedure DoOnCommandCLIENT(ASender: TIdCommand);
    procedure DoOnCommandOther(ASender: TIdCommand);
    procedure DoOnCommandNotHandled(ASender: TIdCommandHandler; ACommand: TIdCommand;
      const AData, AMessage: String);
    //
    procedure InitializeCommandHandlers; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_DICT;
    //
    property OnCommandHelp: TIdDICTGetEvent read fOnCommandHelp write fOnCommandHelp;
    property OnCommandDefine: TIdDICTDefineEvent read fOnCommandDefine write fOnCommandDefine;
    property OnCommandMatch: TIdDICTMatchEvent read fOnCommandMatch write fOnCommandMatch;
    property OnCommandQuit: TIdDICTGetEvent read fOnCommandQuit write fOnCommandQuit;
    property OnCommandShow: TIdDICTShowEvent read fOnCommandShow write fOnCommandShow;
    property OnCommandAuth: TIdDICTAuthEvent read fOnCommandAuth write fOnCommandAuth;
    property OnCommandSASLAuth: TIdDICTAuthEvent read fOnCommandSASLAuth write fOnCommandSASLAuth;
    property OnCommandOption: TIdDICTOtherEvent read fOnCommandOption write fOnCommandOption;
    property OnCommandStatus: TIdDICTGetEvent read fOnCommandStat write fOnCommandStat;
    property OnCommandClient: TIdDICTShowEvent read fOnCommandClient write fOnCommandClient;
    property OnCommandOther: TIdDICTOtherEvent read fOnCommandOther write fOnCommandOther;
  end;

implementation

procedure TIdDICTServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DICT;
end;

{ Command handlers }

procedure TIdDICTServer.DoOnCommandHELP(ASender: TIdCommand);
begin
  if assigned (OnCommandHelp) then
    OnCommandHelp(ASender);
end;

procedure TIdDICTServer.DoOnCommandDEFINE(ASender: TIdCommand);
begin
  if assigned (OnCommandDefine) then
  begin
    OnCommandDefine (ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdDICTServer.DoOnCommandMATCH(ASender: TIdCommand);
begin
  if assigned (OnCommandMatch) then
  begin
    OnCommandMatch(ASender, ASender.Params[0], ASender.Params[1], ASender.Params[2]);
  end;
end;

procedure TIdDICTServer.DoOnCommandQUIT(ASender: TIdCommand);
begin
  if assigned (OnCommandQuit) then
    OnCommandQuit (ASender);
end;

procedure TIdDICTServer.DoOnCommandSHOW(ASender: TIdCommand);
begin
  if assigned ( OnCommandShow ) then
    OnCommandShow (ASender, ASender.Params[0]);
end;

procedure TIdDICTServer.DoOnCommandAUTH(ASender: TIdCommand);
begin
  if assigned (OnCommandAuth) then
  begin
    OnCommandAuth (ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdDICTServer.DoOnCommandSASLAuth(ASender: TIdCommand);
begin
  if assigned ( OnCommandSASLAuth ) then
  begin
    OnCommandSASLAuth(ASender, ASender.Params[0], ASender.Params[1]);
  end;
end;

procedure TIdDICTServer.DoOnCommandOption(ASender: TIdCommand);
begin
  if assigned(OnCommandOption) then
    OnCommandOption(ASender, ASender.Params[0], '');
end;

procedure TIdDICTServer.DoOnCommandSTAT(ASender: TIdCommand);
begin
  if assigned ( OnCommandStatus ) then
    OnCommandStatus (ASender);
end;

procedure TIdDICTServer.DoOnCommandCLIENT(ASender: TIdCommand);
begin
  if assigned (OnCommandClient) then
    OnCommandClient (ASender, ASender.Params[0]);
end;

procedure TIdDICTServer.DoOnCommandOther(ASender: TIdCommand);
begin

end;

procedure TIdDICTServer.DoOnCommandNotHandled(ASender: TIdCommandHandler;
  ACommand: TIdCommand; const AData, AMessage: String);
begin
  ACommand.Context.Connection.IOHandler.WriteLn('500 ' + RSCMDNotRecognized); {do not localize}
end;


procedure TIdDICTServer.InitializeCommandHandlers;
var
  LCommandHandler: TIdCommandHandler;
begin
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'AUTH';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandAUTH;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'CLIENT';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandCLIENT;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'DEFINE';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandDEFINE;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'HELP';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandHELP;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'MATCH'; {do not localize}
  LCommandHandler.OnCommand := DoOnCommandMATCH;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'OPTION';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandOPTION;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'QUIT';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandQUIT;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SASLAUTH';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandSASLAUTH;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'SHOW';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandSHOW;

  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := 'STATUS';  {do not localize}
  LCommandHandler.OnCommand := DoOnCommandSTAT;

  { Other }
  LCommandHandler := CommandHandlers.Add;
  LCommandHandler.Command := '';
  //LCommandHandler.OnCommand :=;
  //LCommandHandler.OnException :=;
end;

end.
