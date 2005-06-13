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
{   Rev 1.13    27.08.2004 22:04:00  Andreas Hausladen
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.12    2004.05.20 1:39:16 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.11    2004.05.20 11:36:58 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.10    2004.05.20 11:13:02 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.9    2004.05.19 3:06:42 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.8    2004.02.03 5:44:04 PM  czhower
{ Name changes
}
{
{   Rev 1.7    2004.01.22 5:56:54 PM  czhower
{ TextIsSame
}
{
{   Rev 1.6    1/21/2004 2:20:24 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.5    1/21/2004 1:30:10 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.4    10/17/2003 12:41:16 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.3    26/09/2003 01:06:18  CCostelloe
{ CodingType property added so caller can find out if it was UUE or XXE encoded
}
{
{   Rev 1.2    6/14/2003 03:07:20 PM  JPMugaas
{ Fixed MessageDecoder so that DecodeBegin is called right after creation and
{ DecodeEnd is called just before destruction.  I also fixed where the code was
{ always assuming that LDecode was always being created.
}
{
{   Rev 1.1    6/13/2003 07:58:44 AM  JPMugaas
{ Should now compile with new decoder design.
}
{
{   Rev 1.0    11/13/2002 07:57:14 AM  JPMugaas
}
unit IdMessageCoderUUE;

{
2003-Sep-20 Ciaran Costelloe
  CodingType property added so caller can find out if it was UUE or XXE encoded
}

interface

uses
  IdCoder3to4,
  IdMessageCoder,
  IdMessage,
  IdGlobal,
  IdObjs,
  IdSys;

type
  TIdMessageDecoderUUE = class(TIdMessageDecoder)
  protected
    FCodingType: string;
  public
    function ReadBody(ADestStream: TIdStream2; var AMsgEnd: Boolean): TIdMessageDecoder; override;
    property CodingType: string read FCodingType;
  end;

  TIdMessageDecoderInfoUUE = class(TIdMessageDecoderInfo)
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; override;
  end;

  TIdMessageEncoderUUEBase = class(TIdMessageEncoder)
  protected
    FEncoderClass: TIdEncoder3to4Class;
  public
    procedure Encode(ASrc: TIdStream2; ADest: TIdStream2); override;
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
  IdCoderUUE, IdCoderXXE, IdException, IdGlobalProtocols, IdResourceStringsProtocols;

{ TIdMessageDecoderInfoUUE }

function TIdMessageDecoderInfoUUE.CheckForStart(ASender: TIdMessage;
 const ALine: string): TIdMessageDecoder;
var
  LPermissionCode: integer;
begin
  LPermissionCode := Sys.StrToInt(Copy(ALine, 7, 3), 0);
  if TextIsSame(Copy(ALine, 1, 6), 'begin ') and (Copy(ALine, 10, 1) = ' ') and (LPermissionCode > 0)    {Do not Localize}
   then begin
    Result := TIdMessageDecoderUUE.Create(ASender);
    with TIdMessageDecoderUUE(Result) do begin
      FFilename := Copy(ALine, 11, MaxInt);
      FPartType := mcptAttachment;
    end;
  end else begin
    Result := nil;
  end;
end;

{ TIdMessageDecoderUUE }

function TIdMessageDecoderUUE.ReadBody(ADestStream: TIdStream2; var AMsgEnd: Boolean): TIdMessageDecoder;
var
  LDecoder: TIdDecoder4to3;
  LLine: string;
begin
  AMSgEnd := False;
  Result := nil;
  LLine := ReadLn;
  LDecoder := nil;
  if (Length(LLine) > 0) then
  begin
    case LLine[1] of
      #32..#85: begin    {Do not Localize}
        // line length may be from 2 (first char + newline) to 65,
        // this is 0 useable to 63 usable bytes, + #32 gives this as a range.
        // (yes, the line length is encoded in the first bytes of each line!)
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
        raise EIdException.Create(RSUnrecognizedUUEEncodingScheme);
      end;
    end;
  end;
  try
    if Assigned(LDecoder) then
    begin
      repeat
        if (Length(Sys.Trim(LLine)) = 0) or (LLine = LDecoder.FillChar) then begin
          // UUE: Comes on the line before end. Supposed to be `, but some put a
          // blank line instead
        end else begin
          LDecoder.Decode(LLine);
        end;
        LLine := ReadLn;
      until TextIsSame(Sys.Trim(LLine), 'end');    {Do not Localize}
      LDecoder.DecodeEnd;
    end;
  finally Sys.FreeAndNil(LDecoder); end;
end;

{ TIdMessageEncoderInfoUUE }

constructor TIdMessageEncoderInfoUUE.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderUUE;
end;

{ TIdMessageEncoderUUEBase }

procedure TIdMessageEncoderUUEBase.Encode(ASrc: TIdStream2; ADest: TIdStream2);
var
  LEncoder: TIdEncoder3to4;
begin
  ASrc.Position := 0;
  WriteStringToStream(ADest, 'begin ' + Sys.IntToStr(PermissionCode) + ' ' + Filename + EOL); {Do not Localize}
  LEncoder := FEncoderClass.Create(nil); try
    while ASrc.Position = (ASrc.Size - 1) do begin
      WriteStringToStream(ADest, LEncoder.Encode(ASrc, 45) + EOL);
    end;
    WriteStringToStream(ADest, LEncoder.FillChar + EOL + 'end' + EOL); {Do not Localize}
  finally Sys.FreeAndNil(LEncoder); end;
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
