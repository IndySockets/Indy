object frmServer: TfrmServer
  Left = 193
  Top = 103
  Width = 544
  Height = 385
  Caption = 'frmServer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object redtLog: TRichEdit
    Left = 8
    Top = 48
    Width = 521
    Height = 289
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object IdFTPServer1: TIdFTPServer
    Bindings = <>
    DefaultPort = 21
    Greeting.NumericCode = 220
    Greeting.Text.Strings = (
      'Indy FTP Server ready.')
    Greeting.TextCode = '220'
    IOHandler = IdSSLServer
    MaxConnectionReply.NumericCode = 0
    OnConnect = IdFTPServer1Connect
    OnDisconnect = IdFTPServer1Disconnect
    OnException = IdFTPServer1Exception
    ReplyExceptionCode = 0
    ReplyTexts = <>
    CommandHandlers = <>
    OnBeforeCommandHandler = IdFTPServer1BeforeCommandHandler
    ReplyUnknownCommand.NumericCode = 500
    ReplyUnknownCommand.Text.Strings = (
      'Syntax error, command unrecognized.')
    ReplyUnknownCommand.TextCode = '500'
    AllowAnonymousLogin = True
    AnonymousAccounts.Strings = (
      'anonymous'
      'ftp'
      'guest')
    EmulateSystem = ftpsUNIX
    FTPFileSystem = IdFTPFileSystem1
    UserAccounts = IdUserManager1
    Left = 296
    Top = 72
  end
  object IdUserManager1: TIdUserManager
    Accounts = <
      item
        UserName = 'jpmugaas'
        Password = 'mypass'
        RealName = 'J. Peter Mugaas'
      end
      item
        UserName = 'root'
        Password = 'rootpass'
        RealName = 'Root'
      end>
    Options = []
    Left = 176
    Top = 176
  end
  object IdFTPFileSystem1: TIdFTPFileSystem
    AdminUsers.Strings = (
      'root')
    RealDirectory = 'w:\comFTPD\home'
    ContainsDirs = <
      item
        RealDirectory = 'w:\comFTPD\home\pub'
        FTPDirectory = 'pub'
        Owner = 'jpmugaas'
        Group = 'jpmugaas'
        ContainsDirs = <>
      end>
    Owner = 'root'
    Group = 'root'
    OtherPermissions = [dpRead, dpTraverse]
    Left = 280
    Top = 200
  end
  object IdSSLServer: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.Method = sslvSSLv3
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    OnGetPassword = IdSSLServerGetPassword
    Left = 208
    Top = 56
  end
end
