{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  20916: CoderRawBubble.pas 
{
{   Rev 1.2    2003.06.24 9:12:20 PM  czhower
{ Removed code that is no loger necessary because of changes to Bubelen.
}
{
{   Rev 1.1    2003.06.24 9:00:50 PM  czhower
{ Updated to match Bubelen event signature change.
}
{
{   Rev 1.0    2003.06.23 10:11:18 PM  czhower
{ Initial Checkin
}
unit CoderRawBubble;

interface

uses
  SysUtils, Classes, BXBubble;

type
  TdmodCoderRawBubble = class(TDataModule)
    bublCoderRawMIME: TBXBubble;
    bublCoderRawUUE: TBXBubble;
    bublCoderRawQP: TBXBubble;
    procedure bublCoderRawUUETest(Sender: TBXBubble);
    procedure bublCoderRawMIMETest(Sender: TBXBubble);
    procedure bublCoderRawQPTest(Sender: TBXBubble);
  private
  protected
    procedure CheckMIMEString(ABubble: TBXBubble; const AEncoded: string;
     const ADecoded: string);
    procedure CheckUUEString(ABubble: TBXBubble; const AEncoded: string;
     const ADecoded: string);
  public
  end;

var
  dmodCoderRawBubble: TdmodCoderRawBubble;

implementation
{$R *.dfm}

uses
  IdCoderMIME, IdCoderQuotedPrintable, IdCoderUUE, IdCoreGlobal, IdGlobal;

{ TdmodCoderRawBubble }

procedure TdmodCoderRawBubble.CheckMIMEString(ABubble: TBXBubble;
 const AEncoded, ADecoded: string);
begin
  ABubble.Check(TIdEncoderMIME.EncodeString(ADecoded) = AEncoded
   , 'Encode mismatch');
  ABubble.Check(TIdDecoderMIME.DecodeString(AEncoded) = ADecoded
   , 'Decode mismatch');
end;

procedure TdmodCoderRawBubble.CheckUUEString(ABubble: TBXBubble;
 const AEncoded, ADecoded: string);
begin
  ABubble.Check(TIdEncoderUUE.EncodeString(ADecoded) = AEncoded
   , 'Encode mismatch');
  ABubble.Check(TIdDecoderUUE.DecodeString(AEncoded) = ADecoded
   , 'Decode mismatch');
end;

procedure TdmodCoderRawBubble.bublCoderRawUUETest(Sender: TBXBubble);
begin
  CheckUUEString(Sender, '%161I=#$`', 'Edit1');
  CheckUUEString(Sender, '95VAA="=S(&AA<''!E;FEN9R!B;W)T:&5R/P``'
   , 'What''s happening borther?');
end;

procedure TdmodCoderRawBubble.bublCoderRawMIMETest(Sender: TBXBubble);
begin
  CheckMIMEString(Sender, 'dXNlcjpwYXNzd29yZA==', 'user:password');
  CheckMIMEString(Sender, 'b25lOnR3bw==', 'one:two');
  CheckMIMEString(Sender, 'dHdvOnRocmVl', 'two:three');
  CheckMIMEString(Sender, 'dGhyZWU6Zm91cg==', 'three:four');
  CheckMIMEString(Sender, 'Zm91cjpmaXZl', 'four:five');
  CheckMIMEString(Sender, 'Zml2ZTpzaXg=', 'five:six');
  CheckMIMEString(Sender, 'c2l4OnNldmVu', 'six:seven');
  CheckMIMEString(Sender, 'c2V2ZW46ZWlnaHQ=', 'seven:eight');
  CheckMIMEString(Sender, 'ZWlnaHQ6bmluZQ==', 'eight:nine');
  CheckMIMEString(Sender, 'bmluZTp0ZW4=', 'nine:ten');
end;

procedure TdmodCoderRawBubble.bublCoderRawQPTest(Sender: TBXBubble);
const
  QPTestIn = 'This is a test.  True = 1. ' + EOL + EOL;
  QPTestOut = 'This is a test.  True =3D 1.=20' + EOL + EOL;
begin
  with TIdEncoderQuotedPrintable.Create(nil) do try
    Sender.Check(Encode(QPTestIn) = QPTestOut, 'Encode Error');
  finally Free; end;
  with TIdDecoderQuotedPrintable.Create(nil) do try
    Sender.Check(DecodeString(QPTestOut) = QPTestIn, 'Decode Error');
  finally Free; end;
end;

end.
