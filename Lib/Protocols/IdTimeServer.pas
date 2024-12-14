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
  Rev 1.8    2/10/2005 2:24:42 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.7    12/2/2004 4:24:00 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.6    2004.02.03 5:44:34 PM  czhower
  Name changes

  Rev 1.5    1/21/2004 4:20:58 PM  JPMugaas
  InitComponent

  Rev 1.4    2003.10.12 6:36:44 PM  czhower
  Now compiles.

  Rev 1.3    2/24/2003 10:37:04 PM  JPMugaas
  Should compile.  TODO:  Figure out what to do with TIdTime and the timeout
  feature.

  Rev 1.2    1/17/2003 07:11:08 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.1    1/8/2003 05:54:00 PM  JPMugaas
  Switched stuff to IdContext.

  Rev 1.0    11/13/2002 08:03:20 AM  JPMugaas
}

unit IdTimeServer;

interface
{$i IdCompilerDefines.inc}

{
 2000-3-May    J. Peter Mugaas
  -Added BaseDate to the date the calculations are based on can be
   adjusted to work after the year 2035
2000-30-April  J. Peter Mugaas
  -Adjusted the formula for the integer so that the Time is now
   always based on Universal Time (also known as Greenwhich Mean
  -Time Replaced the old forumala used to calculate the time with
   a new one suggested by Jim Gunkel.  This forumala is more
   accurate than the old one.
2000-24-April  J. Peter Mugaaas
  -This now uses the Internet Byte order functions
2000-22-Apr    J Peter Mugass
  -Ported to Indy
  -Fixed a problem where the server was not returning anything
2000-13-Jan MTL
  -Moved to new Palette Scheme (Winshoes Servers)
1999-13-Apr
  -Final Version

Original Author: Ozz Nixon
  -Based on RFC 868
}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdCustomTimeServer = class(TIdCustomTCPServer)
  protected
    FBaseDate : TDateTime;
    //
    function DoExecute(AContext: TIdContext): Boolean; override;
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  published
  end;

  TIdTimeServer = class(TIdCustomTimeServer)
  published
    property DefaultPort default IdPORT_TIME;
    {This property is used to set the Date the Time server bases it's
     calculations from.  If both the server and client are based from the same
     date which is higher than the original date, you can extend it beyond the
     year 2035}
    property BaseDate : TDateTime read FBaseDate write FBaseDate;

  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.Time,
  {$ENDIF}
  IdGlobal, //here to facilitate inlining
  IdGlobalProtocols,
  SysUtils;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdCustomTimeServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdCustomTimeServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_TIME;
    {This indicates that the default date is Jan 1, 1900 which was specified
    by RFC 868.}
  FBaseDate := TIME_BASEDATE;
end;

function TIdCustomTimeServer.DoExecute(AContext: TIdContext): Boolean;
begin
  Result := true;
  AContext.Connection.IOHandler.Write(UInt32(Trunc(Extended(LocalTimeToUTCTime(Now) - Int(FBaseDate)) * 24 * 60 * 60)));
  AContext.Connection.Disconnect;
end;

end.
