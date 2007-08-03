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

unit IdStreamVCL;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal;

type
  TIdStreamHelperVCL = class
  public
    class function ReadBytes(
          const AStream: TStream;
          out VBytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; {$IFDEF DOTNET} static; {$ENDIF}
    class procedure Write(
          const AStream: TStream;
          const ABytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; {$IFDEF DOTNET} static; {$ENDIF}
  end;

implementation

class function TIdStreamHelperVCL.ReadBytes(const AStream: TStream; out VBytes: TIdBytes;
  const ACount, AOffset: Integer): Integer;
var
  LActual: Integer;
begin
  Assert(AStream<>nil);
  Result := 0;

  if VBytes = nil then begin
    SetLength(VBytes, 0);
  end;
  //check that offset<length(buffer)? offset+count?
  //is there a need for this to be called with an offset into a nil buffer?

  LActual := ACount;
  if LActual < 0 then begin
    LActual := AStream.Size - AStream.Position;
  end;

  //this prevents eg reading 0 bytes at Offset=10 from allocating memory
  if LActual = 0 then begin
    Exit;
  end;

  if Length(VBytes) < (AOffset+LActual) then begin
    SetLength(VBytes, AOffset+LActual);
  end;

  Assert(VBytes<>nil);
  Result := AStream.Read(VBytes[AOffset], LActual);
end;

class procedure TIdStreamHelperVCL.Write(const AStream: TStream; const ABytes: TIdBytes;
  const ACount: Integer; const AOffset: Integer): Integer;
var
  LActual: Integer;
begin
  Result := 0;
  Assert(AStream<>nil);
  //should we raise assert instead of this nil check?
  if ABytes <> nil then begin
    LActual := IndyLength(ABytes, ACount, AOffset);
    // TODO: loop the writing, or use WriteBuffer(), to mimic .NET where
    // System.IO.Stream.Write() writes all provided bytes in a single operation
    if LActual > 0 then begin
      Result := AStream.Write(ABytes[AOffset], LActual);
    end;
  end;
end;

end.

