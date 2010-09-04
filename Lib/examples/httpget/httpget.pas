program httpget;

{$mode objfpc}{$H+}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  prothandler,
  ftpprothandler,
  httpprothandler,
  Classes
  { add your units here },
  IdGlobal, //for some helper functions I like
  IdURI,
  SysUtils;

procedure PrintHelpScreen;
var LExe : String;
begin
  LExe := ExtractFileName(ParamStr(0));
  WriteLn(LExe);
  WriteLn('');
  WriteLn('usage: '+LExe+' [-v] URL');
  WriteLn('');
  WriteLn('  v : Verbose');
end;

var
  GURL : TIdURI;

  i : Integer;
  LP : TProtHandler;

//program defaults
   GVerbose : Boolean;
   GHelpScreen : Boolean;
   GFTPPort : boolean;

const
   GCmdOpts : array [0..5] of string=('-h','--help','-v','--verbose','-P','--port');
begin
  GFTPPort := False;
  GHelpScreen := False;
  GVerbose := False;
  LP := nil;
  GURL := TIdURI.Create;
  try
    if ParamCount > 0 then
    begin
      for i := 1 to ParamCount do
      begin
        if Copy(ParamStr(i),1,1) = '-' then
        begin
          WriteLn(ParamStr(i));
          case PosInStrArray(ParamStr(i),GCmdOpts) of
            0, 1 : begin
                     GHelpScreen := True;
                     break;
                   end;
            2, 3 : GVerbose := True;
            4, 5 : GFTPPort := True;
          end;
        end
        else
        begin

            GURL.URI := ParamStr(i);
        end;
      end;

    end
    else
    begin
      GHelpScreen := True;
    end;
    WriteLn(GURL.URI);
    if (GURL.URI = '') or GHelpScreen then
    begin
      GHelpScreen := True;
    end
    else
    begin
      try
        if THTTPProtHandler.CanHandleURL(GURL) then
        begin
          LP := THTTPProtHandler.Create;
          LP.Verbose := GVerbose;
          LP.GetFile(GURL);
        end
        else
        begin
          if TFTPProtHandler.CanHandleURL(GURL) then
          begin
            LP := TFTPProtHandler.Create;
            LP.Verbose := GVerbose;
            TFTPProtHandler(LP).Port := GFTPPort;
            LP.GetFile(GURL);
          end;
        end;
      finally
        FreeAndNil(LP);
      end;
    end;
  finally
    FreeAndNil(GURL);
  end;
  if GHelpScreen then
  begin
    PrintHelpScreen;
  end;
end.



