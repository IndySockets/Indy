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
  Rev 1.4    5/12/2003 12:30:58 AM  GGrieve
  Get compiling again with DotNet Changes

  Rev 1.3    10/12/2003 1:49:26 PM  BGooijen
  Changed comment of last checkin

  Rev 1.2    10/12/2003 1:43:24 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/14/2002 02:13:56 PM  JPMugaas
}

unit IdBlockCipherIntercept;

{
 UnitName: IdBlockCipherIntercept
 Author:   Andrew P.Rybin [magicode@mail.ru]
 Creation: 27.02.2002
 Version:  0.9.0b
 Purpose:  Secure communications
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdException,
  IdResourceStringsProtocols,
  IdIntercept;

const
  IdBlockCipherBlockSizeDefault = 16;

  IdBlockCipherBlockSizeMax     = 256;
  // why 256? not any block ciphers that can - or should - be used beyond this
  // length. You can extend this if you like. But the longer it is, the
  // more network traffic is wasted

  //256, as currently the last byte of the block is used to store the block size

type
  TIdBlockCipherIntercept = class;

  // OnSend and OnRecieve Events will always be called with a blockSize Data
  TIdBlockCipherIntercept = class(TIdConnectionIntercept)
  protected
    FBlockSize: Integer;
    FIncoming : TIdBytes;
    procedure Decrypt (var VData : TIdBytes); virtual;
    procedure Encrypt (var VData : TIdBytes); virtual;
    procedure SetBlockSize(const Value: Integer);
    procedure InitComponent; override;
  public
    procedure Receive(var VBuffer: TIdBytes); override; //Decrypt
    procedure Send(var VBuffer: TIdBytes); override; //Encrypt
    procedure CopySettingsFrom (ASrcBlockCipherIntercept: TIdBlockCipherIntercept); // warning: copies Data too
  published
    property  BlockSize: Integer read FBlockSize write SetBlockSize default IdBlockCipherBlockSizeDefault;
  end;

  TIdServerBlockCipherIntercept = class(TIdServerIntercept)
  protected
    FBlockSize: Integer;
    procedure InitComponent; override;
  public
    procedure Init; override;
    function Accept(AConnection: TComponent): TIdConnectionIntercept; override;
  published
    property BlockSize: Integer read FBlockSize write FBlockSize default IdBlockCipherBlockSizeDefault;
  end;

  EIdBlockCipherInterceptException = EIdException; {block length}

implementation

uses
  IdResourceStrings,
  SysUtils;

{ TIdBlockCipherIntercept }

//const
//  bitLongTail = $80; //future: for IdBlockCipherBlockSizeMax>256

procedure TIdBlockCipherIntercept.Encrypt(var VData : TIdBytes);
begin
  if Assigned(FOnSend) then begin
    FOnSend(Self, VData);
  end;//ex: EncryptAES(LTempIn, ExpandedKey, LTempOut);
end;

procedure TIdBlockCipherIntercept.Decrypt(var VData : TIdBytes);
Begin
  if Assigned(FOnReceive) then begin
    FOnReceive(Self, VData);
  end;//ex: DecryptAES(LTempIn, ExpandedKey, LTempOut);
end;

procedure TIdBlockCipherIntercept.Send(var VBuffer: TIdBytes);
var
  LSrc, LBlock : TIdBytes;
  LSize, LCount, LMaxDataSize: Integer;
  LCompleteBlocks, LRemaining: Integer;
begin
  LSrc := nil; // keep the compiler happy

  LSize := Length(VBuffer);
  if LSize > 0 then begin
    LSrc := VBuffer;

    LMaxDataSize := FBlockSize - 1;
    SetLength(VBuffer, ((LSize + LMaxDataSize - 1) div LMaxDataSize) * FBlockSize);
    SetLength(LBlock, FBlockSize);

    LCompleteBlocks := LSize div LMaxDataSize;
    LRemaining := LSize mod LMaxDataSize;

    //process all complete blocks
    for LCount := 0 to LCompleteBlocks-1 do
    begin
      CopyTIdBytes(LSrc, LCount * LMaxDataSize, LBlock, 0, LMaxDataSize);
      LBlock[LMaxDataSize] := LMaxDataSize;
      Encrypt(LBlock);
      CopyTIdBytes(LBlock, 0, VBuffer, LCount * FBlockSize, FBlockSize);
    end;

    //process the possible remaining bytes, ie less than a full block
    if LRemaining > 0 then
    begin
      CopyTIdBytes(LSrc, LSize - LRemaining, LBlock, 0, LRemaining);
      LBlock[LMaxDataSize] := LRemaining;
      Encrypt(LBlock);
      CopyTIdBytes(LBlock, 0, VBuffer, Length(VBuffer) - FBlockSize, FBlockSize);
    end;
  end;

  // let the next Intercept in the chain encode its data next

  // RLebeau: DO NOT call inherited!  It will trigger the OnSend event
  // again with the entire altered buffer as input, which can cause user
  // code to re-encrypt the already-encrypted data.  We do not want that
  // here! Just call the next Intercept directly...

  //inherited Send(VBuffer);
  if Intercept <> nil then begin
    Intercept.Send(VBuffer);
  end;
end;

procedure TIdBlockCipherIntercept.Receive(var VBuffer: TIdBytes);
var
  LBlock : TIdBytes;
  LSize, LCount, LPos, LMaxDataSize, LCompleteBlocks: Integer;
  LRemaining: Integer;
begin
  // let the next Intercept in the chain decode its data first

  // RLebeau: DO NOT call inherited!  It will trigger the OnReceive event
  // with the entire decoded buffer as input, which can cause user
  // code to decrypt data prematurely/incorrectly.  We do not want that
  // here! Just call the next Intercept directly...

  //inherited Receive(VBuffer);
  if Intercept <> nil then begin
    Intercept.Receive(VBuffer);
  end;

  LPos := 0;
  AppendBytes(FIncoming, VBuffer);

  LSize := Length(FIncoming);
  if LSize >= FBlockSize then
  begin
    // the length of ABuffer when we have finished is currently unknown, but must be less than
    // the length of FIncoming. We will reserve this much, then reallocate at the end
    SetLength(VBuffer, LSize);
    SetLength(LBlock, FBlockSize);

    LMaxDataSize := FBlockSize - 1;
    LCompleteBlocks := LSize div FBlockSize;
    LRemaining := LSize mod FBlockSize;

    for LCount := 0 to LCompleteBlocks-1 do
    begin
      CopyTIdBytes(FIncoming, LCount * FBlockSize, LBlock, 0, FBlockSize);
      Decrypt(LBlock);
      if (LBlock[LMaxDataSize] = 0) or (LBlock[LMaxDataSize] >= FBlockSize) then begin
        raise EIdBlockCipherInterceptException.CreateFmt(RSBlockIncorrectLength, [LBlock[LMaxDataSize]]);
      end;
      CopyTIdBytes(LBlock, 0, VBuffer, LPos, LBlock[LMaxDataSize]);
      Inc(LPos, LBlock[LMaxDataSize]);
    end;

    if LRemaining > 0 then begin
      CopyTIdBytes(FIncoming, LSize - LRemaining, FIncoming, 0, LRemaining);
    end;

    SetLength(FIncoming, LRemaining);
  end;

  SetLength(VBuffer, LPos);
end;

procedure TIdBlockCipherIntercept.CopySettingsFrom(ASrcBlockCipherIntercept: TIdBlockCipherIntercept);
Begin
  FBlockSize := ASrcBlockCipherIntercept.FBlockSize;
  {$IFDEF USE_OBJECT_ARC}
  FDataObject := ASrcBlockCipherIntercept.FDataObject;
  FDataValue := ASrcBlockCipherIntercept.FDataValue;
  {$ELSE}
  FData := ASrcBlockCipherIntercept.FData; // not sure that this is actually safe
  {$ENDIF}
  FOnConnect := ASrcBlockCipherIntercept.FOnConnect;
  FOnDisconnect:= ASrcBlockCipherIntercept.FOnDisconnect;
  FOnReceive := ASrcBlockCipherIntercept.FOnReceive;
  FOnSend := ASrcBlockCipherIntercept.FOnSend;
end;

procedure TIdBlockCipherIntercept.SetBlockSize(const Value: Integer);
Begin
  if (Value > 0) and (Value <= IdBlockCipherBlockSizeMax) then begin
    FBlockSize := Value;
  end;
end;

procedure TIdBlockCipherIntercept.InitComponent;
begin
  inherited InitComponent;
  FBlockSize := IdBlockCipherBlockSizeDefault;
  SetLength(FIncoming, 0);
end;

{ TIdServerBlockCipherIntercept }

procedure TIdServerBlockCipherIntercept.InitComponent;
begin
  inherited InitComponent;
  FBlockSize := IdBlockCipherBlockSizeDefault;
end;

procedure TIdServerBlockCipherIntercept.Init;
begin
end;

function TIdServerBlockCipherIntercept.Accept(AConnection: TComponent): TIdConnectionIntercept;
begin
  Result := TIdBlockCipherIntercept.Create(nil);
  TIdBlockCipherIntercept(Result).BlockSize := BlockSize;
end;

end.
