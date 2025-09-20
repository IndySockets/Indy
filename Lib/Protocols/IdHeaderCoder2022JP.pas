unit IdHeaderCoder2022JP;

interface

{$i IdCompilerDefines.inc}

{RLebeau: TODO - move this logic into an IIdTextEncoding implementation}

uses
  IdGlobal, IdHeaderCoderBase;

type
  TIdHeaderCoder2022JP = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet: string; const AData: TIdBytes): String; override;
    class function Encode(const ACharSet, AData: String): TIdBytes; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterHeaderCoder can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdHeaderCoder2022JP"'}
  {$ENDIF}

implementation

uses
  SysUtils;

const
  // RLebeau 1/7/09: using integers for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...

  kana_tbl : array[161..223{#$A1..#$DF}] of Word = (
    $2123,$2156,$2157,$2122,$2126,$2572,$2521,$2523,$2525,$2527,
    $2529,$2563,$2565,$2567,$2543,$213C,$2522,$2524,$2526,$2528,
    $252A,$252B,$252D,$252F,$2531,$2533,$2535,$2537,$2539,$253B,
    $253D,$253F,$2541,$2544,$2546,$2548,$254A,$254B,$254C,$254D,
    $254E,$254F,$2552,$2555,$2558,$255B,$255E,$255F,$2560,$2561,
    $2562,$2564,$2566,$2568,$2569,$256A,$256B,$256C,$256D,$256F,
    $2573,$212B,$212C);

  vkana_tbl : array[161..223{#$A1..#$DF}] of Word = (
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$2574,$0000,
    $0000,$252C,$252E,$2530,$2532,$2534,$2536,$2538,$253A,$253C,
    $253E,$2540,$2542,$2545,$2547,$2549,$0000,$0000,$0000,$0000,
    $0000,$2550,$2553,$2556,$2559,$255C,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000);

  sj1_tbl : array[128..255{#128..#255}] of byte = (
    $00,$21,$23,$25,$27,$29,$2B,$2D,$2F,$31,$33,$35,$37,$39,$3B,$3D,
    $3F,$41,$43,$45,$47,$49,$4B,$4D,$4F,$51,$53,$55,$57,$59,$5B,$5D,
    $00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,
    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,
    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,
    $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,
    $5F,$61,$63,$65,$67,$69,$6B,$6D,$6F,$71,$73,$75,$77,$79,$7B,$7D,
    $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00,$00,$00);

  sj2_tbl : array[0..255{#0..#255}] of Word = (
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,
    $0000,$0000,$0000,$0000,$0021,$0022,$0023,$0024,$0025,$0026,
    $0027,$0028,$0029,$002A,$002B,$002C,$002D,$002E,$002F,$0030,
    $0031,$0032,$0033,$0034,$0035,$0036,$0037,$0038,$0039,$003A,
    $003B,$003C,$003D,$003E,$003F,$0040,$0041,$0042,$0043,$0044,
    $0045,$0046,$0047,$0048,$0049,$004A,$004B,$004C,$004D,$004E,
    $004F,$0050,$0051,$0052,$0053,$0054,$0055,$0056,$0057,$0058,
    $0059,$005A,$005B,$005C,$005D,$005E,$005F,$0000,$0060,$0061,
    $0062,$0063,$0064,$0065,$0066,$0067,$0068,$0069,$006A,$006B,
    $006C,$006D,$006E,$006F,$0070,$0071,$0072,$0073,$0074,$0075,
    $0076,$0077,$0078,$0079,$007A,$007B,$007C,$007D,$007E,$0121,
    $0122,$0123,$0124,$0125,$0126,$0127,$0128,$0129,$012A,$012B,
    $012C,$012D,$012E,$012F,$0130,$0131,$0132,$0133,$0134,$0135,
    $0136,$0137,$0138,$0139,$013A,$013B,$013C,$013D,$013E,$013F,
    $0140,$0141,$0142,$0143,$0144,$0145,$0146,$0147,$0148,$0149,
    $014A,$014B,$014C,$014D,$014E,$014F,$0150,$0151,$0152,$0153,
    $0154,$0155,$0156,$0157,$0158,$0159,$015A,$015B,$015C,$015D,
    $015E,$015F,$0160,$0161,$0162,$0163,$0164,$0165,$0166,$0167,
    $0168,$0169,$016A,$016B,$016C,$016D,$016E,$016F,$0170,$0171,
    $0172,$0173,$0174,$0175,$0176,$0177,$0178,$0179,$017A,$017B,
    $017C,$017D,$017E,$0000,$0000,$0000);

class function TIdHeaderCoder2022JP.Decode(const ACharSet: String; const AData: TIdBytes): String;
var
  T : string;
  I, L : Integer;
  isK : Boolean;
  K1, K2 : Byte;
  K3 : Byte;
begin
  T := '';    {Do not Localize}
  isK := False;
  L := Length(AData);
  I := 0;
  while I < L do
  begin
    if AData[I] = 27 then
    begin
      Inc(I);
      if (I+1) < L then
      begin
        if (AData[I] = Ord('$')) and (AData[I+1] = Ord('B')) then begin {do not localize}
          isK := True;
        end
        else if (AData[I] = Ord('(')) and (AData[I+1] = Ord('B')) then begin {do not localize}
          isK := False;
        end;
        Inc(I, 2);   { TODO -oTArisawa : Check RFC 1468}
      end;
    end
    else if isK then
    begin
      if (I+1) < L then
      begin
        K1 := AData[I];
        K2 := AData[I+1];

        K3 := (K1 - 1) shr 1;
        if K1 < 95 then begin
          K3:= K3 + 113;
        end else begin
          K3 := K3 + 177;
        end;

        if (K1 mod 2) = 1 then
        begin
          if K2 < 96 then begin
            K2 := K2 + 31;
          end else begin
            K2 := K2 + 32;
          end;
        end
        else begin
          K2 := K2 + 126;
        end;

        T := T + Char(K3) + Char(k2);
        Inc(I, 2);
      end
      else begin
        Inc(I); { invalid DBCS }
      end;
    end
    else
    begin
      T := T + Char(AData[I]);
      Inc(I);
    end;
  end;
  Result := T;
end;

class function TIdHeaderCoder2022JP.Encode(const ACharSet, AData: String): TIdBytes;
const
  desig_asc: array[0..2] of Byte = (27, Ord('('), Ord('B'));  {Do not Localize}
  desig_jis: array[0..2] of Byte = (27, Ord('$'), Ord('B'));  {Do not Localize}
var
  T: TIdBytes;
  I, L: Integer;
  isK: Boolean;
  K1: Byte;
  K2, K3: Word;
begin
  SetLength(T, 0);
  isK := False;
  L := Length(AData);
  I := 1;
  while I <= L do
  begin
    if Ord(AData[I]) < 128 then  {Do not Localize}
    begin
      if isK then
      begin
        AppendByte(T, 27);
        AppendByte(T, Ord('(')); {Do not Localize}
        AppendByte(T, Ord('B')); {Do not Localize}
        isK := False;
      end;
      AppendByte(T, Ord(AData[I]));
      Inc(I);
    end else
    begin
      K1 := sj1_tbl[Ord(AData[I])];
      case K1 of
        0: Inc(I);    { invalid SBCS }
        2: Inc(I, 2); { invalid DBCS }
        1:
          begin { halfwidth katakana }
            if not isK then begin
              AppendByte(T, 27);
              AppendByte(T, Ord('$')); {Do not Localize}
              AppendByte(T, Ord('B')); {Do not Localize}
              isK := True;
            end;
            { simple SBCS -> DBCS conversion }
            K2 := kana_tbl[Ord(AData[I])];
            if (I < L) and ((Ord(AData[I+1]) and $FE) = $DE) then
            begin  { convert kana + voiced mark to voiced kana }
              K3 := vkana_tbl[Ord(AData[I])];
              // This is an if and not a case because of a D8 bug, return to
              // case when d8 patch is released

              // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
              // may change characters >= #128 from their Ansi codepage value to their true
              // Unicode codepoint value, depending on the codepage used for the source code.
              // For instance, #128 may become #$20AC...

              if AData[I+1] = Char($DE) then begin  { voiced }
                if K3 <> 0 then
                begin
                  K2 := K3;
                  Inc(I);
                end;
              end
              else if AData[I+1] = Char($DF) then begin  { semivoiced }
                if (K3 >= $2550) and (K3 <= $255C) then
                begin
                  K2 := K3 + 1;
                  Inc(I);
                end;
              end;
            end;
            AppendByte(T, K2 shr 8);
            AppendByte(T, K2 and $FF);
            Inc(I);
          end;
        else { DBCS }
          if (I < L) then begin
            K2 := sj2_tbl[Ord(AData[I+1])];
            if K2 <> 0 then
            begin
              if not isK then begin
                AppendByte(T, 27);
                AppendByte(T, Ord('$')); {Do not Localize}
                AppendByte(T, Ord('B')); {Do not Localize}
                isK := True;
              end;
              AppendByte(T, K1 + K2 shr 8);
              AppendByte(T, K2 and $FF);
            end;
          end;
          Inc(I, 2);
        end;
      end;
  end;
  if isK then begin
    AppendByte(T, 27);
    AppendByte(T, Ord('(')); {Do not Localize}
    AppendByte(T, Ord('B')); {Do not Localize}
  end;
  Result := T;
end;

class function TIdHeaderCoder2022JP.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextIsSame(ACharSet, 'ISO-2022-JP'); {do not localize}
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoder2022JP);
finalization
  UnregisterHeaderCoder(TIdHeaderCoder2022JP);

end.
