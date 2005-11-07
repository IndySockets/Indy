{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11269: ProcessPath.pas 
{
{   Rev 1.0    11/12/2002 09:19:26 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit ProcessPath;

interface

{
2001-Nov-18 Peter Mee
 - Created.
}

uses
  IndyBox;

type
  TProcessPathBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  Classes,
  IdGlobal,
  SysUtils;

procedure TProcessPathBox.Test;
var
  TestData : TStringList;
  Base, Path, Delim, Res, RRes : String;
  index : Integer;
  TestNum : Integer;
begin
  TestData := TStringList.Create;
  try
    TestData.LoadFromFile(GetDataDir + 'ProcessPath.dat');
    Index := 0;
    TestNum := 1;
    while Index < TestData.Count - 1 do
    begin
      Base := TestData[Index];
      if Length(Base) > 0 then
      begin
        if Base[1] = ':' then
        begin
          if Index >= TestData.Count - 4 then
          begin
            raise Exception.Create('Insufficient data for test ' + IntToStr(TestNum));
          end;

          // Have sufficient data for test.
          Base := TestData[Index + 1];
          Status('Test ' + IntToStr(TestNum) + ', Base: ' + Base);
          Path := TestData[Index + 2];
          Status('Test ' + IntToStr(TestNum) + ', Path: ' + Path);
          Delim := TestData[Index + 3];
          Status('Test ' + IntToStr(TestNum) + ', Delim: ' + Delim);
          Res := TestData[Index + 4];
          Status('Test ' + IntToStr(TestNum) + ', Ex. Result: ' + Res);
          RRes := IdGlobal.ProcessPath(Base, Path, Delim);
          Status('Test ' + IntToStr(TestNum) + ', Result: '
            + RRes);
          Check(Res = RRes,
            'Test ' + IntToStr(TestNum) + ' failed');
          Inc(TestNum);
        end;
      end;
      Inc(index);
    end; 
  finally
    FreeAndNil(TestData); 
  end;
end;

initialization
  TIndyBox.RegisterBox(TProcessPathBox, 'ProcessPath', 'Misc');
end.
