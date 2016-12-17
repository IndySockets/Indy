program elizaweb;
{$ifdef fpc}
  {$mode delphi}{$H+}
{$endif}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}

  Classes,   
  ezBillClinton,
  ezPersonality,
  ezEliza,
  ezEngine,
  ezMSTechSupport,
  IdBaseComponent, 
  IdComponent, 
  IdTCPServer, 
  IdCustomHTTPServer,
  IdHTTPServer, IdContext, IdCustomTCPServer, IdSocketHandle, SysUtils;

type
  TElizaWebProg = class(TObject)
  protected
    IdHTTPServer1: TIdHTTPServer;
    FHTMLDir: string;
    FTemplate: string;
    //
    procedure Ask(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    procedure IdHTTPServer1SessionStart(Sender: TIdHTTPSession);
    procedure IdHTTPServer1SessionEnd(Sender: TIdHTTPSession);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
  public
   constructor Create;
   destructor Destroy; override;
  end;

constructor TElizaWebProg.Create;
var b : TIdSocketHandle;
begin
  inherited Create;
  idhttpserver1 := TIdHTTPServer.Create;
    b:=idhttpserver1.Bindings.Add;
  b.IP:='127.0.0.1';
  b.port:=8000;
  idhttpserver1.DefaultPort := 25000;
  idhttpserver1.AutoStartSession := True;
  idhttpserver1.ServerSoftware := 'Eliza Web';
  idhttpserver1.SessionTimeOut := 600000;
  idhttpserver1.OnSessionStart := IdHTTPServer1SessionStart;
  idhttpserver1.OnSessionEnd := IdHTTPServer1SessionEnd;
  idhttpserver1.OnCommandGet := IdHTTPServer1CommandGet;
  idhttpserver1.SessionState := True;
  idhttpserver1.active:=true;
  FHTMLDir := ExtractFilePath(ParamStr(0)) + 'HTML';
  with TFileStream.Create(includetrailingpathdelimiter(FHTMLDir)+ 'eliza.html',   fmOpenRead) do try
    SetLength(FTemplate, Size);
    ReadBuffer(FTemplate[1], Size);
  finally Free; end;
end;

destructor TElizaWebProg.Destroy;
begin
  FreeAndNil(idhttpserver1);
  inherited Destroy;
end;
procedure TElizaWebProg.IdHTTPServer1SessionStart(Sender: TIdHTTPSession);
begin
  Sender.Content.AddObject('Eliza', TEZEngine.Create(nil));
end;

procedure TElizaWebProg.IdHTTPServer1SessionEnd(Sender: TIdHTTPSession);
begin
  TEZEngine(Sender.Content.Objects[0]).Free;
end;

procedure TElizaWebProg.IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
var
  LFilename: string;
  LPathname: string;
begin
  LFilename := ARequestInfo.Document;
  if AnsiSameText(LFilename, '/eliza.html') then begin
    Ask(ARequestInfo, AResponseInfo);
  end else begin
    if LFilename = '/' then begin
      LFilename := '/index.html';
    end;
    LPathname := FHTMLDir + LFilename;
    if FileExists(LPathname) then begin
      AResponseInfo.ContentStream := TFileStream.Create(LPathname, fmOpenRead + fmShareDenyWrite);
    end else begin
      AResponseInfo.ResponseNo := 404;
      AResponseInfo.ContentText := 'The requested URL ' + ARequestInfo.Document
       + ' was not found on this server.';
    end;
  end;
end;

procedure TElizaWebProg.Ask(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  s: string;
  LEliza: TEZEngine;
  LPersonality: string;
  LResponse: string;
  LSound: string;
  LQuestion: string;
begin
  LResponse := '';
  LEliza := TEZEngine(ARequestInfo.Session.Content.Objects[0]);
  LPersonality := Trim(ARequestInfo.Params.Values['Personality']);
  if LPersonality <> '' then begin
    LEliza.SetPersonality(LPersonality);
  end else begin
    LQuestion := Trim(ARequestInfo.Params.Values['Thought']);
    if LQuestion <> '' then begin
      LResponse := LEliza.TalkTo(LQuestion, LSound);
    end;
  end;
  if LEliza.Done then begin
    AResponseInfo.ContentText := LResponse;
  end else begin
    s := FTemplate;
    s := StringReplace(s, '{%RESPONSE%}', LResponse, []);
    if LSound <> '' then begin
      // I cannot distibute the wav files, they are from a commercial game, but I use
      // them when showing the demo live.
      if FileExists(FHTMLDir + '\' + LSound) then begin
        LSound := '<BGSOUND SRC=' + LSound + '.wav>';
      end else begin
        LSound := '';
      end;
    end;
    s := StringReplace(s, '{%SOUND%}', LSound, []);
    AResponseInfo.ContentText := s;
  end;
end;

var GProg : TElizaWebProg;
begin
  GProg := TElizaWebProg.Create;
  try
    WriteLn('Eliza Demo now available at:');
    WriteLn('');
    WriteLn('http://127.0.0.1:8000/');
    WriteLn('');
    WriteLn('Press enter when finished');
    ReadLn;
  finally
   FreeAndNil(GProg);
  end;
end.
