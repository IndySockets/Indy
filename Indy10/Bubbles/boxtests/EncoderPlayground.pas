{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  23936: EncoderPlayground.pas
{
{   Rev 1.1    04/10/2003 15:22:50  CCostelloe
{ Emails generated now have the same date
}
{
{   Rev 1.0    26/09/2003 00:04:08  CCostelloe
{ Initial
}
unit EncoderPlayground;

interface

{$I IdCompilerDefines.inc}

uses
  EncoderBox,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ActnList, ImgList, ToolWin, ExtCtrls, StdCtrls,
  BXBubble,
  IdMessage, Spin;

type
  TformEncoderPlayground = class(TForm)
    lboxMessages: TListBox;
    Splitter1: TSplitter;
    alstMain: TActionList;
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    actnFile_Exit: TAction;
    actnTest_Test: TAction;
    File1: TMenuItem;
    actnFileTest1: TMenuItem;
    Exit1: TMenuItem;
    ToolButton1: TToolButton;
    Panel2: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    lablFilename: TLabel;
    actnTest_Emit: TAction;
    Exit2: TMenuItem;
    Emit1: TMenuItem;
    Emit2: TMenuItem;
    actnTest_Verify: TAction;
    estandVerify1: TMenuItem;
    estandVerify2: TMenuItem;
    eset1: TMenuItem;
    Label4: TLabel;
    lablErrors: TLabel;
    N1: TMenuItem;
    actnTest_VerifyAll: TAction;
    VerifyAll1: TMenuItem;
    bublEncoderPlayground: TBXBubble;
    Label5: TLabel;
    pctlMessage: TPageControl;
    TabSheet1: TTabSheet;
    memoRaw: TMemo;
    Panel3: TPanel;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox2: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    Label10: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    OpenDialog1: TOpenDialog;
    Label11: TLabel;
    ComboBox3: TComboBox;
    Button4: TButton;
    Label12: TLabel;
    ComboBox4: TComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button5: TButton;
    Button1: TButton;
    TabSheet2: TTabSheet;
    memoCorrect: TMemo;
    Label13: TLabel;
    Edit2: TEdit;
    Bevel3: TBevel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label14: TLabel;
    ComboBox5: TComboBox;
    SpinEdit1: TSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    Edit3: TEdit;
    procedure actnFile_ExitExecute(Sender: TObject);
    procedure actnTest_TestExecute(Sender: TObject);
    procedure alstMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lboxMessagesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actnTest_VerifyAllExecute(Sender: TObject);
    procedure bublEncoderPlaygroundPlayground(Sender: TBXBubble);
    procedure Button4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
  protected
    FDataPath: string;
    FEncoderBox: TEncoderBox;
  public
    TheMsg: TIdMessage;
    procedure ResetFieldsToDefaults;
    procedure SetupEmail;
  end;

var
  formEncoderPlayground: TformEncoderPlayground;

implementation
{$R *.dfm}

uses
  IdGlobal, IdText, IdAttachmentFile,
  IdCoreGlobal, EmailSender;

const
  EncoderBody = 'This is the text for the sample body.' + EOL + 'This is a deliberately long line, and the reason it is a long line is that it should test whether the encoder breaks and reassembles it properly since it is longer than any line length I can think of.' + EOL;

procedure TformEncoderPlayground.actnFile_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TformEncoderPlayground.actnTest_TestExecute(Sender: TObject);
var
  LFilename: string;
begin
  LFilename := '';
  Screen.Cursor := crHourglass; try
    try
      if Assigned(FEncoderBox) then begin
        FreeAndNil(FEncoderBox);
      end;
      lablErrors.Caption := '';
      LFilename := Copy(lboxMessages.Items[lboxMessages.ItemIndex], 3, MaxInt);
      FEncoderBox := TEncoderBox.Create(Self);
      with FEncoderBox do begin
        TestMessage(FDataPath + LFilename, Sender = actnTest_Verify, Sender = actnTest_Emit);
        lablFilename.Caption := LFilename;
        lablErrors.Caption := '<None>';
        //Load generated message into raw message...
        GeneratedStream.Seek(0, soFromBeginning);
        memoRaw.Lines.LoadFromStream(GeneratedStream);
        //Load what the correct result is into memoCorrect...
        memoCorrect.Lines.LoadFromFile(TestMessageName);
      end;
      lboxMessages.Items[lboxMessages.ItemIndex] := '+'
       + Copy(lboxMessages.Items[lboxMessages.ItemIndex], 2, MaxInt);
    except
      on E: Exception do begin
        lablFilename.Caption := LFilename;
        lablErrors.Caption := E.Message;
        lboxMessages.Items[lboxMessages.ItemIndex] := '-'
         + Copy(lboxMessages.Items[lboxMessages.ItemIndex], 2, MaxInt);
        memoCorrect.Clear;
        if FEncoderBox.TestMessageName <> '' then memoCorrect.Lines.LoadFromFile(FEncoderBox.TestMessageName);
        memoRaw.Clear;
        if Assigned(FEncoderBox.GeneratedStream) then memoRaw.Lines.LoadFromStream(FEncoderBox.GeneratedStream);
      end;
    end;
  finally Screen.Cursor := crDefault; end;
end;

procedure TformEncoderPlayground.alstMainUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actnTest_Test.Enabled := lboxMessages.ItemIndex > -1;
  Handled := True;
end;

procedure TformEncoderPlayground.lboxMessagesDblClick(Sender: TObject);
begin
  // Here instead of linked at design because of .Enabled
  actnTest_Verify.Execute;
end;

procedure TformEncoderPlayground.FormCreate(Sender: TObject);
var
  i: integer;
  LRec: TSearchRec;
begin
  pctlMessage.ActivePage := TabSheet1;
  {CC: Don't append \ if already in AppDataDir...}
  FDataPath := bublEncoderPlayground.AppDataDir;
  if FDataPath[Length(FDataPath)] <> '\' then FDataPath := FDataPath + '\';
  FDataPath := FDataPath + 'Encoder\';
  //Find and display all the test messages...
  i := FindFirst(FDataPath + '*.ini', faAnyFile, LRec);
  try
    while i = 0 do begin
      lboxMessages.Items.Add('  ' + LRec.Name);
      i := FindNext(LRec);
    end;
  finally
    FindClose(LRec);
  end;
  //Set up the comboboxes with the options in TIdMessage...
  OpenDialog1.InitialDir := 'C:\';
  ComboBox1.Items.Add('Default');
  ComboBox1.Items.Add('base64');
  ComboBox1.Items.Add('quoted-printable');
  ComboBox2.Items.Add('Default');
  ComboBox2.Items.Add('True');
  ComboBox2.Items.Add('False');
  ComboBox3.Items.Add('Default');
  ComboBox3.Items.Add('7bit');
  ComboBox3.Items.Add('base64');
  ComboBox3.Items.Add('quoted-printable');
  ComboBox4.Items.Add('Default');
  ComboBox4.Items.Add('meMIME');
  ComboBox4.Items.Add('meUU');
  ComboBox4.Items.Add('meXX');
  ComboBox5.Items.Add('Default');
  ComboBox5.Items.Add('text/plain');
  ComboBox5.Items.Add('text/html');
  ComboBox5.Items.Add('multipart/alternative');
  ComboBox5.Items.Add('multipart/mixed');
  ResetFieldsToDefaults;
end;

procedure TformEncoderPlayground.actnTest_VerifyAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lboxMessages.Items.Count - 1 do begin
    lboxMessages.ItemIndex := i;
    actnTest_Verify.Execute;
  end;
end;

procedure TformEncoderPlayground.bublEncoderPlaygroundPlayground(Sender: TBXBubble);
begin
  ShowModal;
end;

procedure TformEncoderPlayground.Button4Click(Sender: TObject);
var
  sTemp: string;
begin
  if RadioGroup1.ItemIndex = 0 then begin
    sTemp := 'TIdAttachment,';
  end else begin
    sTemp := 'TIdText,';
  end;
  sTemp := sTemp+ComboBox3.Items[ComboBox3.ItemIndex]+','+Edit1.Text;
  sTemp := sTemp+IntToStr(SpinEdit1.Value);             //ParentPart
  sTemp := sTemp+ComboBox5.Items[ComboBox5.ItemIndex];  //ContentType
  ListBox1.Items.Add(sTemp);
end;

procedure TformEncoderPlayground.Edit1Change(Sender: TObject);
begin
    if Edit1.Text = '' then begin
        Button4.Enabled := False;
    end else begin
        Button4.Enabled := True;
    end;
end;

procedure TformEncoderPlayground.Button2Click(Sender: TObject);
begin
    if OpenDialog1.Execute = True then Edit1.Text := OpenDialog1.FileName;
end;

procedure TformEncoderPlayground.ListBox1Click(Sender: TObject);
begin
    if ListBox1.ItemIndex = -1 then begin
        Button3.Enabled := False;
    end else begin
        Button3.Enabled := True;
    end;
end;

procedure TformEncoderPlayground.Button3Click(Sender: TObject);
begin
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    Button3.Enabled := False;
end;

procedure TformEncoderPlayground.Button1Click(Sender: TObject);
var
    TempStream: TMemoryStream;
begin
    memoRaw.Clear;
    memoCorrect.Clear;
    SetupEmail;
    //Finally save it to a stream...
    TempStream := TMemoryStream.Create;
    TheMsg.SaveToStream(TempStream);
    TempStream.Seek(0, soFromBeginning);
    memoRaw.Lines.LoadFromStream(TempStream);
    Button5.Enabled := True;
end;

procedure TformEncoderPlayground.SetupEmail;
var
    i: integer;
    sTemp, sType, sEncoding, sFile, sContentType: string;
    nPos, nParentPart: integer;
    TheTextPart: TIdText;
    {$IFDEF INDY100}
    TheAttachment: TIdAttachmentFile;
    {$ELSE}
    TheAttachment: TIdAttachment;
    {$ENDIF}
begin
    //Make the message from the control values...
    if Assigned(TheMsg) then FreeAndNil(TheMsg);
    TheMsg := TIdMessage.Create(nil);
    //Make sure the date will always be the same, else get different
    //outputs for the Date header...
    TheMsg.UseNowForDate := False;
    TheMsg.Date := EncodeDate(2011, 11, 11);
    if Memo1.Text <> '' then TheMsg.Body.Text := Memo1.Text;
    if ComboBox1.Items[ComboBox1.ItemIndex] <> 'Default' then TheMsg.ContentTransferEncoding := ComboBox1.Items[ComboBox1.ItemIndex];
    if ComboBox2.Items[ComboBox2.ItemIndex] = 'True' then begin
        TheMsg.ConvertPreamble := True;
    end else if ComboBox2.Items[ComboBox2.ItemIndex] = 'False' then begin
        TheMsg.ConvertPreamble := False;
    end;
    for i := 0 to ListBox1.Items.Count-1 do begin
        sTemp := ListBox1.Items.Strings[i];
        nPos := Pos(',', sTemp);
        sType := Copy(sTemp, 1, nPos-1);
        sTemp := Copy(sTemp, nPos+1, MAXINT);
        nPos := Pos(',', sTemp);
        sEncoding := Copy(sTemp, 1, nPos-1);
        sTemp := Copy(sTemp, nPos+1, MAXINT);
        sContentType := '';
        nParentPart := -999;
        nPos := Pos(',', sTemp);
        if nPos > 0 then begin  //ParentPart+ContentType are optional
            sFile := Copy(sTemp, 1, nPos-1);
            sTemp := Copy(sTemp, nPos+1, MAXINT);
            nPos := Pos(',', sTemp);
            sContentType := Copy(sTemp, nPos+1, MAXINT);
            sTemp := Copy(sTemp, 1, nPos-1);
            nParentPart := StrToInt(sTemp);
        end else begin
            sFile := sTemp;
        end;
        if sType = 'TIdText' then begin
            TheTextPart := TIdText.Create(TheMsg.MessageParts);
            TheTextPart.Body.LoadFromFile(sFile);
            if sEncoding <> 'Default' then TheTextPart.ContentTransfer := sEncoding;
            if ((sContentType <> '') and (sContentType <> 'Default')) then TheTextPart.ContentType := sContentType;
            {$IFDEF INDY100}
            if nParentPart <> -999 then TheTextPart.ParentPart := nParentPart;
            {$ENDIF}
        end else begin
            {$IFDEF INDY100}
            TheAttachment := TIdAttachmentFile.Create(TheMsg.MessageParts, sFile);
            {$ELSE}
            TheAttachment := TIdAttachment.Create(TheMsg.MessageParts, sFile);
            {$ENDIF}
            if sEncoding <> 'Default' then TheAttachment.ContentTransfer := sEncoding;
            if ((sContentType <> '') and (sContentType <> 'Default')) then TheAttachment.ContentType := sContentType;
            {$IFDEF INDY100}
            if nParentPart <> -999 then TheAttachment.ParentPart := nParentPart;
            {$ENDIF}
        end;
    end;
    if TheMsg.Encoding <> meDefault then ShowMessage('Warning: Message encoding was not initially meDefault???');
    if ComboBox4.Items[ComboBox4.ItemIndex] = 'meMIME' then begin
        TheMsg.Encoding := meMIME;
    end else if ComboBox4.Items[ComboBox4.ItemIndex] = 'meUU' then begin
        TheMsg.Encoding := meUU;
    end else if ComboBox4.Items[ComboBox4.ItemIndex] = 'meXX' then begin
        TheMsg.Encoding := meXX;
    end;
    if Edit3.Text <> '' then begin
        TheMsg.ContentType := Edit3.Text;
    end;
end;

procedure TformEncoderPlayground.Button5Click(Sender: TObject);
var
    ExtractPath: string;
    TestName: string;
    TestIni: TStringList;
    i: Integer;
    AttachmentName, PortedAttachmentName: string;
    nPos: Integer;
    sContentType, sType, sEncoding, sParentPath, sTemp: string;
begin
    if MessageDlg('Warning: Dont add tests in this manner unless you are sure they are valid tests.  Add this test?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        //Make sure we don't have a test of this name already...
        TestName := Edit2.Text;
        if TestName = '' then begin
            ShowMessage('You must enter a test name in the edit box provided');
            Exit;
        end;
        if Pos('.', TestName) > 0 then begin
            ShowMessage('Test name may not include a period');
            Exit;
        end;
        if FileExists(FDataPath+TestName+'.ini') then begin
            ShowMessage('This test name exists already, try another.');
            Exit;
        end;
        //Create the test directory...
        ExtractPath := FDataPath + ChangeFileExt(TestName, '') + '\';
        ForceDirectories(ExtractPath);
        //Copy the generated message to it as a .msg...
        memoRaw.Lines.SaveToFile(ExtractPath+TestName+'.msg');
        //Write out the INI...
        TestIni := TStringList.Create;
        if Memo1.Text <> '' then begin
            for i := 0 to Memo1.Lines.Count-1 do begin
                TestIni.Add('Body'+IntToStr(i)+'='+Memo1.Lines[i]);
            end;
        end;
        if ComboBox1.Items[ComboBox1.ItemIndex] <> 'Default' then TestIni.Add('ContentTransferEncoding='+ComboBox1.Items[ComboBox1.ItemIndex]);
        if ComboBox2.Items[ComboBox2.ItemIndex] <> 'Default' then TestIni.Add('ConvertPreamble='+ComboBox2.Items[ComboBox2.ItemIndex]);
        if ComboBox4.Items[ComboBox4.ItemIndex] <> 'Default' then TestIni.Add('Encoding='+ComboBox4.Items[ComboBox4.ItemIndex]);
        if Edit3.Text <> '' then TestIni.Add('ContentType='+Edit3.Text);
        //Copy any attachments into test dir, note the same attachment may be in more than one part...
        for i := 0 to ListBox1.Items.Count-1 do begin
            AttachmentName := ListBox1.Items.Strings[i];
            nPos := Pos(',', AttachmentName);
            sType := Copy(AttachmentName, 1, nPos-1);
            AttachmentName := Copy(AttachmentName, nPos+1, MAXINT);
            nPos := Pos(',', AttachmentName);
            sEncoding := Copy(AttachmentName, 1, nPos-1);
            AttachmentName := Copy(AttachmentName, nPos+1, MAXINT);
            nPos := Pos(',', AttachmentName);
            AttachmentName := Copy(AttachmentName, 1, nPos-1);
            sTemp := Copy(AttachmentName, nPos+1, MAXINT);
            nPos := Pos(',', sTemp);
            sContentType := Copy(sTemp, nPos+1, MAXINT);
            sParentPath := Copy(sTemp, 1, nPos-1);
            PortedAttachmentName := ExtractPath+ExtractFileName(AttachmentName);
            CopyFile(PAnsiChar(AttachmentName), PAnsiChar(PortedAttachmentName), False);
            //Update our INI with the ported path...
            TestIni.Add('Part'+IntToStr(i)+'='+sType+','+sEncoding+','+PortedAttachmentName+','+sParentPath+','+sContentType);
        end;
        TestIni.SaveToFile(FDataPath+TestName+'.ini');
        ShowMessage('Test message '+TestName+' successfully set up, you may need to restart to see it listed.');
    end;
end;

procedure TformEncoderPlayground.Button6Click(Sender: TObject);
begin
    Memo1.Text := EncoderBody;
end;

procedure   TformEncoderPlayground.ResetFieldsToDefaults;
begin
  Memo1.Text := '';
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
  ComboBox3.ItemIndex := 0;
  ComboBox4.ItemIndex := 0;
  ComboBox5.ItemIndex := 0;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button5.Enabled := False;
  ListBox1.Items.Clear;
end;

procedure TformEncoderPlayground.Button7Click(Sender: TObject);
begin
    ResetFieldsToDefaults;
end;

procedure TformEncoderPlayground.Button8Click(Sender: TObject);
begin
    //This sends an email so you can see if that client can decode it...
    SendEmail.ShowModal;
end;

end.
