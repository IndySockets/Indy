object dmodChainedHTTPClient: TdmodChainedHTTPClient
  OldCreateOrder = False
  Left = 423
  Top = 201
  Height = 192
  Width = 334
  object ChainedHTTPClientIOCP: TBXBubble
    Category = 'Chains'
    Description = 'Chained HTTP Client (IOCP)'
    OnTest = ChainedHTTPClientIOCPTest
    Left = 72
    Top = 12
  end
end
