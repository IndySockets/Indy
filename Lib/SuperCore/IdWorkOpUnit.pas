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
  Rev 1.2    6/11/2004 8:40:10 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.1    2004.02.09 9:16:54 PM  czhower
  Updated to compile and match lib changes.

  Rev 1.0    2004.02.03 12:39:08 AM  czhower
  Move

  Rev 1.17    2003.10.19 2:50:42 PM  czhower
  Fiber cleanup

  Rev 1.16    2003.10.11 5:44:02 PM  czhower
  Chained servers now functional.

  Rev 1.15    2003.07.17 4:42:06 PM  czhower
  More IOCP improvements.

  Rev 1.14    2003.07.17 3:55:18 PM  czhower
  Removed IdIOChainEngineIOCP and merged it into TIdChaingEngine in
  IdIOHandlerChain.pas.

  Rev 1.10    2003.07.14 12:54:32 AM  czhower
  Fixed graceful close detection if it occurs after connect.

  Rev 1.9    2003.07.10 7:40:24 PM  czhower
  Comments

  Rev 1.8    7/5/2003 11:47:12 PM  BGooijen
  Added TIdWorkOpUnitCheckForDisconnect and TIdWorkOpUnitWriteFile

  Rev 1.7    4/23/2003 8:22:20 PM  BGooijen

  Rev 1.6    2003.04.22 9:48:50 PM  czhower

  Rev 1.5    2003.04.20 9:12:20 PM  czhower

  Rev 1.5    2003.04.19 3:14:14 PM  czhower

  Rev 1.4    2003.04.17 7:45:02 PM  czhower

  Rev 1.2    3/27/2003 2:43:04 PM  BGooijen
  Added woWriteStream and woWriteBuffer

  Rev 1.1    3/2/2003 12:36:24 AM  BGooijen
  Added woReadBuffer and TIdWorkOpUnitReadBuffer to read a buffer. Now
  ReadBuffer doesn't use ReadStream any more.
  TIdIOHandlerChain.ReadLn now supports MaxLineLength (splitting, and
  exceptions).
  woReadLn doesn't check the intire buffer any more, but continued where it
  stopped the last time.
  Added basic support for timeouts (probably only on read operations, and maybe
  connect), accuratie of timeout is currently 500msec.

  Rev 1.0    2/25/2003 10:45:46 PM  BGooijen
  Opcode files, some of these were in IdIOHandlerChain.pas
}

unit IdWorkOpUnit;

interface

uses
  IdFiber, IdIOHandlerSocket, IdStackConsts, IdWinsock2, IdGlobal,
  SysUtils, Windows;

type
  TIdWorkOpUnit = class;
  TOnWorkOpUnitCompleted = procedure(ASender: TIdWorkOpUnit) of object;

  TIdOverLapped = packed record
    // Reqquired parts of structure
    Internal: DWORD;
    InternalHigh: DWORD;
    Offset: DWORD;
    OffsetHigh: DWORD;
    HEvent: THandle;
    // Indy parts
    WorkOpUnit: TIdWorkOpUnit;
    Buffer: PWSABUF; // Indy part too, we reference it and pass it to IOCP
  end;
  PIdOverlapped = ^TIdOverlapped;

  TIdWorkOpUnit = class(TObject)
  protected
    FCompleted: Boolean;
    FException: Exception;
    FFiber: TIdFiber;
    FIOHandler: TIdIOHandlerSocket;
    FOnCompleted: TOnWorkOpUnitCompleted;
    FSocketHandle:TIdStackSocketHandle;
    FTimeOutAt: Integer;
    FTimedOut: Boolean;
    //
    procedure DoCompleted;
      virtual;
    function GetOverlapped(
      ABuffer: Pointer;
      ABufferSize: Integer
      ): PIdOverlapped;
    procedure Starting; virtual; abstract;
  public
    procedure Complete; virtual;
    destructor Destroy; override;
    procedure MarkComplete; virtual;
    // Process is called by the chain engine when data has been processed
    procedure Process(
      AOverlapped: PIdOverlapped;
      AByteCount: Integer
      ); virtual; abstract;
    procedure RaiseException;
    procedure Start;
    //
    property Completed: Boolean read FCompleted;
    property Fiber: TIdFiber read FFiber write FFiber;
    property IOHandler: TIdIOHandlerSocket read FIOHandler write FIOHandler;
    property OnCompleted: TOnWorkOpUnitCompleted read FOnCompleted
     write FOnCompleted;
    property SocketHandle:TIdStackSocketHandle read FSocketHandle
     write FSocketHandle;
    property TimeOutAt:integer read FTimeOutAt write FTimeOutAt;
    property TimedOut:boolean read FTimedOut write FTimedOut;
  end;

  TIdWorkOpUnitRead = class(TIdWorkOpUnit)
  protected
    // Used when a dynamic buffer is needed
    // Since its reference managed, memory is auto cleaned up
    FBytes: TIdBytes;
    //
    procedure Processing(
      ABuffer: TIdBytes
      ); virtual; abstract;
    procedure Starting;
      override;
  public
    procedure Process(
      AOverlapped: PIdOverlapped;
      AByteCount: Integer
      ); override;
    procedure Read;
  end;

  TIdWorkOpUnitWrite = class(TIdWorkOpUnit)
  protected
    procedure Processing(
      ABytes: Integer
      ); virtual; abstract;
    procedure Write(
      ABuffer: Pointer;
      ASize: Integer
      );
  public
    procedure Process(
      AOverlapped: PIdOverlapped;
      AByteCount: Integer
      ); override;
  end;

const
  WOPageSize = 8192;

implementation

uses
  IdException, IdIOHandlerChain, IdStack, IdStackWindows;

{ TIdWorkOpUnit }

procedure TIdWorkOpUnit.Complete;
begin
  DoCompleted;
end;

destructor TIdWorkOpUnit.Destroy;
begin
  FreeAndNil(FException);
  inherited;
end;

procedure TIdWorkOpUnit.DoCompleted;
begin
  if Assigned(OnCompleted) then begin
    OnCompleted(Self);
  end;
end;

procedure TIdWorkOpUnit.MarkComplete;
begin
  FCompleted := True;
end;

procedure TIdWorkOpUnit.RaiseException;
var
  LException: Exception;
begin
  if FException <> nil then begin
    LException := FException;
    // We need to set this to nil so it wont be freed. Delphi will free it
    // as part of its exception handling mechanism
    FException := nil;
    raise LException;
  end;
end;

function TIdWorkOpUnit.GetOverlapped(
  ABuffer: Pointer;
  ABufferSize: Integer
  ): PIdOverlapped;
begin
  Result := TIdIOHandlerChain(IOHandler).Overlapped;
  with Result^ do begin
    Internal := 0;
    InternalHigh := 0;
    Offset := 0;
    OffsetHigh := 0;
    HEvent := 0;
    WorkOpUnit := Self;
    Buffer.Buf := ABuffer;
    Buffer.Len := ABufferSize;
  end;
end;

procedure TIdWorkOpUnit.Start;
begin
  Starting;
  // This can get called after its already been marked complete. This is
  // ok and the fiber scheduler handles such a situation.
  Fiber.Relinquish;
end;

{ TIdWorkOpUnitWrite }

procedure TIdWorkOpUnitWrite.Process(
  AOverlapped: PIdOverlapped;
  AByteCount: Integer
  );
begin
  Processing(AByteCount);
end;

procedure TIdWorkOpUnitWrite.Write(ABuffer: Pointer;
 ASize: Integer);
var
  LFlags: DWORD;
  LOverlapped: PIdOverlapped;
  LLastError: Integer;
  LVoid: DWORD;
begin
  LFlags := 0;
  LOverlapped := GetOverlapped(ABuffer, ASize);
  case WSASend(SocketHandle, LOverlapped.Buffer, 1, LVoid, LFlags, LOverlapped
   , nil) of
    0: ; // Do nothing

    SOCKET_ERROR: begin
      LLastError := WSAGetLastError;
      if LLastError <> WSA_IO_PENDING then begin
        GStack.RaiseSocketError(LLastError);
      end;
    end;

    else Assert(False, 'Unknown result code received from WSARecv'); {do not localize}
  end;
end;

{ TIdWorkOpUnitRead }

procedure TIdWorkOpUnitRead.Process(
  AOverlapped: PIdOverlapped;
  AByteCount: Integer
  );
begin
  SetLength(FBytes, AByteCount);
  Processing(FBytes);
end;

procedure TIdWorkOpUnitRead.Read;
var
  LBytesReceived: DWORD;
  LFlags: DWORD;
  LOverlapped: PIdOverlapped;
  LLastError: Integer;
begin
  LFlags := 0;
  // Initialize byte array and pass it to overlapped
  SetLength(FBytes, WOPageSize);
  LOverlapped := GetOverlapped(@FBytes[0], Length(FBytes));
  //TODO: What is this 997? Need to check for it? If changed, do in Write too
//   GStack.CheckForSocketError(        // can raise a 997
  case WSARecv(SocketHandle, LOverlapped.Buffer, 1, LBytesReceived, LFlags
   , LOverlapped, nil) of
//  , [997] );
    // Kudzu
    // In this case it completed immediately. The MS docs are not clear, but
    // testing shows that it still causes the completion port.
    0: ; // Do nothing

    SOCKET_ERROR: begin
      LLastError := WSAGetLastError;
      // If its WSA_IO_PENDING this is normal and its been queued
      if LLastError <> WSA_IO_PENDING then begin
        GStack.RaiseSocketError(LLastError);
      end;
    end;

    else Assert(False, 'Unknown result code received from WSARecv'); {do not localize}
  end;
end;

procedure TIdWorkOpUnitRead.Starting;
begin
  Read;
end;

end.
