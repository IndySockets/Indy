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
  Rev 1.7    27.08.2004 22:04:00  Andreas Hausladen
  speed optimization ("const" for string parameters)

  Rev 1.6    2004.05.20 1:39:16 PM  czhower
  Last of the IdStream updates

  Rev 1.5    2004.05.20 11:37:00 AM  czhower
  IdStreamVCL

  Rev 1.4    2004.05.20 11:13:06 AM  czhower
  More IdStream conversions

  Rev 1.3    2004.05.19 3:06:44 PM  czhower
  IdStream / .NET fix

  Rev 1.2    2004.02.03 5:44:06 PM  czhower
  Name changes

    Rev 1.1    5/9/2003 2:14:42 PM  BGooijen
  Streams are now buffered, speed is now about 75 times as fast as before

  Rev 1.0    11/13/2002 07:57:22 AM  JPMugaas
}

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen (bas_gooijen@yahoo.com)                          *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*  yEnc messagepart encoder/decoded                                         *}
{*                                                                           *}
{* QUICK NOTES:                                                              *}
{*   MULTIPART-MESSAGES ARE _NOT_ SUPPORTED                                  *}
{*   THIS CODE IS ALPHA                                                      *}
{*                                                                           *}
{*   implemented according to version 1.3                                    *}
{*   http://www.easynews.com/yenc/yenc-draft.1.3.txt                         *}
{*   http://www.easynews.com/yenc/yEnc-Notes3.txt                            *}
{*   http://www.yenc.org/develop.htm                                         *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 07/07/2002    1.0   Bas Gooijen  Initial start                            *}
{*****************************************************************************}

unit IdMessageCoderYenc;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdMessageCoder, IdMessage, IdExceptionCore, IdGlobal;

type
  EIdMessageYencException = class(EIdMessageException);

  EIdMessageYencInvalidSizeException = class(EIdMessageYencException);
  EIdMessageYencInvalidCRCException = class(EIdMessageYencException);
  EIdMessageYencCorruptionException = class(EIdMessageYencException);

  TIdMessageDecoderYenc = class(TIdMessageDecoder)
  protected
    FPart: Integer;
    FLine: Integer;
    FSize: Integer;
  public
    function ReadBody(ADestStream: TStream; var AMsgEnd: Boolean): TIdMessageDecoder; override;
  end;

  TIdMessageDecoderInfoYenc = class(TIdMessageDecoderInfo)
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; override;
  end;

  TIdMessageEncoderYenc = class(TIdMessageEncoder)
  public
    procedure Encode(ASrc: TStream; ADest: TStream); override;
  end;

  TIdMessageEncoderInfoYenc = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
    procedure InitializeHeaders(AMsg: TIdMessage); override;
  end;

const
  BUFLEN = 4096;
  //fixed chars in integer form for easy byte comparison
  B_PERIOD = $2E;
  B_EQUALS = $3D;
  B_TAB = $09;
  B_LF = $0A;
  B_CR = $0D;
  B_NUL = $00;

implementation

uses
  {$IFDEF DOTNET}
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdHashCRC,
  IdResourceStringsProtocols,
  SysUtils;

function GetStrValue(const Line, Option: string; const AMaxCount: Integer = MaxInt) : string;
var
  LStart, LEnd: Integer;
begin
  LStart := IndyPos(LowerCase(Option) + '=', LowerCase(Line));
  if LStart = 0 then
  begin
    Result := '';  {Do not Localize}
    Exit;
  end;
  Inc(LStart, Length(Option) + 1);
  Result := Copy(Line, LStart, AMaxCount);
  LEnd := IndyPos(' ', Result) ; {Do not Localize}
  if LEnd > 0 then begin
    Result := Copy(Result, 1, LEnd - 1);
  end;
end;

function GetIntValue(const Line, Option: string): Integer;
var
  LValue: String;
begin
  LValue := GetStrValue(Line, Option, $FFFF);
  if LValue <> '' then begin
    Result := IndyStrToInt(LValue);
  end else begin
    Result := 0;
  end;
end;

{ TIdMessageDecoderInfoYenc }

function TIdMessageDecoderInfoYenc.CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder;

  function GetName: string;
  var
    LStart: Integer;
  begin
    LStart := IndyPos('name=', LowerCase(ALine)); {Do not Localize}
    if LStart > 0 then begin
      Result := Copy(ALine, LStart+5, MaxInt);
    end else begin
      Result := '';
    end;
  end;

var
  LYenc: TIdMessageDecoderYenc;
begin
  if TextStartsWith(ALine, '=ybegin ') {Do not Localize} then
  begin
    LYenc := TIdMessageDecoderYenc.Create(ASender);
    try
      LYenc.FSize := GetIntValue(ALine, 'size'); {Do not Localize}
      LYenc.FLine := GetIntValue(ALine, 'line'); {Do not Localize}
      LYenc.FPart := GetIntValue(ALine, 'part'); {Do not Localize}
      LYenc.FFilename := GetName;
      LYenc.FPartType := mcptAttachment;
    except
      FreeAndNil(LYenc);
      raise;
    end;
    Result := LYenc;
  end else begin
    Result := nil;
  end;
end;

{ TIdMessageDecoderYenc }

function TIdMessageDecoderYenc.ReadBody(ADestStream: TStream; var AMsgEnd: Boolean): TIdMessageDecoder;
var
  LLine: string;
  LLinePos: Integer;
  LChar: Byte;
  LBytesDecoded: Integer;
  LPartSize: Integer;
  LCrc32: string;
  LMsgEnd: Boolean;
  LOutputBuffer: TIdBytes;
  LOutputBufferUsed: Integer;
  LHash: UInt32;
  LH: TIdHashCRC32;
  LEncoding: IIdTextEncoding;

  procedure FlushOutputBuffer;
  begin
    //TODO: this uses Array of Characters. Unless its dealing in Unicode or MBCS it should
    // be using TIdBuffer
    if Assigned(ADestStream) then begin
      WriteTIdBytesToStream(ADestStream, LOutputBuffer, LOutputBufferUsed);
    end;
    LOutputBufferUsed := 0;
  end;

  procedure AddByteToOutputBuffer(const AChar: Byte);
  begin
    LOutputBuffer[LOutputBufferUsed] := AChar;
    Inc(LOutputBufferUsed);
    if LOutputBufferUsed >= BUFLEN then begin
      FlushOutputBuffer;
    end;
  end;

begin
  SetLength(LOutputBuffer, BUFLEN);
  AMsgEnd := False;
  Result := nil;
  LPartSize := FSize;
  LOutputBufferUsed := 0;
  LBytesDecoded := 0;

  LH := TIdHashCRC32.Create;
  try
    LH.HashStart(LHash);
    //note that we have to do hashing here because there's no seek
    // in the TStream class, changing definitions in this API might
    // break something, and storing in an extra buffer will just eat space
    LEncoding := IndyTextEncoding_8Bit;
    repeat
      LLine := ReadLnRFC(LMsgEnd, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      if (IndyPos('=yend', LowerCase(LLine)) <> 0) or LMsgEnd then {Do not Localize}
      begin
        Break;
      end;
      if TextStartsWith(LLine, '=ypart ') then begin {Do not Localize}
        LPartSize := GetIntValue(LLine, 'end') - GetIntValue(LLine, 'begin') + 1; {Do not Localize}
      end
      else begin
        LLinePos := 1;
        while LLinePos <= Length(LLine) do
        begin
          LChar := Byte(LLine[LLinePos]);
          if LChar = B_EQUALS then begin
            // invalid file, escape character may not appear at end of line
            if LLinePos = Length(LLine) then begin
              raise EIdMessageYencCorruptionException.Create(RSYencFileCorrupted);
            end;
            Inc(LLinePos);
            LChar := Byte(LLine[LLinePos]);
            Dec(LChar, 64);
          end;
          Dec(LChar, 42);
          AddByteToOutputBuffer(LChar);
          LH.HashByte(LHash, LChar);
          Inc(LLinePos);
          Inc(LBytesDecoded);
        end;
      end;
    until False;
    LH.HashEnd(LHash);

    FlushOutputBuffer;
    if LPartSize <> LBytesDecoded then begin
      raise EIdMessageYencInvalidSizeException.Create(RSYencInvalidSize);
    end;

    LCrc32 := LowerCase(GetStrValue(LLine, 'crc32', $FFFF)); {Do not Localize}
    if LCrc32 <> '' then begin
      //done this way because values can be computed faster than strings and we don't
      //have to mess with charactor case.
      if IndyStrToInt64('$' + LCrc32) <> LHash then begin
        raise EIdMessageYencInvalidCRCException.Create(RSYencInvalidCRC);
      end;
    end;
  finally
    FreeAndNil(LH);
  end;
end;

constructor TIdMessageEncoderInfoYenc.Create;
begin
  inherited Create;
  FMessageEncoderClass := TIdMessageEncoderYenc;
end;

procedure TIdMessageEncoderInfoYenc.InitializeHeaders(AMsg: TIdMessage);
begin
//
end;

{ TIdMessageEncoderYenc }

procedure TIdMessageEncoderYenc.Encode(ASrc: TStream; ADest: TStream);
const
  LineSize = 128;
var
  s: String;
  i, LSSize: TIdStreamSize;
  LInput: Byte;
  LOutput: Byte;
  LCurrentLineLength: Integer;

  LOutputBuffer: TIdBytes;
  LOutputBufferUsed: Integer;

  LInputBuffer: TIdBytes;
  LInputBufferPos: Integer;
  LInputBufferSize: Integer;
  LHash: UInt32;
  LH: TIdHashCRC32;

  procedure FlushOutputBuffer;
  begin
    WriteTIdBytesToStream(ADest, LOutputBuffer, LOutputBufferUsed);
    LOutputBufferUsed := 0;
  end;

  procedure AddByteToOutputBuffer(const AChar: Byte);
  begin
    LOutputBuffer[LOutputBufferUsed] := AChar;
    Inc(LOutputBufferUsed);
    if LOutputBufferUsed >= BUFLEN then begin
      FlushOutputBuffer;
    end;
  end;

  function ReadByteFromInputBuffer: Byte;
  begin
    if LInputBufferPos >= LInputBufferSize then begin
      LInputBufferSize := ReadTIdBytesFromStream(ASrc, LInputBuffer, BUFLEN);
      LInputBufferPos := 0;
    end;
    Result := LInputBuffer[LInputBufferPos];
    Inc(LInputBufferPos);
  end;

begin
  SetLength(LOutputBuffer, BUFLEN);
  SetLength(LInputBuffer, BUFLEN);
  LSSize := IndyLength(ASrc);
  LCurrentLineLength := 0;
  LOutputBufferUsed := 0;

  LH := TIdHashCRC32.Create;
  try
    LH.HashStart(LHash);
    s := '=ybegin line=' + IntToStr(LineSize) + ' size=' + IntToStr(LSSize) + ' name=' + FFilename + EOL;  {do not localize}
    WriteStringToStream(ADest, s);

    i := 0;
    while i < LSSize do
    begin
      LInput := ReadByteFromInputBuffer;
      Inc(i);
      LH.HashByte(LHash, LInput);
      LOutput := LInput;
      Inc(LOutput, 42);
      if LOutput in [B_NUL, B_LF, B_CR, B_EQUALS, B_TAB, B_PERIOD] then begin {do not localize}
        AddByteToOutputBuffer(B_EQUALS);
        Inc(LCurrentLineLength);
        Inc(LOutput, 64);
      end;
      AddByteToOutputBuffer(LOutput);
      Inc(LCurrentLineLength);
      if LCurrentLineLength = 1 then begin
        if LOutput = B_PERIOD then begin
         AddByteToOutputBuffer(LOutput);
         Inc(LCurrentLineLength);
        end;
      end;

      if LCurrentLineLength >= LineSize then
      begin
        AddByteToOutputBuffer(B_CR);
        AddByteToOutputBuffer(B_LF);
        LCurrentLineLength := 0;
      end;
    end;

    FlushOutputBuffer;

    s := EOL + '=yend size=' + IntToStr(LSSize) + ' crc32=' + {do not localize}
      LowerCase(IntToHex(LHash, 8)) + EOL;

    WriteStringToStream(ADest, s);
  finally
    FreeAndNil(LH);
  end;
end;

initialization
  TIdMessageDecoderList.RegisterDecoder('yEnc', TIdMessageDecoderInfoYenc.Create); {Do not Localize}
  TIdMessageEncoderList.RegisterEncoder('yEnc', TIdMessageEncoderInfoYenc.Create); {Do not Localize}
end.

