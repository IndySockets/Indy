object DM: TDM
  OldCreateOrder = False
  Height = 333
  Width = 537
  object tablFile: TTable
    DatabaseName = 'w:\source\Indy10\Builder\Package Generator\Data'
    TableName = 'File.DB'
    Left = 48
    Top = 24
    object tablFileFileID: TAutoIncField
      FieldName = 'FileID'
      ReadOnly = True
    end
    object tablFileFileName: TStringField
      DisplayLabel = 'File Name'
      FieldName = 'FileName'
      Required = True
      Size = 100
    end
    object tablFileDotNet: TBooleanField
      DisplayLabel = 'DotNet (Visual Studio)'
      FieldName = 'DotNet'
    end
    object tablFileDelphiDotNet: TBooleanField
      DisplayLabel = 'Delphi DotNet'
      FieldName = 'DelphiDotNet'
    end
    object tablFileVCL: TBooleanField
      FieldName = 'VCL'
    end
    object tablFileKylix: TBooleanField
      FieldName = 'Kylix'
    end
    object tablFilePkg: TStringField
      DisplayLabel = 'Package'
      FieldName = 'Pkg'
    end
    object tablFileDesignUnit: TBooleanField
      DisplayLabel = 'Design-Time-Only Unit'
      FieldName = 'DesignUnit'
    end
    object tablFileFTPParser: TBooleanField
      DisplayLabel = 'FTP List Parser Class'
      FieldName = 'FTPParser'
    end
    object tablFileDescrShort: TStringField
      DisplayLabel = 'Short Description'
      FieldName = 'DescrShort'
      Size = 100
    end
    object tablFileProtocol: TStringField
      FieldName = 'Protocol'
      Size = 100
    end
    object tablFileRelease: TBooleanField
      FieldName = 'Release'
    end
    object tablFileReleaseNative: TBooleanField
      DisplayLabel = 'Release for Native OS'
      FieldName = 'ReleaseNative'
    end
    object tablFileReleaseDotNet: TBooleanField
      DisplayLabel = 'Release for DotNet'
      FieldName = 'ReleaseDotNet'
    end
    object tablFileReleaseComment: TStringField
      DisplayLabel = 'Release Comment'
      FieldName = 'ReleaseComment'
      Size = 100
    end
    object tablFileBubbleExists: TBooleanField
      DisplayLabel = 'Bubble Exists'
      FieldName = 'BubbleExists'
    end
    object tablFileIFDEFPermitted: TBooleanField
      DisplayLabel = 'IFDEF Permitted'
      FieldName = 'IFDEFPermitted'
    end
    object tablFileOwners: TStringField
      FieldName = 'Owners'
      Size = 100
    end
    object tablFileFPC: TBooleanField
      DisplayLabel = 'FreePascal/Lazarus Unit'
      FieldName = 'FPC'
    end
    object tablFileFPCListInPkg: TBooleanField
      DisplayLabel = 'List in Lazarus Package'
      FieldName = 'FPCListInPkg'
    end
    object tablFileFPCHasRegProc: TBooleanField
      DisplayLabel = 'Has Register Procedure'
      FieldName = 'FPCHasRegProc'
    end
    object tablFileFPCHasLRSFile: TBooleanField
      DisplayLabel = 'Has Associated Lazarus Resource File (.LRS)'
      FieldName = 'FPCHasLRSFile'
    end
  end
end
