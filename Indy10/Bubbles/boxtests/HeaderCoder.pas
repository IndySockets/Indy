{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11255: HeaderCoder.pas 
{
{   Rev 1.1    2003.07.11 4:07:42 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.0    11/12/2002 09:18:16 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit HeaderCoder;
interface

uses
  IndyBox;

type
  THeaderCoderBox = class(TIndyBox)
  public
    procedure TestString(const AIn, AOut: string);
    procedure Test; override;
  end;

implementation

uses
  IdCoderHeader,
  IniFiles,
  SysUtils;

{ THeaderCoderBox }

procedure THeaderCoderBox.Test;
var
  inifile: TMemIniFile;
  i: integer;
begin
  inifile := TMemIniFile.Create(GetDataDir+'headers.ini');
  try
    i := inifile.ReadInteger('main','count',-1);
    while i > 0 do begin
      TestString(inifile.ReadString('test '+inttostr(i), 'encoded',''),
        inifile.ReadString('test '+inttostr(i), 'decoded',''));
      Dec(i);
    end;
  finally
    inifile.free;
  end;
end;

procedure THeaderCoderBox.TestString(const AIn, AOut: string);
begin
  Status('Testing '+AIn);
  Check(IdCoderHeader.DecodeHeader(AIn) = AOut, 'Header '+AIn+' failed to decode into '+AOut);
end;

initialization
  TIndyBox.RegisterBox(THeaderCoderBox, 'Header', 'Coders');
end.
