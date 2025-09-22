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
  Rev 1.10    3/6/2004 3:05:08 PM  JPMugaas
  Added quit code 211 as per bug #83

  Rev 1.9    2004.03.06 1:31:54 PM  czhower
  To match Disconnect changes to core.

  Rev 1.8    2004.02.07 1:42:00 PM  czhower
  Fixed visibility

  Rev 1.7    2004.02.03 5:44:22 PM  czhower
  Name changes

  Rev 1.6    1/21/2004 4:03:40 PM  JPMugaas
  InitComponent

  Rev 1.5    10/17/2003 1:08:06 AM  DSiders
  Added localization comments.

  Rev 1.4    6/5/2003 04:54:12 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.3    1/27/2003 11:36:54 AM  DSiders
  Modified Connect to raise an exception when any response other than 220 is
  received.  Exception code and text comes from the server response.
  Added TODOs needed to complete SNPP Level 1 support.

  Rev 1.2    12/8/2002 07:25:48 PM  JPMugaas
  Added published host and port properties.

  Rev 1.1    12/6/2002 05:30:34 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 08:01:08 AM  JPMugaas
}

unit IdSNPP;

interface
{$i IdCompilerDefines.inc}

uses
  IdComponent, IdGlobal, IdException, IdGlobalProtocols,
  IdReplyRFC,
  IdTCPConnection,
  IdTCPClient;

{
  Simple Network Paging Protocol based on RFC 1861
  Original Author: Mark Holmes
}

{ Note that this only supports Level One SNPP }

type
  { TODO : Unused... remove? }
  TConnectionResult = (crCanPost, crNoPost, crAuthRequired, crTempUnavailable);

  { TODO : Unused... remove? }
  TCheckResp = Record
    Code : Int16;
    Resp : String;
  end;

  { TODO : Add optional HELP command }

  { TODO : Add QUIT procedure }

  { TODO : Add overridden GetResponse to handle multiline 214 response codes
    that omit the continuation mark.  For example:

      214 First line...
      214 Second line...
      214 Final line
      250 OK
  }

  { TODO : Raise an exception when the fatal error response code 421
    is received in SendMessage, SNPPMsg, Pager
  }

  TIdSNPP = class(TIdTCPClientCustom)
  protected
    function Pager(APagerId: String): Boolean;
    function SNPPMsg(AMsg: String): Boolean;
    procedure InitComponent; override;
  public
    procedure Connect; override;
    procedure DisconnectNotifyPeer; override;
    procedure Reset;
    procedure SendMessage(APagerId, AMsg: String);
  published
    property Port default 7777;
    property Host;
  end;

  EIdSNPPException = class(EIdException);
  EIdSNPPConnectionRefused = class (EIdReplyRFCError);
  EIdSNPPProtocolError = class (EIdReplyRFCError);
  EIdSNPPNoMultiLineMessages = class(EIdSNPPException);

implementation

uses
  IdResourceStringsProtocols;

{ TIdSNPP }

procedure TIdSNPP.InitComponent;
begin
  inherited InitComponent;
  Port := 7777;
end;

procedure TIdSNPP.Connect;
begin
  inherited Connect;
  try
    if GetResponse <> 220 then
    begin
      raise EIdSNPPConnectionRefused.CreateError(LastCmdResult.NumericCode,
        LastCmdResult.Text.Text);
    end;
  except
    Disconnect;
    Raise;
  end;
end;

procedure TIdSNPP.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', 211);  {do not localize}
end;

function TIdSNPP.Pager(APagerId: String): Boolean;
begin
  Result := False;
  if SendCmd('PAGER ' + APagerID) = 250 then begin {do not localize}
    Result := True;
  end else begin
    DoStatus(hsStatusText, [LastCmdResult.Text[0]]);
  end;
end;

procedure TIdSNPP.Reset;
begin
  Writeln('RESET');    {do not localize}
end;

procedure TIdSNPP.SendMessage(APagerId, AMsg : String);
begin
  if (Pos(CR,AMsg)>0) or (Pos(LF,AMsg)>0) then
  begin
    raise EIdSNPPNoMultiLineMessages.Create(RSSNPPNoMultiLine);
  end;
  if (Length(APagerId) > 0) and (Length(AMsg) > 0) then begin
    if Pager(APagerID) then begin
      if SNPPMsg(AMsg) then begin
        WriteLn('SEND');    {do not localize}
      end;
      GetResponse(250);
    end;
  end;
end;

function TIdSNPP.SNPPMsg(AMsg: String): Boolean;
begin
  Result := False;
  if SendCmd('MESS ' + AMsg) = 250 then begin {do not localize}
    Result := True;
  end else begin
    DoStatus(hsStatusText, [LastCmdResult.Text.Text]);
  end;
end;

end.
