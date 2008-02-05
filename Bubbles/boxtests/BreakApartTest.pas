{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11229: BreakApartTest.pas 
{
{   Rev 1.0    11/12/2002 09:14:50 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit BreakApartTest;

interface

uses
  Classes,
  IndyBox;

type
  TBreakApartBox = class (TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  IdGlobal,
  SysUtils;

{ TBreakApartBox }

procedure TBreakApartBox.Test;
var
  LList : TStringList;
  LData : TStringList;
  LIndex, LTest, LResults, LCount : Integer;
  LStr, LBreak : String;
begin
  LData := TStringList.Create;
  LList := TStringList.Create;
  try
    LData.LoadFromFile(GetDataDir + 'BreakApart.dat');
    LIndex := 0;
    LTest := 0;
    while LIndex < LData.Count do
    begin
      if Length(LData[LIndex]) > 0 then
      begin
        LStr := LData[LIndex];
        if LStr[1] = ':' then
        begin
          Inc(LIndex);
          if LIndex + 2 > LData.Count then
          begin
            Check(false, 'Insufficient data for test ' + IntToStr(LTest));
          end;

          Inc(LTest);
          Status('---Beginning test ' + IntToStr(LTest));
          LStr := LData[LIndex];
          LBreak := LData[LIndex + 1];
          Status('Data string: ' + LStr);
          Status('Break string: ' + LBreak);

          LResults := StrToInt(LData[LIndex + 2]);
          Status('Results expected: ' + IntToStr(LResults));
          Inc(LIndex, 3); // Now indexing the first result
          LList.Clear;
          BreakApart(LStr, LBreak, TStrings(LList));
          for LCount := 0 to LList.Count - 1 do
          begin
            Status('Output string ' + IntToStr(LCount) + ': ' + LList[LCount]);
          end;
          Check(LResults = LList.Count, 'Test ' + IntToStr(LTest)
            + ' error.  Incorrect number of results');

          for LCount := 0 to LList.Count - 1 do
          begin
            Check(LList[LCount] = LData[LIndex + LCount],
              'Test ' + IntToStr(LTest) + ' error.  Result '
              + IntToStr(LCount + 1) + ' does not match expected result');
          end;
          Inc(LIndex, LList.Count);
        end;
      end;
      Inc(LIndex);
    end;
    for LCount := 0 to LList.Count - 1 do
    begin
      Status(LList[LCount]);
    end;
  finally
    FreeAndNil(LList);
    FreeAndNil(LData);
  end;
end;

initialization
  TIndyBox.RegisterBox(TBreakApartBox, 'BreakApart', 'Misc');
end.
 
