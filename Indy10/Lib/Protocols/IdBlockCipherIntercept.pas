{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log$80; //future: for IdBlockCipherBlockSizeMax>256

procedure TIdBlockCipherIntercept.Encrypt(var VData : TIdBytes);
Begin
  if Assigned(FOnSend) then begin
    FOnSend(Self, VData);
  end;//ex: EncryptAES(LTempIn, ExpandedKey, LTempOut);
end;

procedure TIdBlockCipherIntercept.Decrypt(var VData : TIdBytes);
Begin
  if Assigned(FOnReceive) then begin
    FOnReceive(self, VData);
  end;//ex: DecryptAES(LTempIn, ExpandedKey, LTempOut);
end;

procedure TIdBlockCipherIntercept.Send(var VBuffer: TIdBytes);
var
  LSrc : TIdBytes;
  LTemp : TIdBytes;
  LCount : Integer;
Begin
  if Length(VBuffer) = 0 then
    exit;

  LSrc := VBuffer;
  SetLength(VBuffer, ((Length(LSrc) + FBlockSize - 2) div (FBlockSize - 1)) * FBLockSize);
  SetLength(LTemp, FBlockSize);

  //process all complete blocks
  for LCount := 0 to Length(LSrc) div (FBlockSize - 1)-1 do
    begin
    CopyTIdBytes(LSrc, lCount * (FBlockSize - 1), LTemp, 0, FBlockSize - 1);
    LTemp[FBlockSize - 1] := FBlockSize - 1;
    Encrypt(LTemp);
    CopyTIdBytes(LTemp, 0, VBuffer, LCount * FBlockSize, FBLockSize);
    end;

  //process the possible remaining bytes, ie less than a full block
  if Length(LSrc) Mod (FBlockSize - 1) > 0 then
    begin
    CopyTIdBytes(LSrc, length(LSrc) - (Length(LSrc) Mod (FBlockSize - 1)), LTemp, 0, Length(LSrc) Mod (FBlockSize - 1));
    LTemp[FBlockSize - 1] := Length(LSrc) Mod (FBlockSize - 1);
    Encrypt(LTemp);
    CopyTIdBytes(LTemp, 0, VBuffer, Length(VBuffer) - FBlockSize, FBLockSize);
    end;
end;

procedure TIdBlockCipherIntercept.Receive(var VBuffer: TIdBytes);
var
  LCount : integer;
  LTemp : TIdBytes;
  LPos : Integer;
Begin
  LCount := Length(FIncoming);
  SetLength(FIncoming, Length(FIncoming) + Length(VBuffer));
  CopyTIdBytes(VBuffer, 0, FIncoming, LCount, length(VBuffer));
  SetLength(LTemp, FBlockSize);

  if Length(FIncoming) < FBlockSize then
    begin
    SetLength(VBuffer, 0)
    end
  else
    begin
    // the length of ABuffer when we have finished is currently unknown, but must be less than
    // the length of FIncoming. We will reserve this much, then reallocate at the end
    SetLength(VBuffer, Length(FIncoming));
    LPos := 0;

    for LCount := 0 to (Length(FIncoming) div FBLockSize)-1 do
      begin
      CopyTIdBytes(FIncoming, LCount * FBlockSize, LTemp, 0, FBlockSize);
      Decrypt(LTemp);
      if (LTemp[FBlocksize-1] = 0) or (LTemp[FBlocksize-1] >= FBlockSize) then
        raise EIdBlockCipherInterceptException.Create(RSBlockIncorrectLength+' ('+Sys.IntToStr(LTemp[FBlocksize-1])+')');
      CopyTIdBytes(LTemp, 0, VBuffer, LPos, LTemp[FBlocksize-1]);
      inc(LPos, LTemp[FBlocksize-1]);
      end;
    if Length(FIncoming) mod FBlockSize > 0 then
      begin
      CopyTIdBytes(FIncoming, Length(FIncoming) - (Length(FIncoming) mod FBlockSize), FIncoming, 0, Length(FIncoming) mod FBlockSize);
      SetLength(FIncoming, Length(FIncoming) mod FBlockSize);
      end
    else
      begin
      SetLength(FIncoming, 0);
      end;
    SetLength(VBuffer, LPos);
    end;
end;

procedure TIdBlockCipherIntercept.CopySettingsFrom(ASrcBlockCipherIntercept: TIdBlockCipherIntercept);
Begin
  Self.FBlockSize := ASrcBlockCipherIntercept.FBlockSize;
  Self.FData:= ASrcBlockCipherIntercept.FData; // not sure that this is actually safe
  Self.FOnConnect := ASrcBlockCipherIntercept.FOnConnect;
  Self.FOnDisconnect:= ASrcBlockCipherIntercept.FOnDisconnect;
  Self.FOnReceive := ASrcBlockCipherIntercept.FOnReceive;
  Self.FOnSend := ASrcBlockCipherIntercept.FOnSend;
end;

procedure TIdBlockCipherIntercept.SetBlockSize(const Value: Integer);
Begin
  if (Value>0) and (Value<=IdBlockCipherBlockSizeMax) then begin
    FBlockSize := Value;
  end;
end;

procedure TIdBlockCipherIntercept.InitComponent;
begin
  inherited;
  FBlockSize := IdBlockCipherBlockSizeDefault;
  SetLength(FIncoming, 0);
end;

end.
