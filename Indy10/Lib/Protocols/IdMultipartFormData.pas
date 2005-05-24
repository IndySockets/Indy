{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11687: IdMultipartFormData.pas
{
{   Rev 1.17    2/8/05 6:07:16 PM  RLebeau
{ Removed AddToInternalBuffer() method, using new AppendString() function from
{ IdGlobal instead
}
{
{   Rev 1.16    10/26/2004 10:29:30 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.15    7/16/04 12:02:16 PM  RLebeau
{ Reverted FileName fields to not strip off folder paths anymore.
}
{
{   Rev 1.14    7/5/04 1:19:06 PM  RLebeau
{ Updated IdRead() to check the calculated byte count before copying data into
{ the caller's buffer.
}
{
{   Rev 1.13    5/31/04 9:28:58 PM  RLebeau
{ Updated FileName fields to strip off folder paths.
{ 
{ Added "Content-Transfer-Encoding" header to file fields
{ 
{ Updated "Content-Type" headers to be the appropriate media types when
{ applicable
}
{
{   Rev 1.12    5/30/04 7:39:02 PM  RLebeau
{ Moved FormatField() method from TIdMultiPartFormDataStream to
{ TIdFormDataField instead
{ 
{ Misc. tweaks and bug fixes
}
{
{   Rev 1.11    2004.05.20 11:37:02 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.10    3/1/04 8:57:34 PM  RLebeau
{ Format() fixes for TIdMultiPartFormDataStream.FormatField() and
{ TIdFormDataField.GetFieldSize().
}
{
{   Rev 1.9    2004.02.03 5:44:08 PM  czhower
{ Name changes
}
{
{   Rev 1.8    2004.02.03 2:12:16 PM  czhower
{ $I path change
}
{
{   Rev 1.7    25/01/2004 21:56:42  CCostelloe
{ Updated IdSeek to use new IdFromBeginning
}
{
{   Rev 1.6    24/01/2004 19:26:56  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.5    22/11/2003 12:05:26 AM  GGrieve
{ Get working on both win32 and DotNet after other DotNet changes
}
{
{   Rev 1.4    11/10/2003 8:03:54 PM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.3    2003.10.24 10:43:12 AM  czhower
{ TIdSTream to dos
}
{
    Rev 1.2    10/17/2003 12:49:52 AM  DSiders
  Added localization comments.
  Added resource string for unsupported operation exception.
}
{
{   Rev 1.1    10/7/2003 10:07:06 PM  GGrieve
{ Get HTTP compiling for DotNet
}
{
{   Rev 1.0    11/13/2002 07:57:42 AM  JPMugaas
}
unit IdMultipartFormData;

{
  Implementation of the Multipart From data

  Author: Shiv Kumar
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

Details of implementation
-------------------------
2001-Nov Doychin Bondzhev
 - Now it descends from TStream and does not do buffering.
 - Changes in the way the form parts are added to the stream.

 2001-Nov-23
  - changed spelling error from XxxDataFiled to XxxDataField
}


interface
{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdException,
  IdResourceStringsProtocols,
  IdStreamVCL,
  IdSys,
  IdObjs;

const
  sContentTypeFormData = 'multipart/form-data; boundary=';            {do not localize}
  sContentTypeOctetStream = 'application/octet-stream';               {do not localize}
  crlf = #13#10;
  sContentDisposition = 'Content-Disposition: form-data; name="%s"';  {do not localize}
  sFileNamePlaceHolder = '; filename="%s"';                           {do not localize}
  sContentTypePlaceHolder = 'Content-Type: %s';                       {do not localize}
  sContentTransferEncoding = 'Content-Transfer-Encoding: binary';     {do not localize}

type
  TIdMultiPartFormDataStream = class;

  TIdFormDataField = class(TCollectionItem)
  protected
    FFieldValue: string;
    FFileName: string;
    FContentType: string;
    FFieldName: string;
    FFieldObject: TObject;
    FCanFreeFieldObject: Boolean;

    function GetFieldSize: LongInt;
    function GetFieldStream: TStream;
    function GetFieldStrings: TIdStrings;
    procedure SetContentType(const Value: string);
    procedure SetFieldName(const Value: string);
    procedure SetFieldStream(const Value: TStream);
    procedure SetFieldStrings(const Value: TIdStrings);
    procedure SetFieldValue(const Value: string);
    procedure SetFieldObject(const Value: TObject);
    procedure SetFileName(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    // procedure Assign(Source: TPersistent); override;
    function FormatField: string;
    property ContentType: string read FContentType write SetContentType;
    property FieldName: string read FFieldName write SetFieldName;
    property FieldStream: TStream read GetFieldStream write SetFieldStream;
    property FieldStrings: TIdStrings read GetFieldStrings write SetFieldStrings;
    property FieldObject: TObject read FFieldObject write SetFieldObject;
    property FileName: string read FFileName write SetFileName;
    property FieldValue: string read FFieldValue write SetFieldValue;
    property FieldSize: LongInt read GetFieldSize;
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
    FBoundary: string;
    FRequestContentType: string;
    FCurrentItem: integer;
    FInitialized: Boolean;
    FInternalBuffer: TIdBytes;

    FPosition: Int64;
    FSize: Int64;

    FFields: TIdFormDataFields;

    function GenerateUniqueBoundary: string;
    function PrepareStreamForDispatch: string;

    function IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint; override;
    function IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    procedure IdSetSize(ASize : Int64); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddFormField(const AFieldName, AFieldValue: string);
    procedure AddObject(const AFieldName, AContentType: string; AFileData: TObject; const AFileName: string = '');
    procedure AddFile(const AFieldName, AFileName, AContentType: string);

    property Boundary: string read FBoundary;
    property RequestContentType: string read FRequestContentType;
  end;

  EIdInvalidObjectType = class(EIdException);

implementation

uses
  IdGlobalProtocols;

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
  Sys.FreeAndNil(FFields);
  inherited Destroy;
end;

procedure TIdMultiPartFormDataStream.AddObject(const AFieldName,
  AContentType: string; AFileData: TObject; const AFileName: string = '');
var
  LItem: TIdFormDataField;
begin
  LItem := FFields.Add;

  with LItem do begin
    FFieldName := AFieldName;
    FFileName := AFileName;
    FFieldObject := AFileData;
    if Length(AContentType) > 0 then begin
  	  FContentType := AContentType;
    end else begin
      if Length(FFileName) > 0 then begin
        FContentType := GetMIMETypeFromFile(FFileName);
      end else begin
        FContentType := sContentTypeOctetStream;
      end;
    end;
  end;

  FSize := FSize + LItem.FieldSize;
end;

procedure TIdMultiPartFormDataStream.AddFile(const AFieldName, AFileName,
  AContentType: string);
var
  LStream: TReadFileExclusiveStream;
  LItem: TIdFormDataField;
begin
  LStream := TReadFileExclusiveStream.Create(AFileName);
  try
    LItem := FFields.Add;
  except
    Sys.FreeAndNil(LStream);
    raise;
  end;

  with LItem do begin
    FFieldName := AFieldName;
    FFileName := AFileName;
    FFieldObject := LStream;
    FCanFreeFieldObject := True;
    if Length(AContentType) > 0 then begin
  	  FContentType := AContentType;
    end else begin
      FContentType := GetMIMETypeFromFile(AFileName);
    end;
  end;

  FSize := FSize + LItem.FieldSize;
end;

procedure TIdMultiPartFormDataStream.AddFormField(const AFieldName,
  AFieldValue: string);
var
  LItem: TIdFormDataField;
begin
  LItem := FFields.Add;

  with LItem do begin
    FFieldName := AFieldName;
    FFieldValue := AFieldValue;
  end;

  FSize := FSize + LItem.FieldSize;
end;

function TIdMultiPartFormDataStream.GenerateUniqueBoundary: string;
begin
  Result := '--------' + Sys.FormatDateTime('mmddyyhhnnsszzz', Sys.Now);  {do not localize}
end;

function TIdMultiPartFormDataStream.PrepareStreamForDispatch: string;
begin
  result := {crlf +} '--' + Boundary + '--' + crlf;
end;

// RLebeau - IdRead() should wrap multiple files using a single
// "multipart/mixed" MIME part, as recommended by RFC 1867

function TIdMultiPartFormDataStream.IdRead(var VBuffer: TIdBytes; AOffset, ACount: Longint): Longint;
var
  LTotalRead: Integer;
  LCount: Integer;
  LBufferCount: Integer;
  LRemaining : Integer;
  LItem: TIdFormDataField;
begin
  if not FInitialized then begin
    FInitialized := True;
    FCurrentItem := 0;
    SetLength(FInternalBuffer, 0);
  end;

  LTotalRead := 0;
  LBufferCount := 0;

  while (LTotalRead < ACount) and ((FCurrentItem < FFields.Count) or (Length(FInternalBuffer) > 0)) do begin
    if (Length(FInternalBuffer) = 0) and not Assigned(FInputStream) then begin
      LItem := FFields.Items[FCurrentItem];
      AppendString(FInternalBuffer, LItem.FormatField);

      if Assigned(LItem.FieldObject) then begin
        if (LItem.FieldObject is TStream) then begin
          FInputStream := TStream(LItem.FieldObject);
          FInputStream.Position := 0;
        end else begin
          if (LItem.FieldObject is TIdStrings) then begin
            AppendString(FInternalBuffer, TIdStrings(LItem.FieldObject).Text);
            Inc(FCurrentItem);
          end;
        end;
      end else begin
        Inc(FCurrentItem);
      end;
    end;

    if Length(FInternalBuffer) > 0 then begin
      if Length(FInternalBuffer) > (ACount - LBufferCount) then begin
        LCount := ACount - LBufferCount;
      end else begin
        LCount := Length(FInternalBuffer);
      end;

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

    if Assigned(FInputStream) and (LTotalRead < ACount) then begin
      with TIdStreamVCL.Create(FInputStream, False) do try
        LCount := ReadBytes(VBuffer, ACount - LTotalRead, LBufferCount, False);
      finally
        Free;
      end;   

      if LCount < (ACount - LTotalRead) then begin
        FInputStream.Position := 0;
        FInputStream := nil;
        Inc(FCurrentItem);
        SetLength(FInternalBuffer, 0);
        AppendString(FInternalBuffer, #13#10);
      end;

      LBufferCount := LBufferCount + LCount;
      LTotalRead := LTotalRead + LCount;
      FPosition := FPosition + LCount;
    end;

    if FCurrentItem = FFields.Count then begin
      AppendString(FInternalBuffer, PrepareStreamForDispatch);
      Inc(FCurrentItem);
    end;
  end;
  Result := LTotalRead;
end;

function TIdMultiPartFormDataStream.IdSeek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  Result := 0;
  case AOrigin of
    IdFromBeginning: begin
        if (AOffset = 0) then begin
          FInitialized := False;
          FPosition := 0;
          Result := 0;
        end else begin
          Result := FPosition;
        end;
      end;
    IdFromCurrent: begin
        Result := FPosition;
      end;
    IdFromEnd: begin
        Result := FSize + Length(PrepareStreamForDispatch);
      end;
  end;
end;

function TIdMultiPartFormDataStream.IdWrite(const ABuffer: TIdBytes; AOffset, ACount: Longint): Longint;
begin
  raise EIdException.Create(RSUnsupportedOperation);
end;

procedure TIdMultiPartFormDataStream.IdSetSize(ASize: Int64);
begin
  raise EIdException.Create(RSUnsupportedOperation);
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

function TIdFormDataFields.GetFormDataField(
  AIndex: Integer): TIdFormDataField;
begin
  Result := TIdFormDataField(inherited Items[AIndex]);
end;

{ TIdFormDataField }

constructor TIdFormDataField.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFieldObject := nil;
  FFileName := '';
  FFieldName := '';
  FContentType := '';
  FCanFreeFieldObject := False;
end;

destructor TIdFormDataField.Destroy;
begin
  if Assigned(FFieldObject) then begin
    if FCanFreeFieldObject then begin
      Sys.FreeAndNil(FFieldObject);
    end;
  end;
  inherited Destroy;
end;

function TIdFormDataField.FormatField: string;
var
  LBoundary: string;
begin
  LBoundary := TIdFormDataFields(Collection).MultipartFormDataStream.Boundary;

  if Assigned(FieldObject) then begin
    if Length(FileName) > 0 then begin
      Result := Sys.Format('--%s' + crlf + sContentDisposition +
        sFileNamePlaceHolder + crlf + sContentTypePlaceHolder +
        crlf + sContentTransferEncoding + crlf + crlf,
        [LBoundary, FieldName, FileName, ContentType]);
      Exit;
    end;
  end;

  Result := Sys.Format('--%s' + crlf + sContentDisposition + crlf + crlf +
        '%s' + crlf, [LBoundary, FieldName, FieldValue]);
end;

function TIdFormDataField.GetFieldSize: LongInt;
begin
  Result := Length(FormatField);
  if Assigned(FFieldObject) then begin
    if FieldObject is TIdStrings then begin
      Result := Result + Length(TIdStrings(FieldObject).Text) + 2;
    end else begin
      if FieldObject is TStream then begin
        Result := Result + TStream(FieldObject).Size + 2;
      end;
    end;
  end;
end;

function TIdFormDataField.GetFieldStream: TStream;
begin
  Result := nil;
  if Assigned(FFieldObject) then begin
    if (FFieldObject is TStream) then begin
      Result := TStream(FFieldObject);
    end else begin
      raise EIdInvalidObjectType.Create(RSMFDIvalidObjectType);
    end;
  end;
end;

function TIdFormDataField.GetFieldStrings: TIdStrings;
begin
  Result := nil;
  if Assigned(FFieldObject) then begin
    if (FFieldObject is TIdStrings) then begin
      Result := TIdStrings(FFieldObject);
    end else begin
      raise EIdInvalidObjectType.Create(RSMFDIvalidObjectType);
    end;
  end;
end;

procedure TIdFormDataField.SetContentType(const Value: string);
begin
  if Length(Value) > 0 then begin
    FContentType := Value;
  end else begin
    if Length(FFileName) > 0 then begin
      FContentType := GetMIMETypeFromFile(FFileName);
    end else begin;
      FContentType := sContentTypeOctetStream;
    end;
  end;
  GetFieldSize;
end;

procedure TIdFormDataField.SetFieldName(const Value: string);
begin
  FFieldName := Value;
  GetFieldSize;
end;

procedure TIdFormDataField.SetFieldObject(const Value: TObject);
begin
  if Assigned(Value) then begin
    if not ((Value is TStream) or (Value is TIdStrings)) then begin
      raise EIdInvalidObjectType.Create(RSMFDIvalidObjectType);
    end;
  end;

  if Assigned(FFieldObject) then begin
    if FCanFreeFieldObject then begin
      Sys.FreeAndNil(FFieldObject);
    end;
  end;

  FFieldObject := Value;
  FCanFreeFieldObject := False;
  GetFieldSize;
end;

procedure TIdFormDataField.SetFieldStream(const Value: TStream);
begin
  FieldObject := Value;
end;

procedure TIdFormDataField.SetFieldStrings(const Value: TIdStrings);
begin
  FieldObject := Value;
end;

procedure TIdFormDataField.SetFieldValue(const Value: string);
begin
  FFieldValue := Value;
  GetFieldSize;
end;

procedure TIdFormDataField.SetFileName(const Value: string);
begin
  FFileName := Value;
  GetFieldSize;
end;

end.

