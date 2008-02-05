{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  22848: URIBox2.pas 
{
{   Rev 1.0    9/7/2003 05:55:24 AM  JPMugaas
{ URI2 test restored.
}
{
{   Rev 1.0    2003.04.11 10:01:34 PM  czhower
}
{
{   Rev 1.0    11/12/2002 09:21:38 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit URIBox2;

interface

uses
  IndyBox,
  IdURI;

type
  TURIBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  Classes,
  SysUtils;

{ TURIBox }

procedure TURIBox.Test;
var
  URI : TIdURI;
  TestData : TStringList;
  sindex, testindex : Integer;
  str : String;
  sin, sout, full, protocol, host, path, document, port, username,
  password, bookmark, parameters : String;
begin
  URI := TIdURI.Create;
  TestData := TStringList.Create;
  try
    TestData.LoadFromFile(GetDataDir + 'uri.dat');

    testindex := 0;
    sindex := 0;
    while sindex < TestData.Count do
    begin
      str := TestData[sindex];
      if Length(str) > 0 then
      begin
        if str[1] = ':' then
        begin
          // Begin by resetting the component
          URI.URI := '';
          Inc(testindex);
          if TestData.Count < sindex + 12 then
          begin
            raise Exception.Create('Insufficient data in uri.dat file for test '
              + IntToStr(testindex));
          end else
          begin
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
            if sin = 'Components' then
            begin
              URI.URI := '';
              URI.Protocol := protocol;
              URI.Host := Host;
              URI.Path := Path;
              URI.Document := Document;
              URI.Port := Port;
              URI.Username := Username;
              URI.Password := Password;
              URI.Params := Parameters;
              URI.Bookmark := Bookmark;
            end else
            begin
              URI.URI := sin;
            end;
            Status('Checking URI of test ' + IntToStr(testindex));
            Status('URI in: ' + sin);
            Status('URI expected: ' + sout + ', got: ' + URI.URI);
            Check(URI.URI = sout, 'Test ' + IntToStr(testindex)
              + ' failed on URI.');
            Status('Full URI expected: ' + full + ', got: ' + URI.GetFullURI);
            Check(URI.GetFullURI = full, 'Test ' + IntToStr(testindex)
              + ' failed on full URI.');
            Status('Protocol expected: ' + protocol + ', got: ' + URI.Protocol);
            Check(URI.Protocol = protocol, 'Test ' + IntToStr(testindex)
              + ' failed on protocol.');
            Status('Host expected: ' + host + ', got: ' + URI.Host);
            Check(URI.Host = host, 'Test ' + IntToStr(testindex)
              + ' failed on host.');
            Status('Path expected: ' + path + ', got: ' + URI.Path);
            Check(URI.Path = Path, 'Test ' + IntToStr(testindex)
              + ' failed on path.');
            Status('Document expected: ' + document + ', got: ' + URI.Document);
            Check(URI.Document = Document, 'Test ' + IntToStr(testindex)
              + ' failed on document.');
            Status('Port expected: ' + port + ', got: ' + URI.Port);
            Check(URI.Port = Port, 'Test ' + IntToStr(testindex)
              + ' failed on port.');
            Status('Username expected: ' + username + ', got: ' + URI.Username);
            Check(URI.Username = Username, 'Test ' + IntToStr(testindex)
              + ' failed on username.');
            Status('Password expected: ' + password + ', got: ' + URI.Password);
            Check(URI.Password = password, 'Test ' + IntToStr(testindex)
              + ' failed on password.');
            Status('Parameters expected: ' + parameters + ', got: ' + URI.Params);
            Check(URI.Params = Parameters, 'Test ' + IntToStr(testindex)
              + ' failed on parameters.');
            Status('Bookmark expected: ' + bookmark + ', got: ' + URI.Bookmark);
            Check(URI.Bookmark = Bookmark, 'Test ' + IntToStr(testindex)
              + ' failed on bookmark.');
          end;
        end;
      end;

      Inc(sindex);
    end;
  finally
    FreeAndNil(URI);
    FreeAndNil(TestData);
  end;
end;

initialization
  TIndyBox.RegisterBox(TURIBox, 'URI', 'Misc');
end.
