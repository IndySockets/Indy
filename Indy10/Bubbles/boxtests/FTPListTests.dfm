object dmFTPListTest: TdmFTPListTest
  OldCreateOrder = False
  Left = 192
  Top = 103
  Height = 150
  Width = 215
  object bxUnixLSandSimilar: TBXBubble
    Category = 'FTP List'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'Unix FTP List and Similar formats'
    Details.Strings = (
      
        'This tests FTP List parsing in Unix, Unitree, and Novell Print S' +
        'ervices for Unix (NFS Namespace) FTP Deamon.  Note that these ha' +
        've similar formats but they are NOT the same exact format.  This' +
        ' also tests variations such as MacOS Peter'#39's FTP Server and Unix' +
        ' /bin/ls format with ACL'#39's, the FreeBSD -i switch, the /bin/ls -' +
        'go switch, and ProFTPD on CygWin.')
    OnTest = bxUnixLSandSimilarTest
    Left = 88
    Top = 56
  end
  object bxWin32IISForms: TBXBubble
    Category = 'FTP List'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'Win32 IIS List format tests'
    OnTest = bxWin32IISFormsTest
    Left = 40
    Top = 8
  end
  object bxSterlingComTests: TBXBubble
    Category = 'FTP List'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'Sterling Commerce list parsing tests.'
    OnTest = bxSterlingComTestsTest
    Left = 136
    Top = 24
  end
  object bxOS2Test: TBXBubble
    Category = 'FTP List'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'OS/2 FTP List parsing.'
    OnTest = bxOS2TestTest
    Left = 24
    Top = 72
  end
end
