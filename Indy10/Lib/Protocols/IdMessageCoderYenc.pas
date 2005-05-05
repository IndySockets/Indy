{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11679: IdMessageCoderYenc.pas 
{
{   Rev 1.7    27.08.2004 22:04:00  Andreas Hausladen
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.6    2004.05.20 1:39:16 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.5    2004.05.20 11:37:00 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.4    2004.05.20 11:13:06 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.3    2004.05.19 3:06:44 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.2    2004.02.03 5:44:06 PM  czhower
{ Name changes
}
{
    Rev 1.1    5/9/2003 2:14:42 PM  BGooijen
  Streams are now buffered, speed is now about 75 times as fast as before
}
{
{   Rev 1.0    11/13/2002 07:57:22 AM  JPMugaas
}
{*****************************************************************************}
{*                              IdMessageCoderYenc.pas                       *}
{*****************************************************************************}

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

uses
  Classes,
  IdMessageCoder, IdMessage, IdExceptionCore, IdStreamVCL, IdStream, IdStreamRandomAccess;

type
  EIdMessageYencException = class( EIdMessageException ) ;

  EIdMessageYencInvalidSizeException = class( EIdMessageYencException ) ;
  EIdMessageYencInvalidCRCException = class( EIdMessageYencException ) ;
  EIdMessageYencCorruptionException = class( EIdMessageYencException ) ;

  TIdMessageDecoderYenc = class( TIdMessageDecoder )
  protected
    FPart: integer;
    FLine: integer;
    FSize: integer;
  public
    function ReadBody(ADestStream: TIdStream; var AMsgEnd: Boolean ) : TIdMessageDecoder; override;
  end;

  TIdMessageDecoderInfoYenc = class( TIdMessageDecoderInfo )
  public
    function CheckForStart( ASender: TIdMessage; const ALine: string ) : TIdMessageDecoder; override;
  end;

  TIdMessageEncoderYenc = class( TIdMessageEncoder )
  public
    procedure Encode( ASrc: TIdStreamRandomAccess; ADest: TIdStream ) ; override;
  end;

  TIdMessageEncoderInfoYenc = class( TIdMessageEncoderInfo )
  public
    constructor Create; override;
    procedure InitializeHeaders( AMsg: TIdMessage ) ; override;
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
  IdGlobal,
  IdHashCRC, IdResourceStringsProtocols, IdSys;

{ TIdMessageDecoderInfoYenc }

function TIdMessageDecoderInfoYenc.CheckForStart( ASender: TIdMessage; const ALine: string ) : TIdMessageDecoder;

  function GetValue( const option: string; const default: string = '0' ) : string;
  var
    LStart: integer;
    LEnd: integer;
  begin
    lstart := IndyPos( Sys.lowercase(option) + '=', Sys.lowercase(ALine) ) ;
    if Lstart = 0 then
    begin
      result := default;
      exit;
    end;
    lstart := lstart + length( option ) + 1;
    result := copy( ALine, lstart, MaxInt ) ;
    lend := IndyPos( ' ', result ) ; {Do not Localize}
    if lend > 0 then
    begin
      result := copy( result, 1, lend - 1 );
    end;
  end;

  function GetName: string;
  var
    Lstart: integer;
  begin
    Lstart := IndyPos( 'name=', Sys.lowercase(ALine) ) ; {Do not Localize}
    if Lstart = 0 then
    begin
      result := '';
      exit;
    end;
    Lstart := Lstart + 4 + 1;
    result := copy( ALine, Lstart, MaxInt ) ;
  end;

begin
  if Sys.SameText( Copy( ALine, 1, 8 ) , '=ybegin ' ) {Do not Localize} then
  begin
    Result := TIdMessageDecoderYenc.Create( ASender ) ;
    with TIdMessageDecoderYenc( Result ) do
    begin
      FSize := Sys.strtoint( GetValue( 'size' ) ) ; {Do not Localize}
      FLine := Sys.strtoint( GetValue( 'line' ) ) ; {Do not Localize}
      FPart := Sys.strtoint( GetValue( 'part' ) ) ; {Do not Localize}
      FFilename := {'Yenc_' +} Getname; {Do not Localize}
      FPartType := mcptAttachment;
    end;
  end
  else
  begin
    Result := nil;
  end;
end;

{ TIdMessageDecoderYenc }

{function GetCRC( const Astream: Tstream; const ASize: integer ) : string;
begin
  with TIdHashCRC32.create do
  try
    Astream.Seek( -1 * ASize, IdFromEnd ) ;
    result := Sys.lowercase( Sys.inttohex( HashValue( Astream ) , 8 ) ) ;
  finally
    free;
  end;
end;   }

function TIdMessageDecoderYenc.ReadBody( ADestStream: TIdStream; var AMsgEnd: Boolean ) : TIdMessageDecoder;
var
  LLine: string;
  LLinepos: integer;
  LChar: Byte;
  LBytesDecoded: integer;
  LPartSize: integer;
  Lcrc32: string;

  LOutputBuffer:TIdBytes;
  LOutputBufferUsed:integer;
  LHash : Cardinal;
  LH : TIdHashCRC32;

  function GetValue( const option: string; const default: string = '0' ) : string;
  var
    Lstart: integer;
    LEnd: integer;
  begin
    lstart := IndyPos( Sys.lowercase(option) + '=', Sys.lowercase(LLine) ) ; {Do not Localize}
    if Lstart = 0 then
    begin
      result := default;
      exit;
    end;
    lstart := lstart + length( option ) + 1;
    result := copy( LLine, lstart, $FFFF ) ;
    lend := IndyPos( ' ', result ) ; {Do not Localize}
    if lend > 0 then
    begin
      result := copy( result, 1, lend - 1 );
    end;
  end;

  procedure FlushOutputBuffer;
  begin
  //TODO: this uses Array of Characters. Unless its dealing in Unicode or MBCS it should
  // be using TIdBuffer
    ADestStream.Write(LOutputBuffer, LOutputBufferUsed);
    LOutputBufferUsed:=0;
  end;

  procedure AddByteToOutputBuffer(const AChar:Byte);
  begin
    LOutputBuffer[LOutputBufferUsed]:=AChar;
    inc(LOutputBufferUsed);
    if LOutputBufferUsed>=BUFLEN then begin
      FlushOutputBuffer;
    end;
  end;

begin
  SetLength(LOutputBuffer,BUFLEN);
  AMSgEnd := false;
  Result := nil;
  LPartSize := fsize;
  LOutputBufferUsed:=0;

  LBytesDecoded := 0;
  LH := TIdHashCRC32.Create;
  try
    LH.HashStart(LHash);
  //note that we have to do hashing here because there's no
  //seek in the TIdStream class, changing definiti9ons in this API might break something,
  //and storing in an extra buffer will just eat space
  while true do
  begin
    lline := readln;
    if IndyPos( '=yend', Sys.lowercase(lline) ) <> 0 then {Do not Localize}
    begin
      break;
    end;
    if ( copy( lline, 1, 7 ) = '=ypart ' ) then {Do not Localize}
    begin
      LPartSize := Sys.strtoint( getvalue( 'end' ) ) - Sys.strtoint( getvalue( 'begin' ) ) + 1; {Do not Localize}
    end
    else
    begin
      LLinepos := 1;
      while LLinepos <= length( lline ) do
      begin
        if (LLinepos=1) and (lline[LLinepos]='.') and (lline[LLinepos+1]='.') then {Do not Localize}
        begin
          inc(LLinepos);
        end;
        lchar := Byte(lline[LLinepos]);
        if lchar = B_EQUALS then {Do not Localize}
        begin
          if LLinepos = length( lline ) then // invalid file, escape character may not appear at end of line
          begin
            raise EIdMessageYencCorruptionException.Create( RSYencFileCorrupted ) ;
          end;
          inc( LLinepos ) ;
          lchar := Byte(lline[LLinepos]);
          lchar :=  byte( lchar ) - 42 - 64  ;
        end
        else
        begin
          lchar :=  byte( lchar ) - 42 ;
        end;
        AddByteToOutputBuffer( lchar ) ;
        LH.HashByte(LHash,lchar);
        inc( LLinepos ) ;
        inc( LBytesDecoded ) ;
      end;
    end;
  end;

  FlushOutputBuffer;

  Lcrc32 := Sys.lowercase( GetValue( 'crc32', '' ) ) ; {Do not Localize}

  if LPartSize <> LBytesDecoded then begin
    raise EIdMessageYencInvalidSizeException.Create( RSYencInvalidSize ) ;
  end;

  if Lcrc32 <> '' then begin
    //done this way because values can be computed faster than strings and we don't
    //have to mess with charactor case.
    if Sys.StrToInt64('$'+Lcrc32) <> LHash then begin
      raise EIdMessageYencInvalidCRCException.Create( RSYencInvalidCRC ) ;
    end;
  end;
  finally
    Sys.FreeAndNil(LH);
  end;
end;

constructor TIdMessageEncoderInfoYenc.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderYenc;
end;

procedure TIdMessageEncoderInfoYenc.InitializeHeaders( AMsg: TIdMessage ) ;
begin
//
end;

{ TIdMessageEncoderYenc }

procedure TIdMessageEncoderYenc.Encode( ASrc: TIdStreamRandomAccess; ADest: TIdStream ) ;
const
  Linesize = 128;
var
  i: integer;
  s: string;
  LSSize: Int64;
  LInput: Byte;
  Loutput: Byte;
  LEscape : Byte;
  LCurrentLineLength: integer;

  LOutputBuffer:TIdBytes;
  LOutputBufferUsed:integer;

  LInputBuffer:TIdBytes;
  LInputBufferPos:integer;
  LInputBufferSize:integer;
  LHash : Cardinal;
  LH : TIdHashCRC32;

  procedure FlushOutputBuffer;
  begin
    ADest.Write(LOutputBuffer, LOutputBufferUsed);
    LOutputBufferUsed:=0;
  end;

  procedure AddByteToOutputBuffer(const AChar:Byte);
  begin
    LOutputBuffer[LOutputBufferUsed]:=AChar;
    inc(LOutputBufferUsed);
    if LOutputBufferUsed>=BUFLEN then begin
      FlushOutputBuffer;
    end;
  end;

  function ReadByteFromInputBuffer:Byte;
  begin
    if LInputBufferPos>=LInputBufferSize then begin
      LInputBufferPos:=0;
      LInputBufferSize:=ASrc.ReadBytes( LInputBuffer, BUFLEN ) ;
    end;
    result:=LInputBuffer[LInputBufferPos];
    inc(LInputBufferPos);
  end;

begin
  SetLength(LOutputBuffer,BUFLEN);
  SetLength(LInputBuffer,BUFLEN);
  ASrc.Position := 0;
  LSSize := ASrc.Size;
  LCurrentLineLength := 0;
  LEscape:=B_EQUALS; {do not localize}
  LOutputBufferUsed:=0;
  LH := TIdHashCRC32.Create;
  try
    LH.HashStart(LHash);
    s := '=ybegin line=' + Sys.inttostr( Linesize ) + ' size=' + Sys.inttostr( LSSize ) + ' name='+FFilename+#$0D#$0A;  {do not localize}
    ADest.Write(s);

    for i := 0 to ASrc.Size - 1 do
    begin
      LInput:=ReadByteFromInputBuffer;
      Loutput :=  byte( LInput ) + 42 ;
      if  Loutput in [B_NUL, B_LF, B_CR, B_EQUALS, B_TAB, B_PERIOD] then   {do not localize}
      begin
        AddByteToOutputBuffer( LEscape) ;
        Loutput := Loutput + 64;
        inc( LCurrentLineLength ) ;
      end;
      AddByteToOutputBuffer( Loutput) ;
      LH.HashByte(LHash,LOutput);
      inc( LCurrentLineLength ) ;
      if LCurrentLineLength=1 then begin
        if Loutput=B_PERIOD then begin
          AddByteToOutputBuffer( Loutput ) ;
          inc( LCurrentLineLength ) ;
        end;
      end;

      if LCurrentLineLength >= Linesize then
      begin
        AddByteToOutputBuffer( B_CR) ; {do not localize}
        AddByteToOutputBuffer( B_LF ) ; {do not localize}
        LCurrentLineLength := 0;
      end;
    end;
    FlushOutputBuffer;
    s := EOL + '=yend size=' + Sys.inttostr( LSSize ) + ' crc32=' + {do not localize}
      Sys.lowercase( Sys.inttohex( LHash, 8 )) + EOL;
  finally
    Sys.FreeAndNil(LH);
  end;
  ADest.Write(s);
end;

initialization
  TIdMessageDecoderList.RegisterDecoder( 'yEnc', TIdMessageDecoderInfoYenc.Create ) ; {Do not Localize}
  TIdMessageEncoderList.RegisterEncoder( 'yEnc', TIdMessageEncoderInfoYenc.Create ) ; {Do not Localize}
end.

