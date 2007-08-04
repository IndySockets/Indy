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
  IdCoder3to4;
  
type
  TIdEncoderMIME = class(TIdEncoder3to4)
  protected
    procedure InitComponent; override;
  end;

  TIdDecoderMIME = class(TIdDecoder4to3)
  protected
    procedure InitComponent; override;
  end;

  {WARNING: This is not a general-purpose decoder.  It is used, for example, by
  IdMessageCoderMIME for line-by-line decoding of base64 encoded parts that are
  processed on a line-by-line basis, as against the complete encoded block.}
  TIdDecoderMIMELineByLine = class(TIdDecoderMIME)
  protected
    FLeftFromLastTime: string;
  public
    procedure DecodeBegin(ADestStream: TStream); override;
    procedure DecodeEnd; override;
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  end;

const
  GBase64CodeTable: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';    {Do not Localize}

var
  GBase64DecodeTable: TIdDecodeTable;

implementation

uses
  IdGlobal, SysUtils;

{ TIdDecoderMIMELineByLine }

procedure TIdDecoderMIMELineByLine.DecodeBegin(ADestStream: TStream);
begin
  inherited DecodeBegin(ADestStream);
  {Clear out any chars that may be left from a previous decode...}
  FLeftFromLastTime := '';
end;

procedure TIdDecoderMIMELineByLine.DecodeEnd;
var
  LStream: TStringStream;
  LPos: Integer;
begin
  if FLeftFromLastTime <> '' then begin
    LPos := Length(FLeftFromLastTime)+1;
    SetLength(FLeftFromLastTime, 4);
    while LPos <= 4 do begin
      FLeftFromLastTime[LPos] := FFillChar;
      Inc(LPos);
    end;
    LStream := TStringStream.Create(FLeftFromLastTime);
    try
      inherited Decode(LStream);
    finally
      FreeAndNil(LStream);
      FLeftFromLastTime := '';
    end;
  end;
  inherited DecodeEnd;
end;

procedure TIdDecoderMIMELineByLine.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LMod, LDiv: integer;
  LIn: string;
  LStream: TStringStream;
begin
  LIn := FLeftFromLastTime + ReadStringFromStream(ASrcStream, ABytes);
  LMod := Length(LIn) mod 4;
  if LMod <> 0 then begin
    LDiv := (Length(LIn) div 4) * 4;
    FLeftFromLastTime := Copy(LIn, LDiv+1, Length(LIn)-LDiv);
    LIn := Copy(LIn, 1, LDiv);
  end else begin
    FLeftFromLastTime := '';
  end;
  LStream := TStringStream.Create(LIn);
  try
    inherited Decode(LStream, ABytes);
  finally
    FreeAndNil(LStream);
  end;
end;

{ TIdDecoderMIME }

procedure TIdDecoderMIME.InitComponent;
begin
  inherited InitComponent;
  FDecodeTable := GBase64DecodeTable;
  FCodingTable := GBase64CodeTable;
  FFillChar := '=';  {Do not Localize}
end;

{ TIdEncoderMIME }

procedure TIdEncoderMIME.InitComponent;
begin
  inherited InitComponent;
  FCodingTable := GBase64CodeTable;
  FFillChar := '=';   {Do not Localize}
end;

initialization
  TIdDecoder4to3.ConstructDecodeTable(GBase64CodeTable, GBase64DecodeTable);
end.
