unit IdHeaderCoderBase;

interface

{$i IdCompilerDefines.inc}

uses
  Classes;

type
  TIdHeaderCodingNeededEvent = procedure(const ACharSet, AData: String; var VResult: String) of object;

  TIdHeaderCoder = class(TObject)
  public
    class function Decode(const ACharSet, AData: String): String; virtual;
    class function Encode(const ACharSet, AData: String): String; virtual;
    class function CanHandle(const ACharSet: String): Boolean; virtual;
  end;

  TIdHeaderCoderClass = class of TIdHeaderCoder;

  function HeaderCoderByCharSet(const ACharSet: String): TIdHeaderCoderClass;
  function DecodeHeaderData(const ACharSet, AData: String; ADecodeEvent: TIdHeaderCodingNeededEvent = nil): String;
  function EncodeHeaderData(const ACharSet, AData: String; AEncodeEvent: TIdHeaderCodingNeededEvent = nil): String;
  procedure RegisterHeaderCoder(const ACoder: TIdHeaderCoderClass);
  procedure UnregisterHeaderCoder(const ACoder: TIdHeaderCoderClass);

implementation

uses
  SysUtils;

type
  TIdHeaderCoderList = class(TList)
  public
    function ByCharSet(const ACharSet: String): TIdHeaderCoderClass;
  end;

var
  GHeaderCoderList: TIdHeaderCoderList = nil;

{ TIdHeaderCoder }

class function TIdHeaderCoder.Decode(const ACharSet, AData: String): String;
begin
  Result := '';
end;

class function TIdHeaderCoder.Encode(const ACharSet, AData: String): String;
begin
  Result := '';
end;

class function TIdHeaderCoder.CanHandle(const ACharSet: String): Boolean;
begin
  Result := False;
end;

{ TIdHeaderCoderList }

function TIdHeaderCoderList.ByCharSet(const ACharSet: string): TIdHeaderCoderClass;
var
  I: Integer;
  LCoder: TIdHeaderCoderClass;
begin
  Result := nil;
  // loop backwards so that user-defined coders can override native coders
  for I := Count-1 downto 0 do begin
    LCoder := TIdHeaderCoderClass(Items[I]);
    if LCoder.CanHandle(ACharSet) then begin
      Result := LCoder;
      Exit;
    end;
  end;
end;

function HeaderCoderByCharSet(const ACharSet: String): TIdHeaderCoderClass;
begin
  if Assigned(GHeaderCoderList) then begin
    Result := GHeaderCoderList.ByCharSet(ACharSet);
  end else begin
    Result := nil;
  end;
end;

function DecodeHeaderData(const ACharSet, AData: String;
  ADecodeEvent: TIdHeaderCodingNeededEvent = nil): String;
var
  LCoder: TIdHeaderCoderClass;
begin
  LCoder := HeaderCoderByCharSet(ACharSet);
  if LCoder <> nil then begin
    Result := LCoder.Decode(ACharSet, AData);
  end else
  begin
    Result := '';
    if Assigned(ADecodeEvent) then begin
      ADecodeEvent(ACharSet, AData, Result);
    end;
  end;
end;

function EncodeHeaderData(const ACharSet, AData: String;
  AEncodeEvent: TIdHeaderCodingNeededEvent = nil): String;
var
  LCoder: TIdHeaderCoderClass;
begin
  LCoder := HeaderCoderByCharSet(ACharSet);
  if LCoder <> nil then begin
    Result := LCoder.Encode(ACharSet, AData);
  end else
  begin
    Result := AData;
    if Assigned(AEncodeEvent) then begin
      AEncodeEvent(ACharSet, AData, Result);
    end;
  end;
end;

procedure RegisterHeaderCoder(const ACoder: TIdHeaderCoderClass);
begin
  if Assigned(ACoder) and (GHeaderCoderList.IndexOf(TObject(ACoder)) = -1) then begin
    GHeaderCoderList.Add(TObject(ACoder));
  end;
end;

procedure UnregisterHeaderCoder(const ACoder: TIdHeaderCoderClass);
begin
  if Assigned(GHeaderCoderList) then begin
    GHeaderCoderList.Remove(TObject(ACoder));
  end;
end;

initialization
  GHeaderCoderList := TIdHeaderCoderList.Create;
finalization
  FreeAndNil(GHeaderCoderList);

end.
