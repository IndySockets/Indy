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
  Rev 1.6    1/21/2004 1:44:16 PM  JPMugaas
  InitComponent

  Rev 1.5    10/16/2003 11:11:18 PM  DSiders
  Added localization comments.

  Rev 1.4    2003.06.13 6:57:12 PM  czhower
  Speed improvement

  Rev 1.2    6/13/2003 07:58:48 AM  JPMugaas
  Should now compile with new decoder design.

  Rev 1.1    2003.06.13 3:41:20 PM  czhower
  Optimizaitions.

  Rev 1.0    11/14/2002 02:15:06 PM  JPMugaas
}

unit IdCoderUUE;

{$i IdCompilerDefines.inc}

interface

uses
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  Classes,
  {$ENDIF}
  IdCoder00E, IdCoder3to4;

type
  TIdDecoderUUE = class(TIdDecoder00E)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

  TIdEncoderUUE = class(TIdEncoder00E)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

const
  // Note the embedded '
  GUUECodeTable: string = '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_'; {do not localize}

var
  GUUEDecodeTable: TIdDecodeTable;

implementation

uses
  IdGlobal;

{ TIdEncoderUUE }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdEncoderUUE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdEncoderUUE.InitComponent;
begin
  inherited InitComponent;
  FCodingTable := ToBytes(GUUECodeTable);
  FFillChar := GUUECodeTable[1];
end;

{ TIdDecoderUUE }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDecoderUUE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDecoderUUE.InitComponent;
begin
  inherited InitComponent;
  FDecodeTable := GUUEDecodeTable;
  FFillChar := GUUECodeTable[1];
end;

initialization
  TIdDecoder00E.ConstructDecodeTable(GUUECodeTable, GUUEDecodeTable);
  // Older UUEncoders use space instead of `. This way we account for both.
  GUUEDecodeTable[Ord(' ')] := GUUEDecodeTable[Ord('`')];
end.
