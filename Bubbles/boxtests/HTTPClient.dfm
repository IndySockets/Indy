object dmodHTTPClient: TdmodHTTPClient
  OldCreateOrder = False
  Left = 302
  Top = 137
  Height = 479
  Width = 741
  object HTTPClient: TBXBubble
    Category = 'Clients'
    Description = 'HTTP Client'
    OnTest = HTTPClientTest
    Left = 32
    Top = 24
  end
  object HTTPDecompression: TBXBubble
    Category = 'Clients'
    Description = 'TIdCompressorBorZLib'
    Details.Strings = (
      
        'This tests TIdHTTP with TIdCompressorBorZLib for web-compressed ' +
        'websites.')
    OnTest = HTTPDecompressionTest
    Left = 64
    Top = 96
  end
end
