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

unit IdStreamNET;

interface

uses
  IdObjs, IdGlobal;

type
  TIdStreamHelperNET = class
  public
    class function ReadBytes(AStream: TIdStream2;
                         var VBytes: TIdBytes;
                             ACount: Integer = -1;
                             AOffset: Integer = 0): Integer; static;
    class procedure Write(
          const AStream: TIdStream2;
          const ABytes: TIdBytes;
          const ACount: Integer = -1); static;
  end;

implementation

class function TIdStreamHelperNET.ReadBytes(AStream: TIdStream2; var VBytes: TIdBytes;
  ACount, AOffset: Integer): Integer;
var
 aActual:Integer;
begin
  Assert(AStream<>nil);
  Result:=0;
  //check that offset<length(buffer)? offset+count?
  //is there a need for this to be called with an offset into a nil buffer?

  aActual:=ACount;
  if aActual = -1 then begin
    aActual := AStream.Size - AStream.Position;
  end;

  //this prevents eg reading 0 bytes at Offset=10 from allocating memory
  if aActual=0 then begin
    Exit;
  end;

  if Length(VBytes) < (AOffset+aActual) then begin
    SetLength(VBytes, AOffset+aActual);
  end;

  Assert(VBytes<>nil);
  Result := AStream.Read(VBytes, AOffset, AActual);
end;

class procedure TIdStreamHelperNET.Write(const AStream: TIdStream2;
  const ABytes: TIdBytes; const ACount: Integer);
var
 aActual:Integer;
begin
  Assert(AStream<>nil);

  aActual:=ACount;
  //should we raise assert instead of this nil check?
  if ABytes <> nil then
  begin
    if aActual = -1 then
    begin
      aActual := Length(ABytes);
    end
    else
    begin
      aActual := Min(aActual, Length(ABytes));
    end;
    if aActual > 0 then
    begin
      AStream.Write(ABytes, aActual);
    end;
  end;
end;

end.

