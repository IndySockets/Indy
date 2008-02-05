{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11241: EMailAddress.pas 
{
{   Rev 1.0    11/12/2002 09:15:50 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit EMailAddress;

interface

{
2001-Feb-03 - Peter Mee
  - Added support for e-mail address creation.
2001-Jan-28 - Peter Mee
  - Created to support e-mail address extraction.
}

uses
  IndyBox;

type
  TEMailAddressBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  Classes,
  IdEMailAddress,
  SysUtils;

procedure TEMailAddressBox.Test;
var
  TestAddresses : TStringList;
  i, j, count : Integer;
  EA : TIdEMailAddressList;
begin
  TestAddresses := TStringList.Create;
  EA := TIdEMailAddressList.Create(Nil);
  try
    TestAddresses.LoadFromFile(GetDataDir + 'EMailAddress.dat');
    count := 0;
    i := 1;
    while count < TestAddresses.Count do
    begin
      // Locate the next line in TestResults containing ':' only.
      while count < TestAddresses.Count do
      begin
        if Length(TestAddresses[count]) > 0 then
        begin
          if TestAddresses[count][1] = ':' then
          begin
            break;
          end;
        end;
        Inc(Count);
      end;
      if count >= TestAddresses.Count then
      begin
        break;
      end;
      // The next line is the test line
      Inc(Count);
      EA.EMailAddresses := TestAddresses[count];

      Inc(count);
      Check(StrToInt(TestAddresses[count]) = EA.Count,
        'Test ' + IntToStr(i)
        + ', incorrect number of output addresses: '
        + TestAddresses[count] + 'expected, '
        + IntToStr(EA.Count) + ' found' );

      // Now compare the list of addresses against those in the results file
      // Each address spans two lines in the results file - the address and
      // the name in that order.
      Inc(count);
      for j := 0 to EA.Count - 1 do
      begin
        Check( (EA.Items[j].Address = TestAddresses[count]),
          'Extract Test ' + IntToStr(i)
          + '. Address ' + IntToStr(j) + ' (' + TestAddresses[count]
          + ') failed: ' + EA.Items[j].Address);
        Check( (EA.Items[j].Name = TestAddresses[count + 1]),
          'Test ' + IntToStr(i)
          + '. Name ' + IntToStr(j) + ' (' + TestAddresses[count + 1]
          + ') failed: ' + EA.Items[j].Name);
        Inc(count, 2);
      end;

      // Now put the address(es) back into arpa format.
      for j := 0 to EA.Count - 1 do
      begin
        Check(EA.Items[j].Text = TestAddresses[count],
          'Revert Test ' + IntToStr(i)
          + ' Address ' + IntToStr(j) + ' (' + TestAddresses[count]
          + ') failed: ' + EA.Items[j].Text);
        Inc(count);
      end;
      Inc(i);
    end;
  finally
    EA.Free;
    TestAddresses.Free;
  end;
end;

initialization
  TIndyBox.RegisterBox(TEMailAddressBox, 'EMailAddress', 'Misc');
end.
