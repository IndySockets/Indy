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
  Rev 1.0    27-03-05 10:04:16  MterWoord
  Second import, first time the filenames weren't prefixed with Id

  Rev 1.0    27-03-05 09:08:44  MterWoord
  Created
}

unit IdCarrierStream;

interface

uses
  System.IO;

type
  TIdCarrierStream = class(System.IO.Stream)
  private
    FInternalStream: Stream;
  public
    function get_CanRead: Boolean; override;
    function get_CanSeek: Boolean; override;
    function get_CanWrite: Boolean; override;
    function get_Length: Int64; override;
    function get_Position: Int64; override;
    procedure set_Position(Value: Int64); override;
    { Private Declarations }
  public
    constructor Create(const AInternalStream: Stream); reintroduce;
    destructor Destroy; override;
    function BeginRead(ABuffer: array of byte; AOffset: Integer; ACount: Integer; ACallback: AsyncCallback; AState: TObject) : IAsyncResult; override;
    function BeginWrite(ABuffer: array of byte; AOffset: Integer; ACount: Integer; ACallback: AsyncCallback; AState: TObject) : IAsyncResult; override;
    procedure Close; override;
    function EndRead(AResult: IAsyncResult) : Integer; override;
    procedure EndWrite(AResult: IAsyncResult); override;
    function Read(ABuffer: array of byte; AOffset: Integer; ACount: Integer) : Integer; override;
    function ReadByte : Integer; override;
    function Seek(AOffset: Int64; AOrigin: SeekOrigin) : Int64; override;
    procedure SetLength(ALength: Int64); override;
    procedure Write(ABuffer: array of byte; AOffset: integer; ACount: Integer); override;
    procedure WriteByte(AInput: byte); override;
    procedure Flush; override;
    property CanRead: Boolean read get_CanRead;
    property CanWrite: Boolean read get_CanWrite;
    property CanSeek: Boolean read get_CanSeek;
    property Length: Int64 read get_Length;
    property Position: Int64 read get_Position write set_Position;
    property InternalStream: Stream read FInternalStream;
  end;

implementation

function TIdCarrierStream.BeginRead(ABuffer: array of byte; AOffset,
  ACount: Integer; ACallback: AsyncCallback; AState: TObject): IAsyncResult;
begin
  Result := FInternalStream.BeginRead(ABuffer, AOffset, ACount, ACallback, AState);
end;

function TIdCarrierStream.BeginWrite(ABuffer: array of byte; AOffset,
  ACount: Integer; ACallback: AsyncCallback; AState: TObject): IAsyncResult;
begin
  Result := FInternalStream.BeginWrite(ABuffer, AOffset, ACount, ACallback, AState);
end;

procedure TIdCarrierStream.Close;
begin
  // don't do anything, this is a carrierstream
end;

constructor TIdCarrierStream.Create(const AInternalStream: Stream);
begin
  inherited Create;
  FInternalStream := AInternalStream;
end;

function TIdCarrierStream.get_Length: Int64;
begin
  Result := FInternalStream.Length;
end;

function TIdCarrierStream.get_CanSeek: Boolean;
begin
  Result := FInternalStream.CanSeek;
end;

function TIdCarrierStream.get_CanRead: Boolean;
begin
  Result := FInternalStream.CanRead;
end;

function TIdCarrierStream.get_CanWrite: Boolean;
begin
  Result := FInternalStream.CanWrite;
end;

function TIdCarrierStream.get_Position: Int64;
begin
  Result := FInternalStream.Position;
end;

procedure TIdCarrierStream.set_Position(Value: Int64);
begin
  FInternalStream.Position := Value;
end;

procedure TIdCarrierStream.Write(ABuffer: array of byte; AOffset,
  ACount: Integer);
begin
  FInternalStream.Write(ABuffer, AOffset, ACount);
end;

function TIdCarrierStream.ReadByte: Integer;
begin
  Result := FInternalStream.ReadByte;
end;

procedure TIdCarrierStream.SetLength(ALength: Int64);
begin
  FInternalStream.SetLength(ALength);
end;

procedure TIdCarrierStream.WriteByte(AInput: byte);
begin
  FInternalStream.WriteByte(AInput);
end;

procedure TIdCarrierStream.Flush;
begin
  FInternalStream.Flush;
end;

function TIdCarrierStream.Seek(AOffset: Int64; AOrigin: SeekOrigin): Int64;
begin
  Result := FInternalStream.Seek(AOffset, AOrigin);
end;

function TIdCarrierStream.EndRead(AResult: IAsyncResult): Integer;
begin
  Result := FInternalStream.EndRead(AResult);
end;

function TIdCarrierStream.Read(ABuffer: array of byte; AOffset,
  ACount: Integer): Integer;
begin
  Result := FInternalStream.Read(ABuffer, AOffset, ACount);
end;

destructor TIdCarrierStream.Destroy;
begin
  FInternalStream := nil;
  inherited;
end;

procedure TIdCarrierStream.EndWrite(AResult: IAsyncResult);
begin
  FInternalStream.EndWrite(AResult);
end;

end.
