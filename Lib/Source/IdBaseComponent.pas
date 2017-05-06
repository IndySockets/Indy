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
  Rev 1.10    08.11.2004 ã. 20:00:46  DBondzhev
  changed TObject to &Object

  Rev 1.9    07.11.2004 ã. 18:17:54  DBondzhev
  This contains fix for proper call to unit initialization sections.

  Rev 1.8    2004.11.06 10:55:00 PM  czhower
  Fix for Delphi 2005.

  Rev 1.7    2004.10.26 9:07:30 PM  czhower
  More .NET implicit conversions

  Rev 1.6    2004.10.26 7:51:58 PM  czhower
  Fixed ifdef and renamed TCLRStrings to TIdCLRStrings

  Rev 1.5    2004.10.26 7:35:16 PM  czhower
  Moved IndyCat to CType in IdBaseComponent

  Rev 1.4    04.10.2004 13:15:06  Andreas Hausladen
  Thread Safe Unit initialization

  Rev 1.3    6/11/2004 8:28:26 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.2    2004.04.16 9:18:34 PM  czhower
  .NET fix to call initialization sections. Code taken from IntraWeb.

  Rev 1.1    2004.02.03 3:15:50 PM  czhower
  Updates to move to System.

  Rev 1.0    2004.02.03 2:28:26 PM  czhower
  Move

  Rev 1.4    2004.01.25 11:35:02 PM  czhower
  IFDEF fix for .net.

  Rev 1.3    2004.01.25 10:56:44 PM  czhower
  Bug fix for InitComponent at design time.

  Rev 1.2    2004.01.20 10:03:20 PM  czhower
  InitComponent

  Rev 1.1    2003.12.23 7:33:00 PM  czhower
  .Net change.

  Rev 1.0    11/13/2002 08:38:26 AM  JPMugaas
}

unit IdBaseComponent;

// Kudzu: This unit is permitted to viloate IFDEF restriction to harmonize
// VCL / .Net difference at the base level.

interface

{$I IdCompilerDefines.inc}

uses
  Classes;


// ***********************************************************
// TIdBaseComponent is the base class for all Indy components.
// ***********************************************************
type
  // TIdBaseComponent is the base class for all Indy components. Utility components, and other non
  // socket based components typically inherit directly from this. While socket components inherit
  // from TIdComponent instead as it introduces OnWork, OnStatus, etc.
  TIdBaseComponent = class(TComponent)
  protected
    function GetIndyVersion: string;
    function GetIsLoading: Boolean;
    function GetIsDesignTime: Boolean;
    property IsLoading: Boolean read GetIsLoading;
    property IsDesignTime: Boolean read GetIsDesignTime;
  public
    constructor Create; reintroduce; overload;
    constructor Create(AOwner: TComponent); overload; override;
    {$IFNDEF HAS_RemoveFreeNotification}
    procedure RemoveFreeNotification(AComponent: TComponent);
    {$ENDIF}
    property Version: string read GetIndyVersion;
  published
  end;

implementation

uses
  IdGlobal;

{ TIdBaseComponent }

constructor TIdBaseComponent.Create;
begin
  Create(nil);
end;

constructor TIdBaseComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TIdBaseComponent.GetIsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TIdBaseComponent.GetIsDesignTime: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

{$IFNDEF HAS_RemoveFreeNotification}
procedure TIdBaseComponent.RemoveFreeNotification(AComponent: TComponent);
begin
  // this is a no-op for now, as we can't access the private TComponent.FFreeNotifies list
end;
{$ENDIF}

function TIdBaseComponent.GetIndyVersion: string;
begin
  Result := gsIdVersion;
end;

end.

