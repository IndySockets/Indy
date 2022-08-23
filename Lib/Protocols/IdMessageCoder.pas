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
  Rev 1.15    10/26/2004 10:27:42 PM  JPMugaas
  Updated refs.

  Rev 1.14    27.08.2004 22:03:58  Andreas Hausladen
  speed optimization ("const" for string parameters)

  Rev 1.13    8/10/04 1:41:00 PM  RLebeau
  Added FreeSourceStream property to TIdMessageDecoder

  Rev 1.12    7/23/04 6:43:26 PM  RLebeau
  Added extra exception handling to Encode()

  Rev 1.11    29/05/2004 21:22:40  CCostelloe
  Added support for decoding attachments with a Content-Transfer-Encoding of
  binary

  Rev 1.10    2004.05.20 1:39:12 PM  czhower
  Last of the IdStream updates

  Rev 1.9    2004.05.20 11:36:56 AM  czhower
  IdStreamVCL

  Rev 1.8    2004.05.20 11:12:58 AM  czhower
  More IdStream conversions

  Rev 1.7    2004.05.19 3:06:38 PM  czhower
  IdStream / .NET fix

  Rev 1.6    2004.02.03 5:44:02 PM  czhower
  Name changes

  Rev 1.5    1/21/2004 1:17:20 PM  JPMugaas
  InitComponent

  Rev 1.4    10/11/2003 4:40:24 PM  BGooijen
  Fix for DotNet

  Rev 1.3    10/10/2003 10:42:54 PM  BGooijen
  DotNet

  Rev 1.2    26/09/2003 01:04:22  CCostelloe
  Minor change, if any

  Rev 1.1    07/08/2003 00:46:46  CCostelloe
  Function ReadLnSplit added

  Rev 1.0    11/13/2002 07:57:04 AM  JPMugaas
}

unit IdMessageCoder;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdComponent,
  IdGlobal,
  IdMessage,
  IdBaseComponent;

type
  TIdMessageCoderPartType = (mcptText, mcptAttachment, mcptIgnore, mcptEOF);

  TIdMessageDecoder = class(TIdComponent)
  protected
    FFilename: string;
    FFreeSourceStream: Boolean;
    // Dont use TIdHeaderList for FHeaders - we dont know that they will all be like MIME.
    FHeaders: TStrings;
    FPartType: TIdMessageCoderPartType;
    FSourceStream: TStream;
    procedure InitComponent; override;
  public
    function ReadBody(ADestStream: TStream; var AMsgEnd: Boolean): TIdMessageDecoder; virtual; abstract;
    procedure ReadHeader; virtual;
    //CC: ATerminator param added because Content-Transfer-Encoding of binary needs
    //an ATerminator of EOL...
    function ReadLn(const ATerminator: string = LF; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    //RLebeau: added for RFC 822 retrieves
    function ReadLnRFC(var VMsgEnd: Boolean; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): String; overload;
    function ReadLnRFC(var VMsgEnd: Boolean; const ALineTerminator: String;
      const ADelim: String = '.'; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): String; overload; {do not localize}
    destructor Destroy; override;
    //
    property Filename: string read FFilename;
    property FreeSourceStream: Boolean read FFreeSourceStream write FFreeSourceStream;
    property Headers: TStrings read FHeaders;
    property PartType: TIdMessageCoderPartType read FPartType;
    property SourceStream: TStream read FSourceStream write FSourceStream;
  end;

  TIdMessageDecoderInfo = class
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; virtual;
     abstract;
    constructor Create; virtual;
  end;

  TIdMessageDecoderList = class
  protected
    FMessageCoders: TStrings;
  public
    class function ByName(const AName: string): TIdMessageDecoderInfo;
    class function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder;
    constructor Create;
    destructor Destroy; override;
    class procedure RegisterDecoder(const AMessageCoderName: string;
     AMessageCoderInfo: TIdMessageDecoderInfo);
  end;

  TIdMessageEncoder = class(TIdComponent)
  protected
    FFilename: string;
    FPermissionCode: integer;
    //
    procedure InitComponent; override;
  public
    procedure Encode(const AFilename: string; ADest: TStream); overload;
    procedure Encode(ASrc: TStream; ADest: TStrings); overload;
    procedure Encode(ASrc: TStream; ADest: TStream); overload; virtual; abstract;
  published
    property Filename: string read FFilename write FFilename;
    property PermissionCode: integer read FPermissionCode write FPermissionCode;
  end;

  TIdMessageEncoderClass = class of TIdMessageEncoder;

  TIdMessageEncoderInfo = class
  protected
    FMessageEncoderClass: TIdMessageEncoderClass;
  public
    constructor Create; virtual;
    procedure InitializeHeaders(AMsg: TIdMessage); virtual;
    //
    property MessageEncoderClass: TIdMessageEncoderClass read FMessageEncoderClass;
  end;

  TIdMessageEncoderList = class
  protected
    FMessageCoders: TStrings;
  public
    class function ByName(const AName: string): TIdMessageEncoderInfo;
    constructor Create;
    destructor Destroy; override;
    class procedure RegisterEncoder(const AMessageEncoderName: string;
     AMessageEncoderInfo: TIdMessageEncoderInfo);
  end;

implementation

uses
  IdException, IdResourceStringsProtocols,
  IdTCPStream, IdBuffer, SysUtils;

var
  GMessageDecoderList: TIdMessageDecoderList = nil;
  GMessageEncoderList: TIdMessageEncoderList = nil;

{ TIdMessageDecoderList }

class function TIdMessageDecoderList.ByName(const AName: string): TIdMessageDecoderInfo;
var
  I: Integer;
begin
  Result := nil;
  if GMessageDecoderList <> nil then begin
    I := GMessageDecoderList.FMessageCoders.IndexOf(AName);
    if I <> -1 then begin
      Result := TIdMessageDecoderInfo(GMessageDecoderList.FMessageCoders.Objects[I]);
    end;
  end;
  if Result = nil then begin
    raise EIdException.Create(RSMessageDecoderNotFound + ': ' + AName);    {Do not Localize} // TODO: create a new Exception class for this
  end;
end;

class function TIdMessageDecoderList.CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder;
var
  i: integer;
begin
  Result := nil;
  if GMessageDecoderList <> nil then begin
    for i := 0 to GMessageDecoderList.FMessageCoders.Count - 1 do begin
      Result := TIdMessageDecoderInfo(GMessageDecoderList.FMessageCoders.Objects[i]).CheckForStart(ASender, ALine);
      if Result <> nil then begin
        Break;
      end;
    end;
  end;
end;

constructor TIdMessageDecoderList.Create;
begin
  inherited;
  FMessageCoders := TStringList.Create;
end;

destructor TIdMessageDecoderList.Destroy;
{$IFNDEF USE_OBJECT_ARC}
var
  i: integer;
{$ENDIF}
begin
  {$IFNDEF USE_OBJECT_ARC}
  for i := 0 to FMessageCoders.Count - 1 do begin
    TIdMessageDecoderInfo(FMessageCoders.Objects[i]).Free;
  end;
  {$ENDIF}
  FreeAndNil(FMessageCoders);
  inherited Destroy;
end;

class procedure TIdMessageDecoderList.RegisterDecoder(const AMessageCoderName: string;
 AMessageCoderInfo: TIdMessageDecoderInfo);
begin
  if GMessageDecoderList = nil then begin
    GMessageDecoderList := TIdMessageDecoderList.Create;
  end;
  GMessageDecoderList.FMessageCoders.AddObject(AMessageCoderName, AMessageCoderInfo);
end;

{ TIdMessageDecoderInfo }

constructor TIdMessageDecoderInfo.Create;
begin
  inherited Create;
end;

{ TIdMessageDecoder }

procedure TIdMessageDecoder.InitComponent;
begin
  inherited;
  FFreeSourceStream := True;
  FHeaders := TStringList.Create;
end;

destructor TIdMessageDecoder.Destroy;
begin
  FreeAndNil(FHeaders);
  if FFreeSourceStream then begin
    FreeAndNil(FSourceStream);
  end else begin
    FSourceStream := nil;
  end;
  inherited Destroy;
end;

procedure TIdMessageDecoder.ReadHeader;
begin
end;

// this is copied from TIdIOHandler.ReadLn() and then adjusted to read from
// a TStream, with the same sematics as Idglobal.ReadLnFromStream() but with
// support for searching for a caller-specified terminator.
function DoReadLnFromStream(AStream: TStream; ATerminator: string;
  AMaxLineLength: Integer = -1; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
const
  LBUFMAXSIZE = 2048;
var
  LBuffer: TIdBuffer;
  LSize: Integer;
  LStartPos: Integer;
  LTermPos: Integer;
  LTerm, LTemp: TIdBytes;
  LStrmStartPos, LStrmPos, LStrmSize: TIdStreamSize;
begin
  Assert(AStream<>nil);
  LTerm := nil; // keep the compiler happy

  { we store the stream size for the whole routine to prevent
  so do not incur a performance penalty with TStream.Size.  It has
  to use something such as Seek each time the size is obtained}
  {4 seek vs 3 seek}
  LStrmStartPos := AStream.Position;
  LStrmPos := LStrmStartPos;
  LStrmSize := AStream.Size;

  if LStrmPos >= LStrmSize then begin
    Result := '';
    Exit;
  end;

  SetLength(LTemp, LBUFMAXSIZE);
  LBuffer := TIdBuffer.Create;
  try
    EnsureEncoding(AByteEncoding);
    {$IFDEF STRING_IS_ANSI}
    EnsureEncoding(ADestEncoding, encOSDefault);
    {$ENDIF}
    if AMaxLineLength < 0 then begin
      AMaxLineLength := MaxInt;
    end;
    // User may pass '' if they need to pass arguments beyond the first.
    if ATerminator = '' then begin
      ATerminator := LF;
    end;
    LTerm := ToBytes(ATerminator, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
      );
    LTermPos := -1;
    LStartPos := 0;
    repeat
      LSize := IndyMin(LStrmSize - LStrmPos, LBUFMAXSIZE);
      LSize := ReadTIdBytesFromStream(AStream, LTemp, LSize);
      if LSize < 1 then begin
        LStrmPos := LStrmStartPos + LBuffer.Size;
        Break;
      end;
      Inc(LStrmPos, LSize);
      LBuffer.Write(LTemp, LSize, 0);

      LTermPos := LBuffer.IndexOf(LTerm, LStartPos);
      if LTermPos > -1 then begin
        if (AMaxLineLength > 0) and (LTermPos > AMaxLineLength) then begin
          LStrmPos := LStrmStartPos + AMaxLineLength;
          LTermPos := AMaxLineLength;
        end else begin
          LStrmPos := LStrmStartPos + LTermPos + Length(LTerm);
        end;
        Break;
      end;

      LStartPos := IndyMax(LBuffer.Size-(Length(LTerm)-1), 0);
      if (AMaxLineLength > 0) and (LStartPos >= AMaxLineLength) then begin
        LStrmPos := LStrmStartPos + AMaxLineLength;
        LTermPos := AMaxLineLength;
        Break;
      end;
    until LStrmPos >= LStrmSize;

    // Extract actual data
    if (ATerminator = LF) and (LTermPos > 0) and (LTermPos < LBuffer.Size) then begin
      if (LBuffer.PeekByte(LTermPos) = Ord(LF)) and
         (LBuffer.PeekByte(LTermPos-1) = Ord(CR)) then begin
        Dec(LTermPos);
      end;
    end;

    AStream.Position := LStrmPos;
    Result := LBuffer.ExtractToString(LTermPos, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
      );
  finally
    LBuffer.Free;
  end;
end;

function TIdMessageDecoder.ReadLn(const ATerminator: string = LF;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
begin
  if SourceStream is TIdTCPStream then begin
    Result := TIdTCPStream(SourceStream).Connection.IOHandler.ReadLn(
      ATerminator, IdTimeoutDefault, -1, AByteEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
      );
  end else begin
    Result := DoReadLnFromStream(SourceStream, ATerminator, -1, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}
      );
  end;
end;

function TIdMessageDecoder.ReadLnRFC(var VMsgEnd: Boolean;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): String;
begin
  Result := ReadLnRFC(VMsgEnd, LF, '.', AByteEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF}); {do not localize}
end;

function TIdMessageDecoder.ReadLnRFC(var VMsgEnd: Boolean; const ALineTerminator: String;
  const ADelim: String = '.'; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): String;
begin
  Result := ReadLn(ALineTerminator, AByteEncoding{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  // Do not use ATerminator since always ends with . (standard)
  if Result = ADelim then {do not localize}
  begin
    VMsgEnd := True;
    Exit;
  end;
  if TextStartsWith(Result, '..') then begin {do not localize}
    IdDelete(Result, 1, 1);
  end;
  VMsgEnd := False;
end;


{ TIdMessageEncoderInfo }

constructor TIdMessageEncoderInfo.Create;
begin
  inherited Create;
end;

procedure TIdMessageEncoderInfo.InitializeHeaders(AMsg: TIdMessage);
begin
//
end;

{ TIdMessageEncoderList }

class function TIdMessageEncoderList.ByName(const AName: string): TIdMessageEncoderInfo;
var
  I: Integer;
begin
  Result := nil;
  if GMessageEncoderList <> nil then begin
    I := GMessageEncoderList.FMessageCoders.IndexOf(AName);
    if I <> -1 then begin
      Result := TIdMessageEncoderInfo(GMessageEncoderList.FMessageCoders.Objects[I]);
    end;
  end;
  if Result = nil then begin
    raise EIdException.Create(RSMessageEncoderNotFound + ': ' + AName);    {Do not Localize} // TODO: create a new Exception class for this
  end;
end;

constructor TIdMessageEncoderList.Create;
begin
  inherited;
  FMessageCoders := TStringList.Create;
end;

destructor TIdMessageEncoderList.Destroy;
{$IFNDEF USE_OBJECT_ARC}
var
  i: integer;
{$ENDIF}
begin
  {$IFNDEF USE_OBJECT_ARC}
  for i := 0 to FMessageCoders.Count - 1 do begin
    TIdMessageEncoderInfo(FMessageCoders.Objects[i]).Free;
  end;
  {$ENDIF}
  FreeAndNil(FMessageCoders);
  inherited Destroy;
end;

class procedure TIdMessageEncoderList.RegisterEncoder(const AMessageEncoderName: string;
 AMessageEncoderInfo: TIdMessageEncoderInfo);
begin
  if GMessageEncoderList = nil then begin
    GMessageEncoderList := TIdMessageEncoderList.Create;
  end;
  GMessageEncoderList.FMessageCoders.AddObject(AMessageEncoderName, AMessageEncoderInfo);
end;

{ TIdMessageEncoder }

procedure TIdMessageEncoder.Encode(const AFilename: string; ADest: TStream);
var
  LSrcStream: TStream;
begin
  LSrcStream := TIdReadFileExclusiveStream.Create(AFileName); try
    Encode(LSrcStream, ADest);
  finally FreeAndNil(LSrcStream); end;
end;

procedure TIdMessageEncoder.Encode(ASrc: TStream; ADest: TStrings);
var
  LDestStream: TStream;
begin
  // TODO: provide an Encode() implementation that can save its output directly
  // to ADest without having to waste memory encoding the data entirely to
  // memory first. In Delphi 2009+ in particular, TStrings.LoadFromStream()
  // wastes a lot of memory handling large streams...
  LDestStream := TMemoryStream.Create; try
    Encode(ASrc, LDestStream);
    LDestStream.Position := 0;
    ADest.LoadFromStream(LDestStream);
  finally FreeAndNil(LDestStream); end;
end;

procedure TIdMessageEncoder.InitComponent;
begin
  inherited InitComponent;
  FPermissionCode := 660;
end;

initialization
finalization
  FreeAndNil(GMessageDecoderList);
  FreeAndNil(GMessageEncoderList);
end.
