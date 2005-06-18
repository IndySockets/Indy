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
{   Rev 1.18    27.08.2004 22:03:20  Andreas Hausladen
{ Optimized encoders
{ speed optimization ("const" for string parameters)
}
{
{   Rev 1.17    7/23/04 7:00:14 PM  RLebeau
{ Added extra exception handling to DecodeString() and Encode()
}
{
{   Rev 1.16    2004.06.14 9:23:06 PM  czhower
{ Bug fix.
}
{
{   Rev 1.15    22/05/2004 12:05:20  CCostelloe
{ Bug fix
}
{
{   Rev 1.14    2004.05.20 1:39:20 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.13    2004.05.20 11:37:08 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.12    2004.05.20 11:13:10 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.11    2004.05.19 3:06:48 PM  czhower
{ IdStream / .NET fix
}
{
{   Rev 1.10    2004.02.03 5:44:56 PM  czhower
{ Name changes
}
{
{   Rev 1.9    1/27/2004 3:58:16 PM  SPerry
{ StringStream ->IdStringStream
}
{
{   Rev 1.8    27/1/2004 1:57:58 PM  SGrobety
{ Additional bug fix
}
{
{   Rev 1.6    11/10/2003 7:39:22 PM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.5    2003.10.02 10:52:48 PM  czhower
{ .Net
}
{
{   Rev 1.4    2003.06.24 12:02:08 AM  czhower
{ Coders now decode properly again.
}
{
{   Rev 1.3    2003.06.13 6:57:08 PM  czhower
{ Speed improvement
}
{
{   Rev 1.2    2003.06.13 3:41:18 PM  czhower
{ Optimizaitions.
}
{
{   Rev 1.1    2003.06.13 2:24:06 PM  czhower
{ Speed improvement
}
{
{   Rev 1.0    11/14/2002 02:14:30 PM  JPMugaas
}
unit IdCoder;

interface

uses
  IdBaseComponent,
  IdSys,
  IdGlobal,
  IdObjs;

type
  TIdEncoder = class(TIdBaseComponent)
  public
    function Encode(const ASrc: string): string; overload;
    function Encode(ASrcStream: TIdStream2; const ABytes: Integer = MaxInt)
     : string; overload; virtual; abstract;
    class function EncodeString(const AIn: string): string;
  end;

  TIdDecoder = class(TIdBaseComponent)
  protected
    FStream: TIdStream2;
  public
    procedure Decode(const AIn: string; const AStartPos: Integer = 1;
     const ABytes: Integer = -1); virtual; abstract;
    procedure DecodeBegin(ADestStream: TIdStream2); virtual;
    procedure DecodeEnd; virtual;
    class function DecodeString(const AIn: string): string;
  end;
  TIdDecoderClass = class of TIdDecoder;

implementation

uses
  IdGlobalProtocols;

{ TIdDecoder }

procedure TIdDecoder.DecodeBegin(ADestStream: TIdStream2);
begin
  FStream := ADestStream;
end;

procedure TIdDecoder.DecodeEnd;
begin
end;

class function TIdDecoder.DecodeString(const AIn: string): string;
var
  LStream: TIdMemoryStream;
begin
  with Create(nil) do try
    LStream := TIdMemoryStream.Create; try {Do not Localize}
        DecodeBegin(LStream); try
          Decode(AIn);
          LStream.Position := 0;
          Result := ReadStringFromStream(LStream);
        finally DecodeEnd; end;
    finally Sys.FreeAndNil(LStream); end;
  finally Free; end;
end;

{ TIdEncoder }

function TIdEncoder.Encode(const ASrc: string): string;
var
  LStream: TIdStream2;
begin
  LStream := TIdMemoryStream.Create; try
      WriteStringToStream(LStream, ASrc);
      LStream.Position := 0;
      Result := Encode(LStream);
  finally Sys.FreeAndNil(LStream); end;
end;

class function TIdEncoder.EncodeString(const AIn: string): string;
begin
  with Create(nil) do try
    Result := Encode(AIn);
  finally Free; end;
end;

end.


