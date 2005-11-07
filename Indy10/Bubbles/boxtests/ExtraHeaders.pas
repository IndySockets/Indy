{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11243: ExtraHeaders.pas 
{
{   Rev 1.1    2003.07.11 4:07:42 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.0    11/12/2002 09:17:06 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit ExtraHeaders;

interface

uses
  Classes,
  IndyBox;

type
  TExtraHeadersBox = class (TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  IdGlobal,
  IdMessage, 
  SysUtils, IdAttachmentFile, IdText;

const
  ExHdrNames: array[1..2] of string = ('MyExtraHeader', 'MyLongHeader');
  ExHdrValues: array[1..2] of string =
    ('09823j4lknsdkf80923j4k',
     'lakjsdf289034j234jskyldjflsk djflskd23 923874nc92 jlsdf78 j234lk 234 23203948 20934 0293i'
    );
  ContentID: string = '<73829274893.90238490.hkjsdhfsk>';

{ TExtraHeadersBox }

procedure TExtraHeadersBox.Test;
var
  Msg: TIdMessage;
  Att: TIdAttachmentFile;
  i: integer;
begin
  Msg := TIdMessage.Create(nil);
  Att := TIdAttachmentFile.Create(Msg.MessageParts, GetDataDir+'test.bmp');
  try
    Status('Creating message');
    for i := low(ExHdrNames) to High(ExHdrNames) do begin
      Att.ExtraHeaders.Values[ExHdrNames[i]] := ExHdrValues[i];
    end;
    Att.ContentID := ContentID;
    Att.FileName := 'test.bmp';
    Msg.SaveToFile(GetTempDir()+'test.msg');
    Status('Message saved');
  finally
    Msg.Free;
  end;
  Msg := TIdMessage.Create(nil);
  try
    Status('Loading message');
    Msg.LoadFromFile(GetTempDir()+'test.msg');
    Check(Msg.MessageParts.Count = 2, 'Wrong messagepart count ('+IntToStr(Msg.MessageParts.Count)+')!');
    Check(Msg.MessageParts.Items[0] is TIdText, 'Wrong type of attachment in #1');
    Check(Msg.MessageParts.Items[1] is TIdAttachmentFile, 'Wrong type of attachment in #2');
    Att := TIdAttachmentFile(Msg.MessageParts.Items[1]);
    Check(Att.FileName = 'test.bmp', 'Filename of Attachment lost');
    for i:=low(ExHdrNames) to High(ExHdrNames) do begin
      Check(Att.ExtraHeaders.Values[ExHdrNames[i]] = ExHdrValues[i], 'Extra header '+ExHdrNames[i]+' was lost/garbled!');
    end;
    Check(Att.ContentID = ContentID, 'Content-ID lost/garbled!');
  finally
    Msg.Free;
  end;
end;

initialization
  TIndyBox.RegisterBox(TExtraHeadersBox, 'ExtraHeaders', 'Message');
end.

