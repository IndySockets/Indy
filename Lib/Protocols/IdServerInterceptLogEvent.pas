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
  Rev 1.1    10/17/2003 6:24:58 PM  BGooijen
  Removed const

    Rev 1.0    3/22/2003 11:06:06 PM  BGooijen
  Initial check in.
  ServerIntercept to log data/status to an event.
}

unit IdServerInterceptLogEvent;

interface
{$i IdCompilerDefines.inc}

uses
  IdServerInterceptLogBase;

type
  TIdServerInterceptLogEvent=class;
  
  TIdOnLogString= procedure(ASender: TIdServerInterceptLogEvent; const AText: string) of object;

  TIdServerInterceptLogEvent = class(TIdServerInterceptLogBase)
  protected
    FOnLogString: TIdOnLogString;
  public
    procedure DoLogWriteString(const AText: string); override;
  published
    property OnLogString: TIdOnLogString read FOnLogString write FOnLogString;
  end;

implementation

{ TIdServerInterceptLogEvent }

procedure TIdServerInterceptLogEvent.DoLogWriteString(const AText: string);
begin
  if Assigned(FOnLogString) then begin
    FOnLogString(Self, AText);
  end;
end;

end.
