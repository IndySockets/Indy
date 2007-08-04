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
begin
  if ABytes < 0 then begin
    inherited Decode(ASrcStream, ABytes);
  end
  else if ABytes > 0 then begin
    //Param 2 - Start at second char since 00E's have byte 1 as length
    //Param 3 - Get expected length of input. This is length in bytes, not chars
    TIdStreamHelper.ReadBytes(ASrcStream, LBuf, 1);
    inherited Decode(ASrcStream, FDecodeTable[Ord(LBuf[0])]);
  end;
end;

{ TIdEncoder00E }

procedure TIdEncoder00E.Encode(ASrcStream, ADestStream: TStream; const ABytes: Integer = -1);
var
  LStream: TMemoryStream;
  LSize: Int64;
  LBuf: TIdBytes;
begin
  SetLength(LBuf, 1024);
  LStream := TMemoryStream.Create;
  try
    LBuf[0] := 0;
    TIdStreamHelper.Write(LStream, LBuf, 1);
    inherited Encode(ASrcStream, LStream, ABytes);
    LSize := LStream.Size - 1;
    Assert(LSize<High(Integer));
    LBuf[0] := Byte(FCodingTable[Integer(LSize) + 1]);
    LStream.Position := 0;
    TIdStreamHelper.Write(LStream, LBuf, 1);
    LStream.Position := 0;
    repeat
      LSize := TIdStreamHelper.ReadBytes(LStream, LBuf, Length(LBuf));
      if LSize > 0 then begin
        TIdStreamHelper.Write(ADestStream, LBuf, Integer(LSize));
      end;
    until LSize = 0;
  finally
    FreeAndNil(LStream);
  end;
end;

end.
