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


  $Log$


   Rev 1.18    27.08.2004 22:03:20  Andreas Hausladen
 Optimized encoders
 speed optimization ("const" for string parameters)


   Rev 1.17    7/23/04 7:00:14 PM  RLebeau
 Added extra exception handling to DecodeString() and Encode()


   Rev 1.16    2004.06.14 9:23:06 PM  czhower
 Bug fix.


   Rev 1.15    22/05/2004 12:05:20  CCostelloe
 Bug fix


   Rev 1.14    2004.05.20 1:39:20 PM  czhower
 Last of the IdStream updates


   Rev 1.13    2004.05.20 11:37:08 AM  czhower
 IdStreamVCL


   Rev 1.12    2004.05.20 11:13:10 AM  czhower
 More IdStream conversions


   Rev 1.11    2004.05.19 3:06:48 PM  czhower
 IdStream / .NET fix


   Rev 1.10    2004.02.03 5:44:56 PM  czhower
 Name changes


   Rev 1.9    1/27/2004 3:58:16 PM  SPerry
 StringStream ->IdStringStream


   Rev 1.8    27/1/2004 1:57:58 PM  SGrobety
 Additional bug fix


   Rev 1.6    11/10/2003 7:39:22 PM  BGooijen
 Did all todo's ( TStream to TIdStream mainly )


   Rev 1.5    2003.10.02 10:52:48 PM  czhower
 .Net


   Rev 1.4    2003.06.24 12:02:08 AM  czhower
 Coders now decode properly again.


   Rev 1.3    2003.06.13 6:57:08 PM  czhower
 Speed improvement


   Rev 1.2    2003.06.13 3:41:18 PM  czhower
 Optimizaitions.


   Rev 1.1    2003.06.13 2:24:06 PM  czhower
 Speed improvement


   Rev 1.0    11/14/2002 02:14:30 PM  JPMugaas
}
unit IdCoder;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent,
  IdGlobal;

type
  TIdEncoder = class(TIdBaseComponent)
  public
    function Encode(const AIn: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    procedure Encode(const AIn: string; ADestStrings: TStrings; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ); overload;
    procedure Encode(const AIn: string; ADestStream: TStream; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ); overload;

    function Encode(ASrcStream: TStream; const ABytes: Integer = -1): string; overload;
    procedure Encode(ASrcStream: TStream; ADestStrings: TStrings; const ABytes: Integer = -1); overload;
    procedure Encode(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1); overload; virtual; abstract;

    class function EncodeString(const AIn: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    class procedure EncodeString(const AIn: string; ADestStrings: TStrings;
      AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ); overload;
    class procedure EncodeString(const AIn: string; ADestStream: TStream;
      AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ); overload;

    class function EncodeBytes(const ABytes: TIdBytes): string; overload;
    class procedure EncodeBytes(const ABytes: TIdBytes; ADestStrings: TStrings); overload;
    class procedure EncodeBytes(const ABytes: TIdBytes; ADestStream: TStream); overload;

    class function EncodeStream(ASrcStream: TStream; const ABytes: Integer = -1): string; overload;
    class procedure EncodeStream(ASrcStream: TStream; ADestStrings: TStrings; const ABytes: Integer = -1); overload;
    class procedure EncodeStream(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1); overload;
  end;

  TIdEncoderClass = class of TIdEncoder;

  TIdDecoder = class(TIdBaseComponent)
  protected
    FStream: TStream;
  public
    procedure DecodeBegin(ADestStream: TStream); virtual;
    procedure DecodeEnd; virtual;

    procedure Decode(const AIn: string); overload;
    procedure Decode(ASrcStream: TStream; const ABytes: Integer = -1); overload; virtual; abstract;

    class function DecodeString(const AIn: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    class function DecodeBytes(const AIn: string): TIdBytes;
    class procedure DecodeStream(const AIn: string; ADestStream: TStream);
  end;

  TIdDecoderClass = class of TIdDecoder;

implementation

uses
  {$IFDEF DOTNET}
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdGlobalProtocols, SysUtils;

{ TIdDecoder }

procedure TIdDecoder.DecodeBegin(ADestStream: TStream);
begin
  FStream := ADestStream;
end;

procedure TIdDecoder.DecodeEnd;
begin
  FStream := nil;
end;

procedure TIdDecoder.Decode(const AIn: string);
var
  LStream: TMemoryStream;
  LEncoding: IIdTextEncoding;
begin
  LStream := TMemoryStream.Create;
  try
    LEncoding := IndyTextEncoding_8Bit;
    WriteStringToStream(LStream, AIn, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
    LEncoding := nil;
    LStream.Position := 0;
    Decode(LStream);
  finally
    LStream.Free;
  end;
end;

class function TIdDecoder.DecodeString(const AIn: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    DecodeStream(AIn, LStream);
    LStream.Position := 0;
    EnsureEncoding(AByteEncoding, enc8Bit);
    Result := ReadStringFromStream(LStream, -1, AByteEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  finally
    LStream.Free;
  end;
end;

class function TIdDecoder.DecodeBytes(const AIn: string): TIdBytes;
var
  LStream: TMemoryStream;
begin
  Result := nil;
  LStream := TMemoryStream.Create;
  try
    DecodeStream(AIn, LStream);
    LStream.Position := 0;
    ReadTIdBytesFromStream(LStream, Result, -1);
  finally
    FreeAndNil(LStream);
  end;
end;

class procedure TIdDecoder.DecodeStream(const AIn: string; ADestStream: TStream);
var
  LDecoder: TIdDecoder;
begin
  LDecoder := Create(nil);
  try
    LDecoder.DecodeBegin(ADestStream);
    try
      LDecoder.Decode(AIn);
    finally
      LDecoder.DecodeEnd;
    end;
  finally
    LDecoder.Free;
  end;
end;

{ TIdEncoder }

function TIdEncoder.Encode(const AIn: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LStream: TMemoryStream;
begin
  if AIn <> '' then begin
    LStream := TMemoryStream.Create;
    try
      EnsureEncoding(AByteEncoding, enc8Bit);
      WriteStringToStream(LStream, AIn, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
      LStream.Position := 0;
      Result := Encode(LStream);
    finally
      FreeAndNil(LStream);
    end;
  end else begin
    Result := '';
  end;
end;

procedure TIdEncoder.Encode(const AIn: string; ADestStrings: TStrings;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    EnsureEncoding(AByteEncoding, enc8Bit);
    WriteStringToStream(LStream, AIn, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
    LStream.Position := 0;
    Encode(LStream, ADestStrings);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdEncoder.Encode(const AIn: string; ADestStream: TStream;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    EnsureEncoding(AByteEncoding, enc8Bit);
    WriteStringToStream(LStream, AIn, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
    LStream.Position := 0;
    Encode(LStream, ADestStream);
  finally
    FreeAndNil(LStream);
  end;
end;

function TIdEncoder.Encode(ASrcStream: TStream; const ABytes: Integer = -1) : string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    Encode(ASrcStream, LStream, ABytes);
    LStream.Position := 0;
    Result := ReadStringFromStream(LStream, -1, IndyTextEncoding_8Bit);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdEncoder.Encode(ASrcStream: TStream; ADestStrings: TStrings; const ABytes: Integer = -1);
var
  LStream: TMemoryStream;
begin
  ADestStrings.Clear;
  // TODO: provide an Encode() implementation that can save its output directly
  // to ADestStrings without having to waste memory encoding the data entirely
  // to memory first. In Delphi 2009+ in particular, TStrings.LoadFromStream()
  // wastes a lot of memory handling large streams...
  LStream := TMemoryStream.Create;
  try
    Encode(ASrcStream, LStream, ABytes);
    LStream.Position := 0;
    ADestStrings.LoadFromStream(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

class function TIdEncoder.EncodeString(const AIn: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LEncoder: TIdEncoder;
begin
  LEncoder := Create(nil);
  try
    Result := LEncoder.Encode(AIn, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  finally
    LEncoder.Free;
  end;
end;

class procedure TIdEncoder.EncodeString(const AIn: string; ADestStrings: TStrings;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LEncoder: TIdEncoder;
begin
  LEncoder := Create(nil);
  try
    LEncoder.Encode(AIn, ADestStrings, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  finally
    LEncoder.Free;
  end;
end;

class procedure TIdEncoder.EncodeString(const AIn: string; ADestStream: TStream;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LEncoder: TIdEncoder;
begin
  LEncoder := Create(nil);
  try
    LEncoder.Encode(AIn, ADestStream, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
  finally
    LEncoder.Free;
  end;
end;

class function TIdEncoder.EncodeBytes(const ABytes: TIdBytes): string;
var
  LStream: TMemoryStream;
begin
  if ABytes <> nil then begin
    LStream := TMemoryStream.Create;
    try
      WriteTIdBytesToStream(LStream, ABytes);
      LStream.Position := 0;
      Result := EncodeStream(LStream);
    finally
      FreeAndNil(LStream);
    end;
  end else begin
    Result := '';
  end;
end;

class procedure TIdEncoder.EncodeBytes(const ABytes: TIdBytes; ADestStrings: TStrings);
var
  LStream: TMemoryStream;
begin
  if ABytes <> nil then begin
    LStream := TMemoryStream.Create;
    try
      WriteTIdBytesToStream(LStream, ABytes);
      LStream.Position := 0;
      EncodeStream(LStream, ADestStrings);
    finally
      FreeAndNil(LStream);
    end;
  end;
end;

class procedure TIdEncoder.EncodeBytes(const ABytes: TIdBytes; ADestStream: TStream);
var
  LStream: TMemoryStream;
begin
  if ABytes <> nil then begin
    LStream := TMemoryStream.Create;
    try
      WriteTIdBytesToStream(LStream, ABytes);
      LStream.Position := 0;
      EncodeStream(LStream, ADestStream);
    finally
      FreeAndNil(LStream);
    end;
  end;
end;

class function TIdEncoder.EncodeStream(ASrcStream: TStream; const ABytes: Integer = -1): string;
var
  LEncoder: TIdEncoder;
begin
  if ASrcStream <> nil then begin
    LEncoder := Create(nil);
    try
      Result := LEncoder.Encode(ASrcStream, ABytes);
    finally
      LEncoder.Free;
    end;
  end else begin
    Result := '';
  end;
end;

class procedure TIdEncoder.EncodeStream(ASrcStream: TStream; ADestStrings: TStrings; const ABytes: Integer = -1);
var
  LEncoder: TIdEncoder;
begin
  if ASrcStream <> nil then begin
    LEncoder := Create(nil);
    try
      LEncoder.Encode(ASrcStream, ADestStrings, ABytes);
    finally
      LEncoder.Free;
    end;
  end;
end;

class procedure TIdEncoder.EncodeStream(ASrcStream: TStream; ADestStream: TStream; const ABytes: Integer = -1);
var
  LEncoder: TIdEncoder;
begin
  if ASrcStream <> nil then begin
    LEncoder := Create(nil);
    try
      LEncoder.Encode(ASrcStream, ADestStream, ABytes);
    finally
      LEncoder.Free;
    end;
  end;
end;

end.


