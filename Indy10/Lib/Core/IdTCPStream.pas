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
  Rev 1.13    27.08.2004 21:58:22  Andreas Hausladen
  Speed optimization ("const" for string parameters)

  Rev 1.12    29/05/2004 21:17:48  CCostelloe
  ReadLnSplit added, needed for binary attachments

  Rev 1.11    28/05/2004 20:30:12  CCostelloe
  Bug fix

  Rev 1.10    2004.05.21 8:22:16 PM  czhower
  Added ReadLn

  Rev 1.9    2004.05.20 1:40:00 PM  czhower
  Last of the IdStream updates

  Rev 1.8    2004.03.07 11:48:46 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.7    2004.02.03 4:16:58 PM  czhower
  For unit name changes.

  Rev 1.6    5/12/2003 9:17:58 AM  GGrieve
  remove dead code

  Rev 1.5    5/12/2003 12:32:14 AM  GGrieve
  Refactor to work under DotNet

  Rev 1.4    10/10/2003 11:04:24 PM  BGooijen
  DotNet

  Rev 1.3    9/10/2003 1:50:50 PM  SGrobety
  DotNet

  Rev 1.2    2003.10.01 11:16:38 AM  czhower
  .Net

  Rev 1.1    2003.10.01 1:37:36 AM  czhower
  .Net

  Rev 1.0    11/13/2002 09:01:04 AM  JPMugaas
}

unit IdTCPStream;

{$I IdCompilerDefines.inc}

interface

// TODO: This should be renamed to IdStreamTCP for consistency, and class too

uses
  IdGlobal, IdTCPConnection, IdObjs;

type
  TIdTCPStream = class(TIdStream)
  protected
    FConnection: TIdTCPConnection;
    {$IFDEF DotNetDistro}
    function GetPosition: Int64; override;
    function GetSize: Int64; override;
    {$ENDIF}
    {$IFDEF DOTNET}
    procedure SetSize(NewSize: Int64); override;
    {$ELSE}
    {$IFDEF VCL6ORABOVE}
    procedure SetSize(const NewSize: Int64); override;
    {$ELSE}
    procedure SetSize(NewSize: Longint); override;
    {$ENDIF}
    {$ENDIF}
  public
    constructor Create(AConnection: TIdTCPConnection); reintroduce;
    {$IFDEF DOTNET}
    function Read(var ABuffer: array of Byte; AOffset, ACount: Longint): Longint; overload; override;
    function Write(const ABuffer: array of Byte; AOffset, ACount: Longint): Longint; overload; override;
    {$ELSE}
    function Read(var Buffer; Count: Longint): Longint;  override;
    function Write(const Buffer; Count: Longint): Longint;  override;
    {$ENDIF}
    {$IFDEF VCL6ORABOVE}
    function Seek(const Offset: Int64; Origin: TIdSeekOrigin): Int64; overload; override;
    {$ELSE}
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    {$ENDIF}
    property Connection: TIdTCPConnection read FConnection;
  end;

implementation

{$IFNDEF DOTNET}
uses SysUtils;
{$ENDIF}

constructor TIdTCPStream.Create(AConnection: TIdTCPConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

{$IFDEF DotNetDistro}
function TIdTCPStream.GetSize: Int64;
begin
  Result := 0;
end;

function TIdTCPStream.GetPosition: Int64;
begin
  Result := -1;
end;
{$ENDIF}

{$IFDEF DOTNET}
function TIdTCPStream.Read(var ABuffer: array of Byte; AOffset,
  ACount: Longint): Longint;
var
  TempBuff: TIdBytes;
begin
  TempBuff := ABuffer;
  Connection.IOHandler.ReadBytes(TempBuff, ACount, false);
  ABuffer := TempBuff;
  Result := ACount;
end;
{$ELSE}
function TIdTCPStream.Read(var Buffer; Count: Longint): Longint;
var
  TempBuff: TIdBytes;
begin
  SetLength(TempBuff,Count);

  Connection.IOHandler.ReadBytes(TempBuff, Count, false);
  Move(TempBuff,Buffer,Count);
  Result := Count;
end;
{$ENDIF}

{$IFDEF VCL6ORABOVE}
function TIdTCPStream.Seek(const Offset: Int64; Origin: TIdSeekOrigin): Int64;
{$ELSE}
function TIdTCPStream.Seek(Offset: Longint; Origin: Word): Longint;
{$ENDIF}
begin
  Result := 0;
end;

{$IFDEF DOTNET}
procedure TIdTCPStream.SetSize(NewSize: Int64);
{$ELSE}
{$IFDEF VCL6ORABOVE}
procedure TIdTCPStream.SetSize(const NewSize: Int64);
{$ELSE}
procedure TIdTCPStream.SetSize(NewSize: Longint);
{$ENDIF}
{$ENDIF}
begin
//
end;

{$IFDEF DOTNET}
function TIdTCPStream.Write(const ABuffer: array of Byte; AOffset, ACount: Longint) : Longint;
begin
  if AOffset > 0 then
    ToDo;

  Connection.IOHandler.Write(ToBytes(ABuffer, ACount));
  Result := ACount - AOffset;
end;
{$ELSE}
function TIdTCPStream.Write(const Buffer; Count: Longint): Longint;
begin
  Connection.IOHandler.Write(RawToBytes(Buffer,Count));
  Result := Count;
end;
{$ENDIF}

end.


