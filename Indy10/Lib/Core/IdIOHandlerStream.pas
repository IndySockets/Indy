{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  26782: IdIOHandlerStream.pas 
{
{   Rev 1.21    3/10/05 3:24:30 PM  RLebeau
{ Updated ReadFromSource() and WriteDirect() to access the Intercept property
{ directly.
}
{
{   Rev 1.20    10/21/2004 11:07:30 PM  BGooijen
{ works in win32 now too
}
{
{   Rev 1.19    10/21/2004 1:52:56 PM  BGooijen
{ Raid 214235
}
{
{   Rev 1.18    7/23/04 6:20:52 PM  RLebeau
{ Removed memory leaks in Send/ReceiveStream property setters
}
{
{   Rev 1.17    2004.05.20 11:39:08 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.16    23/04/2004 20:29:36  CCostelloe
{ Minor change to support IdMessageClient's new TIdIOHandlerStreamMsg
}
{
{   Rev 1.15    2004.04.16 11:30:32 PM  czhower
{ Size fix to IdBuffer, optimizations, and memory leaks
}
{
{   Rev 1.14    2004.04.08 3:56:36 PM  czhower
{ Fixed bug with Intercept byte count. Also removed Bytes from Buffer.
}
{
{   Rev 1.13    2004.03.07 11:48:46 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.12    2004.03.03 11:55:04 AM  czhower
{ IdStream change
}
{
{   Rev 1.11    2004.02.03 4:17:16 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.10    11/01/2004 19:52:44  CCostelloe
{ Revisions for TIdMessage SaveToFile & LoadFromFile for D7 & D8
}
{
{   Rev 1.8    08/01/2004 23:37:16  CCostelloe
{ Minor changes
}
{
{   Rev 1.7    1/8/2004 1:01:22 PM  BGooijen
{ Cleaned up
}
{
{   Rev 1.6    1/8/2004 4:23:06 AM  BGooijen
{ temp fixed TIdIOHandlerStream.WriteToDestination
}
{
{   Rev 1.5    08/01/2004 00:25:22  CCostelloe
{ Start of reimplementing LoadFrom/SaveToFile
}
{
{   Rev 1.4    2003.12.31 7:44:54 PM  czhower
{ Matched constructors visibility to ancestor.
}
{
{   Rev 1.3    2003.10.24 10:44:54 AM  czhower
{ IdStream implementation, bug fixes.
}
{
{   Rev 1.2    2003.10.14 11:19:14 PM  czhower
{ Updated for better functionality.
}
{
{   Rev 1.1    2003.10.14 1:27:14 PM  czhower
{ Uupdates + Intercept support
}
{
{   Rev 1.0    2003.10.13 6:40:40 PM  czhower
{ Moved from root
}
{
{   Rev 1.9    2003.10.11 10:00:36 PM  czhower
{ Compiles again.
}
{
{   Rev 1.8    10/10/2003 10:53:42 PM  BGooijen
{ Changed const-ness of some methods to reflect base class changes
}
{
{   Rev 1.7    7/10/2003 6:07:58 PM  SGrobety
{ .net
}
{
{   Rev 1.6    17/07/2003 00:01:24  CCostelloe
{ Added (empty) procedures for the base classes' abstract CheckForDataOnSource
{ and CheckForDisconnect
}
{
    Rev 1.5    7/1/2003 12:45:56 PM  BGooijen
  changed FInputBuffer.Size := 0 to FInputBuffer.Clear
}
{
{   Rev 1.4    12-8-2002 21:05:28  BGooijen
{ Removed call to Close in .Destroy, this is already done in
{ TIdIOHandler.Destroy
}
{
{   Rev 1.3    12/7/2002 06:42:44 PM  JPMugaas
{ These should now compile except for Socks server.  IPVersion has to be a
{ property someplace for that.
}
{
{   Rev 1.2    12/5/2002 02:53:52 PM  JPMugaas
{ Updated for new API definitions.
}
{
{   Rev 1.1    05/12/2002 15:29:16  AO'Neill
}
{
{   Rev 1.0    11/13/2002 07:55:08 AM  JPMugaas
}
unit IdIOHandlerStream;

interface

uses
  IdBaseComponent,
  IdGlobal,
  IdIOHandler,
  IdObjs,
  IdStreamHelper,
  IdSys;

type
  TIdIOHandlerStream = class;
  TIdIOHandlerStreamType = (stRead, stWrite, stReadWrite);
  TIdOnGetStreams = procedure(
    ASender: TIdIOHandlerStream;
    var VReceiveStream: TIdStream2;
    var VSendStream: TIdStream2
    ) of object;

  TIdIOHandlerStream = class(TIdIOHandler)
  protected
    FFreeStreams: Boolean;
    FOnGetStreams: TIdOnGetStreams;
    FReceiveStream: TIdStream2;
    FSendStream: TIdStream2;
    FStreamType: TIdIOHandlerStreamType;
    //
    function GetReceiveStream: TIdStream2;
    function GetSendStream: TIdStream2;
    procedure SetReceiveStream(AStream: TIdStream2);
    procedure SetSendStream(AStream: TIdStream2);
    function ReadFromSource(
      ARaiseExceptionIfDisconnected: Boolean = True;
      ATimeout: Integer = IdTimeoutDefault;
      ARaiseExceptionOnTimeout: Boolean = True
      ): Integer; override;
  public
    procedure CheckForDataOnSource(
      ATimeout: Integer = 0
      ); override;
    procedure CheckForDisconnect(
      ARaiseExceptionIfDisconnected: Boolean = True;
      AIgnoreBuffer: Boolean = False
      ); override;

    constructor Create(
      AOwner: TIdNativeComponent;
      AReceiveStream: TIdStream2;
      ASendStream: TIdStream2 = nil
      ); reintroduce; overload; virtual;
    constructor Create(
      AOwner: TIdNativeComponent
      ); reintroduce; overload;
    function Connected
      : Boolean;
      override;
    procedure Close;
      override;
    procedure Open;
      override;
    function Readable(AMSec: integer = IdTimeoutDefault): boolean; override;
    procedure WriteDirect(
      ABuffer: TIdBytes
      ); override;
    //
    property ReceiveStream: TIdStream2 read GetReceiveStream {write SetReceiveStream};
    property SendStream: TIdStream2 read GetSendStream {write SetSendStream};
  published
    property FreeStreams: Boolean read FFreeStreams write FFreeStreams;
    property StreamType: TIdIOHandlerStreamType read FStreamType
     write FStreamType;
    //
    property OnGetStreams: TIdOnGetStreams read FOnGetStreams
     write FOnGetStreams;
  end;

implementation

{ TIdIOHandlerStream }

procedure TIdIOHandlerStream.CheckForDataOnSource(ATimeout: Integer = 0);
begin
    {All that we are doing here is implementing the base class's abstract function}
end;

procedure TIdIOHandlerStream.CheckForDisconnect(
  ARaiseExceptionIfDisconnected: Boolean = True;
  AIgnoreBuffer: Boolean = False);
begin
    {All that we are doing here is implementing the base class's abstract function}
end;

procedure TIdIOHandlerStream.Close;
begin
  inherited;
  if FreeStreams then begin
    Sys.FreeAndNil(FReceiveStream);
    Sys.FreeAndNil(FSendStream);
  end;
end;

function TIdIOHandlerStream.Connected: Boolean;
begin
  Result := False;  // Just to avoid warning message
  case FStreamType of
    stRead: Result := ReceiveStream <> nil;
    stWrite: Result := SendStream <> nil;
    stReadWrite: Result := (ReceiveStream <> nil) and (SendStream <> nil);
  end;
end;

constructor TIdIOHandlerStream.Create( AOwner: TIdNativeComponent );
begin
  inherited Create(AOwner);
  FFreeStreams := True;
  //
  FStreamType := stReadWrite;
end;

constructor TIdIOHandlerStream.Create(
  AOwner: TIdNativeComponent;
  AReceiveStream: TIdStream2;
  ASendStream: TIdStream2 = nil
  );
begin
  inherited Create(AOwner);
  FFreeStreams := True;
  //
  FStreamType := stReadWrite;
  if (AReceiveStream <> nil) and (ASendStream = nil) then begin
    FStreamType := stWrite;
  end else if (AReceiveStream = nil) and (ASendStream <> nil) then begin
    FStreamType := stRead;
  end;
  SetReceiveStream(AReceiveStream);
  SetSendStream(ASendStream);
end;

procedure TIdIOHandlerStream.Open;
begin
  inherited;
  if Assigned(OnGetStreams) then begin
    OnGetStreams(Self, FReceiveStream, FSendStream);
  end;
end;

function TIdIOHandlerStream.Readable(AMSec: integer): boolean;
begin
  Result := ReceiveStream <> nil;
  if Result then begin
    Result := ReceiveStream.Position < ReceiveStream.Size;
  end;
end;

function TIdIOHandlerStream.ReadFromSource(
  ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
   ARaiseExceptionOnTimeout: Boolean): Integer;
var
  LBuffer: TIdBytes;
begin
  Result := 0;
  if ReceiveStream <> nil then begin
    // We dont want to read the whole stream in at a time. If its a big file will consume way too
    // much memory by loading it all at once. So lets read it in chunks.
    Result := Min(32 * 1024, FReceiveStream.Size - FReceiveStream.Position);
    if Result > 0 then begin
      SetLength(LBuffer, Result);
      TIdStreamHelper.ReadBytes(FReceiveStream,LBuffer,Result);
      if Intercept <> nil then begin
        Intercept.Receive(LBuffer);
        Result := Length(LBuffer);
      end;
      if Result > 0 then begin
        FInputBuffer.Write(LBuffer);
      end;
    end;
  end else begin
    FInputBuffer.Clear;
  end;
end;

procedure TIdIOHandlerStream.WriteDirect(
  ABuffer: TIdBytes
  );
begin
  if SendStream <> nil then begin
    if Intercept <> nil then begin
      Intercept.Send(ABuffer);
    end;
    TIdStreamHelper.Write(FSendStream,ABuffer);
  end;
end;

function TIdIOHandlerStream.GetReceiveStream: TIdStream2;
begin
  Result := FReceiveStream;
end;

function TIdIOHandlerStream.GetSendStream: TIdStream2;
begin
  Result := FSendStream;
end;

procedure TIdIOHandlerStream.SetReceiveStream(AStream: TIdStream2);
begin
  if AStream <> nil then begin
    FReceiveStream := AStream;
  end;
end;

procedure TIdIOHandlerStream.SetSendStream(AStream: TIdStream2);
begin
  if AStream <> nil then begin
    FSendStream := AStream;
  end;
end;

end.

