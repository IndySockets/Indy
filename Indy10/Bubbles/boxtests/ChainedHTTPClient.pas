{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18273: ChainedHTTPClient.pas }
{
{   Rev 1.6    2003.07.28 11:21:40 AM  czhower
{ Updates
}
{
{   Rev 1.5    2003.07.16 3:34:50 PM  czhower
{ Removed IdChainEngineStack
}
{
{   Rev 1.4    2003.07.11 4:07:40 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.3    6/24/2003 01:15:06 PM  JPMugaas
{ Updated for API change.
}
{
    Rev 1.2    5/11/2003 2:16:28 PM  BGooijen
  Added IOCP tests
}
{
    Rev 1.1    4/15/2003 2:40:58 PM  BGooijen
  Other TempDir
}
{
    Rev 1.0    4/14/2003 11:14:18 PM  BGooijen
}
unit ChainedHTTPClient;

interface

uses
  SysUtils, Classes, BXBubble, Forms;

type
  TdmodChainedHTTPClient = class(TDataModule)
    ChainedHTTPClientIOCP: TBXBubble;
    procedure ChainedHTTPClientIOCPTest(Sender: TBXBubble);
  private
  public
  end;

var
  dmodChainedHTTPClient: TdmodChainedHTTPClient;

implementation
{$R *.dfm}

uses
  IdHTTP, IdFiber, IdIOHandlerChain, IdFiberWeaverDefault,
  BXGlobal,
  IdCookieManager,
  IdGlobal,
  // IdSSLOpenSSL,
  IniFiles,
  IdTCPConnection;

Type
  THTTPFiber = class(TIdFiber)
  protected
    FChainEngine: TIdChainEngine;
    FTest: TBXBubble;
    FFiberWeaver: TIdFiberWeaver;
    FHost: string;
    procedure Execute; override;
  end;

procedure THTTPFiber.Execute;
var
  LIOHandler: TIdIOHandlerChain;

  URLFile: TIniFile;
  sMethod,
  sTest,
  sFile : string;
  i,
  iTestCases: Integer;
  strmPostRequest, strmResult : TFileStream;
begin
  sFile := FTest.DataDir + 'ChainedHTTPClient.ini';
  if FileExists(sFile) then begin
    URLFile := TIniFile.Create(sFile);
    try
      // Load the number of test cases
      iTestCases :=  URLFile.ReadInteger('Global', 'TestCases', 0);
      for i := 1 to iTestCases do begin
        // Read the current test case
        sTest := 'Test' + IntToStr(i);
        LIOHandler := TIdIOHandlerChain.Create(nil, FChainEngine, FFiberWeaver, Self);try
          with TIdHTTP.Create(nil) do try
            IOHandler := LIOHandler;
//            Host := URLFile.ReadString(sTest, 'Host', '');
//            Port := URLFile.ReadInteger(sTest, 'Port', 80);
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
            FTest.Status('Testing Test' + IntToStr(i) + ': ' + URLFile.ReadString(sTest, 'URL', ''));
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

              strmPostRequest := TFileStream.Create(FTest.DataDir +
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
        finally
          FreeAndNil(LIOHandler);
        end;
      end;
    finally
      URLFile.Free;
    end;
  end;
end;

procedure TdmodChainedHTTPClient.ChainedHTTPClientIOCPTest( Sender: TBXBubble);
var
  LChainEngine: TIdChainEngine;
  LFiberWeaver: TIdFiberWeaverDefault;
  LFiber: THTTPFiber;
  LSelfFiber: TIdConvertedFiber;
begin
  with ChainedHTTPClientIOCP do begin
    LChainEngine := TIdChainEngine.Create(nil); try
      LSelfFiber := TIdConvertedFiber.Create; try
        LFiberWeaver := TIdFiberWeaverDefault.Create(nil); try
          LFiber := THTTPFiber.Create(LSelfFiber, LFiberWeaver);
          with LFiber do begin
            FChainEngine := LChainEngine;
            FFiberWeaver := LFiberWeaver;
            FTest := ChainedHTTPClientIOCP;
          end;
          LFiberWeaver.ProcessInThisFiber(LSelfFiber);
          LFiber.Free;
        finally FreeAndNil(LFiberWeaver); end;
      finally FreeAndNil(LSelfFiber); end;
    finally FreeAndNil(LChainEngine); end;
  end;
end;

end.
