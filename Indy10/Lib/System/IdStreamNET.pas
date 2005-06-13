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
begin
  if ACount = -1 then begin
    ACount := AStream.Size - AStream.Position;
  end;
  
  //after adjusting for -1
  if ACount=0 then begin
    Result:=0;
    Exit;
  end;

  if Length(VBytes) < (AOffset+ACount) then begin
    SetLength(VBytes, AOffset+ACount);
  end;
  //should be in stream.read
  Assert(VBytes<>nil);
  Result := AStream.Read(VBytes, AOffset, ACount);
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

