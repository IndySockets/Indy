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
  Rev 1.0    27-03-05 10:04:24  MterWoord
  Second import, first time the filenames weren't prefixed with Id

  Rev 1.0    27-03-05 09:08:58  MterWoord
  Created
}

unit IdSocketStream;

interface

uses
  System.IO, System.Net.Sockets, IdStack, System.Collections, IdGlobal;

type
  TIdSocketStream = class(System.IO.Stream)
  private
    FInternalSocket: Socket;
  public
    function get_CanRead: Boolean; override;
    function get_CanSeek: Boolean; override;
    function get_CanWrite: Boolean; override;
    function get_Length: Int64; override;
    function get_Position: Int64; override;
    procedure set_Position(Value: Int64); override;
    { Private Declarations }
  public
    constructor Create(const AInternalSocket: Socket); reintroduce;
    destructor Destroy; override;
    procedure Close; override;
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
    property InternalSocket: Socket read FInternalSocket;
  end;

implementation

procedure TIdSocketStream.Close;
begin
  inherited;
end;

constructor TIdSocketStream.Create(const AInternalSocket: Socket);
begin
  inherited Create;
  FInternalSocket := AInternalSocket;
end;

function TIdSocketStream.get_Length: Int64;
begin
  Result := 0;
  if FInternalSocket.Poll(1, SelectMode.SelectRead) then
    Result := FInternalSocket.Available;
end;

function TIdSocketStream.get_CanSeek: Boolean;
begin
  Result := False;
end;

function TIdSocketStream.get_CanRead: Boolean;
begin
  Result := True;
end;

function TIdSocketStream.get_CanWrite: Boolean;
begin
  Result := True;
end;

function TIdSocketStream.get_Position: Int64;
begin
  Result := 0;
end;

procedure TIdSocketStream.set_Position(Value: Int64);
begin
  raise NotSupportedException.Create;
end;

procedure TIdSocketStream.Write(ABuffer: array of byte; AOffset,
  ACount: Integer);
begin
try
  GStack.Send(FInternalSocket, ABuffer, AOffset, ACount);
except
  on E: Exception do
  begin
    Console.WriteLine('TIdSocketStream.Write: ' + E.ToString);
    raise;
  end;
end;
end;

function TIdSocketStream.ReadByte: Integer;
var
  TempBuff: array[0..1] of byte;
begin
  Result := -1;
  if Length > 0 then
  begin
    if Read(TempBuff, 0, 1) <> 0 then
      Result := TempBuff[0];
  end;
end;

procedure TIdSocketStream.SetLength(ALength: Int64);
begin
  raise NotSupportedException.Create;
end;

procedure TIdSocketStream.WriteByte(AInput: byte);
begin
  Write([AInput], 0, 1);
end;

procedure TIdSocketStream.Flush;
begin
end;

function TIdSocketStream.Seek(AOffset: Int64; AOrigin: SeekOrigin): Int64;
begin
  raise NotSupportedException.Create;
end;

function TIdSocketStream.Read(ABuffer: array of byte; AOffset,
  ACount: Integer): Integer;
var
  I: Integer;
  TempArray: ArrayList;
  TempBytesToRead: Integer;
  TempBuff: TIdBytes;
  BytesRead: Integer;
begin
try
  i := 0;
  TempArray := ArrayList.Create;
  while i < ACount do
  begin
    TempBytesToRead := Math.Min(50, ACount - i);
    TempBuff := ToBytes(System.&String.Create(#0, TempBytesToRead));
    if CanRead then
    begin
      BytesRead := GStack.Receive(FInternalSocket, TempBuff);
      if BytesRead <> 0 then
      begin
        &Array.Copy(TempBuff, 0, ABuffer, i + AOffset, BytesRead);
        Inc(i, BytesRead);
        if BytesRead <> 50 then
          Break;
      end
      else
        Break;
    end
    else
      Break;
  end;
  Result := i;
except
  on E: Exception do
  begin
    Console.WriteLine('Exception "{0}". I = {1}, BytesRead = {2}, AOffset = {3}, ACount = {4}, TempBytesToRead = {5}',
      [E.GetType().FullName + ': ' + E.Message, I, BytesRead, AOffset, ACount, TempBytesToRead]);
    raise;
  end;
end;
end;

destructor TIdSocketStream.Destroy;
begin
  FInternalSocket := nil;
  inherited;
end;

end.
