object Form1: TForm1
  Left = 193
  Top = 108
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
  OnCreate = FormCreate
  DesignSize = (
    536
    348)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFileName: TLabel
    Left = 8
    Top = 16
    Width = 50
    Height = 13
    Caption = '&File Name:'
    FocusControl = edtFileName
  end
  object lblOutputFileName: TLabel
    Left = 8
    Top = 48
    Width = 83
    Height = 13
    Caption = 'Output FIleName:'
  end
  object mmoTestLog: TMemo
    Left = 8
    Top = 80
    Width = 513
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object btnTest: TButton
    Left = 448
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Test'
    TabOrder = 1
    OnClick = btnTestClick
  end
  object edtFileName: TEdit
    Left = 64
    Top = 16
    Width = 281
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object bbtnBrowse: TButton
    Left = 360
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Browse'
    TabOrder = 3
    OnClick = bbtnBrowseClick
  end
  object edtOutputFileName: TEdit
    Left = 112
    Top = 48
    Width = 233
    Height = 21
    TabOrder = 4
  end
  object btnOBrowse: TButton
    Left = 360
    Top = 48
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Browse'
    TabOrder = 5
    OnClick = btnOBrowseClick
  end
  object odlgTestList: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text File (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 264
    Top = 8
  end
  object sdlgOutput: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 288
    Top = 56
  end
end
