{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17981: URIBox.pas 
{
{   Rev 1.7    2003.07.11 4:07:46 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.6    6/24/2003 01:13:38 PM  JPMugaas
{ Updates for minor API change.
}
{
{   Rev 1.5    2003.04.13 9:36:14 PM  czhower
}
{
    Rev 1.4    4/12/2003 12:14:38 PM  BGooijen
  Did not compile on D4 and D5
}
{
{   Rev 1.3    2003.04.11 11:11:00 PM  czhower
}
{
{   Rev 1.2    2003.04.11 11:01:52 PM  czhower
}
{
{   Rev 1.1    2003.04.11 10:12:14 PM  czhower
}
unit URIBox;

interface

{$I IdCompilerDefines.inc}

uses
  SysUtils, Classes, BXBubble, Forms;

type
  TdmodURI = class(TDataModule)
    URI: TBXBubble;
    procedure URITest(Sender: TBXBubble);
  private
  public
  end;

var
  dmodURI: TdmodURI;

implementation
{$R *.dfm}

uses
  IdURI;

procedure TdmodURI.URITest(Sender: TBXBubble);
var
  LURI : TIdURI;
  TestData : TStringList;
  sindex, testindex : Integer;
  str : String;
  sin, sout, full, protocol, host, path, document, port, username,
  password, bookmark, parameters : String;
begin
  with URI do begin
    LURI := TIdURI.Create; try
      TestData := TStringList.Create; try
        TestData.LoadFromFile(DataDir + 'URI.dat');

        testindex := 0;
        sindex := 0;
        while sindex < TestData.Count do begin
          str := TestData[sindex];
          if str <> '' then begin
            if str[1] = ':' then begin
              // Begin by resetting the component
              LURI.URI := '';
              Inc(testindex);
              if TestData.Count < sindex + 12 then begin
                raise Exception.Create('Insufficient data in LURI.dat file for test '
                  + IntToStr(testindex));
              end else begin
                sin := TestData[sindex + 1];
                sout := TestData[sindex + 2];
                full := TestData[sindex + 3];
                protocol := TestData[sindex + 4];
                host := TestData[sindex + 5];
                path := TestData[sindex + 6];
                document := TestData[sindex + 7];
                port := TestData[sindex + 8];
                username := TestData[sindex + 9];
                password := TestData[sindex + 10];
                parameters := TestData[sindex + 11];
                bookmark := TestData[sindex + 12];
                Inc(sindex, 12);
                if sin = 'Components' then begin
                  LURI.URI := '';
                  LURI.Protocol := protocol;
                  LURI.Host := Host;
                  LURI.Path := Path;
                  LURI.Document := Document;
                  LURI.Port := Port;
                  LURI.Username := Username;
                  LURI.Password := Password;
                  LURI.Params := Parameters;
                  LURI.Bookmark := Bookmark;
                end else begin
                  LURI.URI := sin;
                end;
                Status('Checking URI of test ' + IntToStr(testindex));
                Status('URI in: ' + sin);
                Status('URI expected: ' + sout + ', got: ' + LURI.URI);
                Check(LURI.URI = sout, 'Test ' + IntToStr(testindex)
                  + ' failed on LURI.');
                Status('Full URI expected: ' + full + ', got: ' + LURI.GetFullURI);
                Check(LURI.GetFullURI = full, 'Test ' + IntToStr(testindex)
                  + ' failed on full LURI.');
                Status('Protocol expected: ' + protocol + ', got: ' + LURI.Protocol);
                Check(LURI.Protocol = protocol, 'Test ' + IntToStr(testindex)
                  + ' failed on protocol.');
                Status('Host expected: ' + host + ', got: ' + LURI.Host);
                Check(LURI.Host = host, 'Test ' + IntToStr(testindex)
                  + ' failed on host.');
                Status('Path expected: ' + path + ', got: ' + LURI.Path);
                Check(LURI.Path = Path, 'Test ' + IntToStr(testindex)
                  + ' failed on path.');
                Status('Document expected: ' + document + ', got: ' + LURI.Document);
                Check(LURI.Document = Document, 'Test ' + IntToStr(testindex)
                  + ' failed on document.');
                Status('Port expected: ' + port + ', got: ' + LURI.Port);
                Check(LURI.Port = Port, 'Test ' + IntToStr(testindex)
                  + ' failed on port.');
                Status('Username expected: ' + username + ', got: ' + LURI.Username);
                Check(LURI.Username = Username, 'Test ' + IntToStr(testindex)
                  + ' failed on username.');
                Status('Password expected: ' + password + ', got: ' + LURI.Password);
                Check(LURI.Password = password, 'Test ' + IntToStr(testindex)
                  + ' failed on password.');
                Status('Parameters expected: ' + parameters + ', got: ' + LURI.Params);
                Check(LURI.Params = Parameters, 'Test ' + IntToStr(testindex)
                  + ' failed on parameters.');
                Status('Bookmark expected: ' + bookmark + ', got: ' + LURI.Bookmark);
                Check(LURI.Bookmark = Bookmark, 'Test ' + IntToStr(testindex)
                  + ' failed on bookmark.');
              end;
            end;
          end;

          Inc(sindex);
        end;
      finally FreeAndNil(TestData); end;
    finally FreeAndNil(LURI); end;
  end;
end;

end.
