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
  Rev 1.4    1/21/2004 4:21:16 PM  JPMugaas
  InitComponent


  Rev 1.3    2/24/2003 10:39:56 PM  JPMugaas


  Rev 1.2    12/8/2002 07:26:16 PM  JPMugaas
  Added published host and port properties.


  Rev 1.1    12/6/2002 05:30:50 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.


  Rev 1.0    11/13/2002 08:04:40 AM  JPMugaas
}
unit IdWhois;

{
2000-May-30 J. Peter Mugaas
  -made modifications so OnWork event will work for this component
2000-Apr-17 Kudzu
  -Converted to Indy
2000-Jan-13 MTL
  -Moved to new Palette Scheme (Winshoes Servers)
1999-Jan-05 - Kudzu
  -Cleaned uses clause
  -Changed result type
  -Eliminated Response prop
  -Fixed a bug in Whois
  -Added Try..finally
  -Other various mods
Original Author: Hadi Hariri
}

interface
{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdAssignedNumbers,
  IdTCPClient;

type
  TIdWhois = class(TIdTCPClientCustom)
  protected
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    function WhoIs(const ADomain: string): string;
  published
    property Port default IdPORT_WHOIS;
    property Host;
  end;

implementation

uses
  IdGlobal,
  IdTCPConnection;

{ TIdWHOIS }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdWHOIS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdWHOIS.InitComponent;
begin
  inherited;
  Host := 'whois.internic.net';    {Do not Localize}
  Port := IdPORT_WHOIS;
end;

function TIdWHOIS.WhoIs(const ADomain: string): string;
begin
  Connect; try
    IOHandler.WriteLn(ADomain);
    Result := IOHandler.AllData;
  finally Disconnect; end;
end;

end.
