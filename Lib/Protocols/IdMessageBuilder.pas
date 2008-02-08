unit IdMessageBuilder;

interface
{$i IdCompilerDefines.inc}
uses
  Classes, IdMessage;

type
  TIdCustomMessageBuilder = class
  protected
    FAttachments: TStrings;
    FPlainText: TStrings;
    FSubject: String;
    procedure AddAttachments(AMsg: TIdMessage);
    procedure InternalFill(AMsg: TIdMessage); virtual; abstract;
    procedure SetPlainText(AValue: TStrings);
    procedure SetAttachments(AValue: TStrings);
    procedure SetContentType(AMsg: TIdMessage); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    //
    procedure FillMessage(AMsg: TIdMessage);
    function NewMessage(AOwner: TComponent = nil): TIdMessage;
    //
    property Attachments: TStrings read FAttachments write SetAttachments;
    property PlainText: TStrings read FPlainText write SetPlainText;
    property Subject: String read FSubject write FSubject;
  end;

  TIdMessageBuilderHtml = class(TIdCustomMessageBuilder)
  protected
    FHtml: TStrings;
    FHtmlFiles: TStrings;
    procedure InternalFill(AMsg: TIdMessage); override;
    procedure SetContentType(AMsg: TIdMessage); override;
    procedure SetHtml(AValue: TStrings);
    procedure SetHtmlFiles(AValue: TStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    property Html: TStrings read FHtml write SetHtml;
    property HtmlFiles: TStrings read FHtmlFiles write SetHtmlFiles;
  end;

  TIdMessageBuilderRtfType = (idMsgBldrRtfMS, idMsgBldrRtfEnriched, idMsgBldrRtfRichtext);

  TIdMessageBuilderRtf = class(TIdCustomMessageBuilder)
  protected
    FRtf: TStrings;
    FType: TIdMessageBuilderRtfType;
    procedure InternalFill(AMsg: TIdMessage); override;
    procedure SetContentType(AMsg: TIdMessage); override;
    procedure SetRtf(AValue: TStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    property Rtf: TStrings read FRtf write SetRtf;
    property RtfType: TIdMessageBuilderRtfType read FType write FType;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdAttachmentFile, IdText, SysUtils;

const
  cTextPlain = 'text/plain'; {do not localize}
  cTextHtml = 'text/html'; {do not localize}
  cTextRtf: array[TIdMessageBuilderRtfType] of String = ('text/rtf', 'text/enriched', 'text/richtext'); {do not localize}
  cMultipartAlternative = 'multipart/alternative'; {do not localize}
  cMultipartMixed = 'multipart/mixed'; {do not localize}
  cMultipartRelatedHtml = 'multipart/related; type="text/html"'; {do not localize}

{ TIdCustomMessageBuilder }

constructor TIdCustomMessageBuilder.Create;
begin
  inherited Create;
  FPlainText := TStringList.Create;
  FAttachments := TStringList.Create;
end;

destructor TIdCustomMessageBuilder.Destroy;
begin
  FPlainText.Free;
  FAttachments.Free;
  inherited Destroy;
end;

procedure TIdCustomMessageBuilder.AddAttachments(AMsg: TIdMessage);
var
  I: Integer;
begin
  for I := 0 to FAttachments.Count-1 do
  begin
    with TIdAttachmentFile.Create(AMsg.MessageParts, FAttachments[I]) do begin
      ContentType := GetMIMETypeFromFile(FileName);
    end;
  end;
end;

procedure TIdCustomMessageBuilder.FillMessage(AMsg: TIdMessage);
begin
  if not Assigned(AMsg) then begin
    Exit;
  end;

  // Clear only the body and ContentType here...
  //
  AMsg.ClearBody;
  AMsg.ContentType := '';
  AMsg.Subject := FSubject;

  // let the message decide how to encode itself
  // based on what parts are added in InternalFill()
  //
  AMsg.Encoding := meDefault;

  // fill in type-specific content first
  //
  InternalFill(AMsg);

  // Are non-related attachments present?
  //
  AddAttachments(AMsg);

  // Determine the top-level ContentType for the message now
  //
  SetContentType(AMsg);
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

procedure TIdCustomMessageBuilder.SetAttachments(AValue: TStrings);
begin
  FAttachments.Assign(AValue);
end;

procedure TIdCustomMessageBuilder.SetContentType(AMsg: TIdMessage);
begin
  if FAttachments.Count > 0 then
  begin
    if AMsg.MessageParts.Count > 1 then
    begin
      // plain text and/or formatting, and at least 1 non-related attachment
      //
      AMsg.ContentType := cMultipartMixed;
    end else
    begin
      // no plain text or formatting, only 1 non-related attachment
      //
      AMsg.ContentType := AMsg.MessageParts[0].ContentType;
    end;
  end;
end;

procedure TIdCustomMessageBuilder.SetPlainText(AValue: TStrings);
begin
  FPlainText.Assign(AValue);
end;

{ TIdMessageBuilderHtml }

constructor TIdMessageBuilderHtml.Create;
begin
  inherited Create;
  FHtml := TStringList.Create;
  FHtmlFiles := TStringList.Create;
end;

destructor TIdMessageBuilderHtml.Destroy;
begin
  FHtml.Free;
  FHtmlFiles.Free;
  inherited Destroy;
end;

procedure TIdMessageBuilderHtml.InternalFill(AMsg: TIdMessage);
var
  LUseText, LUseHtml, LUseHtmlFiles, LUseAttachments: Boolean;
  I, LAlternativeIndex, LRelatedIndex: Integer;
begin
  // Cache these for better performance
  //
  LUseText := FPlainText.Count > 0;
  LUseHtml := FHtml.Count > 0;
  LUseHtmlFiles := LUseHtml and (FHtmlFiles.Count > 0);
  LUseAttachments := FAttachments.Count > 0;

  LAlternativeIndex := -1;
  LRelatedIndex := -1;

  // Is any body data present at all?
  //
  if not (LUseText or LUseHtml or LUseHtmlFiles or LUseAttachments) then begin
    Exit;
  end;

  // Should the message contain only plain text?
  //
  if LUseText and not (LUseHtml or LUseAttachments) then
  begin
    AMsg.Body.Assign(FPlainText);
    Exit;
  end;

  // Should the message contain only HTML?
  //
  if LUseHtml and not (LUseText or LUseHtmlFiles or LUseAttachments) then
  begin
    AMsg.Body.Assign(FHtml);
    Exit;
  end;

  // At this point, multiple pieces will be present in the message
  // body, so everything must be stored in the MessageParts collection...

  // If the message should contain both plain text and HTML, a
  // "multipart/alternative" piece is needed to wrap them if
  // non-related attachments are also present...
  //
  if LUseHtml and LUseAttachments then
  begin
    with TIdText.Create(AMsg.MessageParts, nil) do
    begin
      ContentType := cMultipartAlternative;
      LAlternativeIndex := Index;
    end;
  end;

  // Is plain text present?
  //
  if LUseText or LUseHtml then
  begin
    with TIdText.Create(AMsg.MessageParts, FPlainText) do
    begin
      if LUseHtml and (not LUseText) then
      begin
        Body.Text := 'An HTML viewer is required to see this message'; {do not localize}
      end;
      ContentType := cTextPlain;
      ParentPart := LAlternativeIndex;
    end;
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
      with TIdText.Create(AMsg.MessageParts, nil) do
      begin
        ContentType := cMultipartRelatedHtml;
        ParentPart := LAlternativeIndex;
        LRelatedIndex := Index;
      end;
    end;

    // Add HTML
    //
    with TIdText.Create(AMsg.MessageParts, FHtml) do
    begin
      ContentType := cTextHtml;
      if LRelatedIndex <> -1 then begin
        ParentPart := LRelatedIndex; // plain text and related attachments
      end else begin
        ParentPart := LAlternativeIndex; // plain text and optional non-related attachments
      end;
    end;

    // Are related attachments present?
    //
    if LUseHtmlFiles then
    begin
      for I := 0 to FHtmlFiles.Count-1 do
      begin
        with TIdAttachmentFile.Create(AMsg.MessageParts, FHtmlFiles[I]) do
        begin
          ContentId := '<' + FileName + '>';
          ContentType := GetMIMETypeFromFile(FileName);
          if TextStartsWith(ContentType, 'image/') then begin {do not localize}
            ContentDisposition := 'inline'; {do not localize}
          end;
          ParentPart := LRelatedIndex;
        end;
      end;
    end;
  end;
end;

procedure TIdMessageBuilderHtml.SetContentType(AMsg: TIdMessage);
begin
  if FAttachments.Count = 0 then
  begin
    if (FPlainText.Count > 0) and (FHtml.Count = 0) then
    begin
      // plain text only
      //
      AMsg.ContentType := cTextPlain;
    end
    else if FHtml.Count > 0 then
    begin
      if (FPlainText.Count = 0) and (FHtmlFiles.Count = 0) then
      begin
        // HTML only
        //
        AMsg.ContentType := cTextHtml;
      end else
      begin
        // plain text and HTML and no related attachments
        //
        AMsg.ContentType := cMultipartAlternative;
      end;
    end;
  end else
  begin
    inherited SetContentType(AMsg);
  end;
end;

procedure TIdMessageBuilderHtml.SetHtml(AValue: TStrings);
begin
  FHtml.Assign(AValue);
end;

procedure TIdMessageBuilderHtml.SetHtmlFiles(AValue: TStrings);
begin
  FHtmlFiles.Assign(AValue);
end;

{ TIdMessageBuilderRTF }

constructor TIdMessageBuilderRtf.Create;
begin
  inherited Create;
  FRtf := TStringList.Create;
  FType := idMsgBldrRtfMS;
end;

destructor TIdMessageBuilderRtf.Destroy;
begin
  FRtf.Free;
  inherited Destroy;
end;

procedure TIdMessageBuilderRtf.InternalFill(AMsg: TIdMessage);
var
  LUseText, LUseRtf, LUseAttachments: Boolean;
  LAlternativeIndex: Integer;
begin
  // Cache these for better performance
  //
  LUseText := FPlainText.Count > 0;
  LUseRtf := FRtf.Count > 0;
  LUseAttachments := FAttachments.Count > 0;
  LAlternativeIndex := -1;

  // Is any body data present at all?
  //
  if not (LUseText or LUseRtf or LUseAttachments) then begin
    Exit;
  end;

  // Should the message contain only plain text?
  //
  if LUseText and not (LUseRtf or LUseAttachments) then
  begin
    AMsg.Body.Assign(FPlainText);
    Exit;
  end;

  // Should the message contain only RTF?
  //
  if LUseRtf and not (LUseText or LUseAttachments) then
  begin
    AMsg.Body.Assign(FRtf);
    Exit;
  end;

  // At this point, multiple pieces will be present in the message
  // body, so everything must be stored in the MessageParts collection...

  // If the message should contain both plain text and RTF, a
  // "multipart/alternative" piece is needed to wrap them if
  // attachments are also present...
  //
  if LUseRtf and LUseAttachments then
  begin
    with TIdText.Create(AMsg.MessageParts, nil) do
    begin
      ContentType := cMultipartAlternative;
      LAlternativeIndex := Index;
    end;
  end;

  // Is plain text present?
  //
  if LUseText or LUseRtf then
  begin
    with TIdText.Create(AMsg.MessageParts, FPlainText) do
    begin
      if LUseRtf and (not LUseText) then
      begin
        Body.Text := 'An RTF viewer is required to see this message'; {do not localize}
      end;
      ContentType := cTextPlain;
      ParentPart := LAlternativeIndex;
    end;
  end;

  // Is RTF present?
  //
  if LUseRtf then
  begin
    // Add RTF
    //
    with TIdText.Create(AMsg.MessageParts, FRtf) do
    begin
      ContentType := cTextRtf[FType];
      ParentPart := LAlternativeIndex; // plain text and optional non-related attachments
    end;
  end;
end;

procedure TIdMessageBuilderRtf.SetContentType(AMsg: TIdMessage);
begin
  if FAttachments.Count = 0 then
  begin
    if (FPlainText.Count > 0) and (FRtf.Count = 0) then
    begin
      // plain text only
      //
      AMsg.ContentType := cTextPlain;
    end
    else if (FRtf.Count > 0) and (FPlainText.Count = 0) then
    begin
      // RTF only
      //
      AMsg.ContentType := cTextRtf[FType];
    end else
    begin
      // plain text and RTF and no non-related attachments
      //
      AMsg.ContentType := cMultipartAlternative;
    end;
  end else
  begin
    inherited SetContentType(AMsg);
  end;
end;

procedure TIdMessageBuilderRtf.SetRtf(AValue: TStrings);
begin
  FRtf.Assign(AValue);
end;

end.
