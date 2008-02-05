{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11259: HTTPClient.pas 
{
{   Rev 1.6    8/2/2003 05:17:20 AM  JPMugaas
{ Added HTTP Decompression test cases in a new test in this unit.
}
{
{   Rev 1.5    2003.07.11 4:07:42 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.4    6/24/2003 01:13:50 PM  JPMugaas
{ Updates for minor API change.
}
{
    Rev 1.3    4/15/2003 2:40:58 PM  BGooijen
  Other TempDir
}
{
    Rev 1.2    4/14/2003 11:25:46 PM  BGooijen
}
{
    Rev 1.1    4/4/2003 7:43:44 PM  BGooijen
  compile again
}
{
{   Rev 1.0    11/12/2002 09:18:36 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit HTTPClient;

interface

uses
  SysUtils, Classes, BXBubble, Forms;

type
  TdmodHTTPClient = class(TDataModule)
    HTTPClient: TBXBubble;
    HTTPDecompression: TBXBubble;
    procedure HTTPClientTest(Sender: TBXBubble);
    procedure HTTPDecompressionTest(Sender: TBXBubble);
  private
  public
  end;

var
  dmodHTTPClient: TdmodHTTPClient;

implementation
{$R *.dfm}

{ THTTPClient }
uses
  IdHTTP,
  IdCompressorBorZLib,
  IdCookieManager,
  IdGlobal,IdCoreGlobal,
  BXGlobal,
  // IdSSLOpenSSL,
  IniFiles,
  IdTCPConnection;


procedure TdmodHTTPClient.HTTPClientTest(Sender: TBXBubble);
var
  URLFile: TIniFile;
  sMethod,
  sTest,
  sFile : string;
  i,
  iTestCases: Integer;
  strmPostRequest, strmResult : TFileStream;
begin
  with HTTPClient do begin
  sFile := DataDir + 'HTTPClient.ini';
  if FileExists(sFile) then begin
    URLFile := TIniFile.Create(sFile);
    try
      // Load the number of test cases
      iTestCases :=  URLFile.ReadInteger('Global', 'TestCases', 0);
      for i := 1 to iTestCases do begin
        // Read the current test case
        sTest := 'Test' + IntToStr(i);
        with TIdHTTP.Create(nil) do try
//          Host := URLFile.ReadString(sTest, 'Host', '');
//          Port := URLFile.ReadInteger(sTest, 'Port', 80);
          if URLFile.ReadString(sTest, 'ProtocolVersion', 'pv1_0') = 'pv1_0' then
            ProtocolVersion := pv1_0
          else
            ProtocolVersion := pv1_1;
          with Request do begin
            Username := URLFile.ReadString(sTest, 'Username', '');
            Password := URLFile.ReadString(sTest, 'Password', '');
            // TODO Add suport for SSL
            ProxyParams.ProxyPort := URLFile.ReadInteger(sTest, 'ProxyPort', 0);
            ProxyParams.ProxyServer := URLFile.ReadString(sTest, 'ProxyServer', '');
            // ProxyAuthenticate is used in the response.
            // ProxyAuthenticate.CommaText := URLFile.ReadString(sTest, 'ProxyAuthenticate', '');
            ProxyParams.ProxyUsername := URLFile.ReadString(sTest, 'ProxyUsername', '');
            ProxyParams.ProxyPassword := URLFile.ReadString(sTest, 'ProxyPassword', '');
          end;
          HandleRedirects := URLFIle.ReadBool(sTest, 'HandleRedirects', False);
          Status('Testing Test' + IntToStr(i) + ': ' + URLFile.ReadString(sTest, 'URL', ''));
          sMethod := URLFile.ReadString(sTest, 'Method', 'GET');
          if AnsiSameText(sMethod, 'GET') then begin
            strmResult := TFileStream.Create(GTempDir + sTest +'.html', fmCreate);
            try
              Get(URLFile.ReadString(sTest, 'URL', ''), strmResult);
            finally
              strmResult.Free;
            end;
            continue;
          end;

          if AnsiSameText(URLFile.ReadString(sTest, 'Cookies', ''), 'YES') then begin
            CookieManager := TIdCookieManager.Create(nil);
          end;

          if AnsiSameText(sMethod, 'HEAD') then begin
            Head(URLFile.ReadString(sTest, 'URL', ''));
            continue;
          end;

          //  Post Support
          if AnsiSameText(sMethod, 'POST') then begin
            Request.ContentType := URLFile.ReadString(sTest, 'ContentType', '');

            strmPostRequest := TFileStream.Create(DataDir +
              URLFile.ReadString(sTest, 'PostInfo', ''), fmOpenRead);

            strmResult := TFileStream.Create(GTempDir + sTest + '.html', fmCreate);
            try
              Post(URLFile.ReadString(sTest, 'URL', ''), strmPostRequest, strmResult);
            finally
              strmResult.Free;
              strmPostRequest.Free;
            end;

            continue;
          end;
        finally
          if Assigned(CookieManager) then CookieManager.Free;
          Free;
        end;
      end;
    finally
      URLFile.Free;
    end;
  end;
  end;
end;

procedure TdmodHTTPClient.HTTPDecompressionTest(Sender: TBXBubble);
var LHTTP : TIdHTTP;
   LZ : TIdCompressorBorZLib;
   s : TStream;
begin
  LHTTP := TIdHTTP.Create(nil);
  LZ := TIdCompressorBorZLib.Create(nil);
  s := TMemoryStream.Create;
  try
    LHTTP.Compressor := LZ;
    //with chunked transfer encoding
    LHTTP.Get('http://www.webcompression.org',s);

    //without chunked transfer encoding
        s.Size := 0;
    LHTTP.Get('http://groups.yahoo.com',s);

    //This is just here as I did see an oddity with groups.yahboo.com.
    //I can not reproduce reliably.
    s.Size := 0;
    LHTTP.Get('http://groups.yahoo.com',s);
  finally
    FreeAndNil(s);
    FreeAndNil(LZ);
    FreeAndNil(LHTTP);
  end;
end;

end.
