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
  Rev 1.4    2004.05.20 1:39:26 PM  czhower
  Last of the IdStream updates

  Rev 1.3    2004.05.20 11:37:20 AM  czhower
  IdStreamVCL

  Rev 1.2    2004.05.20 11:13:16 AM  czhower
  More IdStream conversions

  Rev 1.1    2003.06.13 6:57:10 PM  czhower
  Speed improvement

  Rev 1.0    2003.06.13 4:59:36 PM  czhower
  Initial checkin
}

unit IdCoder00E;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoder3to4;

type
  TIdDecoder00E = class(TIdDecoder4to3)
  public
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); override;
  end;

  TIdEncoder00E = class(TIdEncoder3to4)
  public
    procedure Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1); override;
  end;

implementation

uses
  IdGlobal,
  IdStream,
  SysUtils;

{ TIdDecoder00E }

procedure TIdDecoder00E.Decode(ASrcStream: TStream; const ABytes: Integer = -1);
var
  LBuf: TIdBytes;
  LSize: TIdStreamSize;
begin
  LSize := IndyLength(ASrcStream, ABytes);
  if LSize > 0 then begin
    //Param 2 - Start at second char since 00E's have byte 1 as length
    TIdStreamHelper.ReadBytes(ASrcStream, LBuf, 1);
    //Param 3 - Get output length of input. This is length in bytes,
    // not encoded chars. DO NOT include fill chars in calculation
    {Assert(Ord(FDecodeTable[LBuf[0]]) = (((LSize-1) div 4) * 3));}
    inherited Decode(ASrcStream, LSize-1);
  end;
end;

{ TIdEncoder00E }

procedure TIdEncoder00E.Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1);
var
  LStream: TMemoryStream;
  LSize: TIdStreamSize;
  LEncodeSize: Integer;
  LBuf: TIdBytes;
begin
  SetLength(LBuf, 1);
  LStream := TMemoryStream.Create;
  try
    LSize := IndyLength(ASrcStream, ABytes);
    while LSize > 0 do
    begin
      LEncodeSize := IndyMin(LSize, Length(FCodingTable)-1);
      inherited Encode(ASrcStream, LStream, LEncodeSize);
      Dec(LSize, LEncodeSize);
      LBuf[0] := Ord(FCodingTable[Integer(LEncodeSize)+1]);
      TIdStreamHelper.Write(ADestStream, LBuf, 1);
      LStream.Position := 0;
      ADestStream.CopyFrom(LStream, 0);
      if LSize > 0 then begin
        WriteStringToStream(ADestStream, EOL);
        LStream.Clear;
      end;
    end;
  finally
    FreeAndNil(LStream);
  end;
end;

end.
