object dmodCoderRawBubble: TdmodCoderRawBubble
  OldCreateOrder = False
  Left = 423
  Top = 156
  Height = 236
  Width = 310
  object bublCoderRawMIME: TBXBubble
    Category = 'Coders - Raw'
    Description = 'MIME Raw Coding'
    OnTest = bublCoderRawMIMETest
    Left = 48
    Top = 16
  end
  object bublCoderRawUUE: TBXBubble
    Category = 'Coders - Raw'
    Description = 'UUE Raw Coding'
    OnTest = bublCoderRawUUETest
    Left = 48
    Top = 80
  end
  object bublCoderRawQP: TBXBubble
    Category = 'Coders - Raw'
    Description = 'Quoted Printable Raw Coding'
    OnTest = bublCoderRawQPTest
    Left = 48
    Top = 144
  end
end
