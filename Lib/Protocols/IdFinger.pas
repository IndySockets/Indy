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
  Rev 1.6    2004.02.03 5:45:10 PM  czhower
  Name changes

  Rev 1.5    1/21/2004 2:29:38 PM  JPMugaas
  InitComponent

  Rev 1.4    2/24/2003 08:41:20 PM  JPMugaas
  Should compile with new code.

  Rev 1.3    12/8/2002 07:58:54 PM  JPMugaas
  Now compiles properly.

  Rev 1.2    12/8/2002 07:26:38 PM  JPMugaas
  Added published host and port properties.

  Rev 1.1    12/6/2002 05:29:34 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/14/2002 02:19:50 PM  JPMugaas

  2000-April-30  J. Peter Mugaas
  -adjusted CompleteQuery to permit recursive finger queries such
   as "test@test.com@example.com".  I had mistakenly assumed that
   everything after the first @ was the host name.
  -Added option for verbose output request from server - note that
   many do not support this.
}

unit IdFinger;

{*******************************************************}
{                                                       }
{       Indy Finger Client TIdFinger                    }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2000-April-23                                   }
{       Based on RFC 1288                               }
{                                                       }
{*******************************************************}

interface

{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers,
  IdTCPClient;

type
  TIdFinger = class(TIdTCPClientCustom)
  protected
    FQuery: String;
    FVerboseOutput: Boolean;
    Procedure SetCompleteQuery(AQuery: String);
    Function GetCompleteQuery: String;
    Procedure InitComponent; override;
  public
    {This connects to a server, does the finger querry specified in the Query
    property and returns the results of the querry}
    function Finger: String;
  published
    property Port default IdPORT_FINGER;
    property Host;
    {This is the querry to the server which you set with the Host Property}
    Property Query: String read FQuery write FQuery;
    {This is the complete querry such as "user@host"}
    Property CompleteQuery: String read GetCompleteQuery write SetCompleteQuery;
    {This indicates that the server should give more detailed information on
    some systems.  However, this will probably not work on many systems so it is
    False by default}
    Property VerboseOutput: Boolean read FVerboseOutPut write FVerboseOutPut
      default False;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols,
  IdTCPConnection;

{ TIdFinger }

procedure TIdFinger.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_FINGER;
end;

{This is the method used for retreiving Finger Data which is returned in the
 result}
function TIdFinger.Finger: String;
var
  QStr : String;
begin
  QStr := FQuery;
  if VerboseOutPut then
  begin
    QStr := QStr + '/W';     {Do not Localize}
  end; //if VerboseOutPut then
  Connect;
  try
    {Write querry}
    Result := '';         {Do not Localize}
    IOHandler.WriteLn(QStr);
    {Read results}
    Result := IOHandler.AllData;
  finally
    Disconnect;
  end;
end;

function TIdFinger.GetCompleteQuery: String;
begin
  Result := FQuery + '@' + Host;  {Do not Localize}
end;

procedure TIdFinger.SetCompleteQuery(AQuery: String);
var
  p : Integer;
begin
  p := RPos('@', AQuery, -1);       {Do not Localize}
  if p <> 0 then begin
    if p < Length(AQuery) then
    begin
      Host := Copy(AQuery, p+1, MaxInt);
    end;
    FQuery := Copy(AQuery, 1, p-1);
  end else begin
    FQuery := AQuery;
  end;
end;

end.
