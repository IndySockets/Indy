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
  Rev 1.3    1/21/2004 3:27:12 PM  JPMugaas
  InitComponent

  Rev 1.2    12/8/2002 07:25:44 PM  JPMugaas
  Added published host and port properties.

  Rev 1.1    12/6/2002 05:30:28 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 07:58:34 AM  JPMugaas
}

unit IdQotd;

{*******************************************************}
{                                                       }
{       Indy QUOTD Client TIdQOTD                       }
{                                                       }
{       Copyright (C) 2000 Winshoes WOrking Group       }
{       Started by J. Peter Mugaas                      }
{       2000-April-23                                   }
{                                                       }
{*******************************************************}

interface
{$i IdCompilerDefines.inc}

uses
   IdAssignedNumbers,
   IdTCPClient;

type
  TIdQOTD = class(TIdTCPClientCustom)
  protected
    Function GetQuote: String;
    procedure InitComponent; override;
  public
    { This is the quote from the server }
    Property Quote: String read GetQuote;
  published
    Property Port default IdPORT_QOTD;
    property Host;
  end;

implementation

{ TIdQotd }

procedure TIdQOTD.InitComponent;
begin
  inherited;
  Port := IdPORT_QOTD;
end;

function TIdQOTD.GetQuote: String;
begin
  Result := ConnectAndGetAll;
end;

end.
