{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12004: IdTCPStream.pas 
{
{   Rev 1.13    27.08.2004 21:58:22  Andreas Hausladen
{ Speed optimization ("const" for string parameters)
}
{
{   Rev 1.12    29/05/2004 21:17:48  CCostelloe
{ ReadLnSplit added, needed for binary attachments
}
{
{   Rev 1.11    28/05/2004 20:30:12  CCostelloe
{ Bug fix
}
{
{   Rev 1.10    2004.05.21 8:22:16 PM  czhower
{ Added ReadLn
}
{
{   Rev 1.9    2004.05.20 1:40:00 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.8    2004.03.07 11:48:46 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.7    2004.02.03 4:16:58 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.6    5/12/2003 9:17:58 AM  GGrieve
{ remove dead code
}
{
{   Rev 1.5    5/12/2003 12:32:14 AM  GGrieve
{ Refactor to work under DotNet
}
{
{   Rev 1.4    10/10/2003 11:04:24 PM  BGooijen
{ DotNet
}
{
{   Rev 1.3    9/10/2003 1:50:50 PM  SGrobety
{ DotNet
}
{
{   Rev 1.2    2003.10.01 11:16:38 AM  czhower
{ .Net
}
{
{   Rev 1.1    2003.10.01 1:37:36 AM  czhower
{ .Net
}
{
{   Rev 1.0    11/13/2002 09:01:04 AM  JPMugaas
}
unit IdTCPStream;

{$I IdCompilerDefines.inc}

interface

//TODO: This should be renamed to IdStreamTCP for consistency, and class too

uses
  Classes,
  IdGlobal, IdTCPConnection, IdObjs;

type
  TIdTCPStream = class(TIdStream2)
  protected
    FConnection: TIdTCPConnection;
    function GetPosition: Int64; override;
    function GetSize: Int64; override;
    procedure SetSize(ASize: Int64); override;
  public
    constructor Create(
      AConnection: TIdTCPConnection
      ); reintroduce;
    function Read(var ABuffer: array of Byte; AOffset, ACount: Longint): Longint; overload; override;
    function Write(const ABuffer: array of Byte; AOffset, ACount: Longint): Longint; overload; override;
    function Seek(const Offset: Int64; Origin: TIdSeekOrigin): Int64; overload; override;
    property Connection: TIdTCPConnection read FConnection;
  end;

implementation

{ TIdTCPStream }

constructor TIdTCPStream.Create(AConnection: TIdTCPConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

function TIdTCPStream.GetSize: Int64;
begin
  Result := 0;
end;

function TIdTCPStream.GetPosition: Int64;
begin
  Result := -1;
end;

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

function TIdTCPStream.Seek(const Offset: Int64; Origin: TIdSeekOrigin): Int64;
begin
  Result := 0;
end;

procedure TIdTCPStream.SetSize(ASize: Int64);
begin
//
end;

function TIdTCPStream.Write(const ABuffer: array of Byte; AOffset, ACount: Longint) : Longint;
begin
  if AOffset > 0 then
    ToDo;

  Connection.IOHandler.Write(ToBytes(ABuffer, ACount));
  Result := ACount - AOffset;
end;

end.


