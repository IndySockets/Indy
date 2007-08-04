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
  IdEMailAddress;

type
  TIdDecodeNeededEvent = procedure(Sender: TObject; const ACharSet, AData: String;
    var VResult: String) of object;
  
  TIdHeaderCoder = class(TIdComponent)
  public
    function Decode(const AData: String): String; virtual; abstract;
    function Encode(const AData: String): String; virtual; abstract;
    function CanHandle(const ACharSet: String): Boolean; virtual; abstract;
  end;

  TIdHeaderCoderList = class(TObject)
  protected
    FHeaderCoders: TList;
  public
    constructor Create;
    destructor Destroy; override;
    class function ByCharSet(const ACharSet: String): TIdHeaderCoder;
    class function Decode(const ACharSet, AData: String; ADecodeEvent: TIdDecodeNeededEvent = nil): String;
    class function Encode(const ACharSet, AData: String): String;
    class procedure RegisterCoder(ACoder: TIdHeaderCoder);
  end;

// Procs
  function EncodeAddressItem(EmailAddr: TIdEmailAddressItem; const HeaderEncoding: Char;
    const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
  function EncodeHeader(const Header: string; Specials: String; const HeaderEncoding: Char;
   const MimeCharSet: string): string;
  function EncodeAddress(EmailAddr: TIdEMailAddressList; const HeaderEncoding: Char;
    const MimeCharSet: string; AUseAddressForNameIfNameMissing: Boolean = False): string;
  function DecodeHeader(const Header: string; ADecodeEvent: TIdDecodeNeededEvent = nil): string;
  procedure DecodeAddress(EMailAddr: TIdEmailAddressItem; ADecodeEvent: TIdDecodeNeededEvent = nil);
  procedure DecodeAddresses(AEMails: String; EMailAddr: TIdEmailAddressList; ADecodeEvent: TIdDecodeNeededEvent = nil);

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  SysUtils;

const
  csSPECIALS: String = '()[]<>:;.,@\"';  {Do not Localize}

  base64_tbl: array [0..63] of Char = (
    'A','B','C','D','E','F','G','H',     {Do not Localize}
    'I','J','K','L','M','N','O','P',      {Do not Localize}
    'Q','R','S','T','U','V','W','X',      {Do not Localize}
    'Y','Z','a','b','c','d','e','f',      {Do not Localize}
    'g','h','i','j','k','l','m','n',      {Do not Localize}
    'o','p','q','r','s','t','u','v',       {Do not Localize}
    'w','x','y','z','0','1','2','3',       {Do not Localize}
    '4','5','6','7','8','9','+','/');      {Do not Localize}

var
  GHeaderCoderList: TIdHeaderCoderList = nil;

{ TIdHeaderDecoderList }

class function TIdHeaderCoderList.ByCharSet(const ACharSet: string): TIdHeaderCoder;
var
  I: Integer;
  LCoder: TIdHeaderCoder;
begin
  Result := nil;
  if Assigned(GHeaderCoderList) then begin
    // loop backwards so that user-defined coders can override native coders
    for I := GHeaderCoderList.FHeaderCoders.Count-1 downto 0 do begin
      LCoder := TIdHeaderCoder(GHeaderCoderList.FHeaderCoders[I]);
      if LCoder.CanHandle(ACharSet) then begin
        Result := LCoder;
        Exit;
      end;
    end;
  end;
end;

class function TIdHeaderCoderList.Decode(const ACharSet, AData: String;
  ADecodeEvent: TIdDecodeNeededEvent = nil): String;
var
  LCoder: TIdHeaderCoder;
begin
  LCoder := ByCharSet(ACharSet);
  if LCoder <> nil then begin
    Result := LCoder.Decode(AData);
  end
  else if Assigned(ADecodeEvent) then begin
    Result := '';
    ADecodeEvent(nil, ACharSet, AData, Result);
  end else begin
    Result := AData;
  end;
end;

class function TIdHeaderCoderList.Encode(const ACharSet, AData: string): String;
var
  LCoder: TIdHeaderCoder;
begin
  LCoder := ByCharSet(ACharSet);
  if LCoder <> nil then begin
    Result := LCoder.Encode(AData);
  end else begin
    Result := AData;
  end;
end;

constructor TIdHeaderCoderList.Create;
begin
  inherited Create;
  FHeaderCoders := TList.Create;
end;

destructor TIdHeaderCoderList.Destroy;
var
  i: Integer;
begin
  if Assigned(FHeaderCoders) then begin
    for i := 0 to FHeaderCoders.Count - 1 do begin
      TIdHeaderCoder(FHeaderCoders[i]).Free;
    end;
    FreeAndNil(FHeaderCoders);
  end;
  inherited Destroy;
end;

class procedure TIdHeaderCoderList.RegisterCoder(ACoder: TIdHeaderCoder);
begin
  if not Assigned(GHeaderCoderList) then begin
    GHeaderCoderList := TIdHeaderCoderList.Create;
  end;
  GHeaderCoderList.FHeaderCoders.Add(ACoder);
end;

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
      S := EncodeHeader(EmailAddr.Name, csSPECIALS, HeaderEncoding, MimeCharSet);
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

function DecodeHeader(const Header: string; ADecodeEvent: TIdDecodeNeededEvent = nil): string;
const
  WhiteSpace = LF+CR+CHAR32+TAB;
var
  HeaderCharSet, HeaderEncoding, HeaderData, S: string;
  LStartPos, LEncodingStartPos, LEncodingEndPos: Integer;

  function ContainsOnlyWhiteSpace(const S: String; const AStartPos, AEndPos: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := AStartPos to AEndPos do begin
      if CharIsInSet(S, I, WhiteSpace) then begin
        Result := True;
        Exit;
      end;
    end;
  end;

  function FindNextEncoding(const AHeader: String; const AStartPos: Integer;
    var VStartPos, VEndPos: Integer; var VCharSet, VEncoding, VData: String): Boolean;
  var
    LCharSet, LEncoding, LData, LDataEnd: Integer;
  begin
    Result := False;

    //we need a '=? followed by 2 question marks followed by a '?='.    {Do not Localize}
    //to find the end of the substring, we can't just search for '?=',    {Do not Localize}
    //example: '=?ISO-8859-1?Q?=E4?='    {Do not Localize}

    LCharSet := PosIdx('=?', AHeader, AStartPos); {do not localize}
    if LCharSet = 0 then begin
      Exit;
    end;
    Inc(LCharSet, 2);

    LEncoding := PosIdx('?', AHeader, LCharSet);  {Do not Localize}
    if LEncoding = 0 then begin
      Exit;
    end;
    Inc(LEncoding);

    LData := PosIdx('?', AHeader, LEncoding);  {Do not Localize}
    if LData = 0 then begin
      Exit;
    end;
    Inc(LData);

    LDataEnd := PosIdx('?=', AHeader, LData);  {Do not Localize}
    if LDataEnd = 0 then begin
      Exit;
    end;
    Inc(LDataEnd);

    // valid encoded words can not contain spaces
    // if the user types something *almost* like an encoded word,
    // and its sent as-is, we need to find this!!

    if ContainsOnlyWhiteSpace(AHeader, LCharSet, LEncoding-2) or
       ContainsOnlyWhiteSpace(AHeader, LEncoding, LData-2) or
       ContainsOnlyWhiteSpace(AHeader, LData, LDataEnd-2) then
    begin
      Exit;
    end;

    VStartPos := LCharSet-2;
    VEndPos := LDataEnd+1;

    VCharSet := Copy(AHeader, LCharSet, LEncoding-LCharSet-1);
    VEncoding := Copy(AHeader, LEncoding, LData-LEncoding-1);
    VData := Copy(AHeader, LData, LDataEnd-LData-1);

    Result := True;
  end;

  // TODO: use TIdCoderQuotedPrintable and TIdCoderMIME instead
  function DecodeHeaderData(const AEncoding, AData: String; var VDecoded: String): Boolean;
  var
    I, J: Integer;
    a3: array [1..3] of Byte;
    a4: array [1..4] of Byte;
  begin
    Result := False;
    if TextIsSame(AEncoding, 'Q') then begin {Do not Localize}
      VDecoded := '';        {Do not Localize}
      I := 1;
      while I <= Length(AData) do begin
        if AData[i] = '_' then begin {Do not Localize}
          VDecoded := VDecoded + ' ';    {Do not Localize}
        end
	else if (AData[i] = '=') and (Length(AData) >= (i+2)) then begin //make sure we can access i+2
          VDecoded := VDecoded + Chr(IndyStrToInt('$' + Copy(AData, i+1, 2), 32));   {Do not Localize}
          Inc(I, 2);
        end else
	begin
          VDecoded := VDecoded + AData[i];
        end;
        Inc(I);
      end;
      Result := True;
    end
    else if TextIsSame(AEncoding, 'B') then
    begin
      J := Length(AData) div 4;
      for I := 0 to J-1 do
      begin
        a4[1] := B64(AData[(I*4)+1]);
        a4[2] := B64(AData[(I*4)+2]);
        a4[3] := B64(AData[(I*4)+3]);
        a4[4] := B64(AData[(I*4)+4]);

        a3[1] := Byte((a4[1] shl 2) or (a4[2] shr 4));
        a3[2] := Byte((a4[2] shl 4) or (a4[3] shr 2));
        a3[3] := Byte((a4[3] shl 6) or (a4[4] shr 0));

        VDecoded := VDecoded + Chr(a3[1]) + Chr(a3[2]) + Chr(a3[3]);
      end;
      Result := True;
    end
    else if TextIsSame(HeaderEncoding, '8') then begin
      VDecoded := AData;
      Result := True;
    end;
  end;

begin
  LStartPos := 1;
  Result := Header;

  while FindNextEncoding(Result, LStartPos, LEncodingStartPos, LEncodingEndPos, HeaderCharSet, HeaderEncoding, HeaderData) do
  begin
    if DecodeHeaderData(HeaderEncoding, HeaderData, S) then
    begin
      S := TIdHeaderCoderList.Decode(HeaderCharSet, S, ADecodeEvent);
      //replace old substring in header with decoded one:
      Result := Copy(Result, 1, LEncodingStartPos - 1) + S + Copy(Result, LEncodingEndPos + 1, MaxInt);
      LStartPos := LEncodingStartPos + Length(S);
    end else begin
      LStartPos := LEncodingEndPos + 1;
    end;
  end;

  //There might be #0's in header when this is b64 encoded, e.g with:
  //decodeheader('"Fernando Corti=?ISO-8859-1?B?8Q==?=a" <fernando@nowhere.com>');
  repeat
    LStartPos := Pos(#0, Result);
    if LStartPos > 0 then begin
      Delete(Result, LStartPos, 1);
    end;
  until LStartPos = 0;
end;

procedure DecodeAddress(EMailAddr : TIdEmailAddressItem; ADecodeEvent: TIdDecodeNeededEvent = nil);
begin
  EMailAddr.Name := DecodeHeader(EMailAddr.Name, ADecodeEvent);
end;

procedure DecodeAddresses(AEMails : String; EMailAddr: TIdEmailAddressList;
  ADecodeEvent: TIdDecodeNeededEvent = nil);
var
  idx : Integer;
begin
  EMailAddr.EMailAddresses := AEMails;
  for idx := 0 to EMailAddr.Count-1 do begin
    DecodeAddress(EMailAddr[idx], ADecodeEvent);
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
function EncodeHeader(const Header: string; Specials: String; const HeaderEncoding: Char; const MimeCharSet: string): string;
const
  SPACES: String = ' ' + #9 + EOL;    {Do not Localize}
var
  S, T: string;
  L, P, Q, R: Integer;
  B0, B1, B2: Integer;
  InEncode: Integer;
  NeedEncode: Boolean;
  csNeedEncode, csReqQuote: String;
  BeginEncode, EndEncode: string;

  procedure EncodeWord(P: Integer);
  const
    MaxEncLen = 75;
  var
    Q: Integer;
    EncLen: Integer;
    Enc1: string;
  begin
    T := T + BeginEncode;
    if L < P then P := L + 1;
    Q := InEncode;
    InEncode := 0;
    EncLen := Length(BeginEncode) + 2;

    if TextIsSame(HeaderEncoding, 'Q') then begin { quoted-printable }   {Do not Localize}
      while Q < P do
      begin
        if not CharIsInSet(S, Q, csReqQuote) then begin
          Enc1 := S[Q];
        end
        else if S[Q] = ' ' then begin {Do not Localize}
          Enc1 := '_'   {Do not Localize}
        end else begin
          Enc1 := '=' + IntToHex(Ord(S[Q]), 2);     {Do not Localize}
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
        Inc(Q);
      end;
    end
    else if TextIsSame(HeaderEncoding, 'B') then begin { base64 } {Do not Localize}
      while Q < P do begin
        if (EncLen + 4) > MaxEncLen then begin
          //T := T + EndEncode + #13#10#9 + BeginEncode;
          //CC: The #13#10#9 above caused the subsequent call to FoldWrapText to
          //insert an extra #13#10 which, being a blank line in the headers,
          //was interpreted by email clients, etc., as the end of the headers
          //and the start of the message body.  FoldWrapText seems to look for
          //and treat correctly the sequence #13#10 + ' ' however...
          T := T + EndEncode + #13#10 + ' ' + BeginEncode;
          EncLen := Length(BeginEncode) + 2;
        end;

        B0 := Ord(S[Q]);
        case P - Q of
          1:
            begin
              T := T + base64_tbl[B0 shr 2] + base64_tbl[B0 and $03 shl 4] + '==';  {Do not Localize}
            end;
          2:
            begin
              B1 := Ord(S[Q + 1]);
              T := T + base64_tbl[B0 shr 2] +
                base64_tbl[B0 and $03 shl 4 + B1 shr 4] +
                base64_tbl[B1 and $0F shl 2] + '=';  {Do not Localize}
            end;
          else
            begin
              B1 := Ord(S[Q + 1]);
              B2 := Ord(S[Q + 2]);
              T := T + base64_tbl[B0 shr 2] +
                base64_tbl[B0 and $03 shl 4 + B1 shr 4] +
                base64_tbl[B1 and $0F shl 2 + B2 shr 6] +
                base64_tbl[B2 and $3F];
            end;
        end;
        Inc(EncLen, 4);
        Inc(Q, 3);
      end;
    end;
    T := T + EndEncode;
  end;

  function CreateEncodeRange(AStart, AEnd: Char): String;
  var
    LBuf: TIdBytes;
    I: Integer;
  begin
    SetLength(LBuf, Ord(AEnd)-Ord(AStart)+1);
    for I := 0 to Length(LBuf)-1 do begin
      LBuf[I] := Byte(Ord(AStart)+I);
    end;
    Result := BytesToString(LBuf);
  end;

begin
  S := TIdHeaderCoderList.Encode(MimeCharSet, Header);

  {Suggested by Andrew P.Rybin for easy 8bit support}
  if HeaderEncoding = '8' then begin {Do not Localize}
    Result := S;
    Exit;
  end;//if

  csNeedEncode := CreateEncodeRange(#0, #31) + CreateEncodeRange(#127, #255) + Specials;
  csReqQuote := csNeedEncode + '?=_';   {Do not Localize}
  BeginEncode := '=?' + MimeCharSet + '?' + HeaderEncoding + '?';    {Do not Localize}
  EndEncode := '?=';  {Do not Localize}

  // JMBERG: We want to encode stuff that the user typed
  // as if it already is encoded!!
  if DecodeHeader(Header) <> Header then begin
    csNeedEncode := csNeedEncode + '=';
  end;

  L := Length(S);
  P := 1;
  T := '';  {Do not Localize}
  InEncode := 0;
  while P <= L do
  begin
    Q := P;
    while (P <= L) and CharIsInSet(S, P, SPACES) do begin
      Inc(P);
    end;
    R := P;
    NeedEncode := False;
    while (P <= L) and (not CharIsInSet(S, P, SPACES)) do begin
      if CharIsInSet(S, P, csNeedEncode) then begin
        NeedEncode := True;
      end;
      Inc(P);
    end;
    if NeedEncode then begin
      if InEncode = 0 then begin
        T := T + Copy(S, Q, R - Q);
        InEncode := R;
      end;
    end else
    begin
      if InEncode <> 0 then begin
        EncodeWord(Q);
      end;
      T := T + Copy(S, Q, P - Q);
    end;
  end;
  if InEncode <> 0 then begin
    EncodeWord(P);
  end;
  Result := T;
end;

initialization
finalization
  FreeAndNil(GHeaderCoderList);

end.
