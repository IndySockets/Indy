object DM: TDM
  OldCreateOrder = False
  Height = 333
  Width = 537
  object tablFile: TTable
    DatabaseName = 'd:\teamco\Indy10_Current\Builder\Package Generator\Data'
    TableName = 'File.DB'
    Left = 48
    Top = 24
    object tablFileFileID: TAutoIncField
      FieldName = 'FileID'
      ReadOnly = True
    end
    object tablFileFileName: TStringField
      FieldName = 'FileName'
      Required = True
      Size = 100
    end
    object tablFileDotNet: TBooleanField
      FieldName = 'DotNet'
    end
    object tablFileDelphiDotNet: TBooleanField
      FieldName = 'DelphiDotNet'
    end
    object tablFileVCL: TBooleanField
      FieldName = 'VCL'
    end
    object tablFileKylix: TBooleanField
      FieldName = 'Kylix'
    end
    object tablFilePkg: TStringField
      FieldName = 'Pkg'
    end
    object tablFileDesignUnit: TBooleanField
      FieldName = 'DesignUnit'
    end
    object tablFileFTPParser: TBooleanField
      FieldName = 'FTPParser'
    end
  end
end
