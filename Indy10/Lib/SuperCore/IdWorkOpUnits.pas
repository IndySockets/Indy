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
  Rev 1.4    6/11/2004 8:40:12 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.3    2004.05.06 1:47:28 PM  czhower
  Now uses IndexOf

  Rev 1.2    2004.04.22 11:45:18 PM  czhower
  Bug fixes

  Rev 1.1    2004.02.09 9:16:58 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:39:10 AM  czhower
  Move

  Rev 1.14    2003.10.19 2:50:42 PM  czhower
  Fiber cleanup

  Rev 1.13    2003.10.11 5:44:20 PM  czhower
  Chained servers now functional.

  Rev 1.12    2003.07.17 4:42:08 PM  czhower
  More IOCP improvements.

  Rev 1.11    2003.07.17 3:55:18 PM  czhower
  Removed IdIOChainEngineIOCP and merged it into TIdChaingEngine in
  IdIOHandlerChain.pas.

  Rev 1.7    2003.07.14 11:00:52 PM  czhower
  More IOCP fixes.

  Rev 1.6    2003.07.14 12:54:34 AM  czhower
  Fixed graceful close detection if it occurs after connect.

  Rev 1.5    7/7/2003 1:25:26 PM  BGooijen
  Added BytesSent property to TIdWorkOpUnitWriteFile

  Rev 1.4    7/5/2003 11:47:14 PM  BGooijen
  Added TIdWorkOpUnitCheckForDisconnect and TIdWorkOpUnitWriteFile

  Rev 1.3    3/27/2003 2:43:06 PM  BGooijen
  Added woWriteStream and woWriteBuffer

  Rev 1.2    3/22/2003 09:45:30 PM  JPMugaas
  Now should compile under D4.

  Rev 1.1    3/2/2003 12:36:26 AM  BGooijen
  Added woReadBuffer and TIdWorkOpUnitReadBuffer to read a buffer. Now
  ReadBuffer doesn't use ReadStream any more.
  TIdIOHandlerChain.ReadLn now supports MaxLineLength (splitting, and
  exceptions).
  woReadLn doesn't check the intire buffer any more, but continued where it
  stopped the last time.
  Added basic support for timeouts (probably only on read operations, and maybe
  connect), accuratie of timeout is currently 500msec.

  Rev 1.0    2/27/2003 10:11:50 PM  BGooijen
  WorkOpUnits combined in one file
}

unit IdWorkOpUnits;

interface

uses
  Classes,
  IdWorkOpUnit, IdGlobal,
  SysUtils;

type
  TIdWorkOpUnitStreamBaseRead = class(TIdWorkOpUnitRead)
  protected
    FStream: TStream;
  public
    constructor Create(AStream: TStream); reintroduce; virtual;
  end;

  TIdWorkOpUnitStreamBaseWrite = class(TIdWorkOpUnitWrite)
  protected
    FFreeStream: Boolean;
    FStream: TStream;
  public
    constructor Create(
      AStream: TStream;
      AFreeStream: Boolean = True
      ); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TIdWorkOpUnitWriteBuffer = class(TIdWorkOpUnitWrite)
  protected
    FBuffer: Pointer;
    FFreeBuffer: Boolean;
    FSize: Integer;
    //
    procedure Processing(ABytes: Integer); override;
    procedure Starting; override;
  public
    constructor Create(ABuffer: Pointer; ASize: Integer;
      AFreeBuffer: Boolean = True); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TIdWorkOpUnitWriteFile = class(TIdWorkOpUnitWrite)
  protected
    FFilename: String;
    FBytesSent: Integer;
    //
    procedure Processing(ABytes: Integer); override;
    procedure Starting; override;
  public
    constructor Create(AFileName: string); reintroduce;
  end;

  TIdWorkOpUnitWriteStream = class(TIdWorkOpUnitStreamBaseWrite)
  protected
    FCount: Integer;
    FStartPos: Integer;
    //
    procedure Processing(ABytes: Integer); override;
    procedure Starting; override;
  public
    constructor Create(AStream: TStream; AStartPos, ACount: Integer;
     AFreeStream: Boolean); reintroduce; virtual;
  end;

  TIdWorkOpUnitWaitConnected = class(TIdWorkOpUnit)
  protected
    procedure Starting; override;
  public
    procedure Process(
      AOverlapped: PIdOverlapped;
      AByteCount: Integer
      ); override;
  end;

  TIdWorkOpUnitReadSized = class(TIdWorkOpUnitRead)
  protected
    FSize: Integer;
    //
    procedure Processing(
      ABuffer: TIdBytes
      ); override;
  public
    constructor Create(ASize: Integer); reintroduce;
  end;

  TIdWorkOpUnitReadSizedStream = class(TIdWorkOpUnitStreamBaseRead)
  protected
    FSize: Integer;
    //
    procedure Processing(
      ABuffer: TIdBytes
      ); override;
  public
    constructor Create(AStream: TStream; ASize: Integer);
     reintroduce;
  end;

  TIdWorkOpUnitReadLn = class(TIdWorkOpUnitRead)
  protected
    FLastPos: Integer;
    FMaxLength: Integer;
    FTerminator: string;
    //
    procedure Processing(
      ABuffer: TIdBytes
      ); override;
  public
    constructor Create(
      ATerminator: string;
      AMaxLength: Integer
      ); reintroduce;
  end;

  TIdWorkOpUnitReadUntilDisconnect = class(TIdWorkOpUnitStreamBaseRead)
  protected
    procedure Processing(
      ABuffer: TIdBytes
      ); override;
  end;

  TIdWorkOpUnitReadAvailable = class(TIdWorkOpUnitRead)
  protected
    procedure Processing(
      ABuffer: TIdBytes
      ); override;
  end;

implementation

{ TIdWorkOpUnitWriteStream }

constructor TIdWorkOpUnitWriteStream.Create(AStream: TStream; AStartPos,ACount:integer; AFreeStream: Boolean);
begin
  inherited Create(AStream, AFreeStream);
  FStream.Position := AStartPos;
  FCount := ACount;
end;

procedure TIdWorkOpUnitWriteStream.Processing(ABytes: Integer);
//TODO: This used to use pages from IdBuffer, which because of .Net do not exist
// anymore. We need to maybe keep a local persistent buffer instead then for
// storage reasons.
var
  LBuffer: TIdBytes;
  LSize: Integer;
begin
  FCount := FCount - ABytes;
  if FCount = 0 then begin
    Complete;
  end else begin
    FStream.Position := ABytes;
    //
    //TODO: Dont hard code this value. Also find an optimal size for IOCP
    LSize := Min(FCount, WOPageSize);
    SetLength(LBuffer, LSize);
    //
    FStream.ReadBuffer(LBuffer[0], LSize);
    Write(@LBuffer[0], LSize);
  end;
end;

procedure TIdWorkOpUnitWriteStream.Starting;
begin
  Processing(0);
end;

{ TIdWorkOpUnitWriteBuffer }

constructor TIdWorkOpUnitWriteBuffer.Create(ABuffer: pointer; ASize: integer; AFreeBuffer: Boolean = True);
begin
  inherited Create;
  FSize := ASize;
  FBuffer := ABuffer;
  FFreeBuffer := AFreeBuffer;
end;

destructor TIdWorkOpUnitWriteBuffer.Destroy;
begin
  if FFreeBuffer then begin
    FreeMem(FBuffer);
    FBuffer := nil;
  end;
  inherited;
end;

procedure TIdWorkOpUnitWriteBuffer.Processing(ABytes: Integer);
begin
  //TODO: Change the pointer to a type that points to bytes
  FBuffer := Pointer(Cardinal(FBuffer) + Cardinal(ABytes));
  FSize := FSize - ABytes;
  if FSize = 0 then begin
    Complete;
  end else begin
    //TODO: Reduce this down so it never sends more than a page
    Write(FBuffer, Min(FSize, WOPageSize));
  end;
end;

procedure TIdWorkOpUnitWriteBuffer.Starting;
begin
  Processing(0);
end;

{ TIdWorkOpUnitWriteFile }

constructor TIdWorkOpUnitWriteFile.Create(AFileName:string);
begin
  inherited Create;
  FFilename := AFileName;
end;

procedure TIdWorkOpUnitWriteFile.Processing(ABytes: Integer);
begin
  Assert(False, 'Need to implement WriteFile, also add to a bubble'); {do not localize}
end;

procedure TIdWorkOpUnitWriteFile.Starting;
begin
end;

{ TIdWorkOpUnitSizedStream }

constructor TIdWorkOpUnitReadSizedStream.Create(AStream: TStream; ASize:integer);
begin
  inherited Create(AStream);
  FSize := ASize;
end;

procedure TIdWorkOpUnitWaitConnected.Process(
  AOverlapped: PIdOverlapped;
  AByteCount: Integer
  );
begin
end;

procedure TIdWorkOpUnitWaitConnected.Starting;
begin
end;

{ TIdWorkOpUnitReadLn }

constructor TIdWorkOpUnitReadLn.Create(
  ATerminator: string;
  AMaxLength: Integer);
begin
  inherited Create;
  FLastPos := 1;
  FTerminator := ATerminator;
  FMaxLength := AMaxLength;
end;

procedure TIdWorkOpUnitReadLn.Processing(
  ABuffer: TIdBytes
  );
begin
  //TODO: ReadLn is very common. Need to optimize this class and maybe
  // even pass pack the result directly so we dont search twice.
  //Also allow for hinting from the user.
  IOHandler.InputBuffer.Write(ABuffer);
  if not IOHandler.Connected then begin
    Complete;
  end else if IOHandler.InputBuffer.IndexOf(FTerminator, FLastPos) = -1 then begin
    Read;
  end else begin
    Complete;
  end;
end;

procedure TIdWorkOpUnitReadUntilDisconnect.Processing(
  ABuffer: TIdBytes
  );
begin
  // 0 is disconnected, so keep requesting til 0
  if Length(ABuffer) = 0 then begin
    Complete;
  end else begin
    FStream.WriteBuffer(ABuffer[0], Length(ABuffer));
    Read;
  end;
end;

{ TIdWorkOpUnitReadAvailable }

procedure TIdWorkOpUnitReadAvailable.Processing(
  ABuffer: TIdBytes
  );
begin
  Complete;
end;

{ TIdWorkOpUnitReadSized }

constructor TIdWorkOpUnitReadSized.Create(ASize: Integer);
begin
  inherited Create;
  FSize := ASize;
end;

procedure TIdWorkOpUnitReadSized.Processing(
  ABuffer: TIdBytes
  );
begin
  IOHandler.InputBuffer.Write(ABuffer);
  FSize := FSize - Length(ABuffer);
  if FSize = 0 then begin
    Complete;
  end else begin
    Read;
  end;
end;

{ TIdWorkOpUnitStreamBaseRead }

constructor TIdWorkOpUnitStreamBaseRead.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
end;

{ TIdWorkOpUnitStreamBaseWrite }

constructor TIdWorkOpUnitStreamBaseWrite.Create(AStream: TStream;
  AFreeStream: Boolean);
begin
  inherited Create;
  FStream := AStream;
  FFreeStream := AFreeStream;
end;

destructor TIdWorkOpUnitStreamBaseWrite.Destroy;
begin
  if FFreeStream then begin
    FreeAndNil(FStream);
  end;
  inherited;
end;

procedure TIdWorkOpUnitReadSizedStream.Processing(
  ABuffer: TIdBytes
  );
begin
  FStream.WriteBuffer(ABuffer[0], Length(ABuffer));
  FSize := FSize - Length(ABuffer);
  if FSize = 0 then begin
    Complete;
  end else begin
    Read;
  end;
end;

end.
