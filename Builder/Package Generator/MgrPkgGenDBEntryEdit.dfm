object frmDBEntry: TfrmDBEntry
  Left = 195
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Package Manager Data Entry'
  ClientHeight = 375
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBtnText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 341
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object pgControlMain: TPageControl
      Left = 5
      Top = 5
      Width = 417
      Height = 331
      ActivePage = tbshtMain
      Align = alClient
      TabOrder = 0
      object tbshtMain: TTabSheet
        Caption = 'Main'
        DesignSize = (
          409
          303)
        object lblUnitName: TLabel
          Left = 16
          Top = 16
          Width = 46
          Height = 13
          Caption = 'File Name'
          FocusControl = dbedtFileName
        end
        object dbedtFileName: TDBEdit
          Left = 16
          Top = 32
          Width = 377
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'FileName'
          DataSource = DMDS.DSMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = dbedtFileNameChange
        end
        object grpDevIDE: TGroupBox
          Left = 16
          Top = 59
          Width = 385
          Height = 239
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Packaging (Development ENviornment)'
          TabOrder = 1
          object lblPackage: TLabel
            Left = 24
            Top = 164
            Width = 40
            Height = 13
            Caption = 'Package'
          end
          object dbchkDotNET: TDBCheckBox
            Left = 24
            Top = 25
            Width = 161
            Height = 17
            Caption = 'DotNet (Visual Studio)'
            DataField = 'DotNet'
            DataSource = DMDS.DSMain
            TabOrder = 0
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbchkDelphiDotNET: TDBCheckBox
            Left = 24
            Top = 49
            Width = 97
            Height = 17
            Caption = 'Delphi DotNet'
            DataField = 'DelphiDotNet'
            DataSource = DMDS.DSMain
            TabOrder = 1
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbchkVCL: TDBCheckBox
            Left = 24
            Top = 95
            Width = 97
            Height = 17
            Caption = 'VCL'
            DataField = 'VCL'
            DataSource = DMDS.DSMain
            TabOrder = 3
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbchkKylix: TDBCheckBox
            Left = 24
            Top = 118
            Width = 97
            Height = 17
            Caption = 'Kylix'
            DataField = 'Kylix'
            DataSource = DMDS.DSMain
            TabOrder = 4
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object dbchkDesignTimeOnly: TDBCheckBox
            Left = 24
            Top = 210
            Width = 153
            Height = 17
            Caption = 'Design-Time-Only Unit'
            DataField = 'DesignUnit'
            DataSource = DMDS.DSMain
            TabOrder = 5
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnClick = dbchkDesignTimeOnlyClick
          end
          object dbchkFPCLazarus: TDBCheckBox
            Left = 24
            Top = 141
            Width = 153
            Height = 17
            Caption = 'FreePascal/Lazarus Unit'
            DataField = 'FPC'
            DataSource = DMDS.DSMain
            TabOrder = 6
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            OnClick = dbchkFPCLazarusClick
          end
          object dbcboPackage: TDBComboBox
            Left = 24
            Top = 183
            Width = 265
            Height = 21
            DataField = 'Pkg'
            DataSource = DMDS.DSMain
            ItemHeight = 13
            Items.Strings = (
              'System'
              'Core'
              'Protocols'
              'Security')
            TabOrder = 7
          end
          object dbcboNet20Framework: TDBCheckBox
            Left = 24
            Top = 72
            Width = 213
            Height = 17
            Caption = 'Requires NET 2.0 Framework or Above'
            DataField = 'DotNet2_0OrAboveOnly'
            DataSource = DMDS.DSMain
            TabOrder = 2
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
        end
      end
      object tbshtUnitDetails: TTabSheet
        Caption = 'Unit Details'
        DesignSize = (
          409
          303)
        object lblShortDescription: TLabel
          Left = 16
          Top = 168
          Width = 82
          Height = 13
          Caption = 'Short Description'
          FocusControl = dbedtShortDescription
        end
        object lblOwner: TLabel
          Left = 16
          Top = 264
          Width = 37
          Height = 13
          Caption = 'Owners'
          FocusControl = dbedtOwners
        end
        object lbldbProtocols: TLabel
          Left = 16
          Top = 216
          Width = 39
          Height = 13
          Caption = 'Protocol'
          FocusControl = dbedtProtocols
        end
        object dbedtFTPListParser: TDBCheckBox
          Left = 16
          Top = 16
          Width = 273
          Height = 17
          Caption = 'FTP List Parser Class'
          DataField = 'FTPParser'
          DataSource = DMDS.DSMain
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkIFDEFPermitted: TDBCheckBox
          Left = 16
          Top = 40
          Width = 105
          Height = 17
          Caption = 'IFDEF Permitted'
          DataField = 'IFDEFPermitted'
          DataSource = DMDS.DSMain
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkHasRegisterProc: TDBCheckBox
          Left = 16
          Top = 64
          Width = 153
          Height = 17
          Caption = 'Has Register Procedure'
          DataField = 'FPCHasRegProc'
          DataSource = DMDS.DSMain
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkHasAssociatedLazRes: TDBCheckBox
          Left = 16
          Top = 112
          Width = 273
          Height = 17
          Caption = 'Has Associated Lazarus Resource File (.LRS)'
          DataField = 'FPCHasLRSFile'
          DataSource = DMDS.DSMain
          TabOrder = 4
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkBubbleExists: TDBCheckBox
          Left = 16
          Top = 136
          Width = 97
          Height = 17
          Caption = 'Bubble Exists'
          DataField = 'BubbleExists'
          DataSource = DMDS.DSMain
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbedtShortDescription: TDBEdit
          Left = 16
          Top = 184
          Width = 377
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'DescrShort'
          DataSource = DMDS.DSMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object dbedtOwners: TDBEdit
          Left = 16
          Top = 280
          Width = 377
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DataField = 'Owners'
          DataSource = DMDS.DSMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object dbchkListInLazPackage: TDBCheckBox
          Left = 16
          Top = 88
          Width = 273
          Height = 17
          Caption = 'List in Makefile.fpc or Lazarus Package'
          DataField = 'FPCListInPkg'
          DataSource = DMDS.DSMain
          TabOrder = 3
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnClick = dbchkListInLazPackageClick
        end
        object dbedtProtocols: TDBEdit
          Left = 16
          Top = 232
          Width = 377
          Height = 21
          DataField = 'Protocol'
          DataSource = DMDS.DSMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
      object tbshtRelease: TTabSheet
        Caption = 'Release'
        object lblRelComment: TLabel
          Left = 16
          Top = 112
          Width = 86
          Height = 13
          Caption = 'Release Comment'
          FocusControl = dbedtComment
        end
        object dbchkRelease: TDBCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Release'
          DataField = 'Release'
          DataSource = DMDS.DSMain
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbchkReleaseNativeOS: TDBCheckBox
          Left = 16
          Top = 48
          Width = 129
          Height = 17
          Caption = 'Release for Native OS'
          DataField = 'ReleaseNative'
          DataSource = DMDS.DSMain
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbReleaseDotNET: TDBCheckBox
          Left = 16
          Top = 80
          Width = 153
          Height = 17
          Caption = 'Release for DotNet'
          DataField = 'ReleaseDotNet'
          DataSource = DMDS.DSMain
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dbedtComment: TDBEdit
          Left = 16
          Top = 128
          Width = 377
          Height = 21
          DataField = 'ReleaseComment'
          DataSource = DMDS.DSMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 341
    Width = 427
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      427
      34)
    object OKBtn: TButton
      Left = 187
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 267
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object HelpBtn: TButton
      Left = 347
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Help'
      TabOrder = 2
    end
  end
end
