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
  Rev 1.5    1/21/2004 1:44:18 PM  JPMugaas
  InitComponent

  Rev 1.4    10/16/2003 11:11:34 PM  DSiders
  Added localization comments.

  Rev 1.3    2003.06.13 6:57:12 PM  czhower
  Speed improvement

  Rev 1.1    6/13/2003 08:14:38 AM  JPMugaas
  Removed some extra line feeds causing formatting problems.

  Rev 1.0    11/14/2002 02:15:22 PM  JPMugaas
}

unit IdCoderXXE;

interface

{$i IdCompilerDefines.inc}

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdCoder00E, IdCoder3to4;

type
  TIdDecoderXXE = class(TIdDecoder00E)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

  TIdEncoderXXE = class(TIdEncoder00E)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

const
  GXXECodeTable: string = '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'; {do not localize}

var
  GXXEDecodeTable: TIdDecodeTable;

implementation

uses
  IdGlobal;

{ TIdEncoderXXE }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdEncoderXXE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdEncoderXXE.InitComponent;
begin
  inherited InitComponent;
  FCodingTable := ToBytes(GXXECodeTable);
  FFillChar := GXXECodeTable[1];
end;

{ TIdDecoderXXE }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDecoderXXE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDecoderXXE.InitComponent;
begin
  inherited InitComponent;
  FDecodeTable := GXXEDecodeTable;
  FFillChar := GXXECodeTable[1];
end;

initialization
  TIdDecoder00E.ConstructDecodeTable(GXXECodeTable, GXXEDecodeTable);
end.

