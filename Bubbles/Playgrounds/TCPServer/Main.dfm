object formMain: TformMain
  Left = 339
  Top = 149
  Width = 416
  Height = 373
  Caption = 'Fiber Playground'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'TCP Server'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 8
    Width = 75
    Height = 25
    Caption = 'HTTP Server'
    Default = True
    TabOrder = 1
    OnClick = Button2Click
  end
  object memoTest: TMemo
    Left = 16
    Top = 96
    Width = 377
    Height = 217
    TabOrder = 2
  end
  object tcpsTest: TIdCmdTCPServer
    Bindings = <>
    DefaultPort = 6000
    Greeting.NumericCode = 201
    Greeting.Text.Strings = (
      'Hello and welcome!')
    Greeting.TextCode = '201'
    IOHandler = IdServerIOHandlerChain1
    ListenQueue = 100
    MaxConnectionReply.NumericCode = 0
    ReplyTexts = <>
    Scheduler = IdSchedulerFiber1
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Command = 'Help'
        Disconnect = False
        Name = 'cmdhHelp'
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 100
        ReplyNormal.Text.Strings = (
          'Help follows')
        ReplyNormal.TextCode = '100'
        Response.Strings = (
          'Test1'
          'Test2')
        Tag = 0
      end>
    ReplyExceptionCode = 500
    ReplyUnknownCommand.NumericCode = 400
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    ReplyUnknownCommand.TextCode = '400'
    Left = 40
    Top = 48
  end
  object IdServerIOHandlerChain1: TIdServerIOHandlerChain
    ChainEngine = IdChainEngineStack1
    Left = 120
    Top = 48
  end
  object IdChainEngineStack1: TIdChainEngineStack
    Left = 208
    Top = 48
  end
  object IdSchedulerFiber1: TIdSchedulerFiber
    Left = 120
    Top = 96
  end
end
