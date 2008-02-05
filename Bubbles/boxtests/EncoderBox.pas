{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  23934: EncoderBox.pas
{
{   Rev 1.1    04/10/2003 15:22:18  CCostelloe
{ Emails generated now have the same date
}
{
{   Rev 1.0    26/09/2003 00:04:08  CCostelloe
{ Initial
}
unit EncoderBox;

interface

{$I IdCompilerDefines.inc}

uses
  IndyBox,
  Classes,
  IdComponent, IdGlobal, IdSocketHandle, IdIntercept, IdMessage, IdMessageClient,
  SysUtils;

type
  TEncoderBox = class(TIndyBox)
  protected
    FExtractPath: string;
    FMsg: TIdMessage;
    FGeneratedStream: TMemoryStream;
    FTestMessageName: string;
  public
    procedure Test; override;
    procedure TestMessage(const APathname: string; const AVerify: Boolean = False;
     const AEmit: Boolean = False);
    //
    property ExtractPath: string read FExtractPath;
    property Msg: TIdMessage read FMsg;
    property GeneratedStream: TMemoryStream read FGeneratedStream;
    property TestMessageName: string read FTestMessageName;
  end;

implementation

uses
  IdMessageCoderMIME, IdMessageCoderUUE, IdPOP3,
  IniFiles, IdText, IdAttachmentFile{$IFDEF VER130},FileCtrl{$ENDIF};

{ TEncoderBox }

procedure TEncoderBox.Test;
var
  i: integer;
  LRec: TSearchRec;
  LPathToSearch: string;
begin
  LPathToSearch := GetDataDir +  '*.ini';
  i := FindFirst(LPathToSearch, faAnyFile, LRec); try
    while i = 0 do begin
      TestMessage(GetDataDir + LRec.Name, True);
      i := FindNext(LRec);
    end;
  finally FindClose(LRec); end;
end;

procedure TEncoderBox.TestMessage(const APathname: string; const AVerify: Boolean = False;
 const AEmit: Boolean = False);
var
  IniParams: TStringList;
  CorrectStream: TFileStream;
  //GeneratedStreamToFile: TFileStream;
  i: Integer;
  sTemp: string;
  sParentPart, sContentType, sType, sEncoding, sFile: string;
  nParentPart: Integer;
  nPos: integer;
  TheTextPart: TIdText;
  {$IFDEF INDY100}
  TheAttachment: TIdAttachmentFile;
  {$ELSE}
  TheAttachment: TIdAttachment;
  {$ENDIF}
  sr: TSearchRec;
  FileAttrs: Integer;

  procedure CompareStream(const AStream1: TStream; const AStream2: TStream; const AMsg: string);
  //var
    //i: integer;
    //LByte1, LByte2: byte;
  begin
    Check(AStream1.Size = AStream2.Size, 'File size mismatch with ' + AMsg);
    //The following always fails for MIME because the random boundary is always different !!!
    {
    for i := 1 to AStream1.Size do begin
      AStream1.ReadBuffer(LByte1, 1);
      AStream2.ReadBuffer(LByte2, 1);
      Check(LByte1 = LByte2, 'Mismatch at byte ' + IntToStr(i) + ', '
       + AMsg);
    end;
    }
  end;

begin
  FTestMessageName := '';
  Status('Testing message ' + ExtractFilename(APathname));

  //Set up path to test directory...
  FExtractPath := ChangeFileExt(APathname, '') + GPathSep;
  ForceDirectories(ExtractPath);
  //Set up the filename of the correct (test) message...
  FTestMessageName := ExtractPath+ChangeFileExt(ExtractFilename(APathname), '.msg');

  //If it is Emit, make sure we will be able to delete the message...
  FileAttrs := 0; //Stop compiler whining it might not have been initialized
  if AEmit then begin
    if FindFirst(FTestMessageName, FileAttrs, sr) = 0 then begin
      if (sr.Attr and faReadOnly) = faReadOnly then begin
        raise EBXCheck.Create('The reference file exists and is read-only, Emit not valid: '+FTestMessageName);
      end;
      FindClose(sr);
    end;
  end;

  FMsg := TIdMessage.Create(Self);
  //Read in the INI settings that define the email we are to generate...
  IniParams := TStringList.Create;
  IniParams.LoadFromFile(APathname);
  //Make sure the date will always be the same, else get different
  //outputs for the Date header...
  FMsg.UseNowForDate := False;
  FMsg.Date := EncodeDate(2011, 11, 11);
  i := 0;
  while IniParams.Values['Body'+IntToStr(i)] <> '' do begin
    FMsg.Body.Add(IniParams.Values['Body'+IntToStr(i)]);
    Inc(i);
  end;
  FMsg.ContentTransferEncoding := IniParams.Values['ContentTransferEncoding'];
  if IniParams.Values['ConvertPreamble'] = 'True' then begin
    FMsg.ConvertPreamble := True;
  end else if IniParams.Values['ConvertPreamble'] = 'False' then begin
    FMsg.ConvertPreamble := False;
  end;
  if IniParams.Values['Encoding'] = 'meMIME' then begin
    FMsg.Encoding := meMIME;
  end else if IniParams.Values['Encoding'] = 'meUU' then begin
    FMsg.Encoding := meUU;
  end else if IniParams.Values['Encoding'] = 'meXX' then begin
    FMsg.Encoding := meXX;
  end;
  if IniParams.Values['ContentType'] <> '' then begin
    FMsg.ContentType := IniParams.Values['ContentType'];
  end;
  i := 0;
  while IniParams.Values['Part'+IntToStr(i)] <> '' do begin
    sTemp := IniParams.Values['Part'+IntToStr(i)];
    nPos := Pos(',', sTemp);
    sType := Copy(sTemp, 1, nPos-1);
    sTemp := Copy(sTemp, nPos+1, MAXINT);
    nPos := Pos(',', sTemp);
    sEncoding := Copy(sTemp, 1, nPos-1);
    sFile := Copy(sTemp, nPos+1, MAXINT);
    nParentPart := -999;
    nPos := Pos(',', sFile);
    if nPos > 0 then begin  //ParentPart, ContentType optional
        sTemp := Copy(sFile, nPos+1, MAXINT);
        sFile := Copy(sFile, 1, nPos-1);
        nPos := Pos(',', sTemp);
        sContentType := Copy(sTemp, nPos+1, MAXINT);
        sParentPart := Copy(sTemp, 1, nPos-1);
        nParentPart := StrToInt(sParentPart);
    end;
    if sType = 'TIdText' then begin
        TheTextPart := TIdText.Create(FMsg.MessageParts);
        TheTextPart.Body.LoadFromFile(sFile);
        if sEncoding <> 'Default' then TheTextPart.ContentTransfer := sEncoding;
        if ((sContentType <> '') and (sContentType <> 'Default')) then TheTextPart.ContentType := sContentType;
        {$IFDEF INDY100}
        if nParentPart <> -999 then TheTextPart.ParentPart := nParentPart;
        {$ENDIF}
    end else begin
        {$IFDEF INDY100}
        TheAttachment := TIdAttachmentFile.Create(FMsg.MessageParts, sFile);
        {$ELSE}
        TheAttachment := TIdAttachment.Create(FMsg.MessageParts, sFile);
        {$ENDIF}
        if sEncoding <> 'Default' then TheAttachment.ContentTransfer := sEncoding;
        if ((sContentType <> '') and (sContentType <> 'Default')) then TheAttachment.ContentType := sContentType;
        {$IFDEF INDY100}
        if nParentPart <> -999 then TheAttachment.ParentPart := nParentPart;
        {$ENDIF}
    end;
    Inc(i);
  end;
  //Do the test...
  FGeneratedStream := TMemoryStream.Create;
  FMsg.SaveToStream(FGeneratedStream);
  //Compare the results...
  try
    if AEmit then begin
      GeneratedStream.Seek(0, soFromBeginning);
      GeneratedStream.SaveToFile(TestMessageName);
    end else if AVerify then begin
      Check(FileExists(TestMessageName) = True, 'Missing correct result file '+TestMessageName);
      CorrectStream := TFileStream.Create(TestMessageName, fmOpenRead);
      GeneratedStream.Seek(0, soFromBeginning);
      CompareStream(GeneratedStream, CorrectStream, ExtractFilename(APathname));
    end;
  finally FreeAndNil(CorrectStream); end;
  Status('Message encoded.');
end;

initialization
  TIndyBox.RegisterBox(TEncoderBox, 'Emails', 'Encoders');
end.
