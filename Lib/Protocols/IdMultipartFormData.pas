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


  Prior revision history:

  Rev 1.17    2/8/05 6:07:16 PM  RLebeau
    Removed AddToInternalBuffer() method, using new AppendString() function
    from IdGlobal instead

  Rev 1.16    10/26/2004 10:29:30 PM  JPMugaas
    Updated refs.

  Rev 1.15    7/16/04 12:02:16 PM  RLebeau
    Reverted FileName fields to not strip off folder paths anymore.

  Rev 1.14    7/5/04 1:19:06 PM  RLebeau
    Updated IdRead() to check the calculated byte count before copying data
    into the caller's buffer.

  Rev 1.13    5/31/04 9:28:58 PM  RLebeau
    Updated FileName fields to strip off folder paths.
    Added "Content-Transfer-Encoding" header to file fields
    Updated "Content-Type" headers to be the appropriate media types when
    applicable

  Rev 1.12    5/30/04 7:39:02 PM  RLebeau
    Moved FormatField() method from TIdMultiPartFormDataStream to
    TIdFormDataField instead
    Misc. tweaks and bug fixes

  Rev 1.11    2004.05.20 11:37:02 AM  czhower
    IdStreamVCL

  Rev 1.10    3/1/04 8:57:34 PM  RLebeau
    Format() fixes for TIdMultiPartFormDataStream.FormatField() and
    TIdFormDataField.GetFieldSize().

  Rev 1.9    2004.02.03 5:44:08 PM  czhower
    Name changes

  Rev 1.8    2004.02.03 2:12:16 PM  czhower
    $I path change

  Rev 1.7    25/01/2004 21:56:42  CCostelloe
    Updated IdSeek to use new IdFromBeginning

  Rev 1.6    24/01/2004 19:26:56  CCostelloe
    Cleaned up warnings

  Rev 1.5    22/11/2003 12:05:26 AM  GGrieve
    Get working on both win32 and DotNet after other DotNet changes

  Rev 1.4    11/10/2003 8:03:54 PM  BGooijen
    Did all todo's ( TStream to TIdStream mainly )

  Rev 1.3    2003.10.24 10:43:12 AM  czhower
    TIdSTream to dos

  Rev 1.2    10/17/2003 12:49:52 AM  DSiders
    Added localization comments.
    Added resource string for unsupported operation exception.

  Rev 1.1    10/7/2003 10:07:06 PM  GGrieve
    Get HTTP compiling for DotNet

  Rev 1.0    11/13/2002 07:57:42 AM  JPMugaas
    Initial version control checkin.

  2001-Nov-23
    changed spelling error from XxxDataFiled to XxxDataField

  2001-Nov Doychin Bondzhev
    Now it descends from TStream and does not do buffering.
    Changes in the way the form parts are added to the stream.
}

unit IdMultipartFormData;

{
  Implementation of the Multipart Form data

  Based on Internet standards outlined in:
    RFC 1867 - Form-based File Upload in HTML
    RFC 2388 - Returning Values from Forms:  multipart/form-data

  Author: Shiv Kumar
}

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdException,
  IdCharsets,
  IdCoderHeader,
  IdResourceStringsProtocols;

const
  sContentTypeFormData = 'multipart/form-data; boundary=';            {do not localize}
  sContentTypeOctetStream = 'application/octet-stream';               {do not localize}
  sContentTypeTextPlain = 'text/plain';                               {do not localize}
  CRLF = #13#10;
  sContentDispositionPlaceHolder = 'Content-Disposition: form-data; name="%s"';  {do not localize}
  sFileNamePlaceHolder = '; filename="%s"';                           {do not localize}
  sContentTypePlaceHolder = 'Content-Type: %s';                       {do not localize}
  sCharsetPlaceHolder = '; charset="%s"';                             {do not localize}
  sContentTransferPlaceHolder = 'Content-Transfer-Encoding: %s';      {do not localize}
  sContentTransferQuotedPrintable = 'quoted-printable';               {do not localize}
  sContentTransferBinary = 'binary';                                  {do not localize}

type
  TIdMultiPartFormDataStream = class;

  TIdFormDataField = class(TCollectionItem)
  protected
    FFileName: string;
    FCharset: string;
    FContentType: string;
    FContentTransfer: string;
    FFieldName: string;
    FFieldStream: TStream;
    FFieldValue: String;
    FCanFreeFieldStream: Boolean;
    FHeaderCharSet: string;
    FHeaderEncoding: Char;

    function FormatHeader: string;
    function PrepareDataStream(var VCanFree: Boolean): TStream;

    function GetFieldSize: Int64;
    function GetFieldStream: TStream;
    function GetFieldValue: string;
    procedure SetCharset(const Value: string);
    procedure SetContentType(const Value: string);
    procedure SetContentTransfer(const Value: string);
    procedure SetFieldName(const Value: string);
    procedure SetFieldStream(const Value: TStream);
    procedure SetFieldValue(const Value: string);
    procedure SetFileName(const Value: string);
    procedure SetHeaderCharSet(const Value: string);
    procedure SetHeaderEncoding(const Value: Char);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    // procedure Assign(Source: TPersistent); override;
    property ContentTransfer: string read FContentTransfer write SetContentTransfer;
    property ContentType: string read FContentType write SetContentType;
    property Charset: string read FCharset write SetCharset;
    property FieldName: string read FFieldName write SetFieldName;
    property FieldStream: TStream read GetFieldStream write SetFieldStream;
    property FileName: string read FFileName write SetFileName;
    property FieldValue: string read GetFieldValue write SetFieldValue;
    property FieldSize: Int64 read GetFieldSize;
    property HeaderCharSet: string read FHeaderCharSet write SetHeaderCharSet;
    property HeaderEncoding: Char read FHeaderEncoding write SetHeaderEncoding;
  end;

  TIdFormDataFields = class(TCollection)
  protected
    FParentStream: TIdMultiPartFormDataStream;
    function GetFormDataField(AIndex: Integer): TIdFormDataField;
  public
    constructor Create(AMPStream: TIdMultiPartFormDataStream);
    function Add: TIdFormDataField;
    property MultipartFormDataStream: TIdMultiPartFormDataStream read FParentStream;
    property Items[AIndex: Integer]: TIdFormDataField read GetFormDataField;
  end;

  TIdMultiPartFormDataStream = class(TIdBaseStream)
  protected
    FInputStream: TStream;
    FFreeInputStream: Boolean;
    FBoundary: string;
    FRequestContentType: string;
    FCurrentItem: integer;
    FInitialized: Boolean;
    FInternalBuffer: TIdBytes;

    FPosition: Int64;
    FSize: Int64;

    FFields: TIdFormDataFields;

    function GenerateUniqueBoundary: string;
    procedure CalculateSize;

    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    procedure IdSetSize(ASize : Int64); override;
  public
    constructor Create;
    destructor Destroy; override;

    function AddFormField(const AFieldName, AFieldValue: string; const ACharset: string = ''; const AContentType: string = ''; const AFileName: string = ''): TIdFormDataField; overload;
    function AddFormField(const AFieldName, AContentType, ACharset: string; AFieldValue: TStream; const AFileName: string = ''): TIdFormDataField; overload;
    function AddObject(const AFieldName, AContentType, ACharset: string; AFileData: TObject; const AFileName: string = ''): TIdFormDataField; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use overloaded version of AddFormField()'{$ENDIF};{$ENDIF}
    function AddFile(const AFieldName, AFileName: String; const AContentType: string = ''): TIdFormDataField;

    procedure Clear;
    
    property Boundary: string read FBoundary;
    property RequestContentType: string read FRequestContentType;
  end;

  EIdInvalidObjectType = class(EIdException);
  EIdUnsupportedOperation = class(EIdException);
  EIdUnsupportedTransfer = class(EIdException);
  EIdUnsupportedEncoding = class(EIdException);

implementation

uses
  SysUtils,
  IdCoderQuotedPrintable,
  IdCoderMIME,
  IdStream,
  IdGlobalProtocols;

const
  cAllowedContentTransfers: array[0..4] of String = (
    '7bit', '8bit', 'binary', 'quoted-printable', 'base64' {do not localize}
    );

  cAllowedHeaderEncodings: array[0..2] of String = (
    'Q', 'B', '8' {do not localize}
    );

{ TIdMultiPartFormDataStream }

constructor TIdMultiPartFormDataStream.Create;
begin
  inherited Create;
  FSize := 0;
  FInitialized := False;
  FBoundary := GenerateUniqueBoundary;
  FRequestContentType := sContentTypeFormData + FBoundary;
  FFields := TIdFormDataFields.Create(Self);
end;

destructor TIdMultiPartFormDataStream.Destroy;
begin
  FreeAndNil(FFields);
  inherited Destroy;
end;

{$I IdDeprecatedImplBugOff.inc}
function TIdMultiPartFormDataStream.AddObject(const AFieldName,
  AContentType, ACharset: string; AFileData: TObject;
  const AFileName: string = ''): TIdFormDataField;
{$I IdDeprecatedImplBugOn.inc}
begin
  if not (AFileData is TStream) then begin
    raise EIdInvalidObjectType.Create(RSMFDInvalidObjectType);
  end;
  Result := AddFormField(AFieldName, AContentType, ACharset, TStream(AFileData), AFileName);
end;

function TIdMultiPartFormDataStream.AddFile(const AFieldName, AFileName: String;
  const AContentType: string = ''): TIdFormDataField;
var
  LStream: TIdReadFileExclusiveStream;
  LItem: TIdFormDataField;
begin
  LStream := TIdReadFileExclusiveStream.Create(AFileName);
  try
    LItem := FFields.Add;
  except
    FreeAndNil(LStream);
    raise;
  end;

  LItem.FFieldName := AFieldName;
  LItem.FFileName := ExtractFileName(AFileName);
  LItem.FFieldStream := LStream;
  LItem.FCanFreeFieldStream := True;
  if AContentType <> '' then begin
    LItem.ContentType := AContentType;
  end else begin
    LItem.FContentType := GetMIMETypeFromFile(AFileName);
  end;
  LItem.FContentTransfer := sContentTransferBinary;

  Result := LItem;
end;

function TIdMultiPartFormDataStream.AddFormField(const AFieldName, AFieldValue: string;
  const ACharset: string = ''; const AContentType: string = ''; const AFileName: string = ''): TIdFormDataField;
var
  LItem: TIdFormDataField;
begin
  LItem := FFields.Add;

  LItem.FFieldName := AFieldName;
  LItem.FFileName := ExtractFileName(AFileName);
  LItem.FFieldValue := AFieldValue;
  if AContentType <> '' then begin
    LItem.ContentType := AContentType;
  end else begin
    LItem.FContentType := sContentTypeTextPlain;
  end;
  if ACharset <> '' then begin
    LItem.FCharset := ACharset;
  end;
  LItem.FContentTransfer := sContentTransferQuotedPrintable;

  Result := LItem;
end;

function TIdMultiPartFormDataStream.AddFormField(const AFieldName, AContentType, ACharset: string;
  AFieldValue: TStream; const AFileName: string = ''): TIdFormDataField;
var
  LItem: TIdFormDataField;
begin
  if not Assigned(AFieldValue) then begin
    raise EIdInvalidObjectType.Create(RSMFDInvalidObjectType);
  end;

  LItem := FFields.Add;

  LItem.FFieldName := AFieldName;
  LItem.FFileName := ExtractFileName(AFileName);
  LItem.FFieldStream := AFieldValue;
  if AContentType <> '' then begin
    LItem.ContentType := AContentType;
  end else begin
    LItem.FContentType := GetMIMETypeFromFile(AFileName);
  end;
  if ACharset <> '' then begin
    LItem.FCharSet := ACharset;
  end;
  LItem.FContentTransfer := sContentTransferBinary;

  Result := LItem;
end;

procedure TIdMultiPartFormDataStream.Clear;
begin
  FInitialized := False;
  FFields.Clear;
  if FFreeInputStream then begin
    FInputStream.Free;
  end;
  FInputStream := nil;
  FFreeInputStream := False;
  FCurrentItem := 0;
  FPosition := 0;
  FSize := 0;
  SetLength(FInternalBuffer, 0);
end;

function TIdMultiPartFormDataStream.GenerateUniqueBoundary: string;
begin
  // TODO: add a way for a user-defined prefix to be placed in between
  // the dashes and the random data, such as 'WebKitFormBoundary'...
  Result := '--------' + FormatDateTime('mmddyyhhnnsszzz', Now);  {do not localize}
end;

procedure TIdMultiPartFormDataStream.CalculateSize;
var
  I: Integer;
begin
  FSize := 0;
  if FFields.Count > 0 then begin
    for I := 0 to FFields.Count-1 do begin
      FSize := FSize + FFields.Items[I].FieldSize;
    end;
    FSize := FSize + 2{'--'} + Length(Boundary) + 4{'--'+CRLF};
  end;
end;

// RLebeau - IdRead() should wrap multiple files of the same field name
// using a single "multipart/mixed" MIME part, as recommended by RFC 1867

function TIdMultiPartFormDataStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
var
  LTotalRead, LCount, LBufferCount, LRemaining : Integer;
  LItem: TIdFormDataField;
  LEncoding: IIdTextEncoding;
begin
  if not FInitialized then begin
    FInitialized := True;
    FCurrentItem := 0;
    SetLength(FInternalBuffer, 0);
  end;

  LTotalRead := 0;
  LBufferCount := 0;

  while (LTotalRead < ACount) and ((Length(FInternalBuffer) > 0) or Assigned(FInputStream) or (FCurrentItem < FFields.Count)) do
  begin
    if (Length(FInternalBuffer) = 0) and (not Assigned(FInputStream)) then
    begin
      LItem := FFields.Items[FCurrentItem];
      EnsureEncoding(LEncoding, enc8Bit);
      AppendString(FInternalBuffer, LItem.FormatHeader, -1, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});

      FInputStream := LItem.PrepareDataStream(FFreeInputStream);
      if not Assigned(FInputStream) then begin
        AppendString(FInternalBuffer, CRLF);
        Inc(FCurrentItem);
      end;
    end;

    if Length(FInternalBuffer) > 0 then begin
      LCount := IndyMin(ACount - LBufferCount, Length(FInternalBuffer));
      if LCount > 0 then begin
        LRemaining := Length(FInternalBuffer) - LCount;
        CopyTIdBytes(FInternalBuffer, 0, VBuffer, LBufferCount, LCount);
        if LRemaining > 0 then begin
          CopyTIdBytes(FInternalBuffer, LCount, FInternalBuffer, 0, LRemaining);
        end;
        SetLength(FInternalBuffer, LRemaining);
        LBufferCount := LBufferCount + LCount;
        FPosition := FPosition + LCount;
        LTotalRead := LTotalRead + LCount;
      end;
    end;

    if (LTotalRead < ACount) and (Length(FInternalBuffer) = 0) and Assigned(FInputStream) then begin
      LCount := TIdStreamHelper.ReadBytes(FInputStream, VBuffer, ACount - LTotalRead, LBufferCount);
      if LCount > 0 then begin
        LBufferCount := LBufferCount + LCount;
        LTotalRead := LTotalRead + LCount;
        FPosition := FPosition + LCount;
      end
      else begin
        SetLength(FInternalBuffer, 0);
        if FFreeInputStream then begin
          FInputStream.Free;
        end else begin
          FInputStream.Position := 0;
          AppendString(FInternalBuffer, CRLF);
        end;
        FInputStream := nil;
        FFreeInputStream := False;
        Inc(FCurrentItem);
      end;
    end;

    if (Length(FInternalBuffer) = 0) and (not Assigned(FInputStream)) and (FCurrentItem = FFields.Count) then begin
      AppendString(FInternalBuffer, '--' + Boundary + '--' + CRLF);     {do not localize}
      Inc(FCurrentItem);
    end;
  end;

  Result := LTotalRead;
end;

function TIdMultiPartFormDataStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  Result := 0;
  case AOrigin of
    soBeginning: begin
      if (AOffset = 0) then begin
        FInitialized := False;
        FPosition := 0;
        Result := 0;
      end else begin
        Result := FPosition;
      end;
    end;
    soCurrent: begin
      Result := FPosition;
    end;
    soEnd: begin
      if (AOffset = 0) then begin
        CalculateSize;
        Result := FSize;
      end else begin
        Result := FPosition;
      end;
    end;
  end;
end;

function TIdMultiPartFormDataStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  raise EIdUnsupportedOperation.Create(RSUnsupportedOperation);
end;

procedure TIdMultiPartFormDataStream.IdSetSize(ASize: Int64);
begin
  raise EIdUnsupportedOperation.Create(RSUnsupportedOperation);
end;

{ TIdFormDataFields }

function TIdFormDataFields.Add: TIdFormDataField;
begin
  Result := TIdFormDataField(inherited Add);
end;

constructor TIdFormDataFields.Create(AMPStream: TIdMultiPartFormDataStream);
begin
  inherited Create(TIdFormDataField);
  FParentStream := AMPStream;
end;

function TIdFormDataFields.GetFormDataField(AIndex: Integer): TIdFormDataField;
begin
  Result := TIdFormDataField(inherited Items[AIndex]);
end;

{ TIdFormDataField }

constructor TIdFormDataField.Create(Collection: TCollection);
var
  LDefCharset: TIdCharSet;
begin
  inherited Create(Collection);
  FFieldStream := nil;
  FFileName := '';
  FFieldName := '';
  FContentType := '';
  FCanFreeFieldStream := False;

  // it's not clear when FHeaderEncoding should be Q not B.
  // Comments welcome on atozedsoftware.indy.general

  LDefCharset := IdGetDefaultCharSet;

  case LDefCharset of
    idcs_ISO_8859_1:
      begin
        FHeaderEncoding := 'Q';     { quoted-printable }    {Do not Localize}
        FHeaderCharSet := IdCharsetNames[LDefCharset];
      end;
    idcs_UNICODE_1_1:
      begin
        FHeaderEncoding := 'B';     { base64 }    {Do not Localize}
        FHeaderCharSet := IdCharsetNames[idcs_UTF_8];
      end;
  else
    begin
      FHeaderEncoding := 'B';     { base64 }    {Do not Localize}
      FHeaderCharSet := IdCharsetNames[LDefCharset];
    end;
  end;
end;

destructor TIdFormDataField.Destroy;
begin
  if Assigned(FFieldStream) then begin
    if FCanFreeFieldStream then begin
      FFieldStream.Free;
    end;
  end;
  inherited Destroy;
end;

function TIdFormDataField.FormatHeader: string;
var
  LBoundary: string;
begin
  LBoundary := '--' + TIdFormDataFields(Collection).MultipartFormDataStream.Boundary; {do not localize}

  // TODO: when STRING_IS_ANSI is defined, provide a way for the user to specify the AnsiString encoding for header values...

  Result := IndyFormat('%s' + CRLF + sContentDispositionPlaceHolder,
    [LBoundary, EncodeHeader(FieldName, '', FHeaderEncoding, FHeaderCharSet)]);       {do not localize}

  if Length(FileName) > 0 then begin
    Result := Result + IndyFormat(sFileNamePlaceHolder,
      [EncodeHeader(FileName, '', FHeaderEncoding, FHeaderCharSet)]);                 {do not localize}
  end;

  Result := Result + CRLF;

  if Length(ContentType) > 0 then begin
    Result := Result + IndyFormat(sContentTypePlaceHolder, [ContentType]);      {do not localize}
    if Length(CharSet) > 0 then begin
      Result := Result + IndyFormat(sCharsetPlaceHolder, [Charset]);            {do not localize}
    end;
    Result := Result + CRLF;
  end;

  if Length(FContentTransfer) > 0 then begin
    Result := Result + IndyFormat(sContentTransferPlaceHolder + CRLF, [FContentTransfer]);
  end;

  Result := Result + CRLF;
end;

function TIdFormDataField.GetFieldSize: Int64;
var
  LStream: TStream;
  LOldPos: TIdStreamSize;
  {$IFDEF STRING_IS_ANSI}
  LBytes: TIdBytes;
  {$ENDIF}
  I: Integer;
begin
  {$IFDEF STRING_IS_ANSI}
  LBytes := nil; // keep the compiler happy
  {$ENDIF}
  Result := Length(FormatHeader);
  if Assigned(FFieldStream) then begin
    I := PosInStrArray(ContentTransfer, cAllowedContentTransfers, False);
    if I <= 2 then begin
      // need to include an explicit CRLF at the end of the data
      Result := Result + FFieldStream.Size + 2{CRLF};
    end else
    begin
      LStream := TIdCalculateSizeStream.Create;
      try
        LOldPos := FFieldStream.Position;
        try
          if I = 3 then begin
            TIdEncoderQuotedPrintable.EncodeStream(FFieldStream, LStream);
            // the encoded text always includes a CRLF at the end...
            Result := Result + LStream.Size {+2};
          end else begin
            TIdEncoderMime.EncodeStream(FFieldStream, LStream);
            // the encoded text does not include a CRLF at the end...
            Result := Result + LStream.Size + 2;
          end;
        finally
          FFieldStream.Position := LOldPos;
        end;
      finally
        LStream.Free;
      end;
    end;
  end
  else if Length(FFieldValue) > 0 then begin
    I := PosInStrArray(FContentTransfer, cAllowedContentTransfers, False);
    if I <= 0 then begin
      // 7bit
      {$IFDEF STRING_IS_UNICODE}
      I := IndyTextEncoding_ASCII.GetByteCount(FFieldValue);
      {$ELSE}
      // the methods useful for calculating a length without actually
      // encoding are protected, so have to actually encode the
      // string to find out the final length...
      LBytes := RawToBytes(FFieldValue[1], Length(FFieldValue));
      CheckByteEncoding(LBytes, CharsetToEncoding(FCharset), IndyTextEncoding_ASCII);
      I := Length(LBytes);
      {$ENDIF}
      // need to include an explicit CRLF at the end of the data
      Result := Result + I + 2{CRLF};
    end
    else if (I = 1) or (I = 2) then begin
      // 8bit/binary
      {$IFDEF STRING_IS_UNICODE}
      I := CharsetToEncoding(FCharset).GetByteCount(FFieldValue);
      {$ELSE}
      I := Length(FFieldValue);
      {$ENDIF}
      // need to include an explicit CRLF at the end of the data
      Result := Result + I + 2{CRLF};
    end else
    begin
      LStream := TIdCalculateSizeStream.Create;
      try
        {$IFNDEF STRING_IS_UNICODE}
        LBytes := RawToBytes(FFieldValue[1], Length(FFieldValue));
        {$ENDIF}
        if I = 3 then begin
          // quoted-printable
          {$IFDEF STRING_IS_UNICODE}
          TIdEncoderQuotedPrintable.EncodeString(FFieldValue, LStream, CharsetToEncoding(FCharset));
          {$ELSE}
          TIdEncoderQuotedPrintable.EncodeBytes(LBytes, LStream);
          {$ENDIF}
          // the encoded text always includes a CRLF at the end...
          Result := Result + LStream.Size {+2};
        end else begin
          // base64
          {$IFDEF STRING_IS_UNICODE}
          TIdEncoderMIME.EncodeString(FFieldValue, LStream, CharsetToEncoding(FCharset){$IFDEF STRING_IS_ANSI}, IndyTextEncoding_OSDefault{$ENDIF});
          {$ELSE}
          TIdEncoderMIME.EncodeBytes(LBytes, LStream);
          {$ENDIF}
          // the encoded text does not include a CRLF at the end...
          Result := Result + LStream.Size + 2;
        end;
      finally
        LStream.Free;
      end;
    end;
  end else begin
    // need to include an explicit CRLF at the end of blank text
    Result := Result + 2{CRLF};
  end;
end;

function TIdFormDataField.PrepareDataStream(var VCanFree: Boolean): TStream;
var
  I: Integer;
  {$IFDEF STRING_IS_ANSI}
  LBytes: TIdBytes;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_ANSI}
  LBytes := nil; // keep the compiler happy
  {$ENDIF}
  Result := nil;
  VCanFree := False;

  if Assigned(FFieldStream) then begin
    FFieldStream.Position := 0;
    I := PosInStrArray(FContentTransfer, cAllowedContentTransfers, False);
    if I <= 2 then begin
      Result := FFieldStream;
    end else begin
      Result := TMemoryStream.Create;
      try
        if I = 3 then begin
          TIdEncoderQuotedPrintable.EncodeStream(FFieldStream, Result);
          // the encoded text always includes a CRLF at the end...
        end else begin
          TIdEncoderMime.EncodeStream(FFieldStream, Result);
          // the encoded text does not include a CRLF at the end...
          WriteStringToStream(Result, CRLF);
        end;
        Result.Position := 0;
      except
        FreeAndNil(Result);
        raise;
      end;
      VCanFree := True;
    end;
  end
  else if Length(FFieldValue) > 0 then begin
    Result := TMemoryStream.Create;
    try
      {$IFDEF STRING_IS_ANSI}
      LBytes := RawToBytes(FFieldValue[1], Length(FFieldValue));
      {$ENDIF}
      I := PosInStrArray(FContentTransfer, cAllowedContentTransfers, False);
      if I <= 0 then begin
        // 7bit
        {$IFDEF STRING_IS_UNICODE}
        WriteStringToStream(Result, FFieldValue, IndyTextEncoding_ASCII);
        {$ELSE}
        CheckByteEncoding(LBytes, CharsetToEncoding(FCharset), IndyTextEncoding_ASCII);
        WriteTIdBytesToStream(Result, LBytes);
        {$ENDIF}
        // need to include an explicit CRLF at the end of the data
        WriteStringToStream(Result, CRLF);
      end
      else if (I = 1) or (I = 2) then begin
        // 8bit/binary
        {$IFDEF STRING_IS_UNICODE}
        WriteStringToStream(Result, FFieldValue, CharsetToEncoding(FCharset));
        {$ELSE}
        WriteTIdBytesToStream(Result, LBytes);
        {$ENDIF}
        // need to include an explicit CRLF at the end of the data
        WriteStringToStream(Result, CRLF);
      end else
      begin
        if I = 3 then begin
          // quoted-printable
          {$IFDEF STRING_IS_UNICODE}
          TIdEncoderQuotedPrintable.EncodeString(FFieldValue, Result, CharsetToEncoding(FCharset));
          {$ELSE}
          TIdEncoderQuotedPrintable.EncodeBytes(LBytes, Result);
          {$ENDIF}
          // the encoded text always includes a CRLF at the end...
        end else begin
          // base64
          {$IFDEF STRING_IS_UNICODE}
          TIdEncoderMIME.EncodeString(FFieldValue, Result, CharsetToEncoding(FCharset));
          {$ELSE}
          TIdEncoderMIME.EncodeBytes(LBytes, Result);
          {$ENDIF}
          // the encoded text does not include a CRLF at the end...
          WriteStringToStream(Result, CRLF);
        end;
      end;
    except
      FreeAndNil(Result);
      raise;
    end;
    Result.Position := 0;
    VCanFree := True;
  end;
end;

function TIdFormDataField.GetFieldStream: TStream;
begin
  if not Assigned(FFieldStream) then begin
    raise EIdInvalidObjectType.Create(RSMFDInvalidObjectType);
  end;
  Result := FFieldStream;
end;

function TIdFormDataField.GetFieldValue: string;
begin
  if Assigned(FFieldStream) then begin
    raise EIdInvalidObjectType.Create(RSMFDInvalidObjectType);
  end;
  Result := FFieldValue;
end;

procedure TIdFormDataField.SetCharset(const Value: string);
begin
  FCharset := Value;
end;

procedure TIdFormDataField.SetContentTransfer(const Value: string);
begin
  if Length(Value) > 0 then begin
    if PosInStrArray(Value, cAllowedContentTransfers, False) = -1 then begin
      raise EIdUnsupportedTransfer.Create(RSMFDInvalidTransfer);
    end;
  end;
  FContentTransfer := Value;
end;

procedure TIdFormDataField.SetContentType(const Value: string);
var
  LContentType, LCharSet: string;
begin
  if Length(Value) > 0 then begin
    LContentType := Value;
  end
  else if Length(FFileName) > 0 then begin
    LContentType := GetMIMETypeFromFile(FFileName);
  end
  else begin
    LContentType := sContentTypeOctetStream;
  end;

  FContentType := RemoveHeaderEntry(LContentType, 'charset', LCharSet, QuoteMIME); {do not localize}

  // RLebeau: per RFC 2045 Section 5.2:
  //
  // Default RFC 822 messages without a MIME Content-Type header are taken
  // by this protocol to be plain text in the US-ASCII character set,
  // which can be explicitly specified as:
  //
  //   Content-type: text/plain; charset=us-ascii
  //
  // This default is assumed if no Content-Type header field is specified.
  // It is also recommend that this default be assumed when a
  // syntactically invalid Content-Type header field is encountered. In
  // the presence of a MIME-Version header field and the absence of any
  // Content-Type header field, a receiving User Agent can also assume
  // that plain US-ASCII text was the sender's intent.  Plain US-ASCII
  // text may still be assumed in the absence of a MIME-Version or the
  // presence of an syntactically invalid Content-Type header field, but
  // the sender's intent might have been otherwise.
  if (LCharSet = '') and (FCharSet = '') and IsHeaderMediaType(FContentType, 'text') then begin {do not localize}
    LCharSet := 'us-ascii'; {do not localize}
  end;
  {RLebeau: override the current CharSet only if the header specifies a new value}
  if LCharSet <> '' then begin
    FCharSet := LCharSet;
  end;
end;

procedure TIdFormDataField.SetFieldName(const Value: string);
begin
  FFieldName := Value;
end;

procedure TIdFormDataField.SetFieldStream(const Value: TStream);
begin
  if not Assigned(Value) then begin
    raise EIdInvalidObjectType.Create(RSMFDInvalidObjectType);
  end;

  if Assigned(FFieldStream) and FCanFreeFieldStream then begin
    FFieldStream.Free;
  end;

  FFieldValue := '';
  FFieldStream := Value;
  FCanFreeFieldStream := False;
end;

procedure TIdFormDataField.SetFieldValue(const Value: string);
begin
  if Assigned(FFieldStream) then begin
    if FCanFreeFieldStream then begin
      FFieldStream.Free;
    end;
    FFieldStream := nil;
    FCanFreeFieldStream := False;
  end;
  FFieldValue := Value;
end;

procedure TIdFormDataField.SetFileName(const Value: string);
begin
  FFileName := ExtractFileName(Value);
end;

procedure TIdFormDataField.SetHeaderCharSet(const Value: string);
begin
  FHeaderCharset := Value;
end;

procedure TIdFormDataField.SetHeaderEncoding(const Value: Char);
begin
  if FHeaderEncoding <> Value then begin
    if PosInStrArray(Value, cAllowedHeaderEncodings, False) = -1 then begin
      raise EIdUnsupportedEncoding.Create(RSMFDInvalidEncoding);
    end;
    FHeaderEncoding := Value;
  end;
end;

end.
