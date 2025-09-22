unit ftpprothandler;
{$IFDEF FPC}
{$mode delphi}{$H+}
{$ENDIF}
interface
uses
  {$IFNDEF NO_FTP}
    IdFTP,
  IdFTPList, //for some diffinitions with FTP list
  IdAllFTPListParsers, //with FTP, this links in all list parsing classes.
  IdFTPListParseTandemGuardian, //needed ref. to TIdTandemGuardianFTPListItem property
  IdFTPListTypes, //needed for ref. to TIdUnixBaseFTPListItem property
  IdFTPListParseVMS, //needed for ref. to TIdVMSFTPListItem property ;
    IdIOHandler,
    IdTCPConnection,
  IdIOHandlerStack,
    {$ifdef usezlib}
    IdCompressorZLib,  //for deflate FTP support
    {$endif}
  IdLogEvent, //for logging component
  {$ENDIF}
  prothandler,
  Classes, SysUtils, IdURI;

{$IFDEF VER200}
 {$DEFINE STRING_IS_UNICODE} // 'String' type is Unicode now
{$ENDIF}
{$IFDEF VER210}
 {$DEFINE STRING_IS_UNICODE} // 'String' type is Unicode now
{$ENDIF}
{$IFDEF VER220}
 {$DEFINE STRING_IS_UNICODE} // 'String' type is Unicode now
{$ENDIF}

type
  TFTPProtHandler = class(TProtHandler)
  protected
    FPort : Boolean;
  {$IFNDEF NO_FTP}
    procedure OnSent(ASender: TComponent; const AText: string; const AData: string);
    procedure OnReceived(ASender: TComponent; const AText: string; const AData: string);
    procedure MakeHTMLDirTable(AURL : TIdURI; AFTP : TIdFTP);
    procedure OnDataChannelCreating(ASender: TObject; ADataChannel: TIdTCPConnection);
    procedure OnDataChannelDestroy(ASender: TObject; ADataChannel: TIdTCPConnection);
    procedure OnDirParseStart(ASender : TObject);
    procedure OnDirParseEnd(ASender : TObject);
  {$ENDIF}
  public
     class function CanHandleURL(AURL : TIdURI) : Boolean; override;
    procedure GetFile(AURL : TIdURI); override;
   constructor Create;
   property Port : Boolean read FPort write FPort;
  end;

implementation
uses IdGlobal;

class function TFTPProtHandler.CanHandleURL(AURL : TIdURI) : Boolean;
begin
  {$IFDEF NO_FTP}
  Result := False;
  {$ELSE}
  Result := UpperCase(AURL.Protocol)='FTP';
  {$ENDIF}
end;

constructor TFTPProtHandler.Create;
begin
  inherited Create;
  FPort := False;
end;

procedure TFTPProtHandler.GetFile(AURL : TIdURI); 
  {$IFDEF NO_FTP}
begin
  {$ELSE}
//In this procedure, URL handling has to be done manually because the
//the FTP component does not handle URL's at all.
var
  LStr : TMemoryStream;
  LIO : TIdIOHandlerStack;
  LF : TIdFTP;
  LDI : TIdLogEvent;
 {$ifdef usezlib}
 LC : TIdCompressorZLib;
 {$endif}
  LIsDir : Boolean;
  i : Integer;
begin
  LIsDir := False;
  LDI := TIdLogEvent.Create;

  LF := TIdFTP.Create;
  
  {$ifdef  usezlib}
  LC := TIdCompressorZLib.Create;
  if LC.IsReady then begin
    LF.Compressor := LC;
  end;
  {$endif}
  try
    LDI.Active := True;
    LDI.LogTime := False;
    LDI.ReplaceCRLF := False;
    LDI.OnReceived := OnReceived;
    LDI.OnSent := OnSent;
    LIO := TIdIOHandlerStack.Create;
    LIO.Intercept := LDI;
    LF.IOHandler := LIO;
    LF.Passive := not FPort;
    LF.UseMLIS := True;

    LF.Host := AURL.Host;
    LF.Password := AURL.URLDecode(AURL.Password);
    LF.Username := AURL.URLDecode(AURL.Username);
    LF.IPVersion := AURL.IPVersion;
	LF.Password := AURL.Password;;
	if LF.Username = '' then
    begin
      LF.Username := 'anonymous';
      LF.Password := 'pass@httpget';
    end;
    if AURL.Document = '' then
    begin
      LIsDir := True;
    end;
    LStr := TMemoryStream.Create;
    if FVerbose  then begin
      LF.OnDataChannelCreate := OnDataChannelCreating;
      LF.OnDataChannelDestroy := OnDataChannelDestroy;
      LF.OnDirParseStart := OnDirParseStart;
      LF.OnDirParseEnd := OnDirParseEnd;
    end;
    LF.Connect;
    try
      LF.ChangeDir(AURL.Path);
      //The thing is you can't always know if it's a file or dir.
      if not LIsDir then
      try
        LF.Get(AURL.Document,LStr,True);
        LStr.SaveToFile(AURL.Document);
      except
        LIsDir := True;
      end;
      if LIsDir then
      begin
        LF.List;
        if FVerbose then
        begin
          for i := 0 to LF.ListResult.Count -1 do
          begin
            WriteLn({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},LF.ListResult[i]);
          end;
        end;
        MakeHTMLDirTable(AURL,LF);
      end;
    finally
      LF.Disconnect;
      FreeAndNil(LStr);
    end;
  finally
    FreeAndNil(LF);
    {$ifdef  usezlib}
    FreeAndNil(LC);
    {$endif}
    FreeAndNil(LIO);
    FreeAndNil(LDI);
  end;
{$ENDIF}
end;

{$IFNDEF NO_FTP}
procedure TFTPProtHandler.MakeHTMLDirTable(AURL : TIdURI; AFTP : TIdFTP);
{
This routine is in this demo to show users how to use the directory listing from TIdFTP.
}
var i : integer;
  LTbl : TStringList;
  LTmp : String;

  procedure WriteTableCell(const ACellText : String; AOutput : TStrings);
  begin
    if ACellText = '' then
    begin
      AOutput.Add('          <TD>&nbsp;</TD>');
    end
    else
    begin
      AOutput.Add('          <TD>'+ACellText+'</TD>');
    end;
  end;

  procedure MakeFileNameLink(const AURL :TIdURI; AFileName : String; AOutput : TStrings);
  begin
    if AURL.URI <>'' then
    begin
      if AURL.Document = '' then
      begin
        AOutput.Add('          <TD><A HREF="'+AURL.URI+'/'+AFileName+'">'+AFileName+'</A></TD>');
      end
      else
      begin
        AOutput.Add('          <TD><A HREF="'+AURL.URI +AFileName+'>'+AFileName+'</A></TD>');
      end;
    end
    else
    begin
      WriteTableCell(AFileName,AOutput);
    end;
  end;

begin
  LTbl := TStringList.Create;
  try
    LTbl.Add('<HTML>');
    LTbl.Add('  <TITLE>'+AURL.URI+'</TITLE>');
    {$IFDEF STRING_IS_UNICODE}
	LTbl.Add('  <HEAD>');
	LTbl.Add('    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" >');
	LTbl.Add('  </HEAD>');
	{$ENDIF}
    LTbl.Add('  <BODY>');
    LTbl.Add('     <TABLE>');
    LTbl.Add('       <TR>');
    LTbl.Add('         <TH>Name</TH>');
    LTbl.Add('         <TH>Type</TH>');
    LTbl.Add('         <TH>Size</TH>');
    LTbl.Add('         <TH>Date</TH>');
    LTbl.Add('         <TH>Permissions</TH>');
    LTbl.Add('         <TH>Owner</TH>');
    LTbl.Add('         <TH>Group</TH>');
    LTbl.Add('       </TR>');
    for i := 0 to AFTP.DirectoryListing.Count - 1 do
    begin
      LTbl.Add('       <TR>');
      //we want the name hyperlinked to it's location so a user can click on it in a browser
      //to retreive a file.
      MakeFileNameLink(AURL,AFTP.DirectoryListing[i].FileName,LTbl);
      case AFTP.DirectoryListing[i].ItemType of
        ditDirectory : LTmp := 'Directory';
        ditFile : LTmp := 'File';
        ditSymbolicLink, ditSymbolicLinkDir : LTmp := 'Symbolic link';
        ditBlockDev : LTmp := 'Block Device';
        ditCharDev : LTmp := 'Char Device';
        ditFIFO : LTmp := 'Pipe';
        ditSocket : LTmp := 'Socket';
      end;
      WriteTableCell(LTmp,LTbl);
      //Some dir formats will not return a file size or will only do so in some cases.
      if AFTP.DirectoryListing[i].SizeAvail then
      begin
        WriteTableCell(IntToStr(AFTP.DirectoryListing[i].Size),LTbl);
      end
      else
      begin
        WriteTableCell('',LTbl);
      end;
      //Some dir formats will not return a file date or will only do so in some cases.
      if AFTP.DirectoryListing[i].ModifiedAvail then
      begin
        WriteTableCell(DateTimeToStr(AFTP.DirectoryListing[i].Size),LTbl);
      end
      else
      begin
        WriteTableCell('',LTbl);
      end;
      WriteTableCell(AFTP.DirectoryListing[i].PermissionDisplay,LTbl);
      //get owner name
      if AFTP.DirectoryListing[i] is TIdOwnerFTPListItem then
      begin
        WriteTableCell(TIdOwnerFTPListItem(AFTP.DirectoryListing[i]).OwnerName,LTbl);
      end
      else
      begin
        WriteTableCell('',LTbl);
      end;
      //now get group name
      if AFTP.DirectoryListing[i] is TIdTandemGuardianFTPListItem then
      begin
        WriteTableCell(TIdTandemGuardianFTPListItem(AFTP.DirectoryListing[i]).GroupName,LTbl); 
      end;
      if AFTP.DirectoryListing[i] is TIdUnixBaseFTPListItem then
      begin
         WriteTableCell(TIdUnixBaseFTPListItem(AFTP.DirectoryListing[i]).GroupName,LTbl); 
      end;
      if AFTP.DirectoryListing[i] is TIdVMSFTPListItem then
      begin
         WriteTableCell(TIdVMSFTPListItem(AFTP.DirectoryListing[i]).GroupName,LTbl);
      end;
      LTbl.Add('       </TR>');
    end;
    LTbl.Add('     </TABLE>');
    LTbl.Add('  </BODY>');
    LTbl.Add('</HTML>');
	{$IFDEF STRING_IS_UNICODE}
	LTbl.SaveToFile('index.html', TEncoding.UTF8)
	{$ELSE}
    LTbl.SaveToFile('index.html');
	{$ENDIF}
  finally
    FreeAndNil(LTbl);
  end;
end;

procedure TFTPProtHandler.OnSent(ASender: TComponent; const AText: string; const AData: string);
var LData : String;
begin
  LData := AData;
  if TextStartsWith(LData,'PASS ') then begin
    FLogData.Text := FLogData.Text + 'PASS ****';
  end;
  FLogData.Text := FLogData.Text + LData;
  if FVerbose then begin
      Write({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},LData);
  end;
end;

procedure TFTPProtHandler.OnDataChannelCreating(ASender: TObject;
  ADataChannel: TIdTCPConnection);
begin
  WriteLn({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},'Opening Data Channel');
end;

procedure TFTPProtHandler.OnDataChannelDestroy(ASender: TObject;
  ADataChannel: TIdTCPConnection);
begin
   WriteLn({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},'Closing Data Channel');
end;

procedure TFTPProtHandler.OnDirParseEnd(ASender: TObject);
begin
  WriteLn({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},'DIR Parsing finished');
end;

procedure TFTPProtHandler.OnDirParseStart(ASender: TObject);
begin
  WriteLn('Dir Parsing Started');
end;

procedure TFTPProtHandler.OnReceived(ASender: TComponent; const AText: string; const AData: string);
begin
   FLogData.Text := FLogData.Text + AData;
  if FVerbose then
  begin
    Write({$IFDEF FPC}stdout{$ELSE}output{$ENDIF},AData);
  end;
end;

{$ENDIF}

end.
