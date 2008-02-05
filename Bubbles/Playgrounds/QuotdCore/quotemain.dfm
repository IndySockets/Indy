object Form1: TForm1
  Left = 192
  Top = 103
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 17
      end>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = IdTCPServer1Execute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 96
    Top = 72
  end
end
