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
  Rev 1.4    2/7/2004 7:20:18 PM  JPMugaas
  DotNET to go!! and YES - I want fries with that :-).

  Rev 1.3    2004.02.03 5:44:38 PM  czhower
  Name changes

  Rev 1.2    10/25/2003 06:52:18 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.1    2003.10.12 6:36:48 PM  czhower
  Now compiles.

  Rev 1.0    11/13/2002 08:03:38 AM  JPMugaas
}

unit IdTrivialFTPBase;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdUDPBase, IdUDPClient, SysUtils;

type
  TIdTFTPMode = (tfNetAscii, tfOctet);

// Procs

function MakeActPkt(const BlockNumber: Word): TIdBytes;
procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: TIdPort; const ErrNumber: Word; const ErrString: string); overload;
procedure SendError(UDPClient: TIdUDPClient; const ErrNumber: Word; const ErrString: string); overload;
procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: TIdPort; E: Exception); overload;
procedure SendError(UDPClient: TIdUDPClient; E: Exception); overload;

const  // TFTP opcodes
  TFTP_RRQ   = 1;
  TFTP_WRQ   = 2;
  TFTP_DATA  = 3;
  TFTP_ACK   = 4;
  TFTP_ERROR = 5;
  TFTP_OACK  = 6;  // see RFC 1782 and 1783

const  // TFTP error codes
  ErrUndefined               = 0;
  ErrFileNotFound            = 1;
  ErrAccessViolation         = 2;
  ErrAllocationExceeded      = 3;
  ErrIllegalOperation        = 4;
  ErrUnknownTransferID       = 5;
  ErrFileAlreadyExists       = 6;
  ErrNoSuchUser              = 7;
  ErrOptionNegotiationFailed = 8;

const
  // TFTP options
  sBlockSize = 'blksize';  {do not localize}
  sTransferSize = 'tsize'; {do not localize}

implementation

uses
  IdGlobalProtocols, IdExceptionCore, IdStack;

function MakeActPkt(const BlockNumber: Word): TIdBytes;
begin
  SetLength(Result, 4);
  CopyTIdUInt16(GStack.HostToNetwork(Word(TFTP_ACK)), Result, 0);
  CopyTIdUInt16(GStack.HostToNetwork(BlockNumber), Result, 2);
end;

procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: TIdPort; const ErrNumber: Word; const ErrString: string);
var
  Buffer, LErrStr: TIdBytes;
begin
  LErrStr := ToBytes(ErrString); 
  SetLength(Buffer, 4 + Length(LErrStr) + 1);
  CopyTIdUInt16(GStack.HostToNetwork(Word(TFTP_ERROR)), Buffer, 0);
  CopyTIdUInt16(GStack.HostToNetwork(ErrNumber), Buffer, 2);
  CopyTIdBytes(LErrStr, 0, Buffer, 4, Length(LErrStr));
  Buffer[4 + Length(LErrStr)] := 0;
  UDPBase.SendBuffer(APeerIP, APort, Buffer);
end;

procedure SendError(UDPClient: TIdUDPClient; const ErrNumber: Word; const ErrString: string);
begin
  SendError(UDPClient, UDPClient.Host, UDPClient.Port, ErrNumber, ErrString);
end;

procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: TIdPort; E: Exception);
var
  ErrNumber: Word;
begin
  ErrNumber := ErrUndefined;
  if E is EIdTFTPFileNotFound then
  begin
    ErrNumber := ErrFileNotFound;
  end;
  if E is EIdTFTPAccessViolation then
  begin
    ErrNumber := ErrAccessViolation;
  end;
  if E is EIdTFTPAllocationExceeded then
  begin
    ErrNumber := ErrAllocationExceeded;
  end;
  if E is EIdTFTPIllegalOperation then
  begin
    ErrNumber := ErrIllegalOperation;
  end;
  if E is EIdTFTPUnknownTransferID then
  begin
    ErrNumber := ErrUnknownTransferID;
  end;
  if E is EIdTFTPFileAlreadyExists then
  begin
    ErrNumber := ErrFileAlreadyExists;
  end;
  if E is EIdTFTPNoSuchUser then
  begin
    ErrNumber := ErrNoSuchUser;
  end;
  if E is EIdTFTPOptionNegotiationFailed then
  begin
    ErrNumber := ErrOptionNegotiationFailed;
  end;
  SendError(UDPBase, APeerIP, APort, ErrNumber, E.Message);
end;

procedure SendError(UDPClient: TIdUDPClient; E: Exception);
begin
  SendError(UDPClient, UDPClient.Host, UDPClient.Port, E);
end;

end.
