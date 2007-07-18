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

uses
  IdGlobal,
  IdUDPBase, IdUDPClient, SysUtils;

type
  TIdTFTPMode = (tfNetAscii, tfOctet);

type
  WordStr = string[2];

// Procs
  function MakeAckPkt(const BlockNumber: Word): string;
  procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: Integer; const ErrNumber: Word; ErrorString: string); overload;
  procedure SendError(UDPClient: TIdUDPClient; const ErrNumber: Word; ErrorString: string); overload;
  procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: Integer;  E: Exception); overload;
  procedure SendError(UDPClient: TIdUDPClient; E: Exception); overload;

const  // TFTP opcodes
  TFTP_RRQ   = 1;
  TFTP_WRQ   = 2;
  TFTP_DATA  = 3;
  TFTP_ACK   = 4;
  TFTP_ERROR = 5;
  TFTP_OACK  = 6;  // see RFC 1782 and 1783

const  // various
  MaxWord = High(Word);
  hdrsize = 4;           // TFTP Headersize on DATA packets (opcode + block#)
  sBlockSize = 'blksize'#0;    {Do not Localize}
  // TFTP RFC 1782/1783 allows an optional blocksize to be specified
  // A blocksize of 8192 bytes generates far less ACK packets than 512 bytes blocks

const  // tftp error codes
  ErrUndefined               = 0;
  ErrFileNotFound            = 1;
  ErrAccessViolation         = 2;
  ErrAllocationExceeded      = 3;
  ErrIllegalOperation        = 4;
  ErrUnknownTransferID       = 5;
  ErrFileAlreadyExists       = 6;
  ErrNoSuchUser              = 7;
  ErrOptionNegotiationFailed = 8;

implementation

uses
  IdGlobalProtocols, IdExceptionCore, IdStack;



function MakeAckPkt(const BlockNumber: Word): string;
begin
  Result := WordToStr(GStack.HostToNetwork(TFTP_ACK)) + WordToStr(GStack.HostToNetwork(BlockNumber));
end;

procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: Integer; const ErrNumber: Word; ErrorString: string);
begin
  UDPBase.Send(APeerIP, APort, WordToStr(GStack.HostToNetwork(Word(TFTP_ERROR))) + WordToStr(ErrNumber) + ErrorString + #0);
end;

procedure SendError(UDPClient: TIdUDPClient; const ErrNumber: Word; ErrorString: string);
begin
  SendError(UDPClient, UDPClient.Host, UDPClient.Port, ErrNumber, ErrorString);
end;

procedure SendError(UDPBase: TIdUDPBase; APeerIP: string; const APort: Integer;  E: Exception);
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
