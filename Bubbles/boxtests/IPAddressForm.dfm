object dmodIPAddressForm: TdmodIPAddressForm
  OldCreateOrder = False
  Left = 199
  Top = 103
  Height = 150
  Width = 215
  object bxIPAddressForm: TBXBubble
    Category = 'Misc'
    Description = 'Test IP Address forms (hex, octal, dword)'
    OnTest = bxIPAddressFormTest
    Left = 24
    Top = 8
  end
  object bxDWordToIPv4: TBXBubble
    Category = 'Misc'
    Description = 'MakeDWordIntoIPv4Address'
    Details.Strings = (
      
        'This test involves converting DWords (Cardinals) to dotted forma' +
        't IPv4 addresses.'
      'This tests the MakeDWordIntoIPv4Address function.')
    OnTest = bxDWordToIPv4Test
    Left = 24
    Top = 72
  end
  object bxConvertToDottedIPv4: TBXBubble
    Category = 'Misc'
    Description = 'MakeCanonicalIPv4Address'
    OnTest = bxConvertToDottedIPv4Test
    Left = 120
    Top = 72
  end
end
