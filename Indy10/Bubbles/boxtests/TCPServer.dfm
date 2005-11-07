object dmodTCPServer: TdmodTCPServer
  OldCreateOrder = False
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object TCPServer: TBXBubble
    Category = 'TCP Servers'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'TCP Server'
    LogOptions = []
    OnTest = TCPServerTest
    Left = 32
    Top = 24
  end
  object TCPServerPool: TBXBubble
    Category = 'TCP Servers'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'TCP Server Thread Pool'
    LogOptions = []
    OnTest = TCPServerPoolTest
    Left = 36
    Top = 176
  end
  object TCPClient: TIdTCPClient
    Host = '127.0.0.1'
    Port = 0
    Left = 192
    Top = 32
  end
  object TCPServerFibersIOCP: TBXBubble
    Category = 'TCP Servers'
    CategoryComponent = NoCategoryComponent.Owner
    Description = 'TCP Server Fibers (IOCP)'
    LogOptions = []
    OnTest = TCPServerFibersIOCPTest
    Left = 44
    Top = 124
  end
end
