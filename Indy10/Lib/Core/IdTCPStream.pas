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
  IdGlobal, IdTCPConnection, IdStream;

type
  TIdTCPStream = class(TIdStream)
  protected
    FConnection: TIdTCPConnection;
  public
    constructor Create(
      AConnection: TIdTCPConnection
      ); reintroduce;
    function ReadBytes(
      var VBytes: TIdBytes;
      ACount: Integer;
      AOffset: Integer = 0;
      AExceptionOnCountDiffer: Boolean = True
      ): Integer; override;
    function ReadLn(
      AMaxLineLength: Integer = -1;
      AExceptionIfEOF: Boolean = False
      ): string; override;
    function ReadLnSplit(var AWasSplit: Boolean; ATerminator: string = LF;
         ATimeout: Integer = IdTimeoutDefault;
         AMaxLineLength: Integer = -1): string;
    function ReadString: string; override;
    procedure Write(
      const AValue: string
      ); overload; override;
    procedure Write(
      const ABytes: TIdBytes;
      ACount: Integer = -1
      ); overload; override;
    //
    property Connection: TIdTCPConnection read FConnection;
  end;

implementation

{ TIdTCPStream }

constructor TIdTCPStream.Create(AConnection: TIdTCPConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

function TIdTCPStream.ReadBytes(var VBytes: TIdBytes; ACount,
  AOffset: Integer; AExceptionOnCountDiffer: Boolean): Integer;
begin
  Connection.IOHandler.ReadBytes(VBytes, ACount);
  Result := ACount;
end;

function TIdTCPStream.ReadLn(AMaxLineLength: Integer;
  AExceptionIfEOF: Boolean): string;
begin
  Result := Connection.IOHandler.ReadLn(EOL, -1, AMaxLineLength);
end;

function TIdTCPStream.ReadLnSplit(var AWasSplit: Boolean; ATerminator: string = LF;
         ATimeout: Integer = IdTimeoutDefault;
         AMaxLineLength: Integer = -1): string;
{CC: This function is needed by the message decoders to read long "lines", e.g.
binary-encoded attachments, where the whole attachment is just one line...}
begin
  Result := Connection.IOHandler.ReadLnSplit(AWasSplit, ATerminator, ATimeout, AMaxLineLength);
end;

function TIdTCPStream.ReadString: string;
begin
  Result := Connection.IOHandler.ReadString(ReadInteger);
end;

procedure TIdTCPStream.Write(const ABytes: TIdBytes; ACount: Integer);
begin
  Connection.IOHandler.Write(ABytes);
end;

procedure TIdTCPStream.Write(const AValue: string);
begin
  Connection.IOHandler.Write(AValue);
end;

end.


