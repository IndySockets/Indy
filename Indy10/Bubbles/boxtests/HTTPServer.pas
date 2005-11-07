{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11261: HTTPServer.pas 
{
    Rev 1.3    6/18/2003 11:58:34 PM  BGooijen
  uses ResponseInfo.ServeFile now
}
{
    Rev 1.2    6/18/2003 7:37:20 PM  BGooijen
  Works now
}
{
    Rev 1.1    4/4/2003 7:43:46 PM  BGooijen
  compile again
}
{
{   Rev 1.0    11/12/2002 09:18:44 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit HTTPServer;

interface
uses
  IndyBox,
  Classes,
  IdGlobal,
  IdCustomHTTPServer, IdHTTPServer,IdContext,
  IdTCPServer;

type
  THTTPServer = class(TIndyBox)
  protected
    FMIMEType : TIdMIMETable;
    FUseAuthenticaiton : Boolean;
    FManageSessions : Boolean;
    function GetMIMEType(sFile: String): String;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure HTTPServerCommandGet(AContext:TIdContext;
      RequestInfo: TIdHTTPRequestInfo; ResponseInfo: TIdHTTPResponseInfo);
    procedure Test; override;
  end;

implementation
uses IdHTTP,
     IdCoreGlobal,
     SysUtils{$IFDEF VER130},FileCtrl{$ENDIF};

const
  sauthenticationrealm = 'Indy http server demo';
{ THTTPServer }

constructor THTTPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
   FMIMEType := TIdMIMETable.Create(True);
end;

destructor THTTPServer.Destroy;
begin
  FMIMEType.Free;
  inherited Destroy;
end;

function THTTPServer.GetMIMEType(sFile: String): String;
begin
  Result := FMIMEType.GetFileMIMEType(sFile)
end;

procedure THTTPServer.HTTPServerCommandGet(AContext:TIdContext;
  RequestInfo: TIdHTTPRequestInfo; ResponseInfo: TIdHTTPResponseInfo);

  procedure AuthFailed;
  begin
    ResponseInfo.ContentText := '<html><head><title>Error</title></head><body><h1>Authentication failed</h1>'#13 +
      'Check the demo source code to discover the password:<br><ul><li>Search for <b>AuthUsername</b> in <b>Main.pas</b>!</ul></body></html>';
    ResponseInfo.AuthRealm := sauthenticationrealm;
  end;

  procedure AccessDenied;
  begin
    ResponseInfo.ContentText := '<html><head><title>Error</title></head><body><h1>Access denied</h1>'#13 +
      'You do not have sufficient priviligies to access this document.</body></html>';
    ResponseInfo.ResponseNo := 403;
  end;

var
  LocalDoc: string;
  ResultFile: TFileStream;
begin
  if FUseAuthenticaiton and
     ((RequestInfo.AuthUsername <> 'Indy') or (RequestInfo.AuthPassword <> 'rocks')) then
  begin
    AuthFailed;
    exit;
  end;
  // Interprete the command to it's final path (avoid sending files in parent folders)
  LocalDoc := ExpandFilename(GetDataDir + RequestInfo.Document);
  // Default document (index.html) for folder
  if (LocalDoc[Length(LocalDoc)] = GPathDelim) and DirectoryExists(LocalDoc) then begin
    LocalDoc := ExpandFileName(LocalDoc + '/index.html');
  end;

  {if not FileExists(LocalDoc) and DirectoryExists(LocalDoc) and FileExists(ExpandFileName(LocalDoc + '/index.html')) then
  begin
     LocalDoc := ExpandFileName(LocalDoc + '/index.html');
  end;}
  if FileExists(LocalDoc) then // File exists
    begin
      if AnsiSameText(Copy(LocalDoc, 1, Length(GetDataDir)), ExtractFilePath(GetDataDir)) then // File down in dir structure
      begin
        if AnsiSameText(RequestInfo.Command, 'HEAD') then
        begin
          // HEAD request, don't send the document but still send back it's size
          ResultFile := TFileStream.create(LocalDoc, fmOpenRead	or fmShareDenyWrite);
          try
            ResponseInfo.ResponseNo := 200;
            ResponseInfo.ContentType := GetMIMEType(LocalDoc);
            ResponseInfo.ContentLength := ResultFile.Size;
          finally
            ResultFile.Free; // We must free this file since it won't be done by the web server component
          end;
        end
        else
        begin
          // Normal document request
          // Send the document back
          ResponseInfo.ResponseNo := 200;
          ResponseInfo.ContentType := GetMIMEType(LocalDoc);
          ResponseInfo.ServeFile(AContext, LocalDoc);
        end;
      end
      else
        AccessDenied;
    end
    else
    begin
      ResponseInfo.ResponseNo := 404; // Not found
      ResponseInfo.ContentText := '<html><head><title>Error</title></head><body><h1>' + ResponseInfo.ResponseText + '</h1></body></html>';
    end;
end;


procedure THTTPServer.Test;
var HClient : TIdHTTP;
    HServer : TIdHTTPServer;
    Results : TStream;
begin
  HClient := TIdHTTP.Create(nil);
  try
    HServer := TIdHTTPServer.Create(nil);
    try
      HServer.OnCommandGet := HTTPServerCommandGet;
      HServer.Active := True;
      Results := TMemoryStream.Create;
      try
        Status('Running PDF file test on 99-BG-1518.pdf with no authorization required');
        HClient.Get('http://127.0.0.1/99-BG-1518.pdf',Results);
        if Results.Size <> FileSizeByName(GetDataDir + '99-BG-1518.pdf') then
        begin
          Status('File size of received data not the same as the file size');
        end
        else
        begin
          Status('All bytes in file were sent');
        end;
        if (HClient.Response.ContentType <> 'application/pdf') then
        begin
          Status( 'Content Type should have been application/pdf' );
        end
        else
        begin
          Status('Content Type is correct');
        end;
      finally
        FreeAndNil(Results);
      end;
      FUseAuthenticaiton := True;
      Results := TMemoryStream.Create;
      try
        Status('Running PDF file test on 99-BG-1518.pdf with authorization required');
        HClient.Request.BasicAuthentication := True;
        HClient.Request.Username := 'Indy';
        HClient.Request.Password := 'rocks';
        HClient.Get('http://127.0.0.1/99-BG-1518.pdf',Results);
        if Results.Size <> FileSizeByName(GetDataDir + '99-BG-1518.pdf') then
        begin
          Status('File size of received data not the same as the file size');
        end
        else
        begin
          Status('All bytes in file were sent');
        end;
        if (HClient.Response.ContentType <> 'application/pdf') then
        begin
          Status( 'Content Type should have been application/pdf' );
        end
        else
        begin
          Status('Content Type is correct');
        end;
      finally
        FreeAndNil(Results);
      end;
    finally
      FreeAndNil(HServer);
    end;
  finally
    FreeAndNil(HClient);
  end;
end;

initialization
  TIndyBox.RegisterBox(THTTPServer, 'HTTP Server', 'Servers');
end.
 
