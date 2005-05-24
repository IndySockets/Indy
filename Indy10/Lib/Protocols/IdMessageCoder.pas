{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11671: IdMessageCoder.pas
{
{   Rev 1.15    10/26/2004 10:27:42 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.14    27.08.2004 22:03:58  Andreas Hausladen
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.13    8/10/04 1:41:00 PM  RLebeau
{ Added FreeSourceStream property to TIdMessageDecoder
}
{
{   Rev 1.12    7/23/04 6:43:26 PM  RLebeau
{ Added extra exception handling to Encode()
}
{
{   Rev 1.11    29/05/2004 21:22:40  CCostelloe
{ Added support for decoding attachments with a Content-Transfer-Encoding of
{ binary
}
{
{   Rev 1.10    2004.05.20 1:39:12 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.9    2004.05.20 11:36:56 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.8    2004.05.20 11:12:58 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.7    2004.05.19 3:06:38 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.6    2004.02.03 5:44:02 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/21/2004 1:17:20 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.4    10/11/2003 4:40:24 PM  BGooijen
{ Fix for DotNet
}
{
{   Rev 1.3    10/10/2003 10:42:54 PM  BGooijen
{ DotNet
}
{
{   Rev 1.2    26/09/2003 01:04:22  CCostelloe
{ Minor change, if any
}
{
{   Rev 1.1    07/08/2003 00:46:46  CCostelloe
{ Function ReadLnSplit added
}
{
{   Rev 1.0    11/13/2002 07:57:04 AM  JPMugaas
}
unit IdMessageCoder;

interface

uses
  Classes,
  IdComponent,
  IdGlobal,
  IdMessage,
  IdStream,
  IdStreamRandomAccess,
  IdSys,
  IdObjs;

type
  TIdMessageCoderPartType = (mcptUnknown, mcptText, mcptAttachment);

  TIdMessageDecoder = class(TIdComponent)
  protected
    FFilename: string;
    FFreeSourceStream: Boolean;
    // Dont use TIdHeaderList for FHeaders - we dont know that they will all be like MIME.
    FHeaders: TIdStrings;
    FPartType: TIdMessageCoderPartType;
    FSourceStream: TIdStream;
    procedure InitComponent; override;
  public
    function ReadBody(ADestStream: TIdStream; var AMsgEnd: Boolean): TIdMessageDecoder; virtual; abstract;
    procedure ReadHeader; virtual;
    //CC: ATerminator param added because Content-Transfer-Encoding of binary needs
    //an ATerminator of EOL...
    function ReadLn(const ATerminator: string = LF): string;
    destructor Destroy; override;
    //
    property Filename: string read FFilename;
    property FreeSourceStream: Boolean read FFreeSourceStream write FFreeSourceStream;
    property Headers: TIdStrings read FHeaders;
    property PartType: TIdMessageCoderPartType read FPartType;
    property SourceStream: TIdStream read FSourceStream write FSourceStream;
  end;

  TIdMessageDecoderInfo = class(TObject)
  public
    function CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder; virtual;
     abstract;
    constructor Create; virtual;
  end;

  TIdMessageDecoderList = class(TObject)
  protected
    FMessageCoders: TIdStringList;
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
    procedure Encode(const AFilename: string; ADest: TIdStream); overload;
    procedure Encode(ASrc: TIdStreamRandomAccess; ADest: TIdStream); overload; virtual; abstract;
  published
    property Filename: string read FFilename write FFilename;
    property PermissionCode: integer read FPermissionCode write FPermissionCode;
  end;

  TIdMessageEncoderClass = class of TIdMessageEncoder;

  TIdMessageEncoderInfo = class(TObject)
  protected
    FMessageEncoderClass: TIdMessageEncoderClass;
  public
    constructor Create; virtual;
    procedure InitializeHeaders(AMsg: TIdMessage); virtual;
    //
    property MessageEncoderClass: TIdMessageEncoderClass read FMessageEncoderClass;
  end;

  TIdMessageEncoderList = class(TObject)
  protected
    FMessageCoders: TIdStringList;
  public
    class function ByName(const AName: string): TIdMessageEncoderInfo;
    constructor Create;
    destructor Destroy; override;
    class procedure RegisterEncoder(const AMessageEncoderName: string;
     AMessageEncoderInfo: TIdMessageEncoderInfo);
  end;

implementation

uses
  IdException, IdResourceStringsProtocols, IdStreamVCL,
  IdTCPStream;

var
  GMessageDecoderList: TIdMessageDecoderList = nil;
  GMessageEncoderList: TIdMessageEncoderList = nil;

{ TIdMessageDecoderList }

class function TIdMessageDecoderList.ByName(const AName: string): TIdMessageDecoderInfo;
begin
  with GMessageDecoderList.FMessageCoders do begin
    Result := TIdMessageDecoderInfo(Objects[IndexOf(AName)]);
  end;
  if Result = nil then begin
    raise EIdException.Create(RSMessageDecoderNotFound + ': ' + AName);    {Do not Localize}
  end;
end;

class function TIdMessageDecoderList.CheckForStart(ASender: TIdMessage; const ALine: string): TIdMessageDecoder;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to GMessageDecoderList.FMessageCoders.Count - 1 do begin
    Result := TIdMessageDecoderInfo(GMessageDecoderList.FMessageCoders.Objects[i]).CheckForStart(ASender
     , ALine);
    if Result <> nil then begin
      Break;
    end;
  end;
end;

constructor TIdMessageDecoderList.Create;
begin
  inherited;
  FMessageCoders := TIdStringList.Create;
end;

destructor TIdMessageDecoderList.Destroy;
var
  i: integer;
begin
  for i := 0 to FMessageCoders.Count - 1 do begin
    TIdMessageDecoderInfo(FMessageCoders.Objects[i]).Free;
  end;
  Sys.FreeAndNil(FMessageCoders);
  inherited;
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
  FHeaders := TIdStringList.Create;
end;

destructor TIdMessageDecoder.Destroy;
begin
  Sys.FreeAndNil(FHeaders);
  if FFreeSourceStream then begin
    Sys.FreeAndNil(FSourceStream);
  end else begin
    FSourceStream := nil;
  end;
  inherited;
end;

procedure TIdMessageDecoder.ReadHeader;
begin
end;

function TIdMessageDecoder.ReadLn(const ATerminator: string = LF): string;
var
  LWasSplit: Boolean;  //Needed for lines > 16K, e.g. if Content-Transfer-Encoding is 'binary'
begin
  Result := '';
  if SourceStream is TIdTCPStream then begin
    repeat
      Result := Result + TIdTCPStream(SourceStream).ReadLnSplit(LWasSplit, ATerminator);
    until LWasSplit = False;
  end else begin
    Result := SourceStream.ReadLn;
  end;
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
begin
  with GMessageEncoderList.FMessageCoders do begin
    Result := TIdMessageEncoderInfo(Objects[IndexOf(AName)]);
  end;
  if Result = nil then begin
    raise EIdException.Create(RSMessageEncoderNotFound + ': ' + AName);    {Do not Localize}
  end;
end;

constructor TIdMessageEncoderList.Create;
begin
  inherited;
  FMessageCoders := TIdStringList.Create;
end;

destructor TIdMessageEncoderList.Destroy;
var
  i: integer;
begin
  for i := 0 to FMessageCoders.Count - 1 do begin
    TIdMessageEncoderInfo(FMessageCoders.Objects[i]).Free;
  end;
  Sys.FreeAndNil(FMessageCoders);
  inherited;
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

procedure TIdMessageEncoder.Encode(const AFilename: string; ADest: TIdStream);
var
  LSrcStream: TStream;
  LIdSrcStream: TIdStreamVCL;
begin
  LSrcStream := TReadFileExclusiveStream.Create(AFileName); try
    LIdSrcStream := TIdStreamVCL.Create(LSrcStream); try
      Encode(LIdSrcStream, ADest);
    finally Sys.FreeAndNil(LIdSrcStream); end;
  finally Sys.FreeAndNil(LSrcStream); end;
end;

procedure TIdMessageEncoder.InitComponent;
begin
  inherited;
  FPermissionCode := 660;
end;

initialization
finalization
  Sys.FreeAndNil(GMessageDecoderList);
  Sys.FreeAndNil(GMessageEncoderList);
end.
