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
  Rev 1.13    27.08.2004 22:04:00  Andreas Hausladen
  speed optimization ("const" for string parameters)

  Rev 1.12    2004.05.20 1:39:16 PM  czhower
  Last of the IdStream updates

  Rev 1.11    2004.05.20 11:36:58 AM  czhower
  IdStreamVCL

  Rev 1.10    2004.05.20 11:13:02 AM  czhower
  More IdStream conversions

  Rev 1.9    2004.05.19 3:06:42 PM  czhower
  IdStream / .NET fix

  Rev 1.8    2004.02.03 5:44:04 PM  czhower
  Name changes

  Rev 1.7    2004.01.22 5:56:54 PM  czhower
  TextIsSame

  Rev 1.6    1/21/2004 2:20:24 PM  JPMugaas
  InitComponent

  Rev 1.5    1/21/2004 1:30:10 PM  JPMugaas
  InitComponent

    Rev 1.4    10/17/2003 12:41:16 AM  DSiders
  Added localization comments.

  Rev 1.3    26/09/2003 01:06:18  CCostelloe
  CodingType property added so caller can find out if it was UUE or XXE encoded

  Rev 1.2    6/14/2003 03:07:20 PM  JPMugaas
  Fixed MessageDecoder so that DecodeBegin is called right after creation and
  DecodeEnd is called just before destruction.  I also fixed where the code was
  always assuming that LDecode was always being created.

  Rev 1.1    6/13/2003 07:58:44 AM  JPMugaas
  Should now compile with new decoder design.

  Rev 1.0    11/13/2002 07:57:14 AM  JPMugaas

2003-Sep-20 Ciaran Costelloe
  CodingType property added so caller can find out if it was UUE or XXE encoded
}

unit IdMessageCoderUUE;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCoder3to4,
  IdMessageCoder,
  IdMessage,
  IdGlobal;

type
  TIdMessageDecoderUUE = class(TIdMessageDecoder)
  protected
    FCodingType: string;
  public
    function ReadBody(ADestStream: TStream; var AMsgEnd: Boolean): TIdMessageDecoder; override;
    property CodingType: string read FCodingType;
  end;

  TIdMessageDecoderInfoUUE = class(TIdMessageDecoderInfo)
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; override;
  end;

  TIdMessageEncoderUUEBase = class(TIdMessageEncoder)
  protected
    FEncoderClass: TIdEncoder3to4Class; // TODO: change to "class of TIdEncoder00E" instead
  public
    procedure Encode(ASrc: TStream; ADest: TStream); override;
  end;

  TIdMessageEncoderUUE = class(TIdMessageEncoderUUEBase)
  protected
    procedure InitComponent; override;
  end;

  TIdMessageEncoderInfoUUE = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
  end;

implementation

uses
  IdCoderUUE, IdCoderXXE, IdException, IdGlobalProtocols, IdResourceStringsProtocols, SysUtils;

{ TIdMessageDecoderInfoUUE }

function TIdMessageDecoderInfoUUE.CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder;
var
  LUUE: TIdMessageDecoderUUE;
begin
  Result := nil;
  if TextStartsWith(ALine, 'begin ') and CharEquals(ALine, 10, ' ') and IsNumeric(ALine, 3, 7) then begin {Do not Localize}
    LUUE := TIdMessageDecoderUUE.Create(ASender);
    LUUE.FFilename := Copy(ALine, 11, MaxInt);
    LUUE.FPartType := mcptAttachment;
    Result := LUUE;
  end;
end;

{ TIdMessageDecoderUUE }

function TIdMessageDecoderUUE.ReadBody(ADestStream: TStream; var AMsgEnd: Boolean): TIdMessageDecoder;
var
  LDecoder: TIdDecoder4to3;
  LLine: string;
  LMsgEnd: Boolean;
  LEncoding: IIdTextEncoding;
  LFillCharStr: string;
begin
  Result := nil;
  AMsgEnd := False;
  LEncoding := IndyTextEncoding_8Bit;
  LLine := ReadLnRFC(LMsgEnd, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  if LMsgEnd then begin
    Exit;
  end;
  LDecoder := nil;
  if Length(LLine) > 0 then
  begin
    case LLine[1] of
      #32..#85: begin    {Do not Localize}
        // line length may be from 2 (first char + newline) to 65,
        // this is 0 useable to 63 usable bytes, + #32 gives this as a range.
        // (yes, the line length is encoded in the first bytes of each line!)

        // TODO: need to do a better job of differentiating between UUE and XXE.
        //
        // UUE and XXE both encode 45 bytes max per line. Each line starts with
        // an encoded character that indicates the number of encoded bytes in the
        // line, not counting padding.
        //
        // UUE encodes the byte count as one of the following characters:
        //
        //    0         1         2         3         4
        //    0123456789012345678901234567890123456789012345
        //    `!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLM
        //
        // XXE encodes the byte count as one of the following characters:
        //
        //    0         1         2         3         4
        //    0123456789012345678901234567890123456789012345
        //    +-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgh
        //    (some encoders use [space] instead of +)
        //
        // Without external information to indicate the actual encoding, if we
        // get input whose encoded byte length is encoded as one of the following
        // characters:
        //
        //    -0123456789ABCDEFGHIJKLM
        //
        // We will not know if it is actually UUE or XXE.  About all we could do
        // is calculate the expected input length in both encodings based on the
        // starting character and then check if the input actually matches one
        // of them...

        LDecoder := TIdDecoderUUE.Create(nil);
        LDecoder.DecodeBegin(ADestStream);
        FCodingType := 'UUE'; {do not localize}
      end;
      'h': begin  {do not localize}
        LDecoder := TIdDecoderXXE.Create(nil);
        LDecoder.DecodeBegin(ADestStream);
        FCodingType := 'XXE'; {do not localize}
      end;
      else begin
        raise EIdException.Create(RSUnrecognizedUUEEncodingScheme); // TODO: create a new Exception class for this
      end;
    end;
  end;
  try
    if Assigned(LDecoder) then
    begin
      LFillCharStr := String(LDecoder.FillChar);
      repeat
        if (Length(Trim(LLine)) = 0) or (LLine = LFillCharStr) then begin
          // UUE: Comes on the line before end. Supposed to be `, but some put a
          // blank line instead
        end else begin
          LDecoder.Decode(LLine);
        end;
        LLine := ReadLnRFC(LMsgEnd, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
      until TextIsSame(Trim(LLine), 'end') or LMsgEnd;    {Do not Localize}
      LDecoder.DecodeEnd;
    end;
  finally
    FreeAndNil(LDecoder);
  end;
end;

{ TIdMessageEncoderInfoUUE }

constructor TIdMessageEncoderInfoUUE.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderUUE;
end;

{ TIdMessageEncoderUUEBase }

procedure TIdMessageEncoderUUEBase.Encode(ASrc: TStream; ADest: TStream);
var
  LEncoder: TIdEncoder3to4;
begin
  ASrc.Position := 0;
  WriteStringToStream(ADest, 'begin ' + IntToStr(PermissionCode) + ' ' + Filename + EOL); {Do not Localize}
  LEncoder := FEncoderClass.Create(nil); try
    while ASrc.Position < ASrc.Size do begin
      LEncoder.Encode(ASrc, ADest, 45);
      WriteStringToStream(ADest, EOL);
    end;
    WriteStringToStream(ADest, String(LEncoder.FillChar) + EOL + 'end' + EOL); {Do not Localize}
  finally FreeAndNil(LEncoder); end;
end;

{ TIdMessageEncoderUUE }

procedure TIdMessageEncoderUUE.InitComponent;
begin
  inherited;
  FEncoderClass := TIdEncoderUUE;
end;

initialization
  TIdMessageDecoderList.RegisterDecoder('UUE', TIdMessageDecoderInfoUUE.Create);    {Do not Localize}
  TIdMessageEncoderList.RegisterEncoder('UUE', TIdMessageEncoderInfoUUE.Create);    {Do not Localize}
end.
