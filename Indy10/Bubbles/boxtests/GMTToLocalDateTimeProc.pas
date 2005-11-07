{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11251: GMTToLocalDateTimeProc.pas 
{
{   Rev 1.0    11/12/2002 09:18:06 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit GMTToLocalDateTimeProc;

interface

uses
  IndyBox,
  Classes;

type
  TGMTToLocalDateTimeBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  INIFiles,
  IdCoreGlobal,
  IdGlobal,
  SysUtils;

{ TGMTToLocalDateTimeBox }

procedure TGMTToLocalDateTimeBox.Test;
var
  i: Integer;
  LDateTime: TDateTime;
  LMonth, LDay, LYear: Word;
  LTestString: string;
  LYMDCheck: string;
begin
  with TStringList.Create do try
    LoadFromFile(GetDataDir + 'GMTToLocalDateTimeProc.dat');
    for i := 0 to Count - 1 do begin
      LYMDCheck := Strings[i];
      if Length(Trim(LYMDCheck)) > 0 then begin
        LTestString := Fetch(LYMDCheck, '=');
        LDateTime := GMTToLocalDateTime(LTestString);
        DecodeDate(LDateTime, LYear, LMonth, LDay);
        if Length(LYMDCheck) = 0 then begin
          Check((LYear >= 2000) and (LMonth in [8, 9, 10]), 'Date failed: ' + LTestString);
        end else begin
          Check(LYear = StrToInt(Copy(LYMDCheck, 1, 4)), 'Year mismatch: ' + LTestString);
          Check(LMonth = StrToInt(Copy(LYMDCheck, 5, 2)), 'Month mismatch: ' + LTestString);
          Check(LDay = StrToInt(Copy(LYMDCheck, 7, 2)), 'Day mismatch: ' + LTestString);
        end;
      end;
    end;
  finally Free; end;
end;

initialization
  TIndyBox.RegisterBox(TGMTToLocalDateTimeBox, 'GMTToLocalDateTimeProc', 'Misc');
end.
