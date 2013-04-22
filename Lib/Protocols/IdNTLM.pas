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
  Rev 1.1    6/29/04 12:51:10 PM  RLebeau
  Updatd SetupLanManagerPassword() to check the password length before
  referencing the password data

  Rev 1.0    11/13/2002 07:58:08 AM  JPMugaas

  S.G. 12/7/2002:
    - Rewrote Type 1 and Type 2 structures to be closer to the
                    document referenced in the above URL. (Easier to read and check)
                  - Corrected falgs accouring to bug ID 577895 and own packet traces.
                    This was actually only an adjustment to the new data types when
                    I rewrote the header.
                  - Initialized structures to #0 before using.
}
{
  Implementation of the NTLM authentication as specified in
  http://www.innovation.ch/java/ntlm.html with some fixes
                  
  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.
}

unit IdNTLM;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdStruct;

type
  {$IFDEF DOTNET}
  ProtocolArray = array [1..8] of AnsiChar;
  padArray2 = array[0..1] of Byte;
  padArray3 = Array[0..2] of Byte;
  padArray7 = Array[0..6] of Byte;
  padArray8 = Array[0..7] of Byte;
  nonceArray = Array[1..8] of Byte;

  ntlm_base = class(TIdStruct)
  protected
    fprotocol : ProtocolArray;
    function GetBytesLen: LongWord; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  override;

    property protocol: ProtocolArray read fprotocol write fprotocol; // array [1..8] of Char;     // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
  end;

  type_1_message_header = class(ntlm_base)
  protected
    f_type : Byte;
    fpad : padArray3;
    fflags : Word;
    fpad2 : padArray2;
    fdom_len1 : Word;
    fdom_len2 : Word;
    fdom_off : LongWord;
    fhost_len1 : Word;
    fhost_len2 : Word;
    fhost_off : LongWord;
    function GetBytesLen: LongWord; override;

  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  override;

    property _type: Byte read f_type write f_type;                        // 0x01
    property pad  : padArray3 read fpad write fpad;  // 0x0
    property flags: Word read fflags write fflags;                        // 0xb203
    property pad2 : padArray2 read fpad2 write fpad2;  // 0x0
    property dom_len1: Word read fdom_len1 write fdom_len1;                     // domain string length
    property dom_len2: Word read fdom_len2 write fdom_len2;                     // domain string length
    property dom_off: LongWord read fdom_off write fdom_off;                  // domain string offset

    property host_len1: Word read fhost_len1 write fhost_len1;                    // host string length
    property host_len2: Word read fhost_len2 write fhost_len2;                    // host string length
    property host_off: LongWord read fhost_off write fhost_off;                 // host string offset (always 0x20)
  end;

  type_2_message_header = class(ntlm_base)
  protected
    f_type : Byte;
    fPad: padArray3;
    fhost_len1: Word;
    fhost_len2: Word;
    fhost_off: LongWord;
    fflags: Word;
    fPad2: padArray2;
    fnonce: nonceArray;
    freserved: padArray8;
    finfo_len1: Word;
    finfo_len2: Word;
    finfo_off: LongWord;

    function GetBytesLen: LongWord; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  override;

    property _type: Byte read f_type write f_type;       // $2
    property pad: padArray3 read fPad wrie fPad;
    property host_len1: Word read fhost_len1 write fhost_len1;
    property host_len2: Word read fhost_len2 write fhost_len2;
    property host_off: LongWord read fhost_off write fhost_off;
    property flags: Word read fflags write fflags;
    property pad2: padArray2 read fflags write fflags;
    property nonce: nonceArray read fnonce write fnonce;
    property reserved: padArray8 read freserved write freserved;
    property info_len1: Word read finfo_len1 write finfo_len1;
    property info_len2: Word read finfo_len2 write finfo_len2;
    property info_off: LongWord read finfo_off write finfo_off;
  end;

  type_3_message_header = class(ntlm_base)
  protected
    f_type: LongWord;
    flm_resp_len1: Word;
    flm_resp_len2: Word;
    flm_resp_off : LongWord;
    fnt_resp_len1: Word;
    fnt_resp_len2: Word;
    fnt_resp_off: LongWord;
    fdom_len1: Word;
    fdom_len2 : Word;
    fdom_off : LongWord;
    fuser_len1: Word;
    fuser_len2: Word;
    fuser_off: LongWord;
    fhost_len1: Word;
    fhost_len2: Word;
    fhost_off: LongWord;
    fkey_len1: Word;
    fkey_len2: Word;
    fkey_off: LonWord;
    fflags: LongWord;
    function GetBytesLen: LongWord; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  override;

    property _type: LongWord read f_type write f_type;                    // 0x03

    property lm_resp_len1: Word read flm_resp_len1 write flm_resp_len1;                 // LanManager response length (always 0x18)
    property lm_resp_len2: Word read flm_resp_len2 write flm_resp_len2;                 // LanManager response length (always 0x18)
    property lm_resp_off: LongWord read flm_resp_off write flm_resp_off;              // LanManager response offset

    property nt_resp_len1: Word read fnt_resp_len1 write fnt_resp_len1;                 // NT response length (always 0x18)
    property nt_resp_len2: Word read fnt_resp_len2 write fnt_resp_len2;                 // NT response length (always 0x18)
    property nt_resp_off: LongWord read fnt_resp_off write fnt_resp_off;              // NT response offset

    property dom_len1: Word read fdom_len1 write fdom_len1;           // domain string length
    property dom_len2: Word read fdom_len2 write fdom_len2;           // domain string length
    property dom_off: LongWord read fdom_off write fdom_off;          // domain string offset (always 0x40)

    property user_len1: Word read fuser_len1 write fuser_len1;                    // username string length
    property user_len2: Word read fuser_len2 write fuser_len2;                    // username string length
    property user_off: LongWord read fuser_off write fuser_off;                 // username string offset

    property host_len1: Word read fhost_len1 write fhost_len1;                    // host string length
    property host_len2: Word read fhost_len2 write fhost_len2;                    // host string length
    property host_off: LongWord read fhost_off write fhost_off;                 // host string offset

    property key_len1: Word read fkey_len1 write fkey_len1;                     // session key length
    property key_len2: Word read fkey_len2 write fkey_len2;                     // session key length
    property key_off: LongWord read fkey_off write fkey_off;                      // session key offset

    property flags: LongWord read fflags write fflags;                    // 0xA0808205
  end;
{$ELSE}
  type_1_message_header = packed record
    protocol: array [1..8] of Byte; // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
    _type: Byte;                        // 0x01
    pad  : packed Array[1..3] of Byte;  // 0x0
    flags: Word;                        // 0xb203
    pad2 : packed Array[1..2] of Byte;  // 0x0
    dom_len1: Word;                     // domain string length
    dom_len2: Word;                     // domain string length
    dom_off: LongWord;                  // domain string offset

    host_len1: Word;                    // host string length
    host_len2: Word;                    // host string length
    host_off: LongWord;                 // host string offset (always 0x20)
  end;

  type_2_message_header = packed record
    protocol: packed array [1..8] of Byte;  // 'N', 'T', 'L', 'M', 'S', 'S', 'P', #0    {Do not Localize}
    _type: Byte;                                // $2
    Pad: packed Array[1..3] of Byte;
    host_len1: Word;
    host_len2: Word;
    host_off: LongWord;
    flags: Word;
    Pad2: packed Array[1..2] of Byte;
    nonce: packed Array[1..8] of Byte;
    reserved: packed Array[1..8] of Byte;
    info_len1: Word;
    info_len2: Word;
    info_off: LongWord;
  end;

  type_3_message_header = packed record
    protocol: array [1..8] of Byte; // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
    _type: LongWord;                    // 0x03

    lm_resp_len1: Word;                 // LanManager response length (always 0x18)
    lm_resp_len2: Word;                 // LanManager response length (always 0x18)
    lm_resp_off: LongWord;              // LanManager response offset

    nt_resp_len1: Word;                 // NT response length (always 0x18)
    nt_resp_len2: Word;                 // NT response length (always 0x18)
    nt_resp_off: LongWord;              // NT response offset

    dom_len1: Word;                     // domain string length
    dom_len2: Word;                     // domain string length
    dom_off: LongWord;                  // domain string offset (always 0x40)

    user_len1: Word;                    // username string length
    user_len2: Word;                    // username string length
    user_off: LongWord;                 // username string offset

    host_len1: Word;                    // host string length
    host_len2: Word;                    // host string length
    host_off: LongWord;                 // host string offset

    key_len1: Word;                     // session key length
    key_len2: Word;                     // session key length
    key_off: LongWord;                  // session key offset
    
    flags: LongWord;                    // 0xA0808205
  end;

function BuildType1Message(const ADomain, AHost: String): String;
function BuildType3Message(const ADomain, AHost, AUsername: TIdUnicodeString; const APassword: String; const ANonce: TIdBytes): String;
{$ENDIF}

function NTLMFunctionsLoaded : Boolean;

procedure GetDomain(const AUserName : String; var VUserName, VDomain : String);

  //IMPORTANT!!!
  //
  //NTLM is a funny protocol because it was designed for little endian machines.
  //Some record values must be in little endian byte-orders.

const
  // S.G. 12/7/2002: Changed the flag to $B207 (from BugID 577895 and packet trace)
  //was $A000B207;     //b203;
  //JPM - note that this value has to be little endian.  We precalculate
  //this for big endian machines.
  MSG1_FLAGS : Word = $b207;
  // S.G. 12/7/2002: was: flags := $A0808205;  (from BugID 577895 and packet trace)
  MSG3_FLAGS : LongWord =  $018205;

implementation

uses
  {$IFDEF HAS_UNIT_AnsiStrings}
  AnsiStrings,
  {$ENDIF}
  SysUtils,
  {$IFDEF DOTNET}
  System.Text,
  {$ENDIF}
  IdFIPS,
  IdGlobalProtocols,
  IdHash,
  IdHashMessageDigest,
  IdCoderMIME
  {$IFNDEF DOTNET}, IdSSLOpenSSLHeaders{$ENDIF}
  ;

type
  Pdes_key_schedule = ^des_key_schedule;

const
  cProtocolStr: string = 'NTLMSSP'#0; {Do not Localize}

procedure GetDomain(const AUserName : String; var VUserName, VDomain : String);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i: Integer;
begin
  i := Pos('\', AUsername);
  if i > -1 then
  begin
    VDomain := Copy(AUsername, 1, i - 1);
    VUserName := Copy(AUsername, i + 1, Length(AUserName));
  end else
  begin
    VDomain := ' ';         {do not localize}
    VUserName := AUserName;
  end;
end;

{$IFDEF DOTNET}
function NTLMFunctionsLoaded : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := True;
end;
{$ELSE}
function NTLMFunctionsLoaded : Boolean;
begin
  Result := IdSSLOpenSSLHeaders.Load;
  if Result then begin
    Result := Assigned(DES_set_odd_parity) and
      Assigned(DES_set_key) and
      Assigned(DES_ecb_encrypt);
  end;
end;
{$ENDIF}

{$IFNDEF DOTNET}
{/*
 * turns a 56 bit key into the 64 bit, odd parity key and sets the key.
 * The key schedule ks is also set.
 */}
procedure setup_des_key(key_56: des_cblock; Var ks: des_key_schedule);
Var
  key: des_cblock;
begin
  key[0] := key_56[0];

  key[1] := ((key_56[0] SHL 7) and $FF) or (key_56[1] SHR 1);
  key[2] := ((key_56[1] SHL 6) and $FF) or (key_56[2] SHR 2);
  key[3] := ((key_56[2] SHL 5) and $FF) or (key_56[3] SHR 3);
  key[4] := ((key_56[3] SHL 4) and $FF) or (key_56[4] SHR 4);
  key[5] := ((key_56[4] SHL 3) and $FF) or (key_56[5] SHR 5);
  key[6] := ((key_56[5] SHL 2) and $FF) or (key_56[6] SHR 6);
  key[7] :=  (key_56[6] SHL 1) and $FF;

  DES_set_odd_parity(@key);
  DES_set_key(@key, ks);
end;

{/*
 * takes a 21 byte array and treats it as 3 56-bit DES keys. The
 * 8 byte plaintext is encrypted with each key and the resulting 24
 * bytes are stored in the results array.
 */}
procedure calc_resp(keys: PDES_cblock; const ANonce: TIdBytes; results: Pdes_key_schedule);
Var
  ks: des_key_schedule;
  nonce: des_cblock;
begin
  setup_des_key(keys^, ks);
  Move(ANonce[0], nonce, 8);
  des_ecb_encrypt(@nonce, Pconst_DES_cblock(results), ks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(PtrUInt(keys) + 7)^, ks);
  des_ecb_encrypt(@nonce, Pconst_DES_cblock(PtrUInt(results) + 8), ks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(PtrUInt(keys) + 14)^, ks);
  des_ecb_encrypt(@nonce, Pconst_DES_cblock(PtrUInt(results) + 16), ks, DES_ENCRYPT);
end;

Const
  Magic: des_cblock = ($4B, $47, $53, $21, $40, $23, $24, $25 );

//* setup LanManager password */
function SetupLanManagerPassword(const APassword: String; const ANonce: TIdBytes): TIdBytes;
var
  lm_hpw: array[0..20] of Byte;
  lm_pw: array[0..13] of Byte;
  idx, len: Integer;
  ks: des_key_schedule;
  lm_resp: array [0..23] of Byte;
  lPassword: {$IFDEF STRING_IS_UNICODE}TIdBytes{$ELSE}AnsiString{$ENDIF};
begin
  {$IFDEF STRING_IS_UNICODE}
  lPassword := IndyTextEncoding_OSDefault.GetBytes(UpperCase(APassword));
  {$ELSE}
  lPassword := UpperCase(APassword);
  {$ENDIF}

  len := IndyMin(Length(lPassword), 14);
  if len > 0 then begin
    Move(lPassword[{$IFDEF STRING_IS_UNICODE}0{$ELSE}1{$ENDIF}], lm_pw[0], len);
  end;
  if len < 14 then begin
    for idx := len to 13 do begin
      lm_pw[idx] := $0;
    end;
  end;

  //* create LanManager hashed password */

  setup_des_key(pdes_cblock(@lm_pw[0])^, ks);
  des_ecb_encrypt(@magic, Pconst_DES_cblock(@lm_hpw[0]), ks, DES_ENCRYPT);

  setup_des_key(pdes_cblock(PtrUInt(@lm_pw[0]) + 7)^, ks);
  des_ecb_encrypt(@magic, Pconst_DES_cblock(PtrUInt(@lm_hpw[0]) + 8), ks, DES_ENCRYPT);

  FillChar(lm_hpw[16], 5, 0);

  calc_resp(PDes_cblock(@lm_hpw[0]), ANonce, Pdes_key_schedule(@lm_resp[0]));

  SetLength(Result, SizeOf(lm_resp));
  Move(lm_resp[0], Result[0], SizeOf(lm_resp));
end;

function BuildUnicode(const S: String): TIdBytes;
{$IFDEF STRING_IS_UNICODE}
  {$IFDEF USE_INLINE}inline;{$ENDIF}
{$ELSE}
var
  i: integer;
{$ENDIF}
begin
  {$IFDEF STRING_IS_UNICODE}
  Result := IndyTextEncoding_UTF16LE.GetBytes(S);
  {$ELSE}
  // RLebeau: TODO - should this use encUTF16LE as well?  This logic will
  // not produce a valid Unicode string if non-ASCII characters are present!
  SetLength(Result, Length(S) * SizeOf(WideChar));
  for i := 0 to Length(S)-1 do begin
    Result[i*2] := Byte(S[i+1]);
    Result[(i*2)+1] := Byte(#0);
  end;
  {$ENDIF}
end;

//* create NT hashed password */
function CreateNTPassword(const APassword: String; const ANonce: TIdBytes): TIdBytes;
var
  nt_hpw: array [1..21] of Byte;
  nt_hpw128: TIdBytes;
  nt_resp: array [1..24] of Byte;
  LMD4: TIdHashMessageDigest4;
begin
  CheckMD4Permitted;
  LMD4 := TIdHashMessageDigest4.Create;
  try
    {$IFDEF STRING_IS_UNICODE}
    nt_hpw128 := LMD4.HashString(APassword, IndyTextEncoding_UTF16LE);
    {$ELSE}
    nt_hpw128 := LMD4.HashBytes(BuildUnicode(APassword));
    {$ENDIF}
  finally
    LMD4.Free;
  end;

  Move(nt_hpw128[0], nt_hpw[1], 16);
  FillChar(nt_hpw[17], 5, 0);

  calc_resp(pdes_cblock(@nt_hpw[1]), ANonce, Pdes_key_schedule(@nt_resp[1]));

  SetLength(Result, SizeOf(nt_resp));
  Move(nt_resp[1], Result[0], SizeOf(nt_resp));
end;

function BuildType1Message(const ADomain, AHost: String): String;
var
  LEncoding: IIdTextEncoding;
  Type_1_Message: type_1_message_header;
  lDomain: TIdBytes;
  lHost: TIdBytes;
  buf: TIdBytes;
begin
  LEncoding := IndyTextEncoding_ASCII;
  lDomain := ToBytes(UpperCase(ADomain), LEncoding);
  lHost := ToBytes(UpperCase(AHost), LEncoding);
  LEncoding := nil;

  FillChar(Type_1_Message, SizeOf(Type_1_Message), #0);
  StrPLCopy(@Type_1_Message.protocol[1], cProtocolStr, 8);
  Type_1_Message._type := 1;

  // S.G. 12/7/2002: Changed the flag to $B207 (from BugID 577895 and packet trace)
  Type_1_Message.flags := MSG1_FLAGS; //was $A000B207;     //b203;

  Type_1_Message.dom_len1 := Word(Length(lDomain));
  // dom_off := 0;
  Type_1_Message.dom_off := 32;

  Type_1_Message.host_len1 := Word(Length(lHost));
  Type_1_Message.host_off := LongWord(Type_1_Message.dom_off + Type_1_Message.dom_len1);

  Type_1_Message._type := HostToLittleEndian(Type_1_Message._type);
  Type_1_Message.flags := HostToLittleEndian(Type_1_Message.flags);
  Type_1_Message.dom_len1 := HostToLittleEndian(Type_1_Message.dom_len1);
  Type_1_Message.dom_len2 := Type_1_Message.dom_len1;
  Type_1_Message.dom_off := HostToLittleEndian(Type_1_Message.dom_off);
  Type_1_Message.host_len1 := HostToLittleEndian(Type_1_Message.host_len1);
  Type_1_Message.host_len2 := Type_1_Message.host_len1;
  Type_1_Message.host_off := HostToLittleEndian(Type_1_Message.host_off);

  buf := RawToBytes(Type_1_Message, SizeOf(Type_1_Message));
  AppendBytes(buf, lDomain);
  AppendBytes(buf, lHost);

  Result := TIdEncoderMIME.EncodeBytes(buf);
end;

function BuildType3Message(const ADomain, AHost, AUsername: TIdUnicodeString;
  const APassword: String; const ANonce: TIdBytes): String;
var
  type3: type_3_message_header;
  buf: TIdBytes;
  lm_password: TIdBytes;
  nt_password: TIdBytes;
  lDomain: TIdBytes;
  lHost: TIdBytes;
  lUsername: TIdBytes;
begin
  lm_password := SetupLanManagerPassword(APassword, ANonce);
  nt_password := CreateNTPassword(APassword, ANonce);

  lDomain := BuildUnicode(UpperCase(ADomain));
  lHost := BuildUnicode(UpperCase(AHost));
  lUsername := BuildUnicode(AUsername);

  StrPLCopy(@Type3.protocol[1], cProtocolStr, 8);
  Type3._type := 3;

  Type3.lm_resp_len1 := Word(Length(lm_password));
  Type3.lm_resp_off := $40;

  Type3.nt_resp_len1 := Word(Length(nt_password));
  Type3.nt_resp_off := LongWord(Type3.lm_resp_off + Type3.lm_resp_len1);

  Type3.dom_len1 := Word(Length(lDomain));
  Type3.dom_off :=  LongWord(Type3.nt_resp_off + Type3.nt_resp_len1);

  Type3.user_len1 := Word(Length(lUsername));
  Type3.user_off := LongWord(Type3.dom_off + Type3.dom_len1);

  Type3.host_len1 := Word(Length(lHost));
  Type3.host_off := LongWord(Type3.user_off + Type3.user_len1);

  Type3.key_len1 := 0;
  Type3.key_off := LongWord(Type3.user_len1 + Type3.host_len1);

  Type3.flags := MSG3_FLAGS;

  Type3._type := HostToLittleEndian(Type3._type);
  Type3.lm_resp_len1 := HostToLittleEndian(Type3.lm_resp_len1);
  Type3.lm_resp_len2 := Type3.lm_resp_len1;
  Type3.lm_resp_off := HostToLittleEndian(Type3.lm_resp_off);
  Type3.nt_resp_len1 := HostToLittleEndian(Type3.nt_resp_len1);
  Type3.nt_resp_len2 := Type3.nt_resp_len1;
  Type3.nt_resp_off := HostToLittleEndian(Type3.nt_resp_off);
  Type3.dom_len1 := HostToLittleEndian(Type3.dom_len1);
  Type3.dom_len2 := Type3.dom_len1;
  Type3.dom_off := HostToLittleEndian(Type3.dom_off);
  Type3.user_len1 := HostToLittleEndian(Type3.user_len1);
  Type3.user_len2 := Type3.user_len1;
  Type3.user_off := HostToLittleEndian(Type3.user_off);
  Type3.host_len1 := HostToLittleEndian(Type3.host_len1);
  Type3.host_len2 := Type3.host_len1;
  Type3.host_off := HostToLittleEndian(Type3.host_off);
  Type3.key_len1 := HostToLittleEndian(Type3.key_len1);
  Type3.key_len2 := Type3.key_len1;
  Type3.key_off := HostToLittleEndian(Type3.key_off);
  Type3.flags := HostToLittleEndian(Type3.flags);

  buf := RawToBytes(Type3, SizeOf(Type3));
  AppendBytes(buf, lm_password);
  AppendBytes(buf, nt_password);
  AppendBytes(buf, lDomain);
  AppendBytes(buf, lUsername);
  AppendBytes(buf, lHost);

  Result := TIdEncoderMIME.EncodeBytes(buf);
end;

{$ELSE}

procedure BytesToCharArray(const ABytes : TIdBytes; var VArray : Array of Char; const AIndex : Integer = 0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low(VArray);
  lh := High(Varray);
  for i := ll to lh do begin
    VArray[i] := Char(ABytes[ (i - ll)+ AIndex]);
  end;
end;

procedure BytesToByteArray(const ABytes : TIdBytes; var VArray : Array of Byte; const AIndex : Integer = 0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low(VArray);
  lh := High(Varray);
  for i := ll to lh do begin
    VArray[i] := ABytes[ (i - ll)+ AIndex];
  end;
end;

procedure ByteArrayToBytes(const VArray : array of Byte; const ABytes : TIdBytes; const AIndex : Integer = 0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low(VArray);
  lh := High(Varray);
  for i := ll to lh do begin
    ABytes[ (i - ll)+ AIndex] := VArray[i];
  end;
end;

function ntlm_base.GetBytesLen: LongWord;
begin
  Result := 8;
end;

procedure ntlm_base.ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord);
var
  i : Integer;
begin
  inherited ReadStruct(ABytes,VIndex);
  for i := 1 to Length(fprotocol) do
  begin
    fprotocol[i] := Char(ABytes[i+VIndex]);
  end;
  Inc(VIndex, Length(fprotocol));
end;

procedure ntlm_base.WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);
var
  LLen : Integer;
  LBytes : TIdBytes;
begin
  inherited WriteStruct(VBytes,VIndex);
  LBytes := System.Text.ASCIIEncoding.GetBytes(fprotocol);
  LLen := Length(fprotocol);
  CopyTIdBytes(LBytes, VIndex, VBytes, VIndex, LLen);
  Inc(VIndex, LLen);
end;

function type_1_message_header.GetBytesLen: LongWord;
begin
  Result := inherited GetByesLen() + 24;
end;

procedure type_1_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord);
begin
  inherited ReadStruct(ABytes, VIndex);
  f_type := ABytes[VIndex];
  Inc(VIndex);
  BytesToByteArray(ABytes, fpad, VIndex);
  Inc(VIndex, Length(fpad));
  fflags := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  BytesToByteArray(ABytes, fpad2, VIndex);
  Inc(VIndex, Length(fpad2));
  fdom_len1 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fdom_len2 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fdom_off := IdGlobal.BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
  fhost_len1 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_len2 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_off := IdGlobal.BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
end;

procedure type_1_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := f_type;
  Inc(VIndex);
  ByteArrayToBytes(fpad, VBytes, VIndex);
  Inc(VIndex, Length(fpad));
  CopyTIdWord(fflags, VBytes, VIndex);
  Inc(VIndex, 2);
  ByteArrayToBytes(fpad2, VBytes, VIndex);
  Inc(VIndex, Length(fpad2));
  CopyTIdWord(fdom_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(fdom_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdLongWord(fdom_off, VBytes, VIndex);
  Inc(VIndex, 4);
  CopyTIdWord(fhost_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(fhost_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdLongWord(fhost_off, VBytes, VIndex);
  Inc(VIndex, 4);
end;

function type_2_message_header.GetBytesLen: LongWord;
begin
  Result := inherited GetBytesLen() + 40;
end;

procedure type_2_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord);
begin
  inherited ReadStruct(ABytes, VIndex);
  f_type := ABytes[VIndex];
  Inc(VIndex);
  BytesToByteArray(ABytes, fpad, VIndex);
  Inc(VIndex, Length(fpad));
  fhost_len1 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_len2 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_off := IdGlobal.BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
  fflags := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  BytesToByteArray(ABytes, fPad2, VIndex);
  Inc(VIndex, Length(fpad2));
  BytesToByteArray(ABytes, fnonce, VIndex);
  Inc(VIndex, Length(fnonce));
  BytesToByteArray(ABytes, freserved, VIndex);
  Inc(VIndex, Length(freserved));
  finfo_len1 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  finfo_len2 := IdGlobal.BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  finfo_off := IdGlobal.BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
end;

procedure type_2_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := f_type;
  Inc(VIndex);
  ByteArrayToBytes(fPad, VBytes, VIndex);
  Inc(VIndex, Length(fpad));
  CopyTIdWord(fhost_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(fhost_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdLongWord(fhost_off, VBytes, VIndex);
  Inc(VIndex, 4);
  CopyTIdWord(fflags, VBytes, VIndex);
  Inc(VIndex, 2);
  ByteArrayToBytes(fPad2, VBytes, VIndex);
  Inc(VIndex, Length(fPad2));
  ByteArrayToBytes(fnonce, VBytes, VIndex);
  Inc(VIndex, Length(fnonce));
  ByteArrayToBytes(freserved, VBytes, VIndex);
  Inc(VIndex, Length(freserved));
  CopyTIdWord(finfo_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(finfo_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdLongWord(finfo_off, VBytes, VIndex);
  Inc(VIndex, 4);
end;

function type_3_message_header.GetBytesLen: LongWord;
begin
  Result := inherited GetByteLen() + ? ;
end;

procedure type_3_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord);
begin
{
    _type: LongWord;                    // 0x03

    lm_resp_len1: Word;                 // LanManager response length (always 0x18)
    lm_resp_len2: Word;                 // LanManager response length (always 0x18)
    lm_resp_off: LongWord;              // LanManager response offset

    nt_resp_len1: Word;                 // NT response length (always 0x18)
    nt_resp_len2: Word;                 // NT response length (always 0x18)
    nt_resp_off: LongWord;              // NT response offset

    dom_len1: Word;                     // domain string length
    dom_len2: Word;                     // domain string length
    dom_off: LongWord;                  // domain string offset (always 0x40)

    user_len1: Word;                    // username string length
    user_len2: Word;                    // username string length
    user_off: LongWord;                 // username string offset

    host_len1: Word;                    // host string length
    host_len2: Word;                    // host string length
    host_off: LongWord;                 // host string offset
    zero: LongWord;

    msg_len: LongWord;                  // message length

    flags: LongWord;                    // 0xA0808205
    }
end;

procedure type_3_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);
begin
{
    _type: LongWord;                    // 0x03

    lm_resp_len1: Word;                 // LanManager response length (always 0x18)
    lm_resp_len2: Word;                 // LanManager response length (always 0x18)
    lm_resp_off: LongWord;              // LanManager response offset

    nt_resp_len1: Word;                 // NT response length (always 0x18)
    nt_resp_len2: Word;                 // NT response length (always 0x18)
    nt_resp_off: LongWord;              // NT response offset

    dom_len1: Word;                     // domain string length
    dom_len2: Word;                     // domain string length
    dom_off: LongWord;                  // domain string offset (always 0x40)

    user_len1: Word;                    // username string length
    user_len2: Word;                    // username string length
    user_off: LongWord;                 // username string offset

    host_len1: Word;                    // host string length
    host_len2: Word;                    // host string length
    host_off: LongWord;                 // host string offset
    zero: LongWord;

    msg_len: LongWord;                  // message length

    flags: LongWord;                    // 0xA0808205
}
end;

{$ENDIF}

end.
