object dmCoderSpeed: TdmCoderSpeed
  OldCreateOrder = False
  Left = 267
  Top = 114
  Height = 254
  Width = 380
  object bublMime: TBXBubble
    Category = 'Coders'
    Description = 'Decode Speed - MIME'
    Details.Strings = (
      'This test measures the raw speed of the decode routines'
      'by calling them in a realistic manner with a lot of data in a'
      'series simulating a large file decode.')
    OnTest = bublMimeTest
    Left = 40
    Top = 24
  end
  object bublUUE: TBXBubble
    Category = 'Coders'
    Description = 'Decode Speed - UUE'
    Details.Strings = (
      'This test measures the raw speed of the decode routines'
      'by calling them in a realistic manner with a lot of data in a'
      'series simulating a large file decode.')
    OnTest = bublUUETest
    Left = 40
    Top = 80
  end
end
