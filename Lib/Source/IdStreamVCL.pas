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

unit IdStreamVCL deprecated;

interface

uses
  Classes,
  IdGlobal;

type
  TIdStreamHelperVCL = class
  public
    class function ReadBytes(
          const AStream: TStream;
          var VBytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; deprecated 'Use IdGlobal.ReadTIdBytesFromStream()';
    class function Write(
          const AStream: TStream;
          const ABytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; deprecated 'Use IdGlobal.WriteTIdBytesToStream()';
    class function Seek(
          const AStream: TStream;
          const AOffset: Int64;
          const AOrigin: TSeekOrigin) : Int64; deprecated 'use TStream.Seek()';
  end;

implementation

{$I IdCompilerDefines.inc}

// RLebeau: must use a 'var' and not an 'out' for the VBytes parameter,
// or else any preallocated buffer the caller passes in will get wiped out!

class function TIdStreamHelperVCL.ReadBytes(const AStream: TStream; var VBytes: TIdBytes;
  const ACount, AOffset: Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IdGlobal.ReadTIdBytesFromStream(AStream, VBytes, ACount, AOffset);
end;

class function TIdStreamHelperVCL.Write(const AStream: TStream; const ABytes: TIdBytes;
  const ACount: Integer; const AOffset: Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IdGlobal.WriteTIdBytesToStream(AStream, ABytes, ACount, AOffset);
end;

class function TIdStreamHelperVCL.Seek(const AStream: TStream; const AOffset: Int64;
  const AOrigin: TSeekOrigin): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := AStream.Seek(AOffset, AOrigin);
end;

end.

