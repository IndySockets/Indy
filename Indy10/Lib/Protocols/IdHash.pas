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
  Classes,
  IdGlobal;

type
  TIdHash = class(TObject)
  protected
    function GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes; virtual; abstract;
    function HashToHex(const AHash: TIdBytes): String; virtual; abstract;
    function WordHashToHex(const AHash: TIdBytes; const ACount: Integer): String;
    function LongWordHashToHex(const AHash: TIdBytes; const ACount: Integer): String;
  public
    constructor Create; virtual;
    function HashString(const ASrc: string): TIdBytes;
    function HashStringAsHex(const AStr: String): String;
    function HashBytes(const ASrc: TIdBytes): TIdBytes;
    function HashBytesAsHex(const ASrc: TIdBytes): String;
    function HashStream(AStream: TStream): TIdBytes; overload;
    function HashStreamAsHex(AStream: TStream): String; overload;
    function HashStream(AStream: TStream; const AStartPos, ASize: Int64): TIdBytes; overload;
    function HashStreamAsHex(AStream: TStream; const AStartPos, ASize: Int64): String; overload;
  end;

  TIdHash16 = class(TIdHash)
  protected
    function GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes; override;
    function HashToHex(const AHash: TIdBytes): String; override;
  public
    function HashValue(const ASrc: string): Word; overload;
    function HashValue(const ASrc: TIdBytes): Word; overload;
    function HashValue(AStream: TStream): Word; overload;
    function HashValue(AStream: TStream; const AStartPos, ASize: Int64): Word; overload;
    procedure HashStart(var VRunningHash : Word); virtual; abstract;
    procedure HashEnd(var VRunningHash : Word); virtual;
    procedure HashByte(var VRunningHash : Word; const AByte : Byte); virtual; abstract;
  end;

  TIdHash32 = class(TIdHash)
  protected
    function GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes; override;
    function HashToHex(const AHash: TIdBytes): String; override;
  public
    function HashValue(const ASrc: string): LongWord; overload;
    function HashValue(const ASrc: TIdBytes): LongWord; overload;
    function HashValue(AStream: TStream): LongWord; overload;
    function HashValue(AStream: TStream; const AStartPos, ASize: Int64): LongWord; overload;
    procedure HashStart(var VRunningHash : LongWord); virtual; abstract;
    procedure HashEnd(var VRunningHash : LongWord); virtual;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); virtual; abstract;
  end;

  TIdHashClass = class of TIdHash;
  
implementation

uses
  IdGlobalProtocols, SysUtils;

{ TIdHash }

constructor TIdHash.Create;
begin
  inherited Create;
end;

function TIdHash.HashString(const ASrc: string): TIdBytes;
var
  LStream: TStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TMemoryStream.Create; try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashStream(LStream);
  finally FreeAndNil(LStream); end;
end;

function TIdHash.HashStringAsHex(const AStr: String): String;
begin
  Result := HashToHex(HashString(AStr));
end;

function TIdHash.HashBytes(const ASrc: TIdBytes): TIdBytes;
var
  LStream: TStream;
begin
  LStream := TMemoryStream.Create; try
    WriteTIdBytesToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashStream(LStream);
  finally FreeAndNil(LStream); end;
end;

function TIdHash.HashBytesAsHex(const ASrc: TIdBytes): String;
begin
  Result := HashToHex(HashBytes(ASrc));
end;

function TIdHash.HashStream(AStream: TStream): TIdBytes;
begin
  Result := HashStream(AStream, -1, -1);
end;

function TIdHash.HashStreamAsHex(AStream: TStream): String;
begin
  Result := HashToHex(HashStream(AStream));
end;

function TIdHash.HashStream(AStream: TStream; const AStartPos, ASize: Int64): TIdBytes;
var
  LSize, LAvailable: Int64;
begin
  if AStartPos >= 0 then begin
    AStream.Position := AStartPos;
  end;
  LAvailable := AStream.Size - AStream.Position;
  if ASize < 0 then begin
    LSize := LAvailable;
  end else begin
    LSize := Min(LAvailable, ASize);
  end;
  Result := GetHashBytes(AStream, LSize);
end;

function TIdHash.HashStreamAsHex(AStream: TStream; const AStartPos, ASize: Int64): String;
begin
  Result := HashToHex(HashStream(AStream, AStartPos, ASize));
end;

function TIdHash.WordHashToHex(const AHash: TIdBytes; const ACount: Integer): String;
var
  LValue: Word;
  I: Integer;
begin
  Result := '';
  for I := 0 to ACount-1 do begin
    LValue := BytesToWord(AHash, SizeOf(Word)*I);
    Result := Result + IntToHex(LValue, 4);
  end;
end;

function TIdHash.LongWordHashToHex(const AHash: TIdBytes; const ACount: Integer): String;
var
  LValue: LongWord;
  I: Integer;
begin
  Result := '';
  for I := 0 to ACount-1 do begin
    LValue := BytesToLongWord(AHash, SizeOf(LongWord)*I);
    Result := Result + IntToHex(LValue, 8);
  end;
end;

{ TIdHash16 }

function TIdHash16.GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes;
const
  cBufSize = 1024; // Keep it small for dotNet
var
  I: Integer;
  LBuffer: TIdBytes;
  LSize: Integer;
  LHash: Word;
begin
  Result := nil;
  HashStart(LHash);

  SetLength(LBuffer, cBufSize);

  while ASize > 0 do
  begin
    LSize := ReadTIdBytesFromStream(AStream, LBuffer, Min(cBufSize, ASize));
    if LSize < 1 then begin
      Break; // TODO: throw a stream read exception instead?
    end;
    for i := 0 to LSize - 1 do begin
      HashByte(LHash, LBuffer[i]);
    end;
    Dec(ASize, LSize);
  end;

  HashEnd(LHash);
  
  SetLength(Result, SizeOf(Word));
  CopyTIdWord(LHash, Result, 0);
end;

function TIdHash16.HashToHex(const AHash: TIdBytes): String;
begin
  Result := IntToHex(BytesToWord(AHash), 4);
end;

procedure TIdHash16.HashEnd(var VRunningHash : Word);
begin
end;

function TIdHash16.HashValue(const ASrc: string): Word;
begin
  Result := BytesToWord(HashString(ASrc));
end;

function TIdHash16.HashValue(const ASrc: TIdBytes): Word;
begin
  Result := BytesToWord(HashBytes(ASrc));
end;

function TIdHash16.HashValue(AStream: TStream): Word;
begin
  Result := BytesToWord(HashStream(AStream));
end;

function TIdHash16.HashValue(AStream: TStream; const AStartPos, ASize: Int64): Word;
begin
  Result := BytesToWord(HashStream(AStream, AStartPos, ASize));
end;

{ TIdHash32 }

function TIdHash32.GetHashBytes(AStream: TStream; ASize: Int64): TIdBytes;
const
  cBufSize = 1024; // Keep it small for dotNet
var
  I: Integer;
  LBuffer: TIdBytes;
  LSize: Integer;
  LHash: LongWord;
begin
  Result := nil;
  HashStart(LHash);

  SetLength(LBuffer, cBufSize);

  while ASize > 0 do
  begin
    LSize := ReadTIdBytesFromStream(AStream, LBuffer, Min(cBufSize, ASize));
    if LSize < 1 then begin
      Break;  // TODO: throw a stream read exception instead?
    end;
    for i := 0 to LSize - 1 do begin
      HashByte(LHash, LBuffer[i]);
    end;
    Dec(ASize, LSize);
  end;

  HashEnd(LHash); // RLebeau: TIdHashCRC32 uses this to XOR the hash with $FFFFFFFF

  SetLength(Result, SizeOf(LongWord));
  CopyTIdLongWord(LHash, Result, 0);
end;

function TIdHash32.HashToHex(const AHash: TIdBytes): String;
begin
  Result := IntToHex(BytesToLongWord(AHash), 8);
end;

procedure TIdHash32.HashEnd(var VRunningHash : LongWord);
begin
end;

function TIdHash32.HashValue(const ASrc: string): LongWord;
begin
  Result := BytesToLongWord(HashString(ASrc));
end;

function TIdHash32.HashValue(const ASrc: TIdBytes): LongWord;
begin
  Result := BytesToLongWord(HashBytes(ASrc));
end;

function TIdHash32.HashValue(AStream: TStream) : LongWord;
begin
  Result := BytesToLongWord(HashStream(AStream));
end;

function TIdHash32.HashValue(AStream: TStream; const AStartPos, ASize: Int64) : LongWord;
begin
  Result := BytesToLongWord(HashStream(AStream, AStartPos, ASize));
end;

end.
