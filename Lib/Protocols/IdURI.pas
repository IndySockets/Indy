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
}
{
  $Log$
}
{
  Rev 1.9    10.10.2004 13:46:00  ARybin
  dont add default port to URI

  Rev 1.8    2004.02.03 5:44:40 PM  czhower
  Name changes

  Rev 1.7    2004.01.22 5:27:24 PM  czhower
  Fixed compile errors.

  Rev 1.6    1/22/2004 4:06:56 PM  SPerry
  fixed set problems

  Rev 1.5    10/5/2003 11:44:24 PM  GGrieve
  Use IsLeadChar

  Rev 1.4    6/9/2003 9:35:58 PM  BGooijen
  %00 is valid now too

  Rev 1.3    2003.05.09 10:30:16 PM  czhower

  Rev 1.2    2003.04.11 9:41:34 PM  czhower

  Rev 1.1    29/11/2002 9:56:10 AM  SGrobety    Version: 1.1
  Changed URL encoding

  Rev 1.0    21/11/2002 12:42:52 PM  SGrobety    Version: Indy 10

  Rev 1.0    11/13/2002 08:04:10 AM  JPMugaas
}

unit IdURI;

{Details of implementation
-------------------------
2002-Apr-14 Peter Mee
- Fixed reset.  Now resets FParams as well - wasn't before.
2001-Nov Doychin Bondzhev
 - Fixes in URLEncode. There is difference when encoding Path+Doc and Params
2001-Oct-17 Peter Mee
 - Minor speed improvement - removed use of NormalizePath in SetURI.
 - Fixed bug that was cutting off the first two chars of the host when a
    username / password present.
 - Fixed bug that prevented username and password being updated.
 - Fixed bug that was leaving the bookmark in the document when no ? or =
    parameters existed.
2001-Feb-18 Doychin Bondzhev
 - Added UserName and Password to support URI's like
    http://username:password@hostname:port/path/document#bookmark
}

interface

{$i IdCompilerDefines.inc}

uses
  IdException,
  IdGlobal;

type
  TIdURIOptionalFields = (ofAuthInfo, ofBookmark);
  TIdURIOptionalFieldsSet = set of TIdURIOptionalFields;

  TIdURI = class
  protected
    FDocument: string;
    FProtocol: string;
    FURI: String;
    FPort: string;
    Fpath: string;
    FHost: string;
    FBookmark: string;
    FUserName: string;
    FPassword: string;
    FParams: string;
    FIPVersion: TIdIPVersion;
    //
    procedure SetURI(const Value: String);
    function GetURI: String;
  public
    constructor Create(const AURI: string = ''); virtual;    {Do not Localize}
    function GetFullURI(const AOptionalFields: TIdURIOptionalFieldsSet = [ofAuthInfo, ofBookmark]): String;
    function GetPathAndParams: String;
    class procedure NormalizePath(var APath: string);
    class function URLDecode(ASrc: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    class function URLEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    class function ParamsEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    class function PathEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string;
    //
    property Bookmark : string read FBookmark write FBookMark;
    property Document: string read FDocument write FDocument;
    property Host: string read FHost write FHost;
    property Password: string read FPassword write FPassword;
    property Path: string read FPath write FPath;
    property Params: string read FParams write FParams;
    property Port: string read FPort write FPort;
    property Protocol: string read FProtocol write FProtocol;
    property URI: string read GetURI write SetURI;
    property Username: string read FUserName write FUserName;
    property IPVersion : TIdIPVersion read FIPVersion write FIPVersion;
  end;

  EIdURIException = class(EIdException);

implementation

uses
  IdGlobalProtocols, IdResourceStringsProtocols, IdUriUtils,
  SysUtils;

{ TIdURI }

constructor TIdURI.Create(const AURI: string = '');    {Do not Localize}
begin
  inherited Create;
  if length(AURI) > 0 then begin
    URI := AURI;
  end;
end;

class procedure TIdURI.NormalizePath(var APath: string);
var
  i, PathLen: Integer;
  LChar: Char;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := nil;
  {$ENDIF}

  // Normalize the directory delimiters to follow the UNIX syntax

  // RLebeau 8/10/2010: only normalize within the actual path,
  // nothing outside of it...

  i := Pos(':', APath);  {do not localize}
  if i > 0 then begin
    Inc(i);
    // if the path does not already begin with '//', then do not
    // normalize the first two characters if they would produce
    // '//', as that will change the semantics of the URL...
    if CharIsInSet(APath, I, '\/') and CharIsInSet(APath, I+1, '\/') then begin
      Inc(i, 2);
    end;
  end else begin
    i := 1;
  end;

  PathLen := Length(APath);
  while i <= PathLen do begin
    LChar := APath[i];
    {$IFDEF STRING_IS_ANSI}
    if IsLeadChar(LChar) then begin
      Inc(i, 2);
      Continue;
    end;
    {$ENDIF}
    if (LChar = '?') or (LChar = '#') then begin {Do not Localize}
      // stop normalizing at query/fragment portion of the URL
      Break;
    end;
    if LChar = '\' then begin    {Do not Localize}
      {$IFDEF STRING_IS_IMMUTABLE}
      if LSB = nil then begin
        LSB := TIdStringBuilder.Create(APath);
      end;
      LSB[i-1] := '/';    {Do not Localize}
      {$ELSE}
      APath[i] := '/';    {Do not Localize}
      {$ENDIF}
    end;
    Inc(i);
  end;

  {$IFDEF STRING_IS_IMMUTABLE}
  if LSB <> nil then begin
    APath := LSB.ToString;
  end;
  {$ENDIF}
end;

procedure TIdURI.SetURI(const Value: String);
var
  LBuffer: string;
  LTokenPos: Integer;
  LURI: string;
begin
  FURI := Value;
  NormalizePath(FURI);
  LURI := FURI;
  FHost := '';    {Do not Localize}
  FProtocol := '';    {Do not Localize}
  FPath := '';    {Do not Localize}
  FDocument := '';    {Do not Localize}
  FPort := '';    {Do not Localize}
  FBookmark := '';    {Do not Localize}
  FUsername := '';    {Do not Localize}
  FPassword := '';    {Do not Localize}
  FParams := '';  {Do not localise}  //Peter Mee
  FIPVersion := Id_IPv4;

  LTokenPos := IndyPos('://', LURI);    {Do not Localize}
  if (LTokenPos = 0) and TextStartsWith(LURI, '//') then begin {Do not Localize}
    LTokenPos := 1;
  end;
  if LTokenPos > 0 then begin
    // absolute URI
    // What to do when data don't match configuration ??    {Do not Localize}
    // Get the protocol
    if LURI[LTokenPos] = ':' then begin {Do not Localize}
      FProtocol := Copy(LURI, 1, LTokenPos - 1);
      Delete(LURI, 1, LTokenPos + 2);
    end else begin
      Delete(LURI, 1, LTokenPos + 1);
    end;
    // separate the path from the parameters
    LTokenPos := IndyPos('?', LURI);    {Do not Localize}
    // RLebeau: this is BAD! It messes up JSP and similar URLs that use '=' characters in the document
    {if LTokenPos = 0 then begin
      LTokenPos := IndyPos('=', LURI);    {Do not Localize
    end;}
    if LTokenPos > 0 then begin
      FParams := Copy(LURI, LTokenPos + 1, MaxInt);
      LURI := Copy(LURI, 1, LTokenPos - 1);
      // separate the bookmark from the parameters
      LTokenPos := IndyPos('#', FParams);    {Do not Localize}
      if LTokenPos > 0 then begin   {Do not Localize}
        FBookmark := FParams;
        FParams := Fetch(FBookmark, '#');       {Do not Localize}
      end;
    end else begin
      // separate the path from the bookmark
      LTokenPos := IndyPos('#', LURI);    {Do not Localize}
      if LTokenPos > 0 then begin   {Do not Localize}
        FBookmark := Copy(LURI, LTokenPos + 1, MaxInt);
        LURI := Copy(LURI, 1, LTokenPos - 1);
      end;
    end;
    // Get the user name, password, host and the port number
    LBuffer := Fetch(LURI, '/', True);    {Do not Localize}
    // Get username and password
    LTokenPos := RPos('@', LBuffer);    {Do not Localize}
    if LTokenPos > 0 then begin
      FPassword := Copy(LBuffer, 1, LTokenPos  - 1);
      Delete(LBuffer, 1, LTokenPos);
      FUserName := Fetch(FPassword, ':');    {Do not Localize}
      // Ignore cases where there is only password (http://:password@host/pat/doc)
      if Length(FUserName) = 0 then begin
        FPassword := '';    {Do not Localize}
      end;
    end;
    // Get the host and the port number
    if (IndyPos('[', LBuffer) > 0) and (IndyPos(']', LBuffer) > IndyPos('[', LBuffer)) then begin {Do not Localize}
      //This is for IPv6 Hosts
      FHost := Fetch(LBuffer, ']'); {Do not Localize}
      Fetch(FHost, '['); {Do not Localize}
      Fetch(LBuffer, ':'); {Do not Localize}
      FIPVersion := Id_IPv6;
    end else begin
      FHost := Fetch(LBuffer, ':', True);    {Do not Localize}
    end;
    FPort := LBuffer;
    // Get the path
    LTokenPos := RPos('/', LURI, -1);
    if LTokenPos > 0 then begin
      FPath := '/' + Copy(LURI, 1, LTokenPos);    {Do not Localize}
      Delete(LURI, 1, LTokenPos);
    end else begin
      FPath := '/';    {Do not Localize}
    end;
  end else begin
    // received an absolute path, not an URI
    LTokenPos := IndyPos('?', LURI);    {Do not Localize}
    // RLebeau: this is BAD! It messes up JSP and similar URLs that use '=' characters in the document
    {if LTokenPos = 0 then begin
      LTokenPos := IndyPos('=', LURI);    {Do not Localize
    end;}
    if LTokenPos > 0 then begin // The case when there is parameters after the document name
      FParams := Copy(LURI, LTokenPos + 1, MaxInt);
      LURI := Copy(LURI, 1, LTokenPos - 1);
      // separate the bookmark from the parameters
      LTokenPos := IndyPos('#', FParams);    {Do not Localize}
      if LTokenPos > 0 then begin
        FBookmark := FParams;
        FParams := Fetch(FBookmark, '#');       {Do not Localize}
      end;
    end else begin
      // separate the bookmark from the path
      LTokenPos := IndyPos('#', LURI);    {Do not Localize}
      if LTokenPos > 0 then begin // The case when there is a bookmark after the document name
        FBookmark := Copy(LURI, LTokenPos + 1, MaxInt);
        LURI := Copy(LURI, 1, LTokenPos - 1);
      end;
    end;
    // Get the path
    LTokenPos := RPos('/', LURI, -1);    {Do not Localize}
    if LTokenPos > 0 then begin
      FPath := Copy(LURI, 1, LTokenPos);
      Delete(LURI, 1, LTokenPos);
    end;
  end;
  // Get the document
  FDocument := LURI;
end;

function TIdURI.GetURI: String;
begin
  FURI := GetFullURI;
  // Result must contain only the proto://host/path/document
  // If you need the full URI then you have to call GetFullURI
  Result := GetFullURI([]);
end;

class function TIdURI.URLDecode(ASrc: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  i, SrcLen: Integer;
  ESC: string;
  LChars: TIdWideChars;
  LBytes: TIdBytes;
begin
  Result := '';    {Do not Localize}
  LChars := nil;
  LBytes := nil;
  EnsureEncoding(AByteEncoding, encUTF8);
  // S.G. 27/11/2002: Spaces is NOT to be encoded as "+".
  // S.G. 27/11/2002: "+" is a field separator in query parameter, space is...
  // S.G. 27/11/2002: well, a space
  // ASrc := ReplaceAll(ASrc, '+', ' ');  {do not localize}
  i := 1;
  SrcLen := Length(ASrc);
  while i <= SrcLen do begin
    if ASrc[i] <> '%' then begin  {do not localize}
      AppendByte(LBytes, Ord(ASrc[i])); // Copy the char
      Inc(i); // Then skip it
    end else begin
      Inc(i); // skip the % char
      if not CharIsInSet(ASrc, i, 'uU') then begin  {do not localize}
        // simple ESC char
        ESC := Copy(ASrc, i, 2); // Copy the escape code
        Inc(i, 2); // Then skip it.
        try
          AppendByte(LBytes, Byte(IndyStrToInt('$' + ESC))); {do not localize}
        except end;
      end else
      begin
        // unicode ESC code

        // RLebeau 5/10/2006: under Win32, the character will likely end
        // up as '?' in the Result when converted from Unicode to Ansi,
        // but at least the URL will be parsed properly

        ESC := Copy(ASrc, i+1, 4); // Copy the escape code
        Inc(i, 5); // Then skip it.
        try
          if LChars = nil then begin
            SetLength(LChars, 1);
          end;
          LChars[0] := WideChar(IndyStrToInt('$' + ESC));  {do not localize}
          AppendBytes(LBytes, AByteEncoding.GetBytes(LChars));
        except end;
      end;
    end;
  end;
  {$IFDEF STRING_IS_UNICODE}
  Result := AByteEncoding.GetString(LBytes);
  {$ELSE}
  EnsureEncoding(ADestEncoding, encOSDefault);
  CheckByteEncoding(LBytes, AByteEncoding, ADestEncoding);
  SetString(Result, PAnsiChar(LBytes), Length(LBytes));
    {$IFDEF HAS_SetCodePage}
  // on compilers that support AnsiString codepages,
  // set the string's codepage to match ADestEncoding...
  SetCodePage(PRawByteString(@Result)^, GetEncodingCodePage(ADestEncoding), False);
    {$ENDIF}
  {$ENDIF}
end;

{$IFNDEF STRING_IS_UNICODE}
// RLebeau 6/16/2017: IdGlobal.IsHexidecimal() expects Ansi input, but we need
// a Unicode version here, so we don't truncate wide characters into something
// that happen to be valid hex characters...
function IsHexidecimal(const AChar: TIdWideChar): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ((AChar >= '0') and (AChar <= '9'))  {Do not Localize}
         or ((AChar >= 'A') and (AChar <= 'F'))  {Do not Localize}
         or ((AChar >= 'a') and (AChar <= 'f')); {Do not Localize}
end;
{$ENDIF}

function IsPercentEncoded(const ASrc: {$IFDEF STRING_IS_UNICODE}string{$ELSE}TIdWideChars{$ENDIF}; AIndex: Integer): Boolean;
begin
  {$IFDEF STRING_IS_UNICODE}
  Result := (AIndex + 2) <= Length(ASrc);
  {$ELSE}
  Result := (AIndex + 2) < Length(ASrc);
  {$ENDIF}
  if Result then begin
    Result := (ASrc[AIndex] = '%') {Do not Localize}
          and IsHexidecimal(ASrc[AIndex+1])
          and IsHexidecimal(ASrc[AIndex+2]);
  end;
end;

class function TIdURI.ParamsEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
const
  UnsafeChars: TIdUnicodeString = '*<>#%"{}|\^[]`';  {do not localize}
var
  I, J, SrcLen, CharLen, ByteLen: Integer;
  Buf: TIdBytes;
  {$IFDEF STRING_IS_ANSI}
  LChars: TIdWideChars;
  {$ENDIF}
  LChar: WideChar;
begin
  Result := '';    {Do not Localize}

  // keep the compiler happy
  Buf := nil;
  {$IFDEF STRING_IS_ANSI}
  LChars := nil;
  {$ENDIF}

  if ASrc = '' then begin
    Exit;
  end;

  EnsureEncoding(AByteEncoding, encUTF8);
  {$IFDEF STRING_IS_ANSI}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LChars := ASrcEncoding.GetChars(
    {$IFNDEF VCL_6_OR_ABOVE}
    // RLebeau: for some reason, Delphi 5 causes a "There is no overloaded
    // version of 'GetChars' that can be called with these arguments" compiler
    // error if the PByte type-cast is used, even though GetChars() actually
    // expects a PByte as input.  Must be a compiler bug, as it compiles fine
    // in Delphi 6.  So, converting to TIdBytes until I find a better solution...
    RawToBytes(PAnsiChar(ASrc)^, Length(ASrc))
    {$ELSE}
    PByte(PAnsiChar(ASrc)), Length(ASrc)
    {$ENDIF}
  );
  {$ENDIF}

  // 2 Chars to handle UTF-16 surrogates
  SetLength(Buf, AByteEncoding.GetMaxByteCount(2));

  I := 0;
  SrcLen := Length({$IFDEF STRING_IS_UNICODE}ASrc{$ELSE}LChars{$ENDIF});
  while I < SrcLen do
  begin
    // RLebeau 6/9/2017: if LChar is '%', check if it belongs to a pre-encoded
    // '%HH' octet, and if so then preserve the whole sequence as-is...

    if IsPercentEncoded({$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF}) then begin
      {$IFDEF STRING_IS_UNICODE}
      Result := Result + Copy(ASrc, I+1, 3);
      {$ELSE}
      for J := 0 to 2 do begin
        Result := Result + Char(LChars[I+J]);  {do not localize}
      end;
      {$ENDIF}
      Inc(I, 3);
    end else
    begin
      LChar := {$IFDEF STRING_IS_UNICODE}ASrc[I+1]{$ELSE}LChars[I]{$ENDIF};

      // S.G. 27/11/2002: Changed the parameter encoding: Even in parameters, a space
      // S.G. 27/11/2002: is much more likely to be meaning "space" than "this is
      // S.G. 27/11/2002: a new parameter"
      // S.G. 27/11/2002: ref: Message-ID: <3de30169@newsgroups.borland.com> borland.public.delphi.internet.winsock
      // S.G. 27/11/2002: Most low-ascii is actually Ok in parameters encoding.

      // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
      // may change characters >= #128 from their Ansi codepage value to their true
      // Unicode codepoint value, depending on the codepage used for the source code.
      // For instance, #128 may become #$20AC...

      if WideCharIsInSet(UnsafeChars, LChar) or (Ord(LChar) < 33) or (Ord(LChar) > 127) then
      begin
        CharLen := CalcUTF16CharLength(
          {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF}
          ); // calculate length including surrogates
        ByteLen := AByteEncoding.GetBytes(
          {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF},
          CharLen, Buf, 0); // explicit Unicode->Ansi conversion
        for J := 0 to ByteLen-1 do begin
          Result := Result + '%' + IntToHex(Ord(Buf[J]), 2);  {do not localize}
        end;
        Inc(I, CharLen);
      end else
      begin
        Result := Result + Char(LChar);
        Inc(I);
      end;
    end;
  end;
end;

class function TIdURI.PathEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
const
  UnsafeChars: TIdUnicodeString = '*<>#%"{}|\^[]`+';  {do not localize}
var
  I, J, SrcLen, CharLen, ByteLen: Integer;
  Buf: TIdBytes;
  {$IFDEF STRING_IS_ANSI}
  LChars: TIdWideChars;
  {$ENDIF}
  LChar: WideChar;
begin
  Result := '';    {Do not Localize}

  // keep the compiler happy
  Buf := nil;
  {$IFDEF STRING_IS_ANSI}
  LChars := nil;
  {$ENDIF}

  if ASrc = '' then begin
    Exit;
  end;

  EnsureEncoding(AByteEncoding, encUTF8);
  {$IFDEF STRING_IS_ANSI}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LChars := ASrcEncoding.GetChars(
    {$IFNDEF VCL_6_OR_ABOVE}
    // RLebeau: for some reason, Delphi 5 causes a "There is no overloaded
    // version of 'GetChars' that can be called with these arguments" compiler
    // error if the PByte type-cast is used, even though GetChars() actually
    // expects a PByte as input.  Must be a compiler bug, as it compiles fine
    // in Delphi 6.  So, converting to TIdBytes until I find a better solution...
    RawToBytes(PAnsiChar(ASrc)^, Length(ASrc))
    {$ELSE}
    PByte(PAnsiChar(ASrc)), Length(ASrc)
    {$ENDIF}
  );
  {$ENDIF}

  // 2 Chars to handle UTF-16 surrogates
  SetLength(Buf, AByteEncoding.GetMaxByteCount(2));

  I := 0;
  SrcLen := Length({$IFDEF STRING_IS_UNICODE}ASrc{$ELSE}LChars{$ENDIF});
  while I < SrcLen do
  begin
    // RLebeau 6/9/2017: if LChar is '%', check if it belongs to a pre-encoded
    // '%HH' octet, and if so then preserve the whole sequence as-is...

    if IsPercentEncoded({$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF}) then begin
      {$IFDEF STRING_IS_UNICODE}
      Result := Result + Copy(ASrc, I+1, 3);
      {$ELSE}
      for J := 0 to 2 do begin
        Result := Result + Char(LChars[I+J]);  {do not localize}
      end;
      {$ENDIF}
      Inc(I, 3);
    end else
    begin
      LChar := {$IFDEF STRING_IS_UNICODE}ASrc[I+1]{$ELSE}LChars[I]{$ENDIF};

      if WideCharIsInSet(UnsafeChars, LChar) or (Ord(LChar) < 33) or (Ord(LChar) > 127) then
      begin
        CharLen := CalcUTF16CharLength(
          {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF}
          ); // calculate length including surrogates
        ByteLen := AByteEncoding.GetBytes(
          {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF},
          CharLen, Buf, 0); // explicit Unicode->Ansi conversion
        for J := 0 to ByteLen-1 do begin
          Result := Result + '%' + IntToHex(Ord(Buf[J]), 2);  {do not localize}
        end;
        Inc(I, CharLen);
      end else
      begin
        Result := Result + Char(LChar);
        Inc(I);
      end;
    end;
  end;
end;

class function TIdURI.URLEncode(const ASrc: string; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LUri: TIdURI;
begin
  LUri := TIdURI.Create(ASrc);
  try
    LUri.Path := PathEncode(LUri.Path, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
      );
    LUri.Document := PathEncode(LUri.Document, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
      );
    LUri.Params := ParamsEncode(LUri.Params, AByteEncoding
      {$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}
      );
    Result := LUri.URI;
  finally
    LUri.Free;
  end;
end;

function TIdURI.GetFullURI(const AOptionalFields: TIdURIOptionalFieldsSet): String;
var
  LURI: String;
begin
  if FProtocol = '' then begin
    raise EIdURIException.Create(RSURINoProto);
  end;

  if FHost = '' then begin
    raise EIdURIException.Create(RSURINoHost);
  end;

  LURI := FProtocol + '://';    {Do not Localize}

  if (FUserName <> '') and (ofAuthInfo in AOptionalFields) then begin
    LURI := LURI + FUserName;
    if FPassword <> '' then begin
      LURI := LURI + ':' + FPassword;    {Do not Localize}
    end;
    LURI := LURI + '@';    {Do not Localize}
  end;

  if IPVersion = Id_IPv6 then begin
    LURI := LURI + '[' + FHost + ']';    {Do not Localize}
  end else begin
    LURI := LURI + FHost;
  end;

  if FPort <> '' then begin
    case PosInStrArray(FProtocol, ['HTTP', 'HTTPS', 'FTP'], False) of {Do not Localize}
      0:
        begin
          if FPort <> '80' then begin
            LURI := LURI + ':' + FPort;    {Do not Localize}
          end;
        end;
      1:
        begin
          if FPort <> '443' then begin
            LURI := LURI + ':' + FPort;    {Do not Localize}
          end;
        end;
      2:
        begin
          if FPort <> '21' then begin
            LURI := LURI + ':' + FPort;    {Do not Localize}
          end;
        end;
      else
        begin
          LURI := LURI + ':' + FPort;    {Do not Localize}
        end;
    end;
  end;

  LURI := LURI + GetPathAndParams;

  if (FBookmark <> '') and (ofBookmark in AOptionalFields) then begin
    LURI := LURI + '#' + FBookmark;    {Do not Localize}
  end;

  Result := LURI;
end;

function TIdURI.GetPathAndParams: String;
begin
  Result := FPath + FDocument;
  if FParams <> '' then begin
    Result := Result + '?' + FParams; {Do not Localize}
  end;
end;

end.
