{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  22276: SaveToLoadFromFileTests.pas 
{
{   Rev 1.1    28/07/2003 19:30:02  CCostelloe
{ Added tests for base64, quoted-printable and default encoding.  Added check 0
{ for message body text.  Incorporated '.' tests to ensure that the
{ end-of-message marker CRLF.CRLF is not confused with inline '.'s.
}
{
{   Rev 1.0    26/07/2003 13:34:52  CCostelloe
{ Test to show bug with attachments being saved base64 encoded while Content
{ Transfer Encoding set to 7bit.
}
unit SaveToLoadFromFileTests;

{This was written to demonstrate a bug in TIdMessage and hopefully check for it
if it ever creeps in again.
The attachment is written out with:
    Content-Transfer-Encoding: 7bit
...but the attachment is actually encoded as base64 - you can verify this by
running the test, wait for the ShowMessage dialog, manually edit the file
it displays the name of (change the "7bit" to "base64"), and it will pass
check 6 but not check 7.
The real bug is that SaveToFile should have left the attachment content
unencoded.

Ciaran Costelloe, 26th July 2003.

CC2: Added tests for base64, quoted-printable and default encoding.  Added
check 0 for message body text.  Incorporated '.' tests to ensure that the
end-of-message marker CRLF.CRLF is not confused with inline '.'s.
}
interface

uses
  Dialogs,
  Classes,
  IndyBox;

type
  TSaveToLoadFromFileTests = class (TIndyBox)
  public
    procedure Test; override;
    procedure ATest(AContentTransferEncoding: string);
  end;

implementation

uses
  IdGlobal,
  IdMessage,
  SysUtils, IdAttachmentFile, IdAttachmentMemory, IdText;

const
  ContentID: string = '<73829274893.90238490.hkjsdhfsk>';

{ TExtraHeadersBox }

procedure TSaveToLoadFromFileTests.Test;
begin
    ATest('base64');
    ATest('');      {"Default" encoding}
    ATest('quoted-printable');
    ATest('7bit');
end;

procedure TSaveToLoadFromFileTests.ATest(AContentTransferEncoding: string);
var
  Msg: TIdMessage;
  Att: TIdAttachmentMemory;
  Att2: TIdAttachmentFile;
  LTempFilename: string;
  AttText: string;
  MsgText: string;
  sTemp: string;
  TheStrings: TStringList;
begin
  sTemp := AContentTransferEncoding; if sTemp = '' then sTemp := 'default';
  ShowMessage('Starting test for '+sTemp+' encoding...');
  TheStrings := TStringList.Create;
  Msg := TIdMessage.Create(nil);
  MsgText := 'This is test message text.';
  Msg.Body.Add(MsgText);
  //Att := TIdAttachmentFile.Create(Msg.MessageParts, GetDataDir+'test.bmp');
  AttText := 'This is a test attachment.  This is deliberately a long line to ensure that the generated encoded lines go beyond 80 characters so that their line-breaking is tested.'#13#10'.This starts with a period'#13#10'.'#13#10'Last line only had a period.';
  Att := TIdAttachmentMemory.Create(Msg.MessageParts, AttText);
  try
    Status('Creating message');
    Att.ContentID := ContentID;
    Att.FileName := 'test.txt';
    Att.ContentTransfer := AContentTransferEncoding;
    LTempFilename := MakeTempFilename;
    //Msg.SaveToFile(GetTempDir()+'test.msg');
    Msg.SaveToFile(LTempFilename);
    Status('Message saved to file '+LTempFilename);
    ShowMessage('Message saved to file '+LTempFilename+'. You may wish to view this to see if the intermediate file looks OK.');
  finally
    Msg.Free;
  end;
  Msg := TIdMessage.Create(nil);
  try
    Status('Loading message');
    //Msg.LoadFromFile(GetTempDir()+'test.msg');
    Msg.LoadFromFile(LTempFilename);
    sTemp := Msg.Body.Strings[0];
    Check(sTemp = MsgText, 'Check 0: Message body text >'+MsgText+'< changed to >'+sTemp+'<');
    Check(Msg.MessageParts.Count = 2, 'Check 1: Wrong messagepart count ('+IntToStr(Msg.MessageParts.Count)+')!');
    Check(Msg.MessageParts.Items[0] is TIdText, 'Check 2: Wrong type of attachment in #1');
    Check(Msg.MessageParts.Items[1] is TIdAttachmentFile, 'Check 3: Wrong type of attachment in #2');
    Att2 := TIdAttachmentFile(Msg.MessageParts.Items[1]);
    Check(Att2.FileName = 'test.txt', 'Check 4: Filename of Attachment lost');
    Check(Att2.ContentID = ContentID, 'Check 5: Content-ID lost/garbled!');
    TheStrings.LoadFromFile(Att2.StoredPathName);
    sTemp := TheStrings.Strings[0];
    Check(sTemp = 'This is a test attachment.  This is deliberately a long line to ensure that the generated encoded lines go beyond 80 characters so that their line-breaking is tested.',
    'Check 6a: Attachment text >'+'This is a test attachment.  This is deliberately a long line to ensure that the generated encoded lines go beyond 80 characters so that their line-breaking is tested.'+'< changed to >'+sTemp+'<');
    sTemp := TheStrings.Strings[1];
    Check(sTemp = '.This starts with a period',
    'Check 6b: Attachment text >'+'.This starts with a period'+'< changed to >'+sTemp+'<');
    sTemp := TheStrings.Strings[2];
    Check(sTemp = '.',
    'Check 6c: Attachment text >'+'.'+'< changed to >'+sTemp+'<');
    sTemp := TheStrings.Strings[3];
    Check(sTemp = 'Last line only had a period.',
    'Check 6d: Attachment text >'+'Last line only had a period.'+'< changed to >'+sTemp+'<');
    if AContentTransferEncoding <> '' then begin
      {Note: We don't check encoding type if AContentTransferEncoding is '' because
      we don't care what encoding SaveToFile chose.  We do in the other cases, because
      we specifically requested a certain encoding type.}
      Check(Att2.ContentTransfer = AContentTransferEncoding, 'Check 7: Attachment Content Transfer Encoding changed from '+AContentTransferEncoding+' to '+Att2.ContentTransfer);
    end;
  finally
    Msg.Free;
  end;
  sTemp := AContentTransferEncoding; if sTemp = '' then sTemp := 'default';
  ShowMessage('Successfully completed test for '+sTemp+' encoding!');
end;

initialization
  TIndyBox.RegisterBox(TSaveToLoadFromFileTests, 'ExtraHeaders', 'Message');
end.

