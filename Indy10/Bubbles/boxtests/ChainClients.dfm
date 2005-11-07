object formChainClients: TformChainClients
  Left = 287
  Top = 126
  Width = 433
  Height = 434
  Caption = 'Fiber Playground'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 129
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 144
      Top = 8
      Width = 28
      Height = 13
      Caption = '&Fibers'
      FocusControl = editFibers
    end
    object Label1: TLabel
      Left = 232
      Top = 8
      Width = 35
      Height = 13
      Caption = 'Repeat'
    end
    object Label4: TLabel
      Left = 144
      Top = 80
      Width = 49
      Height = 13
      Caption = 'Document'
    end
    object Label3: TLabel
      Left = 144
      Top = 32
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object lablThreads: TLabel
      Left = 328
      Top = 8
      Width = 42
      Height = 13
      Caption = 'Threads:'
    end
    object lablReturns: TLabel
      Left = 328
      Top = 24
      Width = 40
      Height = 13
      Caption = 'Returns:'
    end
    object butnFiber: TButton
      Left = 336
      Top = 96
      Width = 75
      Height = 25
      Caption = '&Test'
      Default = True
      TabOrder = 0
      OnClick = butnFiberClick
    end
    object editFibers: TEdit
      Left = 184
      Top = 8
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object editRepeat: TEdit
      Left = 272
      Top = 8
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object editDocument: TEdit
      Left = 144
      Top = 96
      Width = 169
      Height = 21
      TabOrder = 3
      Text = '/MLTest/1.html'
    end
    object editHost: TEdit
      Left = 144
      Top = 48
      Width = 169
      Height = 21
      TabOrder = 4
      Text = '127.0.0.1'
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 129
      Height = 57
      Caption = 'Client Type'
      TabOrder = 5
      object radoTCP: TRadioButton
        Left = 8
        Top = 16
        Width = 113
        Height = 17
        Caption = 'TCP'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object radoHTTP: TRadioButton
        Left = 8
        Top = 32
        Width = 113
        Height = 17
        Caption = 'HTTP'
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 64
      Width = 129
      Height = 57
      Caption = 'Chain Type'
      TabOrder = 6
      object radoWinsock: TRadioButton
        Left = 8
        Top = 16
        Width = 113
        Height = 17
        Caption = 'Winsock'
        TabOrder = 0
      end
      object radoIOCP: TRadioButton
        Left = 8
        Top = 32
        Width = 113
        Height = 17
        Caption = 'IOCP'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
    end
  end
  object memoTest: TMemo
    Left = 0
    Top = 129
    Width = 425
    Height = 278
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ChainClient: TBXBubble
    Category = 'Chains'
    Description = 'Client Playground'
    OnPlayground = ChainClientPlayground
    Left = 24
    Top = 168
  end
end
