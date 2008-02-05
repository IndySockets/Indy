object SendEmail: TSendEmail
  Left = 322
  Top = 160
  Width = 352
  Height = 369
  Caption = 'SendEmail'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 297
    Height = 45
    AutoSize = False
    Caption = 
      'This will send the email setup in the previous controls via IdSM' +
      'TP so you can see if the email client can decode it as you would' +
      ' expect.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 58
    Top = 230
    Width = 253
    Height = 47
    AutoSize = False
    Caption = 
      'WARNING: If you check Remember Settings, the settings, including' +
      ' password, will be saved in plain text on this PC in C:\IndyEnco' +
      'derSmtp.dat'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 20
    Top = 54
    Width = 62
    Height = 13
    Caption = 'SMTP server'
  end
  object Label4: TLabel
    Left = 20
    Top = 80
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label5: TLabel
    Left = 20
    Top = 106
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 20
    Top = 133
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label7: TLabel
    Left = 20
    Top = 159
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label8: TLabel
    Left = 20
    Top = 186
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object BitBtn1: TBitBtn
    Left = 64
    Top = 290
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 194
    Top = 290
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object CheckBox1: TCheckBox
    Left = 38
    Top = 210
    Width = 135
    Height = 17
    Caption = 'Remember Settings'
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 94
    Top = 52
    Width = 225
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 94
    Top = 78
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 94
    Top = 104
    Width = 225
    Height = 21
    TabOrder = 5
  end
  object Edit4: TEdit
    Left = 94
    Top = 130
    Width = 225
    Height = 21
    TabOrder = 6
  end
  object Edit5: TEdit
    Left = 94
    Top = 156
    Width = 225
    Height = 21
    TabOrder = 7
  end
  object Edit6: TEdit
    Left = 94
    Top = 182
    Width = 225
    Height = 21
    TabOrder = 8
    Text = 'Indy encoder test email'
  end
end
