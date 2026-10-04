program testftplistparseunix;

{$IFNDEF FPC}
{$APPTYPE CONSOLE}
{$ELSE}
{$MODE DELPHI}
{$ENDIF}

uses
  Classes,
  SysUtils,
  IdFTPCommon,
  IdFTPList,
  IdFTPListParseUnix;

var
  Passed, Failed: Integer;

procedure TestListing(const ADescription, ADate, AFileName: string);
var
  LListing: TStringList;
  LItems: TIdFTPListItems;
  LParsed: Boolean;
  LExpectedDate: TDateTime;
begin
  LListing := TStringList.Create;
  LItems := TIdFTPListItems.Create;
  try
    try
      LListing.Add('-rw-r--r-- 1 owner group 123 ' + ADate + ' ' + AFileName);
      LParsed := TIdFTPLPUnix.ParseListing(LListing, LItems);
      if not LParsed then begin
        raise Exception.Create('Listing was not parsed');
      end;
      if LItems.Count <> 1 then begin
        raise Exception.Create('Expected one file');
      end;
      if LItems[0].FileName <> AFileName then begin
        raise Exception.Create('Incorrect file name');
      end;
      if LItems[0].Size <> 123 then begin
        raise Exception.Create('Incorrect file size');
      end;
      LExpectedDate := EncodeDate(2099, 1, 1) + EncodeTime(0, 0, 0, 999);
      if LItems[0].ModifiedDate <> LExpectedDate then begin
        raise Exception.Create('Incorrect modification date');
      end;
      Inc(Passed);
      WriteLn('PASS: ' + ADescription);
    except
      on E: Exception do begin
        Inc(Failed);
        WriteLn('FAIL: ' + ADescription + ': ' + E.ClassName + ': ' + E.Message);
      end;
    end;
  finally
    LItems.Free;
    LListing.Free;
  end;
end;

begin
  TestListing('English date', 'Jan 1 2099', 'report.txt');
  TestListing('Day marker in file name', 'Jan 1 2099', ChineseDay + '.txt');
  TestListing('Month marker in file name', 'Jan 1 2099', ChineseMonth + '.txt');
  TestListing('Chinese date', '2099' + ChineseYear + '1' + ChineseMonth +
    '1' + ChineseDay, 'report.txt');
  TestListing('Chinese date with spaces', '2099' + ChineseYear + ' 1' +
    ChineseMonth + ' 1' + ChineseDay, ChineseDay + '.txt');
  WriteLn('Passed: ', Passed, ', failed: ', Failed);
  if Failed <> 0 then begin
    Halt(1);
  end;
end.
