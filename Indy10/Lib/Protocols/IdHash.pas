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
  Rev 1.10    7/24/04 12:54:32 PM  RLebeau
  Compiler fix for TIdHash128.HashValue()

  Rev 1.9    7/23/04 7:09:12 PM  RLebeau
  Added extra exception handling to various HashValue() methods

  Rev 1.8    2004.05.20 11:37:06 AM  czhower
  IdStreamVCL

  Rev 1.7    2004.03.03 11:54:30 AM  czhower
  IdStream change

  Rev 1.6    2004.02.03 5:44:48 PM  czhower
  Name changes

  Rev 1.5    1/27/2004 4:00:08 PM  SPerry
  StringStream ->IdStringStream

  Rev 1.4    11/10/2003 7:39:22 PM  BGooijen
  Did all todo's ( TStream to TIdStream mainly )

  Rev 1.3    2003.10.24 10:43:08 AM  czhower
  TIdSTream to dos

  Rev 1.2    10/18/2003 4:28:30 PM  BGooijen
  Removed the pchar for DotNet

  Rev 1.1    10/8/2003 10:15:10 PM  GGrieve
  replace TIdReadMemoryStream (might be fast, but not compatible with DotNet)

  Rev 1.0    11/13/2002 08:30:24 AM  JPMugaas
  Initial import from FTP VC.
}

unit IdHash;

interface

uses
  IdGlobal, IdSys, IdObjs;

type
  TIdHash = class(TIdBaseObject)
  protected
    function GetHashBytes(AStream: TIdStream; ASize: Int64): TIdBytes; virtual; abstract;
  public
    constructor Create; virtual;
    function HashString(const ASrc: string): TIdBytes;
    function HashBytes(const ASrc: TIdBytes): TIdBytes;
    function HashStream(AStream: TIdStream): TIdBytes; overload;
    function HashStream(AStream: TIdStream; const AStartPos, ASize: Int64): TIdBytes; overload;
    function HashStringAsHex(const ASrc: string): String;
    function HashBytesAsHex(const ASrc: TIdBytes): String;
    function HashStreamAsHex(AStream: TIdStream): String; overload;
    function HashStreamAsHex(AStream: TIdStream; const AStartPos, ASize: Int64): String; overload;
  end;

  TIdHash16 = class(TIdHash)
  public
    function HashValue(const ASrc: string): Word; overload;
    function HashValue(const ASrc: TIdBytes): Word; overload;
    function HashValue(AStream: TIdStream): Word; overload;
    function HashValue(AStream: TIdStream; const AStartPos, ASize: Int64): Word; overload;
    procedure HashStart(var VRunningHash : Word); virtual; abstract;
    procedure HashByte(var VRunningHash : Word; const AByte : Byte); virtual; abstract;
  end;

  TIdHash32 = class(TIdHash)
  public
    function HashValue(const ASrc: string): LongWord; overload;
    function HashValue(const ASrc: TIdBytes): LongWord; overload;
    function HashValue(AStream: TIdStream): LongWord; overload;
    function HashValue(AStream: TIdStream; const AStartPos, ASize: Int64): LongWord; overload;
    procedure HashStart(var VRunningHash : LongWord); virtual; abstract;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); virtual; abstract;
  end;

  TIdHashClass = class of TIdHash;
  
implementation

uses
  IdGlobalProtocols;

{ TIdHash }

constructor TIdHash.Create;
begin
end;

function TIdHash.HashString(const ASrc: string): TIdBytes;
var
  LStream: TIdStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TIdMemoryStream.Create; try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashStream(LStream);
  finally Sys.FreeAndNil(LStream); end;
end;

function TIdHash.HashBytes(const ASrc: TIdBytes): TIdBytes;
var
  LStream: TIdStream;
begin
  LStream := TIdMemoryStream.Create; try
    WriteTIdBytesToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashStream(LStream);
  finally Sys.FreeAndNil(LStream); end;
end;

function TIdHash.HashStream(AStream: TIdStream): TIdBytes;
begin
  Result := GetHashBytes(AStream, AStream.Size - AStream.Position);
end;

function TIdHash.HashStream(AStream: TIdStream; const AStartPos, ASize: Int64): TIdBytes;
var
  LSize: Int64;
begin
  LSize := ASize;
  if LSize < 0 then begin
    LSize := AStream.Size;
  end;
  AStream.Position := AStartPos;
  Result := GetHashBytes(AStream, LSize);
end;

function TIdHash.HashStringAsHex(const ASrc: string): String;
begin
  Result := ToHex(HashString(ASrc));
end;

function TIdHash.HashBytesAsHex(const ASrc: TIdBytes): String;
begin
  Result := ToHex(HashBytes(ASrc));
end;

function TIdHash.HashStreamAsHex(AStream: TIdStream): String;
begin
  Result := ToHex(HashStream(AStream));
end;

function TIdHash.HashStreamAsHex(AStream: TIdStream; const AStartPos, ASize: Int64) : String;
begin
  Result := ToHex(HashStream(AStream, AStartPos, ASize));
end;

{ TIdHash16 }

function TIdHash16.HashValue(const ASrc: string): Word;
begin
  Result := BytesToWord(HashString(ASrc));
end;

function TIdHash16.HashValue(const ASrc: TIdBytes): Word;
begin
  Result := BytesToWord(HashBytes(ASrc));
end;

function TIdHash16.HashValue(AStream: TIdStream): Word;
begin
  Result := BytesToWord(HashStream(AStream));
end;

function TIdHash16.HashValue(AStream: TIdStream; const AStartPos, ASize: Int64): Word;
begin
  Result := BytesToWord(HashStream(AStream, AStartPos, ASize));
end;

{ TIdHash32 }

function TIdHash32.HashValue(const ASrc: string): LongWord;
begin
  Result := BytesToLongWord(HashString(ASrc));
end;

function TIdHash32.HashValue(const ASrc: TIdBytes): LongWord;
begin
  Result := BytesToLongWord(HashBytes(ASrc));
end;

function TIdHash32.HashValue(AStream: TIdStream) : LongWord;
begin
  Result := BytesToLongWord(HashStream(AStream));
end;

function TIdHash32.HashValue(AStream: TIdStream; const AStartPos, ASize: Int64) : LongWord;
begin
  Result := BytesToLongWord(HashStream(AStream, AStartPos, ASize));
end;

end.
