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
  Rev 1.0    11/13/2002 08:03:48 AM  JPMugaas
}

unit IdTunnelCommon;

{*
  Indy Tunnel components module
  Copyright (C) 1999, 2000, 2001 Gregor Ibic (gregor.ibic@intelicom.si)
  Intelicom d.o.o., www.intelicom.si
  This component is published under same license like Indy package.

  This package is a TCP Tunnel implementation written
  by Gregor Ibic (gregor.ibic@intelicom.si).


  This notice may not be removed or altered from any source
  distribution.

 // MAJOR CHANGES
 05-January-20001
 GI: Major code  reorganization and polishing
 31-May-2000
 GI TunnelHeaders eliminated. Some other code jugling.
 29-May-2000
 GI Components split in several files to be more compliant
                 with Indy coding standards.
                 It consists of:
                 - IdTunnelHeaders
                 - IdTunnelCommon
                 - IdTunnelMaster
                 - IdTunnelSlave
 24-May-2000
 GI: Turbo translation mode finished (01:24). It works!
                 Will draw icons in the morning.
 23-May-2000
 GI: Turbo translation mode to Indy standard started by
                 Gregor Ibic (hehe) (now is 23:15)

*}

interface
{$i IdCompilerDefines.inc}

uses
  SysUtils, Classes, SyncObjs,
  IdException,
  IdHashCRC,
  IdStack,
  IdCoder, IdResourceStrings,
  IdTCPServer;


const
  BUFFERLEN = $4000;

  // Statistics constants
  NumberOfConnectionsType = 1;
  NumberOfPacketsType     = 2;
  CompressionRatioType    = 3;
  CompressedBytesType     = 4;
  BytesReadType           = 5;
  BytesWriteType          = 6;
  NumberOfClientsType     = 7;
  NumberOfSlavesType      = 8;
  NumberOfServicesType    = 9;

  // Message types
  tmError                 = 0;
  tmData                  = 1;
  tmDisconnect             = 2;
  tmConnect               = 3;
  tmCustom                = 99;


type
  TIdStatisticsOperation = (soIncrease,
                            soDecrease
                           );

  TIdHeader = record
    CRC16: Word;
    MsgType: Word;
    MsgLen: Word;
    UserId: Word;
    Port: Word;
    IpAddr: TIdInAddr;
  end;

  TReceiver = class(TObject)
  private
    fiPrenosLen: LongInt;
    fiMsgLen: LongInt;
    fsData: String;
    fbNewMessage: Boolean;
    fCRCFailed: Boolean;
    Locker: TCriticalSection;
    CRC16Calculator: TIdHashCRC16;
    function FNewMessage: Boolean;
    procedure SetData(const Value: string);
  public
    pBuffer: PChar;
    HeaderLen: Integer;
    Header: TIdHeader;
    MsgLen: Word;
    TypeDetected: Boolean;
    Msg: PChar;
    property Data: String read fsData write SetData;
    property NewMessage: Boolean read FNewMessage;
    property CRCFailed: Boolean read fCRCFailed;
    procedure ShiftData;
    constructor Create;
    destructor Destroy; override;
  end;


  TSender = class(TObject)
  public
    Header: TIdHeader;
    DataLen: Word;
    HeaderLen: Integer;
    pMsg: PChar;
    Locker: TCriticalSection;
    CRC16Calculator: TIdHashCRC16;
  public
    Msg: String;
    procedure PrepareMsg(var Header: TIdHeader;
                         buffer: PChar; buflen: Integer);
    constructor Create;
    destructor Destroy; override;
  end;
  //
  // END Communication classes
  ///////////////////////////////////////////////////////////////////////////////


  ///////////////////////////////////////////////////////////////////////////////
  // Logging class
  //
  TLogger = class(TObject)
  private
    OnlyOneThread: TCriticalSection; // Some locking code
    fLogFile: TextFile; // Debug Log File
    fbActive: Boolean;
  public
    property Active: Boolean read fbActive Default False;
    procedure LogEvent(Msg: String);
    constructor Create(LogFileName: String);
    destructor Destroy; override;
  end;
  //
  // Logging class
  ///////////////////////////////////////////////////////////////////////////////


  TSendMsgEvent  = procedure(Thread: TIdPeerThread; var CustomMsg: String) of object;
  TSendTrnEvent  = procedure(Thread: TIdPeerThread; var Header: TIdHeader; var CustomMsg: String) of object;
  TSendTrnEventC = procedure(var Header: TIdHeader; var CustomMsg: String) of object;
  TTunnelEventC  = procedure(Receiver: TReceiver) of object;
  TSendMsgEventC = procedure(var CustomMsg: String) of object;
//  TTunnelEvent   = procedure(Thread: TSlaveThread) of object;

  EIdTunnelException = class(EIdException);
  EIdTunnelTransformErrorBeforeSend = class(EIdTunnelException);
  EIdTunnelTransformError = class(EIdTunnelException);
  EIdTunnelConnectToMasterFailed = class(EIdTunnelException);
  EIdTunnelDontAllowConnections = class(EIdTunnelException);
  EIdTunnelCRCFailed = class(EIdTunnelException);
  EIdTunnelMessageTypeRecognitionError = class(EIdTunnelException);
  EIdTunnelMessageHandlingFailed = class(EIdTunnelException);
  EIdTunnelInterpretationOfMessageFailed = class(EIdTunnelException);
  EIdTunnelCustomMessageInterpretationFailure = class(EIdTunnelException);

implementation

///////////////////////////////////////////////////////////////////////////////
// Communication classes
//
constructor TSender.Create;
begin
  inherited;
  Locker := TCriticalSection.Create;
  CRC16Calculator := TIdHashCRC16.Create;
  HeaderLen := SizeOf(TIdHeader);
  GetMem(pMsg, BUFFERLEN);
end;

destructor TSender.Destroy;
begin
  FreeMem(pMsg, BUFFERLEN);
  Locker.Free;
  CRC16Calculator.Free;
  inherited;
end;

procedure TSender.PrepareMsg(var Header: TIdHeader;
                             buffer: PChar; buflen: Integer);
begin
  Locker.Enter;
  try
    //Header.MsgType := mType;
    Header.CRC16 := CRC16Calculator.HashValue(buffer^);
    Header.MsgLen := Headerlen + bufLen;
    //Header.UserId := mUser;
    //Header.Port := Port;
    //Header.IpAddr := IPAddr;
    Move(Header, pMsg^, Headerlen);
    Move(buffer^, (pMsg + Headerlen)^, bufLen);
    SetString(Msg, pMsg, Header.MsgLen);
    {$IFDEF STRING_IS_ANSI}
    // TODO: do we need to use SetCodePage() here?
    {$ENDIF}
  finally
    Locker.Leave;
  end;
end;



constructor TReceiver.Create;
begin
  inherited;
  Locker := TCriticalSection.Create;
  CRC16Calculator := TIdHashCRC16.Create;
  fiPrenosLen := 0;
  fsData := '';    {Do not Localize}
  fiMsgLen := 0;
  HeaderLen := SizeOf(TIdHeader);
  GetMem(pBuffer, BUFFERLEN);
  GetMem(Msg, BUFFERLEN);
end;


destructor TReceiver.Destroy;
begin
  FreeMem(pBuffer, BUFFERLEN);
  FreeMem(Msg, BUFFERLEN);
  Locker.Free;
  CRC16Calculator.Free;
  inherited;
end;

function TReceiver.FNewMessage: Boolean;
begin
  Result := fbNewMessage;
end;

procedure TReceiver.SetData(const Value: string);
var
  CRC16: Word;
begin
  Locker.Enter;
  try
    try
      fsData := Value;
      fiMsgLen := Length(fsData);
      if fiMsgLen > 0 then begin
        Move(fsData[1], (pBuffer + fiPrenosLen)^, fiMsgLen);
        fiPrenosLen := fiPrenosLen + fiMsgLen;
        if (fiPrenosLen >= HeaderLen) then begin
          // copy the header
          Move(pBuffer^, Header, HeaderLen);
          TypeDetected := True;
          // do we have enough data for the entire message
          if Header.MsgLen <= fiPrenosLen then begin
            MsgLen := Header.MsgLen - HeaderLen;
            Move((pBuffer+HeaderLen)^, Msg^, MsgLen);
            // Calculate the crc code
            CRC16 := CRC16Calculator.HashValue(Msg^);
            if CRC16 <> Header.CRC16 then begin
              fCRCFailed := True;
            end
            else begin
              fCRCFailed := False;
            end;
            fbNewMessage := True;
          end
          else begin
            fbNewMessage := False;
          end;
        end
        else begin
          TypeDetected := False;
        end;
      end
      else begin
        fbNewMessage := False;
        TypeDetected := False;
      end;
    except
      raise;
    end;

  finally
    Locker.Leave;
  end;
end;

procedure TReceiver.ShiftData;
var
  CRC16: Word;
begin
  Locker.Enter;
  try
    fiPrenosLen := fiPrenosLen - Header.MsgLen;
    // check if we have another entire message
    if fiPrenosLen > 0 then begin
      Move((pBuffer + Header.MsgLen)^, pBuffer^, fiPrenosLen);
    end;

    // check if we have another entire message
    if (fiPrenosLen >= HeaderLen) then begin
      // copy the header
      Move(pBuffer^, Header, HeaderLen);
      TypeDetected := True;
      // do we have enough data for the entire message
      if Header.MsgLen <= fiPrenosLen then begin
        MsgLen := Header.MsgLen - HeaderLen;
        Move((pBuffer+HeaderLen)^, Msg^, MsgLen);
        // Calculate the crc code
        CRC16 := CRC16Calculator.HashValue(Msg^);
        if CRC16 <> Header.CRC16 then begin
          fCRCFailed := True;
        end
        else begin
          fCRCFailed := False;
        end;
        fbNewMessage := True;
      end
      else begin
        fbNewMessage := False;
      end;
    end
    else begin
      TypeDetected := False;
    end;
  finally
    Locker.Leave;
  end;
end;
//
// END Communication classes
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// Logging class
//
constructor TLogger.Create(LogFileName: String);
begin
  fbActive := False;
  OnlyOneThread := TCriticalSection.Create;
  try
    AssignFile(fLogFile, LogFileName);
    Rewrite(fLogFile);
    fbActive := True;
  except
    fbActive := False; //self.Destroy; // catch file i/o errors, double create file
  end;
end;

destructor TLogger.Destroy;
begin
  if fbActive then
    CloseFile(fLogFile);
  OnlyOneThread.Free;
  inherited;
end;

procedure TLogger.LogEvent(Msg: String);
begin
  OnlyOneThread.Enter;
  try
    WriteLn(fLogFile, Msg);
    Flush(fLogFile);
  finally
    OnlyOneThread.Leave;
  end;
end;
//
// Logging class
///////////////////////////////////////////////////////////////////////////////


end.
