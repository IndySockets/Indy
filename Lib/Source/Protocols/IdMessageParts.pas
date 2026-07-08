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
  Rev 1.8    9/30/2004 5:04:20 PM  BGooijen
  Self was not initialized

  Rev 1.7    01/06/2004 00:28:46  CCostelloe
  Minor bug fix

  Rev 1.6    5/30/04 11:29:36 PM  RLebeau
  Added OwnerMessage property to TIdMessageParts for use with
  TIdMessagePart.ResolveContentType() under Delphi versions prior to v6,
  where the TCollection.Owner method does not exist.

  Rev 1.5    16/05/2004 18:55:46  CCostelloe
  New TIdText/TIdAttachment processing

  Rev 1.4    2004.02.03 5:44:06 PM  czhower
  Name changes

  Rev 1.3    10/17/03 12:06:04 PM  RLebeau
  Updated TIdMessagePart.Assign() to copy all available header values
  rather than select ones.

    Rev 1.2    10/17/2003 12:43:12 AM  DSiders
  Added localization comments.

  Rev 1.1    26/09/2003 01:07:18  CCostelloe
  Added FParentPart, so that nested MIME types
  (like multipart/alternative nested in multipart/related and vica-versa)
  can be encoded and decoded (when encoding, need to know this so the
  correct boundary is emitted) and so the user can properly define which
  parts belong to which sections.

  Rev 1.0    11/13/2002 07:57:32 AM  JPMugaas

24-Sep-2003 Ciaran Costelloe
  - Added FParentPart, so that nested MIME types (like multipart/alternative
    nested in multipart/related and vica-versa) can be encoded and decoded
    (when encoding, need to know this so the correct boundary is emitted)
    and so the user can properly define which parts belong to which sections.
2002-08-30 Andrew P.Rybin
  - ExtractHeaderSubItem
  - virtual methods. Now descendant can add functionality.
    Ex: TIdText.GetContentType = GetContentType w/o charset
}

unit IdMessageParts;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdHeaderList,
  IdExceptionCore,
  IdGlobal;

type
  TOnGetMessagePartStream = procedure(AStream: TStream) of object;

  TIdMessagePartType = (mptText, mptAttachment);
  // if you add to this, please also adjust the case statement in
  // TIdMessageParts.CountParts;

  TIdMessageParts = class;
  
  TIdMessagePart = class(TCollectionItem)
  protected
    FContentMD5: string;
    FCharSet: string;
    FEndBoundary: string;
    FExtraHeaders: TIdHeaderList;
    FFileName: String;
    FName: String;
    FHeaders: TIdHeaderList;
    FIsEncoded: Boolean;
    FOnGetMessagePartStream: TOnGetMessagePartStream;
    FParentPart: Integer;
    //
    function  GetContentDisposition: string; virtual;
    function  GetContentType: string; virtual;
    function  GetContentTransfer: string; virtual;
    function  GetContentID: string; virtual;
    function  GetContentLocation: string; virtual;
    function  GetContentDescription: string; virtual;
    function  GetMessageParts: TIdMessageParts;
    function  GetOwnerMessage: TPersistent;
    procedure SetContentDisposition(const Value: string); virtual;
    procedure SetContentType(const Value: string); virtual;
    procedure SetContentTransfer(const Value: string); virtual;
    procedure SetExtraHeaders(const Value: TIdHeaderList);
    procedure SetContentID(const Value: string); virtual;
    procedure SetContentDescription(const Value: string); virtual;
    procedure SetContentLocation(const Value: string); virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  GetCharSet(AHeader: string): String;
    function  ResolveContentType(AContentType: string): string; //Fixes up ContentType
    class function PartType: TIdMessagePartType; virtual;
    //
    property IsEncoded: Boolean read FIsEncoded;
    property MessageParts: TIdMessageParts read GetMessageParts;
    property OwnerMessage: TPersistent read GetOwnerMessage;
    property OnGetMessagePartStream: TOnGetMessagePartStream read FOnGetMessagePartStream write FOnGetMessagePartStream;
    property Headers: TIdHeaderList read FHeaders;
  published
    property CharSet: string read FCharSet write FCharSet;
    property ContentDescription: string read GetContentDescription write SetContentDescription;
    property ContentDisposition: string read GetContentDisposition write SetContentDisposition;
    property ContentID: string read GetContentID write SetContentID;
    property ContentLocation: string read GetContentLocation write SetContentLocation;
    property ContentTransfer: string read GetContentTransfer write SetContentTransfer;
    property ContentType: string read GetContentType write SetContentType;
    property ExtraHeaders: TIdHeaderList read FExtraHeaders write SetExtraHeaders;
    property FileName: String read FFileName write FFileName;
    property Name: String read FName write FName;
    property ParentPart: integer read FParentPart write FParentPart;
  end;

  TIdMessagePartClass = class of TIdMessagePart;

  TIdMessageParts = class(TOwnedCollection)
  protected
    FAttachmentEncoding: string;
    FAttachmentCount: integer;
    FMessageEncoderInfo: TObject;
    FRelatedPartCount: integer;
    FTextPartCount: integer;
    //
    function GetItem(Index: Integer): TIdMessagePart;
    function GetOwnerMessage: TPersistent;
    procedure SetAttachmentEncoding(const AValue: string);
    procedure SetItem(Index: Integer; const Value: TIdMessagePart);
  public
    function Add: TIdMessagePart;
    procedure CountParts;
    constructor Create(AOwner: TPersistent); reintroduce;
    //
    property AttachmentCount: integer read FAttachmentCount;
    property AttachmentEncoding: string read FAttachmentEncoding write SetAttachmentEncoding;
    property Items[Index: Integer]: TIdMessagePart read GetItem write SetItem; default;
    property MessageEncoderInfo: TObject read FMessageEncoderInfo;
    property OwnerMessage: TPersistent read GetOwnerMessage;
    property RelatedPartCount: integer read FRelatedPartCount;
    property TextPartCount: integer read FTextPartCount;
  end;

  EIdCanNotCreateMessagePart = class(EIdMessageException);

implementation

uses
  IdMessage, IdGlobalProtocols, IdResourceStringsProtocols, IdMessageCoder, IdCoderHeader,
  SysUtils;

{ TIdMessagePart }

procedure TIdMessagePart.Assign(Source: TPersistent);
var
  mp: TIdMessagePart;
begin
  if Source is TIdMessagePart then begin
    mp := TIdMessagePart(Source);
    // RLebeau 10/17/2003
    Headers.Assign(mp.Headers);
    ExtraHeaders.Assign(mp.ExtraHeaders);
    CharSet := mp.CharSet;
    FileName := mp.FileName;
    Name := mp.Name;
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdMessagePart.Create(Collection: TCollection);
begin
  inherited;
  if ClassType = TIdMessagePart then begin
    raise EIdCanNotCreateMessagePart.Create(RSTIdMessagePartCreate);
  end;
  FIsEncoded := False;
  FHeaders := TIdHeaderList.Create(QuoteRFC822);
  FExtraHeaders := TIdHeaderList.Create(QuoteRFC822);
  FParentPart := -1;
end;

destructor TIdMessagePart.Destroy;
begin
  FHeaders.Free;
  FExtraHeaders.Free;
  inherited Destroy;
end;

function TIdMessagePart.GetContentDisposition: string;
begin
  Result := Headers.Values['Content-Disposition']; {do not localize}
end;

function TIdMessagePart.GetContentID: string;
begin
  Result := Headers.Values['Content-ID']; {do not localize}
end;

function TIdMessagePart.GetContentDescription: string;
begin
  Result := Headers.Values['Content-Description']; {do not localize}
end;

function TIdMessagePart.GetContentLocation: string;
begin
  Result := Headers.Values['Content-Location']; {do not localize}
end;

function TIdMessagePart.GetContentTransfer: string;
begin
  Result := Headers.Values['Content-Transfer-Encoding']; {do not localize}
end;

function TIdMessagePart.GetCharSet(AHeader: string): String;
begin
  Result := ExtractHeaderSubItem(AHeader, 'charset', QuoteMIME); {do not localize}
end;

function TIdMessagePart.ResolveContentType(AContentType: string): string;
var
  LMsg: TIdMessage;
  LParts: TIdMessageParts;
begin
  //This extracts 'text/plain' from 'text/plain; charset="xyz"; boundary="123"'
  //or, if '', it finds the correct default value for MIME messages.
  if AContentType <> '' then begin
    Result := AContentType;
  end else begin
    //If it is MIME, then we need to find the correct default...
    LParts := MessageParts;
    if Assigned(LParts) then begin
      LMsg := TIdMessage(LParts.OwnerMessage);
      if Assigned(LMsg) and (LMsg.Encoding = meMIME) then begin
        //There is an exception if we are a child of multipart/digest...
        if ParentPart <> -1 then begin
          AContentType := LParts.Items[ParentPart].Headers.Values['Content-Type'];  {do not localize}
          if IsHeaderMediaType(AContentType, 'multipart/digest') then begin  {do not localize}
            Result := 'message/rfc822';  {do not localize}
            Exit;
          end;
        end;
        //The default type...
        Result := 'text/plain';      {do not localize}
        Exit;
      end;
    end;
    Result := '';  //Default for non-MIME messages
  end;
end;

function TIdMessagePart.GetContentType: string;
begin
  Result := Headers.Values['Content-Type']; {do not localize}
end;

function TIdMessagePart.GetMessageParts: TIdMessageParts;
begin
  if Collection is TIdMessageParts then begin
    Result := TIdMessageParts(Collection);
  end else begin
    Result := nil;
  end;
end;

function TIdMessagePart.GetOwnerMessage: TPersistent;
var
  LParts: TIdMessageParts;
begin
  LParts := MessageParts;
  if Assigned(LParts) then begin
    Result := LParts.OwnerMessage;
  end else begin
    Result := nil;
  end;
end;

class function TIdMessagePart.PartType: TIdMessagePartType;
begin
  Result := mptAttachment;
end;

procedure TIdMessagePart.SetContentID(const Value: string);
begin
  Headers.Values['Content-ID'] := Value; {do not localize}
end;

procedure TIdMessagePart.SetContentDescription(const Value: string);
begin
  Headers.Values['Content-Description'] := Value; {do not localize}
end;

procedure TIdMessagePart.SetContentDisposition(const Value: string);
var
  LFileName: string;
begin
  Headers.Values['Content-Disposition'] := RemoveHeaderEntry(Value, 'filename', LFileName, QuoteMIME); {do not localize}
  {RLebeau: override the current value only if the header specifies a new one}
  if LFileName <> '' then begin
    LFileName := DecodeHeader(LFileName);
  end;
  if LFileName <> '' then begin
    FFileName := LFileName;
  end;
end;

procedure TIdMessagePart.SetContentLocation(const Value: string);
begin
  Headers.Values['Content-Location'] := Value; {do not localize}
end;

procedure TIdMessagePart.SetContentTransfer(const Value: string);
begin
  Headers.Values['Content-Transfer-Encoding'] := Value; {do not localize}
end;

procedure TIdMessagePart.SetContentType(const Value: string);
var
  LTmp, LCharSet, LName: string;
begin
  LTmp := RemoveHeaderEntry(Value, 'charset', LCharSet, QuoteMIME);{do not localize}
  LTmp := RemoveHeaderEntry(LTmp, 'name', LName, QuoteMIME);{do not localize}
  Headers.Values['Content-Type'] := LTmp;
  {RLebeau: override the current values only if the header specifies new ones}
  if LCharSet <> '' then begin
    FCharSet := LCharSet;
  end;
  if LName <> '' then begin
    FName := LName;
  end;
end;

procedure TIdMessagePart.SetExtraHeaders(const Value: TIdHeaderList);
begin
  FExtraHeaders.Assign(Value);
end;

{ TMessageParts }

function TIdMessageParts.Add: TIdMessagePart;
begin
  // This helps prevent TIdMessagePart from being added
  Result := nil;
end;

procedure TIdMessageParts.CountParts;
//TODO: Make AttCount, etc maintained on the fly
var
  i: integer;
begin
  FAttachmentCount := 0;
  FRelatedPartCount := 0;
  FTextPartCount := 0;
  for i := 0 to Count - 1 do begin
    if Length(TIdMessagePart(Items[i]).ContentID) > 0 then begin
      Inc(FRelatedPartCount);
    end;
    case TIdMessagePart(Items[i]).PartType of
      mptText :
        begin
          Inc(FTextPartCount)
        end;
      mptAttachment:
        begin
         Inc(FAttachmentCount);
        end;
    end;
  end;
end;

constructor TIdMessageParts.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdMessagePart);
  // Must set prop and not variable so it will initialize it
  AttachmentEncoding := 'MIME'; {do not localize}
end;

function TIdMessageParts.GetItem(Index: Integer): TIdMessagePart;
begin
  Result := TIdMessagePart(inherited GetItem(Index));
end;

function TIdMessageParts.GetOwnerMessage: TPersistent;
var
  LOwner: TPersistent;
begin
  LOwner := inherited GetOwner;
  if LOwner is TIdMessage then begin
    Result := LOwner;
  end else begin
    Result := nil;
  end;
end;

procedure TIdMessageParts.SetAttachmentEncoding(const AValue: string);
begin
  FMessageEncoderInfo := TIdMessageEncoderList.ByName(AValue);
  FAttachmentEncoding := AValue;
end;

procedure TIdMessageParts.SetItem(Index: Integer; const Value: TIdMessagePart);
begin
  inherited SetItem(Index, Value);
end;

end.
