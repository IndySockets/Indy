unit IdMessageBuilder;

interface

{$i IdCompilerDefines.inc}

uses
  Classes, IdMessage;

type
  TIdMessageBuilderAttachment = class(TCollectionItem)
  private
    FContentID: String;
    FContentTransfer: String;
    FContentType: String;
    FData: TStream;
    FFileName: String;
    FName: String;
    FWantedFileName: String;
  public
    procedure Assign(Source: TPersistent); override;
    property ContentID: String read FContentID write FContentID;
    property ContentTransfer: String read FContentTransfer write FContentTransfer;
    property ContentType: String read FContentType write FContentType;
    property Data: TStream read FData write FData;
    property FileName: String read FFileName write FFileName;
    property Name: String read FName write FName;
    property WantedFileName: String read FWantedFileName write FWantedFileName;
  end;

  TIdMessageBuilderAttachments = class(TCollection)
  private
    function GetAttachment(Index: Integer): TIdMessageBuilderAttachment;
    procedure SetAttachment(Index: Integer; Value: TIdMessageBuilderAttachment);
  public
    constructor Create; reintroduce;
    function Add: TIdMessageBuilderAttachment; reintroduce; overload;
    function Add(const AFileName: String; const AContentID: String = ''): TIdMessageBuilderAttachment; overload;
    function Add(AData: TStream; const AContentType: String; const AContentID: String = ''): TIdMessageBuilderAttachment; overload;
    procedure AddToMessage(AMsg: TIdMessage; ParentPart: Integer);
    property Attachment[Index: Integer]: TIdMessageBuilderAttachment
      read GetAttachment write SetAttachment; default;
  end;

  TIdCustomMessageBuilder = class
  protected
    FAttachments: TIdMessageBuilderAttachments;
    FPlainText: TStrings;
    FPlainTextCharSet: String;
    FPlainTextContentTransfer: String;
    procedure AddAttachments(AMsg: TIdMessage);
    procedure FillBody(AMsg: TIdMessage); virtual; abstract;
    procedure FillHeaders(AMsg: TIdMessage); virtual;
    procedure SetPlainText(AValue: TStrings);
    procedure SetAttachments(AValue: TIdMessageBuilderAttachments);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    //
    procedure Clear; virtual;
    procedure FillMessage(AMsg: TIdMessage);
    function NewMessage(AOwner: TComponent = nil): TIdMessage;
    //
    property Attachments: TIdMessageBuilderAttachments read FAttachments write SetAttachments;
    property PlainText: TStrings read FPlainText write SetPlainText;
    property PlainTextCharSet: String read FPlainTextCharSet write FPlainTextCharSet;
    property PlainTextContentTransfer: String read FPlainTextContentTransfer write FPlainTextContentTransfer;
  end;

  TIdMessageBuilderPlain = class(TIdCustomMessageBuilder)
  protected
    procedure FillBody(AMsg: TIdMessage); override;
    procedure FillHeaders(AMsg: TIdMessage); override;
  end;

  TIdMessageBuilderHtml = class(TIdCustomMessageBuilder)
  protected
    FHtml: TStrings;
    FHtmlCharSet: String;
    FHtmlContentTransfer: String;
    FHtmlFiles: TIdMessageBuilderAttachments;
    FHtmlViewerNeededMsg: String;
    procedure FillBody(AMsg: TIdMessage); override;
    procedure FillHeaders(AMsg: TIdMessage); override;
    procedure SetHtml(AValue: TStrings);
    procedure SetHtmlFiles(AValue: TIdMessageBuilderAttachments);
  public
    constructor Create; override;
    destructor Destroy; override;
    //
    procedure Clear; override;
    //
    property Html: TStrings read FHtml write SetHtml;
    property HtmlCharSet: String read FHtmlCharSet write FHtmlCharSet;
    property HtmlContentTransfer: String read FHtmlContentTransfer write FHtmlContentTransfer;
    property HtmlFiles: TIdMessageBuilderAttachments read FHtmlFiles write SetHtmlFiles;
    property HtmlViewerNeededMsg: String read FHtmlViewerNeededMsg write FHtmlViewerNeededMsg;
  end;

  TIdMessageBuilderRtfType = (idMsgBldrRtfMS, idMsgBldrRtfEnriched, idMsgBldrRtfRichtext);

  TIdMessageBuilderRtf = class(TIdCustomMessageBuilder)
  protected
    FRtf: TStrings;
    FRtfType: TIdMessageBuilderRtfType;
    FRtfViewerNeededMsg: String;
    procedure FillBody(AMsg: TIdMessage); override;
    procedure FillHeaders(AMsg: TIdMessage); override;
    procedure SetRtf(AValue: TStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    //
    procedure Clear; override;
    //
    property Rtf: TStrings read FRtf write SetRtf;
    property RtfType: TIdMessageBuilderRtfType read FRtfType write FRtfType;
    property RtfViewerNeededMsg: String read FRtfViewerNeededMsg write FRtfViewerNeededMsg;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdMessageParts, IdAttachment, IdAttachmentFile,
  IdAttachmentMemory, IdResourceStringsProtocols, IdText, SysUtils;

const
  cTextPlain = 'text/plain'; {do not localize}
  cTextHtml = 'text/html'; {do not localize}
  cTextRtf: array[TIdMessageBuilderRtfType] of String = ('text/rtf', 'text/enriched', 'text/richtext'); {do not localize}
  cMultipartAlternative = 'multipart/alternative'; {do not localize}
  cMultipartMixed = 'multipart/mixed'; {do not localize}
  cMultipartRelatedHtml = 'multipart/related; type="text/html"'; {do not localize}
  cQuotedPrintable = 'quoted-printable'; {do not localize}
  cUTF8 = 'utf-8'; {do not localize}

{ TIdMessageBuilderAttachment }

procedure TIdMessageBuilderAttachment.Assign(Source: TPersistent);
var
  LSource: TIdMessageBuilderAttachment;
begin
  if Source is TIdMessageBuilderAttachment then
  begin
    LSource := TIdMessageBuilderAttachment(Source);
    FContentID := LSource.FContentID;
    FContentTransfer := LSource.FContentTransfer;
    FContentType := LSource.FContentType;
    FData := LSource.FData;
    FFileName := LSource.FFileName;
    FName := LSource.FName;
    FWantedFileName := LSource.FWantedFileName;
  end else begin
    inherited Assign(Source);
  end;
end;

{ TIdMessageBuilderAttachments }

constructor TIdMessageBuilderAttachments.Create;
begin
  inherited Create(TIdMessageBuilderAttachment);
end;

function TIdMessageBuilderAttachments.Add: TIdMessageBuilderAttachment;
begin
  // This helps prevent unsupported TIdMessageBuilderAttachment from being added
  Result := nil;
end;

function TIdMessageBuilderAttachments.Add(const AFileName: String;
  const AContentID: String = ''): TIdMessageBuilderAttachment;
begin
  Result := TIdMessageBuilderAttachment(inherited Add);
  if AContentID <> '' then begin
    Result.FContentID := AContentID;
  end else begin
    Result.FContentID := ExtractFileName(AFileName);
  end;
  Result.FFileName := AFileName;
  Result.FWantedFileName := ExtractFileName(AFileName);
end;

function TIdMessageBuilderAttachments.Add(AData: TStream; const AContentType: String;
  const AContentID: String = ''): TIdMessageBuilderAttachment;
begin
  Assert(AData <> nil);
  Result := TIdMessageBuilderAttachment(inherited Add);
  Result.FContentID := AContentID;
  Result.FContentType := AContentType;
  Result.FData := AData;
end;

procedure TIdMessageBuilderAttachments.AddToMessage(AMsg: TIdMessage; ParentPart: Integer);
var
  I: Integer;
  LMsgBldrAttachment: TIdMessageBuilderAttachment;
  LMsgAttachment: TIdAttachment;
  LStream: TStream;

  function FormatContentId(Item: TIdMessageBuilderAttachment): String;
  begin
    if Item.ContentID <> '' then begin
      Result := EnsureMsgIDBrackets(Item.ContentID);
    end else begin
      Result := '';
    end;
  end;

  function FormatContentType(Item: TIdMessageBuilderAttachment): String;
  begin
    if Item.ContentType <> '' then begin
      Result := Item.ContentType;
    end else begin
      Result := GetMIMETypeFromFile(Item.FileName);
    end;
  end;

  function FormatFileName(Item: TIdMessageBuilderAttachment): String;
  begin
    if Item.WantedFileName <> '' then begin
      Result := ExtractFileName(Item.WantedFileName);
    end
    else if Item.FileName <> '' then begin
      Result := ExtractFileName(Item.FileName);
    end else begin
      Result := '';
    end;
  end;

  function FormatName(Item: TIdMessageBuilderAttachment): String;
  begin
    if Item.Name <> '' then begin
      Result := Item.Name;
    end else begin
      Result := FormatFileName(Item);
    end;
  end;

begin
  for I := 0 to Count-1 do
  begin
    LMsgBldrAttachment := Attachment[I];
    if Assigned(LMsgBldrAttachment.Data) then
    begin
      LMsgAttachment := TIdAttachmentMemory.Create(AMsg.MessageParts);
      try
        LMsgAttachment.FileName := FormatFileName(LMsgBldrAttachment);
        LStream := LMsgAttachment.PrepareTempStream;
        try
          LStream.CopyFrom(LMsgBldrAttachment.Data, 0);
        finally
          LMsgAttachment.FinishTempStream;
        end;
      except
        LMsgAttachment.Free;
        raise;
      end;
    end else
    begin
      LMsgAttachment := TIdAttachmentFile.Create(AMsg.MessageParts, LMsgBldrAttachment.FileName);
      if LMsgBldrAttachment.WantedFileName <> '' then begin
        LMsgAttachment.FileName := ExtractFileName(LMsgBldrAttachment.WantedFileName);
      end;
    end;
    LMsgAttachment.Name := FormatName(LMsgBldrAttachment);
    LMsgAttachment.ContentId := FormatContentId(LMsgBldrAttachment);
    LMsgAttachment.ContentType := FormatContentType(LMsgBldrAttachment);
    LMsgAttachment.ContentTransfer := LMsgBldrAttachment.ContentTransfer;
    if ParentPart > -1 then
    begin
      if IsHeaderMediaType(LMsgAttachment.ContentType, 'image') then begin {do not localize}
        LMsgAttachment.ContentDisposition := 'inline'; {do not localize}
      end;
      LMsgAttachment.ParentPart := ParentPart;
    end;
  end;
end;

function TIdMessageBuilderAttachments.GetAttachment(Index: Integer): TIdMessageBuilderAttachment;
begin
  Result := TIdMessageBuilderAttachment(inherited GetItem(Index));
end;

procedure TIdMessageBuilderAttachments.SetAttachment(Index: Integer; Value: TIdMessageBuilderAttachment);
begin
  inherited SetItem(Index, Value);
end;

{ TIdCustomMessageBuilder }

constructor TIdCustomMessageBuilder.Create;
begin
  inherited Create;
  FPlainText := TStringList.Create;
  FAttachments := TIdMessageBuilderAttachments.Create;
end;

destructor TIdCustomMessageBuilder.Destroy;
begin
  FPlainText.Free;
  FAttachments.Free;
  inherited Destroy;
end;

procedure TIdCustomMessageBuilder.AddAttachments(AMsg: TIdMessage);
begin
  FAttachments.AddToMessage(AMsg, -1);
end;

procedure TIdCustomMessageBuilder.Clear;
begin
  FAttachments.Clear;
  FPlainText.Clear;
  FPlainTextCharSet := '';
  FPlainTextContentTransfer := '';
end;

procedure TIdCustomMessageBuilder.FillMessage(AMsg: TIdMessage);
begin
  if not Assigned(AMsg) then begin
    Exit;
  end;

  // Clear only the body, ContentType, CharSet, and ContentTransferEncoding here...
  //
  AMsg.ClearBody;
  AMsg.ContentType := '';
  AMsg.CharSet := '';
  AMsg.ContentTransferEncoding := '';

  // let the message decide how to encode itself
  // based on what parts are added in InternalFill()
  //
  AMsg.Encoding := meDefault;

  // fill in type-specific content first
  //
  FillBody(AMsg);

  // Are non-related attachments present?
  //
  AddAttachments(AMsg);

  // Determine the top-level ContentType and
  // ContentTransferEncoding for the message now
  //
  FillHeaders(AMsg);
end;

function TIdCustomMessageBuilder.NewMessage(AOwner: TComponent = nil): TIdMessage;
begin
  Result := TIdMessage.Create(AOwner);
  try
    FillMessage(Result);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TIdCustomMessageBuilder.SetAttachments(AValue: TIdMessageBuilderAttachments);
begin
  FAttachments.Assign(AValue);
end;

procedure TIdCustomMessageBuilder.FillHeaders(AMsg: TIdMessage);
var
  LPart: TIdMessagePart;
begin
  if FAttachments.Count > 0 then
  begin
    if AMsg.MessageParts.Count > 1 then
    begin
      // plain text and/or formatting, and at least 1 non-related attachment
      //
      AMsg.ContentType := cMultipartMixed;
      AMsg.CharSet := '';
      AMsg.ContentTransferEncoding := '';
    end else
    begin
      // no plain text or formatting, only 1 non-related attachment
      //
      // TODO: can we use AMsg.IsMsgSinglePartMime=True instead?
      //
      LPart := AMsg.MessageParts[0];
      AMsg.ContentType := LPart.ContentType;
      AMsg.CharSet := LPart.CharSet;
      AMsg.ContentTransferEncoding := LPart.ContentTransfer;
    end;
  end else
  begin
    AMsg.ContentType := '';
    AMsg.CharSet := '';
    AMsg.ContentTransferEncoding := '';
  end;
end;

procedure TIdCustomMessageBuilder.SetPlainText(AValue: TStrings);
begin
  FPlainText.Assign(AValue);
end;

{ TIdMessageBuilderPlain }

procedure TIdMessageBuilderPlain.FillBody(AMsg: TIdMessage);
var
  LTextPart: TIdText;
begin
  // Is plain text present?
  //
  if FPlainText.Count > 0 then
  begin
    // Should the message contain only plain text?
    //
    if FAttachments.Count = 0 then
    begin
      AMsg.Body.Assign(FPlainText);
    end else
    begin
      // At this point, multiple pieces will be present in the message
      // body, so everything must be stored in the MessageParts collection...
      //
      LTextPart := TIdText.Create(AMsg.MessageParts, FPlainText);
      LTextPart.ContentType := cTextPlain;
      LTextPart.CharSet := FPlainTextCharSet;
      {$IFDEF STRING_IS_UNICODE}
      if LTextPart.CharSet = '' then begin
        LTextPart.CharSet := cUTF8;
      end;
      {$ELSE}
      // TODO: which default charset to use, if any?
      {$ENDIF}
      LTextPart.ContentTransfer := FPlainTextContentTransfer;
      if LTextPart.ContentTransfer = '' then begin
        LTextPart.ContentTransfer := cQuotedPrintable;
      end;
    end;
  end;
end;

procedure TIdMessageBuilderPlain.FillHeaders(AMsg: TIdMessage);
begin
  if (FPlainText.Count > 0) and (FAttachments.Count = 0) then
  begin
    // plain text only
    //
    AMsg.ContentType := cTextPlain;
    AMsg.CharSet := FPlainTextCharSet;
    {$IFDEF STRING_IS_UNICODE}
    if AMsg.CharSet = '' then begin
      AMsg.CharSet := cUTF8;
    end;
    {$ELSE}
    // which default charset to use, if any?
    {$ENDIF}
    AMsg.ContentTransferEncoding := FPlainTextContentTransfer;
    if AMsg.ContentTransferEncoding = '' then begin
      AMsg.ContentTransferEncoding := cQuotedPrintable;
    end;
  end else
  begin
    inherited FillHeaders(AMsg);
  end;
end;

{ TIdMessageBuilderHtml }

constructor TIdMessageBuilderHtml.Create;
begin
  inherited Create;
  FHtml := TStringList.Create;
  FHtmlFiles := TIdMessageBuilderAttachments.Create;
  FHtmlViewerNeededMsg := rsHtmlViewerNeeded;
end;

destructor TIdMessageBuilderHtml.Destroy;
begin
  FHtml.Free;
  FHtmlFiles.Free;
  inherited Destroy;
end;

procedure TIdMessageBuilderHtml.Clear;
begin
  FHtml.Clear;
  FHtmlCharSet := '';
  FHtmlContentTransfer := '';
  FHtmlFiles.Clear;
  inherited Clear;
end;

procedure TIdMessageBuilderHtml.FillBody(AMsg: TIdMessage);
var
  LUsePlain, LUseHtml, LUseViewerMsg, LUseHtmlFiles, LUseAttachments: Boolean;
  LAlternativeIndex, LRelatedIndex: Integer;
  LTextPart: TIdText;
begin
  // Cache these for better performance
  //
  LUsePlain := FPlainText.Count > 0;
  LUseHtml := FHtml.Count > 0;
  LUseViewerMsg := FHtmlViewerNeededMsg <> '';
  LUseHtmlFiles := LUseHtml and (FHtmlFiles.Count > 0);
  LUseAttachments := FAttachments.Count > 0;

  LAlternativeIndex := -1;
  LRelatedIndex := -1;

  // Is any body data present at all?
  //
  if not (LUsePlain or LUseHtml or LUseHtmlFiles or LUseAttachments) then begin
    Exit;
  end;

  // Should the message contain only plain text?
  //
  if LUsePlain and not (LUseHtml or LUseAttachments) then
  begin
    AMsg.Body.Assign(FPlainText);
    Exit;
  end;

  // Should the message contain only HTML?
  //
  if LUseHtml and not (LUsePlain or LUseViewerMsg or LUseHtmlFiles or LUseAttachments) then
  begin
    // TODO: create "multipart/alternative" pieces if FHtmlViewerNeededMsg is not empty...
    AMsg.Body.Assign(FHtml);
    Exit;
  end;

  // At this point, multiple pieces will be present in the message
  // body, so everything must be stored in the MessageParts collection...

  // If the message should contain both plain text and HTML, a
  // "multipart/alternative" piece is needed to wrap them if
  // non-related attachments are also present...
  //
  // RLebeau 5/23/2011: need to output the Alternative piece if
  // the "HTML Viewer is needed" text is going to be used...
  //
  if {LUsePlain and} LUseHtml and LUseAttachments then
  begin
    LTextPart := TIdText.Create(AMsg.MessageParts, nil);
    LTextPart.ContentType := cMultipartAlternative;
    LAlternativeIndex := LTextPart.Index;
  end;

  // Is plain text present?
  //
  if LUsePlain or LUseHtml then
  begin
    LTextPart := TIdText.Create(AMsg.MessageParts, FPlainText);
    if LUseHtml and (not LUsePlain) then begin
      LTextPart.Body.Text := FHtmlViewerNeededMsg;
    end;
    LTextPart.ContentType := cTextPlain;
    LTextPart.CharSet := FPlainTextCharSet;
    {$IFDEF STRING_IS_UNICODE}
    if LTextPart.CharSet = '' then begin
      LTextPart.CharSet := cUTF8;
    end;
    {$ELSE}
    // TODO: which default charset to use, if any?
    {$ENDIF}
    LTextPart.ContentTransfer := FPlainTextContentTransfer;
    if LTextPart.ContentTransfer = '' then begin
      LTextPart.ContentTransfer := cQuotedPrintable;
    end;
    LTextPart.ParentPart := LAlternativeIndex;
  end;

  // Is HTML present?
  //
  if LUseHtml then
  begin
    // related attachments can't be referenced by, or used inside
    // of, plain text, so there is no point in wrapping the plain
    // text inside the same "multipart/related" part with the HTML
    // and attachments.  Some email programs don't do that as well.
    // This logic is newer and more accurate than what is described
    // in the "HTML Messages" article found on Indy's website.
    //
    if LUseHtmlFiles then
    begin
      LTextPart := TIdText.Create(AMsg.MessageParts, nil);
      LTextPart.ContentType := cMultipartRelatedHtml;
      LTextPart.ParentPart := LAlternativeIndex;
      LRelatedIndex := LTextPart.Index;
    end;

    // Add HTML
    //
    LTextPart := TIdText.Create(AMsg.MessageParts, FHtml);
    LTextPart.ContentType := cTextHtml;
    LTextPart.CharSet := FHtmlCharSet;
    {$IFDEF STRING_IS_UNICODE}
    if LTextPart.CharSet = '' then begin
      LTextPart.CharSet := cUTF8;
    end;
    {$ELSE}
    // TODO: which default charset to use, if any?
    {$ENDIF}
    LTextPart.ContentTransfer := FHtmlContentTransfer;
    if LTextPart.ContentTransfer = '' then begin
      LTextPart.ContentTransfer := cQuotedPrintable;
    end;
    if LRelatedIndex <> -1 then begin
      LTextPart.ParentPart := LRelatedIndex; // plain text and related attachments
    end else begin
      LTextPart.ParentPart := LAlternativeIndex; // plain text and optional non-related attachments
    end;

    // Are related attachments present?
    //
    if LUseHtmlFiles then begin
      FHtmlFiles.AddToMessage(AMsg, LRelatedIndex);
    end;
  end;
end;

procedure TIdMessageBuilderHtml.FillHeaders(AMsg: TIdMessage);
var
  LUsePlain, LUseHtml, LUseViewerMsg: Boolean;
begin
  if FAttachments.Count = 0 then
  begin
    LUsePlain := FPlainText.Count > 0;
    LUseHtml := FHtml.Count > 0;
    LUseViewerMsg := FHtmlViewerNeededMsg <> '';

    if LUsePlain and (not LUseHtml) then
    begin
      // plain text only
      //
      AMsg.ContentType := cTextPlain;
      AMsg.CharSet := FPlainTextCharSet;
      {$IFDEF STRING_IS_UNICODE}
      if AMsg.CharSet = '' then begin
        AMsg.CharSet := cUTF8;
      end;
      {$ELSE}
      // TODO: which default charset to use, if any?
      {$ENDIF}
      AMsg.ContentTransferEncoding := FPlainTextContentTransfer;
      if AMsg.ContentTransferEncoding = '' then begin
        AMsg.ContentTransferEncoding := cQuotedPrintable;
      end;
    end
    else if LUseHtml then
    begin
      if (not LUsePlain) and (not LUseViewerMsg) and (FHtmlFiles.Count = 0) then
      begin
        // HTML only
        //
        AMsg.ContentType := cTextHtml;
        AMsg.CharSet := FHtmlCharSet;
        {$IFDEF STRING_IS_UNICODE}
        if AMsg.CharSet = '' then begin
          AMsg.CharSet := cUTF8;
        end;
        {$ELSE}
        // TODO: which default charset to use, if any?
        {$ENDIF}
        AMsg.ContentTransferEncoding := FHtmlContentTransfer;
        if AMsg.ContentTransferEncoding = '' then begin
          AMsg.ContentTransferEncoding := cQuotedPrintable;
        end;
      end else
      begin
        // plain text and HTML and no related attachments
        //
        AMsg.ContentType := cMultipartAlternative;
        AMsg.CharSet := '';
        AMsg.ContentTransferEncoding := '';
      end;
    end else
    begin
      // TODO: what to put here??
    end;
  end else
  begin
    inherited FillHeaders(AMsg);
  end;
end;

procedure TIdMessageBuilderHtml.SetHtml(AValue: TStrings);
begin
  FHtml.Assign(AValue);
end;

procedure TIdMessageBuilderHtml.SetHtmlFiles(AValue: TIdMessageBuilderAttachments);
begin
  FHtmlFiles.Assign(AValue);
end;

{ TIdMessageBuilderRTF }

constructor TIdMessageBuilderRtf.Create;
begin
  inherited Create;
  FRtf := TStringList.Create;
  FRtfType := idMsgBldrRtfMS;
  FRtfViewerNeededMsg := rsRtfViewerNeeded;
end;

destructor TIdMessageBuilderRtf.Destroy;
begin
  FRtf.Free;
  inherited Destroy;
end;

procedure TIdMessageBuilderRtf.Clear;
begin
  FRtf.Clear;
  inherited Clear;
end;

procedure TIdMessageBuilderRtf.FillBody(AMsg: TIdMessage);
var
  LUsePlain, LUseRtf, LUseViewerMsg, LUseAttachments: Boolean;
  LAlternativeIndex: Integer;
  LTextPart: TIdText;
begin
  // Cache these for better performance
  //
  LUsePlain := FPlainText.Count > 0;
  LUseRtf := FRtf.Count > 0;
  LUseViewerMsg := FRtfViewerNeededMsg <> '';
  LUseAttachments := FAttachments.Count > 0;
  LAlternativeIndex := -1;

  // Is any body data present at all?
  //
  if not (LUsePlain or LUseRtf or LUseAttachments) then begin
    Exit;
  end;

  // Should the message contain only plain text?
  //
  if LUsePlain and not (LUseRtf or LUseAttachments) then
  begin
    AMsg.Body.Assign(FPlainText);
    Exit;
  end;

  // Should the message contain only RTF?
  //
  if LUseRtf and not (LUsePlain or LUseViewerMsg or LUseAttachments) then
  begin
    // TODO: create "multipart/alternative" pieces if FRtfViewerNeededMsg is not empty...
    AMsg.Body.Assign(FRtf);
    Exit;
  end;

  // At this point, multiple pieces will be present in the message
  // body, so everything must be stored in the MessageParts collection...

  // If the message should contain both plain text and RTF, a
  // "multipart/alternative" piece is needed to wrap them if
  // attachments are also present...
  //
  // RLebeau 11/11/2013: need to output the Alternative piece if
  // the "RTF Viewer is needed" text is going to be used...
  //
  if {LUsePlain and} LUseRtf and LUseAttachments then
  begin
    LTextPart := TIdText.Create(AMsg.MessageParts, nil);
    LTextPart.ContentType := cMultipartAlternative;
    LAlternativeIndex := LTextPart.Index;
  end;

  // Is plain text present?
  //
  if LUsePlain or LUseRtf then
  begin
    LTextPart := TIdText.Create(AMsg.MessageParts, FPlainText);
    if LUseRtf and (not LUsePlain) then begin
      LTextPart.Body.Text := FRtfViewerNeededMsg;
    end;
    LTextPart.ContentType := cTextPlain;
    LTextPart.CharSet := FPlainTextCharSet;
    {$IFDEF STRING_IS_UNICODE}
    if LTextPart.CharSet = '' then begin
      LTextPart.CharSet := cUTF8;
    end;
    {$ELSE}
    // TODO: which default charset to use, if any?
    {$ENDIF}
    LTextPart.ContentTransfer := FPlainTextContentTransfer;
    if LTextPart.ContentTransfer = '' then begin
      LTextPart.ContentTransfer := cQuotedPrintable;
    end;
    LTextPart.ParentPart := LAlternativeIndex;
  end;

  // Is RTF present?
  //
  if LUseRtf then
  begin
    // Add RTF
    //
    LTextPart := TIdText.Create(AMsg.MessageParts, FRtf);
    LTextPart.ContentType := cTextRtf[FRtfType];
    LTextPart.ParentPart := LAlternativeIndex; // plain text and optional non-related attachments
  end;
end;

procedure TIdMessageBuilderRtf.FillHeaders(AMsg: TIdMessage);
var
  LUsePlain, LUseRtf, LUseViewerMsg: Boolean;
begin
  if FAttachments.Count = 0 then
  begin
    LUsePlain := FPlainText.Count > 0;
    LUseRtf := FRtf.Count > 0;
    LUseViewerMsg := FRtfViewerNeededMsg <> '';

    if (LUsePlain) and (not LUseRtf) then
    begin
      // plain text only
      //
      AMsg.ContentType := cTextPlain;
      AMsg.CharSet := FPlainTextCharSet;
      {$IFDEF STRING_IS_UNICODE}
      if AMsg.CharSet = '' then begin
        AMsg.CharSet := cUTF8;
      end;
      {$ELSE}
      // TODO: which default charset to use, if any?
      {$ENDIF}
      AMsg.ContentTransferEncoding := FPlainTextContentTransfer;
      if AMsg.ContentTransferEncoding = '' then begin
        AMsg.ContentTransferEncoding := cQuotedPrintable;
      end;
    end
    else if LUseRtf then
    begin
      if (not LUsePlain) and (not LUseViewerMsg) then
      begin
        // RTF only
        //
        AMsg.ContentType := cTextRtf[FRtfType];
        AMsg.CharSet := '';
        AMsg.ContentTransferEncoding := '';
      end else
      begin
        // plain text and RTF and no non-related attachments
        //
        AMsg.ContentType := cMultipartAlternative;
        AMsg.CharSet := '';
        AMsg.ContentTransferEncoding := '';
      end;
    end else
    begin
      // TODO: what to put here?
    end;
  end else
  begin
    inherited FillHeaders(AMsg);
  end;
end;

procedure TIdMessageBuilderRtf.SetRtf(AValue: TStrings);
begin
  FRtf.Assign(AValue);
end;

end.
