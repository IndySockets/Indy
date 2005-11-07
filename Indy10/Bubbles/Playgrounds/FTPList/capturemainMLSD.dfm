object frmCapture: TfrmCapture
  Left = 178
  Top = 124
  Width = 544
  Height = 384
  Caption = 'FTP Dir Capture Utility'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    536
    357)
  PixelsPerInch = 96
  TextHeight = 13
  object lblHost: TLabel
    Left = 120
    Top = 8
    Width = 25
    Height = 13
    Caption = '&Host:'
    FocusControl = edtHost
  end
  object lblUserName: TLabel
    Left = 88
    Top = 40
    Width = 56
    Height = 13
    Caption = '&User Name:'
    FocusControl = edtUsername
  end
  object lblPassword: TLabel
    Left = 96
    Top = 72
    Width = 49
    Height = 13
    Caption = '&Password:'
    FocusControl = edtPassword
  end
  object lblCaptureFileName: TLabel
    Left = 40
    Top = 168
    Width = 102
    Height = 13
    Caption = 'Capture to &File Name:'
    FocusControl = edtFileName
  end
  object lblRemoteDir: TLabel
    Left = 88
    Top = 104
    Width = 56
    Height = 13
    Caption = '&Remote Dir:'
    FocusControl = edtRemoteDir
  end
  object lblParameters: TLabel
    Left = 88
    Top = 136
    Width = 56
    Height = 13
    Caption = 'Parameters:'
    FocusControl = edtParams
  end
  object mmoLog: TMemo
    Left = 8
    Top = 232
    Width = 513
    Height = 122
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object chkUsePasv: TCheckBox
    Left = 152
    Top = 200
    Width = 233
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Use PA&SV transfers'
    TabOrder = 8
  end
  object edtUsername: TEdit
    Left = 152
    Top = 40
    Width = 233
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 152
    Top = 72
    Width = 233
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object edtHost: TEdit
    Left = 152
    Top = 8
    Width = 233
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object edtFileName: TEdit
    Left = 152
    Top = 168
    Width = 233
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object btnGo: TButton
    Left = 408
    Top = 200
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Go'
    TabOrder = 9
    OnClick = btnGoClick
  end
  object btnBrowse: TButton
    Left = 408
    Top = 168
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Browse'
    TabOrder = 7
    OnClick = btnBrowseClick
  end
  object edtRemoteDir: TEdit
    Left = 152
    Top = 104
    Width = 233
    Height = 21
    TabOrder = 5
  end
  object edtParams: TEdit
    Left = 152
    Top = 136
    Width = 233
    Height = 21
    TabOrder = 6
  end
  object svdlgCapture: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File (*.txt)|*.txt|Any File (*.*)|*.*'
    Left = 488
    Top = 104
  end
  object IdFTPCapture: TIdFTP
    Intercept = IdLog
    MaxLineAction = maException
    UseMLIS = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    OnCheckListFormat = IdFTPCaptureCheckListFormat
    OnParseCustomListFormat = IdFTPCaptureParseCustomListFormat
    Left = 48
    Top = 192
  end
  object IdLog: TIdLogEvent
    Active = True
    OnReceived = IdLogReceived
    OnSent = IdLogSent
    Left = 96
    Top = 192
  end
end
