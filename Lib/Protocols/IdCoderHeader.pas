{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.


  $Log$


    Rev 1.13    9/8/2004 8:55:46 PM  JPMugaas
  Fix for compile problem where a char is being compared with an incompatible
  type in some compilers.


    Rev 1.12    02/07/2004 21:59:28  CCostelloe
  Bug fix


    Rev 1.11    17/06/2004 14:19:00  CCostelloe
  Bug fix for long subject lines that have characters needing CharSet encoding


    Rev 1.10    23/04/2004 20:33:04  CCostelloe
  Minor change to support From headers holding multiple addresses


    Rev 1.9    2004.02.03 5:44:58 PM  czhower
  Name changes


   Rev 1.8    24/01/2004 19:08:14  CCostelloe
 Cleaned up warnings


    Rev 1.7    1/22/2004 3:56:38 PM  SPerry
  fixed set problems


   Rev 1.6    2004.01.22 2:34:58 PM  czhower
  TextIsSame + D8 bug workaround


    Rev 1.5    10/16/2003 11:11:02 PM  DSiders
  Added localization comments.


    Rev 1.4    10/8/2003 9:49:36 PM  GGrieve
  Use IdDelete


    Rev 1.3    6/10/2003 5:48:46 PM  SGrobety
  DotNet updates


    Rev 1.2    04/09/2003 20:35:28  CCostelloe
  Parameter AUseAddressForNameIfNameMissing (defaulting to False to preserve
  existing code) added to EncodeAddressItem


    Rev 1.1    2003.06.23 9:46:52 AM  czhower
  Russian, Ukranian support for headers.


   Rev 1.0    11/14/2002 02:14:46 PM  JPMugaas
}
unit IdCoderHeader;

//refer http://www.faqs.org/rfcs/rfc2047.html

//TODO: Optimize and restructure code
//TODO: Redo this unit to fit with the new coders and use the exisiting MIME stuff

{
2002-08-21 JM Berg
 - brought in line with the RFC regarding
   whitespace between encoded words
 - added logic so that lines that already seem encoded are really encoded again
   (so that if a user types =?iso8859-1?Q?======?= its really encoded again
   and displayed like that on the other side)
2001-Nov-18 Peter Mee
 - Fixed multiple QP decoding in single header.
11-10-2001 - J. Peter Mugaas
  - tiny fix for 8bit header encoding suggested by Andrew P.Rybin
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdComponent,
  IdEMailAddress,
  IdHeaderCoderBase;

// Procs
  function EncodeAddressItem(EmailAddr: TIdEmailAddressItem; const HeaderEncoding: Char;
    const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
  function EncodeHeader(const Header: string; Specials: String; const HeaderEncoding: Char;
   const MimeCharSet: string): string;
  function EncodeAddress(EmailAddr: TIdEMailAddressList; const HeaderEncoding: Char;
    const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
  function DecodeHeader(const Header: string): string;
  procedure DecodeAddress(EMailAddr: TIdEmailAddressItem);
  procedure DecodeAddresses(AEMails: String; EMailAddr: TIdEmailAddressList);

implementation

uses
  IdException,
  IdGlobal,
  IdGlobalProtocols,
  IdAllHeaderCoders,
  SysUtils;

const
  csAddressSpecials: String = '()[]<>:;.,@\"';  {Do not Localize}

  base64_tbl: array [0..63] of Char = (
    'A','B','C','D','E','F','G','H',     {Do not Localize}
    'I','J','K','L','M','N','O','P',      {Do not Localize}
    'Q','R','S','T','U','V','W','X',      {Do not Localize}
    'Y','Z','a','b','c','d','e','f',      {Do not Localize}
    'g','h','i','j','k','l','m','n',      {Do not Localize}
    'o','p','q','r','s','t','u','v',       {Do not Localize}
    'w','x','y','z','0','1','2','3',       {Do not Localize}
    '4','5','6','7','8','9','+','/');      {Do not Localize}

function EncodeAddressItem(EmailAddr: TIdEmailAddressItem; const HeaderEncoding: Char;
  const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
var
  S : string;
  I : Integer;
  NeedEncode : Boolean;
begin
  if AUseAddressForNameIfNameMissing and (EmailAddr.Name = '') then begin
    {CC: Use Address as Name...}
    EmailAddr.Name := EmailAddr.Address;
  end;
  if EmailAddr.Name <> '' then  {Do not Localize}
  begin
    NeedEncode := False;
    for I := 1 to Length(EmailAddr.Name) do begin
      if (EmailAddr.Name[I] < #32) or (EmailAddr.Name[I] >= #127) then
      begin
        NeedEncode := True;
        Break;
      end;
    end;
    if NeedEncode then begin
      S := EncodeHeader(EmailAddr.Name, csAddressSpecials, HeaderEncoding, MimeCharSet);
    end else begin
      { quoted string }
      S := '"';           {Do not Localize}
      for I := 1 to Length(EmailAddr.Name) do
      begin              { quote special characters }
        if (EmailAddr.Name[I] = '\') or (EmailAddr.Name[I] = '"') then begin
          S := S + '\';    {Do not Localize}
        end;
        S := S + EmailAddr.Name[I];
      end;
      S := S + '"';   {Do not Localize}
    end;
    Result := IndyFormat('%s <%s>', [S, EmailAddr.Address])    {Do not Localize}
  end
  else begin
    Result := IndyFormat('%s', [EmailAddr.Address]);     {Do not Localize}
  end;
end;

function B64(AChar: Char): Byte;
//TODO: Make this use the more efficient MIME Coder
begin
  for Result := Low(base64_tbl) to High(base64_tbl) do begin
    if AChar = base64_tbl[Result] then begin
      Exit;
    end;
  end;
  Result := 0;
end;

function DecodeHeader(const Header: string): string;
var
  HeaderCharSet, HeaderEncoding, HeaderData, S: string;
  LDecoded: Boolean;
  LStartPos, LLength, LEncodingStartPos, LEncodingEndPos, LLastStartPos: Integer;
  LLastWordWasEncoded: Boolean;
  Buf: TIdBytes;

  function ExtractEncoding(const AHeader: string; const AStartPos: Integer;
    var VStartPos, VEndPos: Integer; var VCharSet, VEncoding, VData: String): Boolean;
  var
    LCharSet, LCharSetEnd, LEncoding, LEncodingEnd, LData, LDataEnd: Integer;
  begin
    Result := False;

    //we need a '=? followed by 2 question marks followed by a '?='.    {Do not Localize}
    //to find the end of the substring, we can't just search for '?=',    {Do not Localize}
    //example: '=?ISO-8859-1?Q?=E4?='    {Do not Localize}

    LCharSet := PosIdx('=?', AHeader, AStartPos);  {Do not Localize}
    if (LCharSet = 0) or (LCharSet > VEndPos) then begin
      Exit;
    end;
    Inc(LCharSet, 2);

    // ignore language, if present
    LCharSetEnd := FindFirstOf('*?', AHeader, -1, LCharSet);  {Do not Localize}
    if (LCharSetEnd = 0) or (LCharSetEnd > VEndPos) then begin
      Exit;
    end;
    if AHeader[LCharSetEnd] = '*' then begin
      LEncoding := PosIdx('?', AHeader, LCharSetEnd);  {Do not Localize}
      if (LEncoding = 0) or (LEncoding > VEndPos) then begin
        Exit;
      end;
    end else begin
      LEncoding := LCharSetEnd;
    end;
    Inc(LEncoding);

    LEncodingEnd := PosIdx('?', AHeader, LEncoding);  {Do not Localize}
    if (LEncodingEnd = 0) or (LEncodingEnd > VEndPos) then begin
      Exit;
    end;
    LData := LEncodingEnd+1;

    LDataEnd := PosIdx('?=', AHeader, LData);  {Do not Localize}
    if (LDataEnd = 0) or (LDataEnd > VEndPos) then begin
      Exit;
    end;

    VStartPos := LCharSet-2;
    VEndPos := LDataEnd+1;
    VCharSet := Copy(AHeader, LCharSet, LCharSetEnd-LCharSet);
    VEncoding := Copy(AHeader, LEncoding, LEncodingEnd-LEncoding);
    VData := Copy(AHeader, LData, LDataEnd-LData);

    Result := True;
  end;

  // TODO: use TIdCoderQuotedPrintable and TIdCoderMIME instead
  function ExtractEncodedData(const AEncoding, AData: String; var VDecoded: TIdBytes): Boolean;
  var
    I, J: Integer;
    a3: TIdBytes;
    a4: array [0..3] of Byte;
  begin
    Result := False;
    SetLength(VDecoded, 0);
    case PosInStrArray(AEncoding, ['Q', 'B', '8'], False) of {Do not Localize}
      0: begin // quoted-printable
        I := 1;
        while I <= Length(AData) do begin
          if AData[i] = '_' then begin {Do not Localize}
            AppendByte(VDecoded, Ord(' '));    {Do not Localize}
          end
          else if (AData[i] = '=') and (Length(AData) >= (i+2)) then begin //make sure we can access i+2
            AppendByte(VDecoded, IndyStrToInt('$' + Copy(AData, i+1, 2), 32));   {Do not Localize}
            Inc(I, 2);
          end else
          begin
            AppendByte(VDecoded, Ord(AData[i]));
          end;
          Inc(I);
        end;
        Result := True;
      end;
      1: begin // base64
        J := Length(AData) div 4;
        if J > 0 then
        begin
          SetLength(a3, 3);
          for I := 0 to J-1 do
          begin
            a4[0] := B64(AData[(I*4)+1]);
            a4[1] := B64(AData[(I*4)+2]);
            a4[2] := B64(AData[(I*4)+3]);
            a4[3] := B64(AData[(I*4)+4]);

            a3[0] := Byte((a4[0] shl 2) or (a4[1] shr 4));
            a3[1] := Byte((a4[1] shl 4) or (a4[2] shr 2));
            a3[2] := Byte((a4[2] shl 6) or (a4[3] shr 0));

            if AData[(I*4)+4] = '=' then begin
              if AData[(I*4)+3] = '=' then begin
                AppendByte(VDecoded, a3[0]);
              end else begin
                AppendBytes(VDecoded, a3, 0, 2);
              end;
              Break;
            end else begin
              AppendBytes(VDecoded, a3, 0, 3);
            end;
          end;
        end;
        Result := True;
      end;
      2: begin // 8-bit
        {$IFDEF STRING_IS_ANSI}
        if AData <> '' then begin
          VDecoded := RawToBytes(AData[1], Length(AData));
        end;
        {$ELSE}
        VDecoded := IndyTextEncoding_8Bit.GetBytes(AData);
        {$ENDIF}
        Result := True;
      end;
    end;
  end;

begin
  Result := Header;

  LStartPos := 1;
  LLength := Length(Result);

  LLastWordWasEncoded := False;
  LLastStartPos := LStartPos;

  while LStartPos <= LLength do
  begin
    // valid encoded words can not contain spaces
    // if the user types something *almost* like an encoded word,
    // and its sent as-is, we need to find this!!
    LStartPos := FindFirstNotOf(LWS+CR+LF, Result, LLength, LStartPos);
    if LStartPos = 0 then begin
      Break;
    end;
    LEncodingEndPos := FindFirstOf(LWS+CR+LF, Result, LLength, LStartPos);
    if LEncodingEndPos <> 0 then begin
      Dec(LEncodingEndPos);
    end else begin
      LEncodingEndPos := LLength;
    end;
    if ExtractEncoding(Result, LStartPos, LEncodingStartPos, LEncodingEndPos, HeaderCharSet, HeaderEncoding, HeaderData) then
    begin
      LDecoded := False;
      if ExtractEncodedData(HeaderEncoding, HeaderData, Buf) then begin
        LDecoded := DecodeHeaderData(HeaderCharSet, Buf, S);
      end;
      if LDecoded then
      begin
        //replace old substring in header with decoded string,
        // ignoring whitespace that separates encoded words:
        if LLastWordWasEncoded then begin
          Result := Copy(Result, 1, LLastStartPos - 1) + S + Copy(Result, LEncodingEndPos + 1, MaxInt);
          LStartPos := LLastStartPos + Length(S);
        end else begin
          Result := Copy(Result, 1, LEncodingStartPos - 1) + S + Copy(Result, LEncodingEndPos + 1, MaxInt);
          LStartPos := LEncodingStartPos + Length(S);
        end;
      end else
      begin
        // could not decode the data, so preserve it in case the user
        // wants to do it manually.  Though, they really should use the
        // IdHeaderCoderBase.GHeaderDecodingNeeded hook for that instead...
        LStartPos := LEncodingEndPos + 1;
      end;
      LLength := Length(Result);
      LLastWordWasEncoded := True;
      LLastStartPos := LStartPos;
    end else
    begin
      LStartPos := FindFirstOf(LWS+CR+LF, Result, LLength, LStartPos);
      if LStartPos = 0 then begin
        Break;
      end;
      LLastWordWasEncoded := False;
    end;
  end;
end;

procedure DecodeAddress(EMailAddr : TIdEmailAddressItem);
begin
  EMailAddr.Name := UnquotedStr(DecodeHeader(EMailAddr.Name));
end;

procedure DecodeAddresses(AEMails : String; EMailAddr: TIdEmailAddressList);
var
  idx : Integer;
begin
  EMailAddr.EMailAddresses := AEMails;
  for idx := 0 to EMailAddr.Count-1 do begin
    DecodeAddress(EMailAddr[idx]);
  end;
end;

function EncodeAddress(EmailAddr: TIdEMailAddressList; const HeaderEncoding: Char;
  const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
var
  idx : Integer;
begin
  if EmailAddr.Count > 0 then begin
    Result := EncodeAddressItem(EMailAddr[0], HeaderEncoding, MimeCharSet, AUseAddressForNameIfNameMissing);
    for idx := 1 to EmailAddr.Count-1 do begin
      Result := Result + ', ' +    {Do not Localize}
        EncodeAddressItem(EMailAddr[idx], HeaderEncoding, MimeCharSet, AUseAddressForNameIfNameMissing);
    end;
  end else begin
    Result := '';      {Do not Localize}
  end;
end;

{ encode a header field if non-ASCII characters are used }
function EncodeHeader(const Header: string; Specials: String; const HeaderEncoding: Char;
  const MimeCharSet: string): string;
const
  SPACES = [Ord(' '), 9, 13, 10];    {Do not Localize}
var
  T: string;
  Buf: TIdBytes;
  L, P, Q, R: Integer;
  B0, B1, B2: Integer;
  InEncode: Integer;
  NeedEncode: Boolean;
  csNoEncode, csNoReqQuote, csSpecials: TIdBytes;
  BeginEncode, EndEncode: string;

  procedure EncodeWord(AP: Integer);
  const
    MaxEncLen = 75;
  var
    LQ: Integer;
    EncLen: Integer;
    Enc1: string;
  begin
    T := T + BeginEncode;
    if L < AP then AP := L + 1;
    LQ := InEncode;
    InEncode := -1;
    EncLen := Length(BeginEncode) + 2;

    case PosInStrArray(HeaderEncoding, ['Q', 'B'], False) of {Do not Localize}
      0: begin { quoted-printable }
        while LQ < AP do
        begin
          if Buf[LQ] = Ord(' ') then begin {Do not Localize}
            Enc1 := '_';  {Do not Localize}
          end
          else if (not ByteIsInSet(Buf, LQ, csNoReqQuote)) or ByteIsInSet(Buf, LQ, csSpecials) then begin
            Enc1 := '=' + IntToHex(Buf[LQ], 2);     {Do not Localize}
          end
          else begin
            Enc1 := Char(Buf[LQ]);
          end;
          if (EncLen + Length(Enc1)) > MaxEncLen then begin
            //T := T + EndEncode + #13#10#9 + BeginEncode;
            //CC: The #13#10#9 above caused the subsequent call to FoldWrapText to
            //insert an extra #13#10 which, being a blank line in the headers,
            //was interpreted by email clients, etc., as the end of the headers
            //and the start of the message body.  FoldWrapText seems to look for
            //and treat correctly the sequence #13#10 + ' ' however...
            T := T + EndEncode + EOL + ' ' + BeginEncode;
            EncLen := Length(BeginEncode) + 2;
          end;
          T := T + Enc1;
          Inc(EncLen, Length(Enc1));
          Inc(LQ);
        end;
      end;
      1: begin { base64 }
        while LQ < AP do begin
          if (EncLen + 4) > MaxEncLen then begin
            //T := T + EndEncode + #13#10#9 + BeginEncode;
            //CC: The #13#10#9 above caused the subsequent call to FoldWrapText to
            //insert an extra #13#10 which, being a blank line in the headers,
            //was interpreted by email clients, etc., as the end of the headers
            //and the start of the message body.  FoldWrapText seems to look for
            //and treat correctly the sequence #13#10 + ' ' however...
            T := T + EndEncode + EOL + ' ' + BeginEncode;
            EncLen := Length(BeginEncode) + 2;
          end;

          B0 := Buf[LQ];
          case AP - LQ of
            1:
              begin
                T := T + base64_tbl[B0 shr 2] + base64_tbl[B0 and $03 shl 4] + '==';  {Do not Localize}
              end;
            2:
              begin
                B1 := Buf[LQ + 1];
                T := T + base64_tbl[B0 shr 2] +
                  base64_tbl[B0 and $03 shl 4 + B1 shr 4] +
                  base64_tbl[B1 and $0F shl 2] + '=';  {Do not Localize}
              end;
            else
              begin
                B1 := Buf[LQ + 1];
                B2 := Buf[LQ + 2];
                T := T + base64_tbl[B0 shr 2] +
                  base64_tbl[B0 and $03 shl 4 + B1 shr 4] +
                  base64_tbl[B1 and $0F shl 2 + B2 shr 6] +
                  base64_tbl[B2 and $3F];
              end;
          end;
          Inc(EncLen, 4);
          Inc(LQ, 3);
        end;
      end;
    end;
    T := T + EndEncode;
  end;

  function CreateEncodeRange(AStart, AEnd: Byte): TIdBytes;
  var
    I: Integer;
  begin
    SetLength(Result, AEnd-AStart+1);
    for I := 0 to Length(Result)-1 do begin
      Result[I] := AStart+I;
    end;
  end;

begin
  if Header = '' then begin
    Result := '';
    Exit;
  end;

  // TODO: this function needs to take encoded codeunits into account when
  // deciding where to split the encoded data between adjacent encoded-words,
  // so that a single encoded character does not get split between encoded-words
  // thus corrupting that character...

  Buf := EncodeHeaderData(MimeCharSet, Header);

  {Suggested by Andrew P.Rybin for easy 8bit support}
  if HeaderEncoding = '8' then begin {Do not Localize}
    Result := BytesToStringRaw(Buf);
    Exit;
  end;//if

  // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...

  // RLebeau 2/12/09: changed the logic to use "no-encode" sets instead, so
  // that words containing codeunits outside the ASCII range are always
  // encoded.  This is easier to manage when Unicode data is involved.
  
  csNoEncode := CreateEncodeRange(32, 126);

  csNoReqQuote := CreateEncodeRange(33, 60);
  AppendByte(csNoReqQuote, 62);
  AppendBytes(csNoReqQuote, CreateEncodeRange(64, 94));
  AppendBytes(csNoReqQuote, CreateEncodeRange(96, 126));

  csSpecials := ToBytes(Specials, IndyTextEncoding_8Bit);

  BeginEncode := '=?' + MimeCharSet + '?' + HeaderEncoding + '?';    {Do not Localize}
  EndEncode := '?=';  {Do not Localize}

  // JMBERG: We want to encode stuff that the user typed
  // as if it already is encoded!!
  if DecodeHeader(Header) <> Header then begin
    RemoveBytes(csNoEncode, 1, ByteIndex(Ord('='), csNoEncode));
  end;

  L := Length(Buf);
  P := 0;
  T := '';  {Do not Localize}
  InEncode := -1;
  while P < L do
  begin
    Q := P;
    while (P < L) and (Buf[P] in SPACES) do begin
      Inc(P);
    end;
    R := P;
    NeedEncode := False;
    while (P < L) and (not (Buf[P] in SPACES)) do begin
      if (not ByteIsInSet(Buf, P, csNoEncode)) or ByteIsInSet(Buf, P, csSpecials) then begin
        NeedEncode := True;
      end;
      Inc(P);
    end;
    if NeedEncode then begin
      if InEncode = -1 then begin
        T := T + BytesToString(Buf, Q, R - Q);
        InEncode := R;
      end;
    end else
    begin
      if InEncode <> -1 then begin
        EncodeWord(Q);
      end;
      T := T + BytesToString(Buf, Q, P - Q);
    end;
  end;
  if InEncode <> -1 then begin
    EncodeWord(P);
  end;
  Result := T;
end;

end.
