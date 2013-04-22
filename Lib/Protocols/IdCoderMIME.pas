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
  Rev 1.3    26/03/2005 19:19:30  CCostelloe
  Fixes for "uneven size" exception

  Rev 1.2    2004.01.21 1:04:54 PM  czhower
  InitComponenet

  Rev 1.1    10/6/2003 5:37:02 PM  SGrobety
  Bug fix in decoders.

  Rev 1.0    11/14/2002 02:14:54 PM  JPMugaas
}

unit IdCoderMIME;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoder3to4,
  IdGlobal;

type
  TIdEncoderMIME = class(TIdEncoder3to4)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

  TIdDecoderMIME = class(TIdDecoder4to3)
  protected
    procedure InitComponent; override;
  {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
  {$ENDIF}
  end;

  {WARNING: This is not a general-purpose decoder.  It is used, for example, by
  IdMessageCoderMIME for line-by-line decoding of base64 encoded parts that are
  processed on a line-by-line basis, as against the complete encoded block.}
  TIdDecoderMIMELineByLine = class(TIdDecoderMIME)
  protected
    FLeftFromLastTime: TIdBytes;
  public
    procedure DecodeBegin(ADestStream: TStream); override;
    procedure DecodeEnd; override;
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  end;

const
  GBase64CodeTable: string =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';    {Do not Localize}

var
  GBase64DecodeTable: TIdDecodeTable;

implementation

uses
  {$IFDEF DOTNET}
  IdStreamNET,
    {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  SysUtils;

{ TIdDecoderMIMELineByLine }

procedure TIdDecoderMIMELineByLine.DecodeBegin(ADestStream: TStream);
begin
  inherited DecodeBegin(ADestStream);
  {Clear out any bytes that may be left from a previous decode...}
  SetLength(FLeftFromLastTime, 0);
end;

procedure TIdDecoderMIMELineByLine.DecodeEnd;
var
  LStream: TMemoryStream;
  LPos: Integer;
begin
  if Length(FLeftFromLastTime) > 0 then begin
    LPos := Length(FLeftFromLastTime);
    SetLength(FLeftFromLastTime, 4);
    while LPos < 4 do begin
      FLeftFromLastTime[LPos] := Ord(FFillChar);
      Inc(LPos);
    end;
    LStream := TMemoryStream.Create;
    try
      WriteTIdBytesToStream(LStream, FLeftFromLastTime);
      LStream.Position := 0;
      inherited Decode(LStream);
    finally
      FreeAndNil(LStream);
      SetLength(FLeftFromLastTime, 0);
    end;
  end;
  inherited DecodeEnd;
end;

procedure TIdDecoderMIMELineByLine.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LMod, LDiv: integer;
  LIn, LSrc: TIdBytes;
  LStream: TMemoryStream;
begin
  LIn := FLeftFromLastTime;
  if ReadTIdBytesFromStream(ASrcStream, LSrc, ABytes) > 0 then begin
    AppendBytes(LIn, LSrc);
  end;
  LMod := Length(LIn) mod 4;
  if LMod <> 0 then begin
    LDiv := (Length(LIn) div 4) * 4;
    FLeftFromLastTime := Copy(LIn, LDiv, Length(LIn)-LDiv);
    LIn := Copy(LIn, 0, LDiv);
  end else begin
    SetLength(FLeftFromLastTime, 0);
  end;
  LStream := TMemoryStream.Create;
  try
    WriteTIdBytesToStream(LStream, LIn);
    LStream.Position := 0;
    inherited Decode(LStream, ABytes);
  finally
    FreeAndNil(LStream);
  end;
end;

{ TIdDecoderMIME }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdDecoderMIME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdDecoderMIME.InitComponent;
begin
  inherited InitComponent;
  FDecodeTable := GBase64DecodeTable;
  FCodingTable := ToBytes(GBase64CodeTable);
  FFillChar := '=';  {Do not Localize}
end;

{ TIdEncoderMIME }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdEncoderMIME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdEncoderMIME.InitComponent;
begin
  inherited InitComponent;
  FCodingTable := ToBytes(GBase64CodeTable);
  FFillChar := '=';   {Do not Localize}
end;

initialization
  TIdDecoder4to3.ConstructDecodeTable(GBase64CodeTable, GBase64DecodeTable);
end.
