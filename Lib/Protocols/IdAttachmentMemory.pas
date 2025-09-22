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


  $Log$


   Rev 1.6    6/29/04 12:27:14 PM  RLebeau
 Updated to remove DotNet conditionals
 
 Updated constructor to call SetDataString()


   Rev 1.5    2004.02.03 5:44:52 PM  czhower
 Name changes


   Rev 1.4    2004.02.03 2:12:04 PM  czhower
 $I path change


   Rev 1.3    24/01/2004 19:07:18  CCostelloe
 Cleaned up warnings


   Rev 1.2    14/12/2003 18:07:16  CCostelloe
 Changed GetDataString to avoiud error 'String element cannot be passed to var
 parameter'


   Rev 1.1    13/05/2003 20:28:04  CCostelloe
 Bug fix: remove default values in Create to avoid ambiguities with
 Create(TCollection)


   Rev 1.0    11/14/2002 02:12:46 PM  JPMugaas
}
unit IdAttachmentMemory;

interface

{$I IdCompilerDefines.inc}

uses
  Classes, IdAttachment, IdMessageParts, IdGlobal;

type
  TIdAttachmentMemory = class(TIdAttachment)
  protected
    FDataStream: TStream;
    FDataStreamBeforeLoadPosition: TIdStreamSize;

    function GetDataString: string;
    procedure SetDataStream(const Value: TStream);
    procedure SetDataString(const Value: string);
  public
    {CC: Bug fix, remove default values to resolve ambiguities with Create(TCollection).}
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(Collection: TIdMessageParts; const CopyFrom: TStream); reintroduce; overload;
    constructor Create(Collection: TIdMessageParts; const CopyFrom: String); reintroduce; overload;
    destructor Destroy; override;

    property DataStream: TStream read FDataStream write SetDataStream;
    property DataString: string read GetDataString write SetDataString;
    function OpenLoadStream: TStream; override;
    procedure CloseLoadStream; override;
    procedure FinishTempStream; override;
    function PrepareTempStream: TStream; override;
  end;

implementation

uses
  SysUtils;

{ TIdAttachmentMemory }

constructor TIdAttachmentMemory.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataStream := TMemoryStream.Create;
end;

constructor TIdAttachmentMemory.Create(Collection: TIdMessageParts;
  const CopyFrom: TStream);
var
  LSize: TIdStreamSize;
begin
  inherited Create(Collection);
  FDataStream := TMemoryStream.Create;
  if Assigned(CopyFrom) then begin
    LSize := IndyLength(CopyFrom);
    if LSize > 0 then begin
      FDataStream.CopyFrom(CopyFrom, LSize);
    end;
  end;
end;

constructor TIdAttachmentMemory.Create(Collection: TIdMessageParts;
  const CopyFrom: String);
begin
  inherited Create(Collection);
  FDataStream := TMemoryStream.Create;
  SetDataString(CopyFrom);
end;

destructor TIdAttachmentMemory.Destroy;
begin
  FreeAndNil(FDataStream);
  inherited Destroy;
end;

procedure TIdAttachmentMemory.CloseLoadStream;
begin
  DataStream.Position := FDataStreamBeforeLoadPosition;
end;

function TIdAttachmentMemory.GetDataString: string;
var
  Pos: TIdStreamSize;
begin
  Pos := FDataStream.Position;
  try
    FDataStream.Position := 0;
    Result := ReadStringFromStream(FDataStream, FDataStream.Size);
  finally
    FDataStream.Position := Pos;
  end;
end;

function TIdAttachmentMemory.OpenLoadStream: TStream;
begin
  FDataStreamBeforeLoadPosition := DataStream.Position;
  DataStream.Position := 0;
  Result := DataStream;
end;

procedure TIdAttachmentMemory.SetDataStream(const Value: TStream);
var
  LSize: TIdStreamSize;
begin
  FDataStream.Size := 0;
  LSize := IndyLength(Value);
  if LSize > 0 then begin
    FDataStream.CopyFrom(Value, LSize);
  end;
end;

procedure TIdAttachmentMemory.SetDataString(const Value: string);
begin
  FDataStream.Size := 0;
  WriteStringToStream(FDataStream, Value);
end;

procedure TIdAttachmentMemory.FinishTempStream;
begin
  DataStream.Position := 0;
end;

function TIdAttachmentMemory.PrepareTempStream: TStream;
begin
  DataStream.Size := 0;
  Result := DataStream;
end;

end.
