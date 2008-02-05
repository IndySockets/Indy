object formEncoderPlayground: TformEncoderPlayground
  Left = 567
  Top = 135
  Width = 982
  Height = 695
  Caption = 'Encoder Playground'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 225
    Top = 29
    Width = 8
    Height = 612
    Beveled = True
  end
  object lboxMessages: TListBox
    Left = 0
    Top = 29
    Width = 225
    Height = 612
    Align = alLeft
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu1
    Sorted = True
    TabOrder = 0
    OnDblClick = lboxMessagesDblClick
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 974
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Action = actnTest_Test
    end
  end
  object Panel2: TPanel
    Left = 233
    Top = 29
    Width = 741
    Height = 612
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 741
      Height = 337
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 45
        Height = 13
        Caption = 'Filename:'
      end
      object lablFilename: TLabel
        Left = 80
        Top = 24
        Width = 36
        Height = 13
        Caption = '<none>'
      end
      object Label4: TLabel
        Left = 8
        Top = 40
        Width = 30
        Height = 13
        Caption = 'Errors:'
      end
      object lablErrors: TLabel
        Left = 80
        Top = 40
        Width = 26
        Height = 13
        Caption = 'None'
      end
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 702
        Height = 13
        Caption = 
          'Either double-click a test from the left or create a message usi' +
          'ng the controls below whose names generally correspond to the TI' +
          'dMessage variables..'
      end
      object Panel3: TPanel
        Left = 1
        Top = 62
        Width = 739
        Height = 274
        Align = alBottom
        TabOrder = 0
        object Bevel3: TBevel
          Left = 500
          Top = 220
          Width = 229
          Height = 49
        end
        object Label2: TLabel
          Left = 12
          Top = 14
          Width = 51
          Height = 13
          Caption = '.Body.Text'
        end
        object Label3: TLabel
          Left = 16
          Top = 114
          Width = 124
          Height = 13
          Caption = '.ContentTransferEncoding'
        end
        object Label6: TLabel
          Left = 12
          Top = 138
          Width = 309
          Height = 13
          Caption = 
            '(this is outputted in the headers and applied to the message bod' +
            'y)'
        end
        object Label7: TLabel
          Left = 18
          Top = 158
          Width = 84
          Height = 13
          Caption = '.ConvertPreamble'
        end
        object Label8: TLabel
          Left = 10
          Top = 216
          Width = 337
          Height = 19
          AutoSize = False
          Caption = 'Note: "Default" means this code does not set the value.'
          WordWrap = True
        end
        object Label9: TLabel
          Left = 362
          Top = 18
          Width = 73
          Height = 13
          Caption = '.MessageParts:'
        end
        object Label10: TLabel
          Left = 364
          Top = 98
          Width = 52
          Height = 13
          Caption = 'File to add:'
        end
        object Label11: TLabel
          Left = 362
          Top = 160
          Width = 79
          Height = 13
          Caption = '.ContentTransfer'
        end
        object Label12: TLabel
          Left = 32
          Top = 246
          Width = 48
          Height = 13
          Caption = '.Encoding'
        end
        object Bevel1: TBevel
          Left = 8
          Top = 8
          Width = 339
          Height = 201
        end
        object Bevel2: TBevel
          Left = 354
          Top = 8
          Width = 375
          Height = 203
        end
        object Label13: TLabel
          Left = 610
          Top = 224
          Width = 53
          Height = 13
          Caption = 'Test name:'
        end
        object Label14: TLabel
          Left = 366
          Top = 186
          Width = 64
          Height = 13
          Caption = '.ContentType'
        end
        object Label15: TLabel
          Left = 610
          Top = 162
          Width = 53
          Height = 13
          Caption = '.ParentPart'
        end
        object Label16: TLabel
          Left = 24
          Top = 182
          Width = 64
          Height = 13
          Caption = '.ContentType'
        end
        object Memo1: TMemo
          Left = 76
          Top = 16
          Width = 265
          Height = 89
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Lines.Strings = (
            'Memo1')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
        object ComboBox1: TComboBox
          Left = 154
          Top = 110
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
        end
        object ComboBox2: TComboBox
          Left = 152
          Top = 156
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 2
        end
        object ListBox1: TListBox
          Left = 362
          Top = 36
          Width = 353
          Height = 55
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 3
          OnClick = ListBox1Click
        end
        object Edit1: TEdit
          Left = 424
          Top = 96
          Width = 233
          Height = 21
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = 'Edit1'
          OnChange = Edit1Change
        end
        object Button2: TButton
          Left = 660
          Top = 96
          Width = 53
          Height = 21
          Caption = 'Browse'
          TabOrder = 5
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 584
          Top = 16
          Width = 129
          Height = 21
          Caption = 'Delete selected part'
          TabOrder = 6
          OnClick = Button3Click
        end
        object RadioGroup1: TRadioGroup
          Left = 358
          Top = 122
          Width = 357
          Height = 33
          Caption = 'Type of attachment (if TIdText, file should be a text file)'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'TIdAttachment'
            'TIdText')
          TabOrder = 7
        end
        object ComboBox3: TComboBox
          Left = 454
          Top = 158
          Width = 137
          Height = 21
          Style = csDropDownList
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 8
        end
        object Button4: TButton
          Left = 620
          Top = 182
          Width = 89
          Height = 21
          Caption = 'Add part'
          TabOrder = 9
          OnClick = Button4Click
        end
        object ComboBox4: TComboBox
          Left = 88
          Top = 242
          Width = 145
          Height = 21
          Style = csDropDownList
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 10
        end
        object Button5: TButton
          Left = 508
          Top = 226
          Width = 95
          Height = 25
          Caption = 'Make into a test'
          TabOrder = 11
          OnClick = Button5Click
        end
        object Button1: TButton
          Left = 242
          Top = 238
          Width = 123
          Height = 25
          Caption = 'Generate email'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          OnClick = Button1Click
        end
        object Edit2: TEdit
          Left = 608
          Top = 240
          Width = 113
          Height = 21
          TabOrder = 13
        end
        object Button6: TButton
          Left = 16
          Top = 40
          Width = 51
          Height = 25
          Caption = 'Sample'
          TabOrder = 14
          OnClick = Button6Click
        end
        object Button8: TButton
          Left = 372
          Top = 238
          Width = 123
          Height = 25
          Caption = 'Send email somewhere'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          OnClick = Button8Click
        end
        object ComboBox5: TComboBox
          Left = 454
          Top = 182
          Width = 137
          Height = 21
          Style = csDropDownList
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 16
        end
        object SpinEdit1: TSpinEdit
          Left = 676
          Top = 158
          Width = 39
          Height = 22
          MaxValue = 99
          MinValue = -1
          TabOrder = 17
          Value = -1
        end
        object Edit3: TEdit
          Left = 152
          Top = 182
          Width = 181
          Height = 21
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
      end
      object Button7: TButton
        Left = 288
        Top = 276
        Width = 125
        Height = 21
        Caption = 'Reset fields to defaults'
        TabOrder = 1
        OnClick = Button7Click
      end
    end
    object pctlMessage: TPageControl
      Left = 0
      Top = 337
      Width = 741
      Height = 275
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Resultant raw message'
        ImageIndex = 1
        object memoRaw: TMemo
          Left = 0
          Top = 0
          Width = 733
          Height = 247
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Correct test message'
        ImageIndex = 1
        object memoCorrect: TMemo
          Left = 0
          Top = 0
          Width = 733
          Height = 229
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
  end
  object alstMain: TActionList
    Images = ImageList1
    OnUpdate = alstMainUpdate
    Left = 64
    Top = 56
    object actnFile_Exit: TAction
      Category = 'File'
      Caption = 'E&xit'
      OnExecute = actnFile_ExitExecute
    end
    object actnTest_Test: TAction
      Category = 'Test'
      Caption = '&Test'
      ShortCut = 16468
      OnExecute = actnTest_TestExecute
    end
    object actnTest_Emit: TAction
      Category = 'Test'
      Caption = '&Emit'
      ShortCut = 16453
      OnExecute = actnTest_TestExecute
    end
    object actnTest_Verify: TAction
      Category = 'Test'
      Caption = '&Verify'
      ShortCut = 120
      OnExecute = actnTest_TestExecute
    end
    object actnTest_VerifyAll: TAction
      Category = 'Test'
      Caption = 'Verify &All'
      OnExecute = actnTest_VerifyAllExecute
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 64
    Top = 136
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Action = actnFile_Exit
      end
    end
    object Emit2: TMenuItem
      Caption = 'Test'
      ShortCut = 16453
      object eset1: TMenuItem
        Action = actnTest_Emit
      end
      object actnFileTest1: TMenuItem
        Action = actnTest_Test
      end
      object estandVerify2: TMenuItem
        Action = actnTest_Verify
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object VerifyAll1: TMenuItem
        Action = actnTest_VerifyAll
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 64
    Top = 200
    object estandVerify1: TMenuItem
      Action = actnTest_Verify
      Default = True
    end
    object Exit2: TMenuItem
      Action = actnTest_Test
    end
    object Emit1: TMenuItem
      Action = actnTest_Emit
    end
  end
  object ImageList1: TImageList
    Left = 64
    Top = 272
  end
  object OpenDialog1: TOpenDialog
    Left = 66
    Top = 388
  end
  object bublEncoderPlayground: TBXBubble
    Category = 'Encoders'
    Description = 'Encoder Playground'
    OnPlayground = bublEncoderPlaygroundPlayground
    Left = 64
    Top = 336
  end
end
