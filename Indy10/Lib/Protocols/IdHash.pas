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
  IdSys,
  IdObjs;

type
  TIdHash = class(TIdBaseObject);

  TIdHash16 = class(TIdHash)
  public
    function HashValue(const ASrc: string): Word; overload;
    function HashValue(AStream: TIdStream): Word; overload; virtual; abstract;
    function HashValueAsHex(const ASrc: string): String; overload;
    function HashValueAsHex(AStream: TIdStream): String; overload;
    procedure HashStart(var VRunningHash : Word); virtual; abstract;
    procedure HashByte(var VRunningHash : Word; const AByte : Byte); virtual; abstract;
  end;

  TIdHash32 = class(TIdHash)
  public
    function HashValue(const ASrc: string): LongWord; overload;
    function HashValue(AStream: TIdStream): LongWord; overload; virtual; abstract;
    function HashValueAsHex(const ASrc: string): String; overload;
    function HashValueAsHex(AStream: TIdStream): String; overload;
    procedure HashStart(var VRunningHash : LongWord); virtual; abstract;
    procedure HashByte(var VRunningHash : LongWord; const AByte : Byte); virtual; abstract;
  end;

  T4x4LongWordRecord = array [0..3] of LongWord;

  {
  RLebeau 8/27/2006 - C++Builder does not allow Delphi functions
  to return arrays in the Result, so use TIdByte results instead
  }

  TIdHash128 = class(TIdHash)
  public
    function HashValue(const ASrc: string): TIdBytes; overload;
    function HashValue(AStream: TIdStream): TIdBytes; overload; virtual; abstract;
    function HashValueAsHex(const ASrc: string): String; overload;
    function HashValueAsHex(AStream: TIdStream): String; overload;
  end;

  T5x4LongWordRecord = array [0..4] of LongWord;

  TIdHash160 = class(TIdHash)
  public
    function HashValue(const ASrc: string): TIdBytes; overload;
    function HashValue(AStream: TIdStream): TIdBytes; overload; virtual; abstract;
    function HashValueAsHex(const ASrc: string): String; overload;
    function HashValueAsHex(AStream: TIdStream): String; overload;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols;

{ TIdHash16 }

function TIdHash16.HashValue(const ASrc: string): Word;
var
  LStream: TIdStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TIdMemoryStream.Create; try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashValue(LStream);
  finally Sys.FreeAndNil(LStream); end;
end;

function TIdHash16.HashValueAsHex(const ASrc: string): String;
begin
  Result := Sys.IntToHex(HashValue(ASrc), 4);
end;

function TIdHash16.HashValueAsHex(AStream: TIdStream): String;
begin
  Result := Sys.IntToHex(HashValue(AStream), 4);
end;

{ TIdHash32 }

function TIdHash32.HashValue(const ASrc: string): LongWord;
var
  LStream: TIdStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TIdMemoryStream.Create; try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashValue(LStream);
  finally Sys.FreeAndNil(LStream); end;
end;

function TIdHash32.HashValueAsHex(const ASrc: string): String;
begin
  Result := Sys.IntToHex(HashValue(ASrc), 8);
end;

function TIdHash32.HashValueAsHex(AStream: TIdStream): String;
begin
  Result := Sys.IntToHex(HashValue(AStream), 8);
end;

{ TIdHash128 }

function TIdHash128.HashValue(const ASrc: string): TIdBytes;
var
  LStream: TIdStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TIdMemoryStream.Create;
  try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashValue(LStream);
  finally
    Sys.FreeAndNil(LStream);
  end;
end;

function TIdHash128.HashValueAsHex(const ASrc: string): string;
begin
  Result := ToHex(HashValue(ASrc));
end;

function TIdHash128.HashValueAsHex(AStream: TIdStream): string;
begin
  Result := ToHex(HashValue(AStream));
end;

{ TIdHash160 }

function TIdHash160.HashValue(const ASrc: string): TIdBytes;
var
  LStream: TIdStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TIdMemoryStream.Create;
  try
    WriteStringToStream(LStream, ASrc);
    LStream.Position := 0;
    Result := HashValue(LStream);
  finally
    Sys.FreeAndNil(LStream);
  end;
end;

function TIdHash160.HashValueAsHex(const ASrc: string): String;
begin
  Result := ToHex(HashValue(ASrc));
end;

function TIdHash160.HashValueAsHex(AStream: TIdStream): String;
begin
  Result := ToHex(HashValue(AStream));
end;

end.
