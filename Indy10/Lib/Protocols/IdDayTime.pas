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
  Rev 1.3    1/21/2004 2:12:40 PM  JPMugaas
  InitComponent

  Rev 1.2    12/8/2002 07:26:30 PM  JPMugaas
  Added published host and port properties.

  Rev 1.1    12/6/2002 05:29:28 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/14/2002 02:17:02 PM  JPMugaas

  2000-April-30  J. Peter Mugaas
    changed to drop control charactors and spaces from result to ease
    parsing
}

unit IdDayTime;

{*******************************************************}
{                                                       }
{       Indy QUOTD Client TIdDayTime                    }
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
  TIdDayTime = class(TIdTCPClientCustom)
  protected
    Function GetDayTimeStr : String;
    procedure InitComponent; override;
  public
    Property DayTimeStr : String read GetDayTimeStr;
  published
    property Port default IdPORT_DAYTIME;
    property Host;
  end;

implementation

uses
  IdGlobal, SysUtils;

{ TIdDayTime }

procedure TIdDayTime.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_DAYTIME;
end;

function TIdDayTime.GetDayTimeStr: String;
begin
  Result := Trim ( ConnectAndGetAll );
end;

end.
