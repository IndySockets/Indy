{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11876: IdHash.pas 
{
{   Rev 1.10    7/24/04 12:54:32 PM  RLebeau
{ Compiler fix for TIdHash128.HashValue()
}
{
{   Rev 1.9    7/23/04 7:09:12 PM  RLebeau
{ Added extra exception handling to various HashValue() methods
}
{
{   Rev 1.8    2004.05.20 11:37:06 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.7    2004.03.03 11:54:30 AM  czhower
{ IdStream change
}
{
{   Rev 1.6    2004.02.03 5:44:48 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/27/2004 4:00:08 PM  SPerry
{ StringStream ->IdStringStream
}
{
{   Rev 1.4    11/10/2003 7:39:22 PM  BGooijen
{ Did all todo's ( TStream to TIdStream mainly )
}
{
{   Rev 1.3    2003.10.24 10:43:08 AM  czhower
{ TIdSTream to dos
}
{
{   Rev 1.2    10/18/2003 4:28:30 PM  BGooijen
{ Removed the pchar for DotNet
}
{
{   Rev 1.1    10/8/2003 10:15:10 PM  GGrieve
{ replace TIdReadMemoryStream (might be fast, but not compatible with DotNet)
}
{
{   Rev 1.0    11/13/2002 08:30:24 AM  JPMugaas
{ Initial import from FTP VC.
}
unit IdHash;

interface

uses
  IdSys,
  Classes;

type
  TIdHash = class(TObject);

  TIdHash16 = class(TIdHash)
  public
    function HashValue(const ASrc: string): Word; overload;
    function HashValue(AStream: TStream): Word; overload; virtual; abstract;
  end;

  TIdHash32 = class(TIdHash)
  public
    function HashValue(const ASrc: string): LongWord; overload;
    function HashValue(AStream: TStream): LongWord; overload; virtual; abstract;
  end;

  T4x4LongWordRecord = array [0..3] of LongWord;

  TIdHash128 = class(TIdHash)
  public
    class function AsHex(const AValue: T4x4LongWordRecord): string;
    function HashValue(const ASrc: string): T4x4LongWordRecord; overload;
    function HashValue(AStream: TStream): T4x4LongWordRecord; overload; virtual; abstract;
  end;
  
  T5x4LongWordRecord = array [0..4] of LongWord;

  TIdHash160 = class(TIdHash)
  public
    class function AsHex(const AValue: T5x4LongWordRecord): string;
    function HashValue(const ASrc: string): T5x4LongWordRecord; overload;
    function HashValue(AStream: TStream): T5x4LongWordRecord; overload; virtual; abstract;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  IdStreamVCL;

{ TIdHash32 }

function TIdHash32.HashValue(const ASrc: string): LongWord;
var
  LStream: TStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TMemoryStream.Create; try
    with TIdStreamVCL.Create(LStream) do try
      Write(ASrc);
      VCLStream.Position := 0;
      Result := HashValue(VCLStream);
    finally Free; end;
  finally Sys.FreeAndNil(LStream); end;
end;

{ TIdHash16 }

function TIdHash16.HashValue(const ASrc: string): Word;
var
  LStream: TStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TMemoryStream.Create; try
    with TIdStreamVCL.Create(LStream) do try
      Write(ASrc);
      VCLStream.Position := 0;
      Result := HashValue(VCLStream);
    finally Free; end;
  finally Sys.FreeAndNil(LStream); end;
end;

{ TIdHash128 }

function TIdHash128.HashValue(const ASrc: string): T4x4LongWordRecord;
var
  LStream: TStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TMemoryStream.Create; try
    with TIdStreamVCL.Create(LStream) do try
      Write(ASrc);
      VCLStream.Position := 0;
      Result := HashValue(VCLStream);
    finally Free; end;
  finally Sys.FreeAndNil(LStream); end;
end;

class function TIdHash128.AsHex(const AValue: T4x4LongWordRecord): string;
Begin
  result := ToHex(AValue);
end;

{ TIdHash160 }

function TIdHash160.HashValue(const ASrc: string): T5x4LongWordRecord;
var
  LStream: TStream;  // not TIdStringStream -  Unicode on DotNet!
begin
  LStream := TMemoryStream.Create; try
    with TIdStreamVCL.Create(LStream) do try
      Write(ASrc);
      VCLStream.Position := 0;
      Result := HashValue(VCLStream);
    finally Free; end;
  finally Sys.FreeAndNil(LStream); end;
end;

class function TIdHash160.AsHex(const AValue: T5x4LongWordRecord): string;
Begin
  result := ToHex(AValue);
end;

end.
