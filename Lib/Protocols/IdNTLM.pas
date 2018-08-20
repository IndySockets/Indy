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
    function GetBytesLen: UInt32; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);  override;

    property protocol: ProtocolArray read fprotocol write fprotocol; // array [1..8] of Char;     // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
  end;

  type_1_message_header = class(ntlm_base)
  protected
    f_type : UInt8;
    fpad : padArray3;
    fflags : UInt16;
    fpad2 : padArray2;
    fdom_len1 : UInt16;
    fdom_len2 : UInt16;
    fdom_off : UInt32;
    fhost_len1 : UInt16;
    fhost_len2 : UInt16;
    fhost_off : UInt32;
    function GetBytesLen: UInt32; override;

  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);  override;

    property _type: UInt8 read f_type write f_type;                             // 0x01
    property pad  : padArray3 read fpad write fpad;                             // 0x0
    property flags: UInt16 read fflags write fflags;                            // 0xb203
    property pad2 : padArray2 read fpad2 write fpad2;                           // 0x0
    property dom_len1: UInt16 read fdom_len1 write fdom_len1;                   // domain string length
    property dom_len2: UInt16 read fdom_len2 write fdom_len2;                   // domain string length
    property dom_off: UInt32 read fdom_off write fdom_off;                      // domain string offset

    property host_len1: UInt16 read fhost_len1 write fhost_len1;                // host string length
    property host_len2: UInt16 read fhost_len2 write fhost_len2;                // host string length
    property host_off: UInt32 read fhost_off write fhost_off;                   // host string offset (always 0x20)
  end;

  type_2_message_header = class(ntlm_base)
  protected
    f_type : UInt8;
    fPad: padArray3;
    fhost_len1: UInt16;
    fhost_len2: UInt16;
    fhost_off: UInt32;
    fflags: UInt16;
    fPad2: padArray2;
    fnonce: nonceArray;
    freserved: padArray8;
    finfo_len1: UInt16;
    finfo_len2: UInt16;
    finfo_off: UInt32;

    function GetBytesLen: UInt32; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);  override;

    property _type: UInt8 read f_type write f_type;       // $2
    property pad: padArray3 read fPad wrie fPad;
    property host_len1: UInt16 read fhost_len1 write fhost_len1;
    property host_len2: UInt16 read fhost_len2 write fhost_len2;
    property host_off: UInt32 read fhost_off write fhost_off;
    property flags: UInt16 read fflags write fflags;
    property pad2: padArray2 read fflags write fflags;
    property nonce: nonceArray read fnonce write fnonce;
    property reserved: padArray8 read freserved write freserved;
    property info_len1: UInt16 read finfo_len1 write finfo_len1;
    property info_len2: UInt16 read finfo_len2 write finfo_len2;
    property info_off: UInt32 read finfo_off write finfo_off;
  end;

  type_3_message_header = class(ntlm_base)
  protected
    f_type: UInt32;
    flm_resp_len1: UInt16;
    flm_resp_len2: UInt16;
    flm_resp_off : UInt32;
    fnt_resp_len1: UInt16;
    fnt_resp_len2: UInt16;
    fnt_resp_off: UInt32;
    fdom_len1: UInt16;
    fdom_len2 : UInt16;
    fdom_off : UInt32;
    fuser_len1: UInt16;
    fuser_len2: UInt16;
    fuser_off: UInt32;
    fhost_len1: UInt16;
    fhost_len2: UInt16;
    fhost_off: UInt32;
    fkey_len1: UInt16;
    fkey_len2: UInt16;
    fkey_off: UInt32;
    fflags: UInt32;
    function GetBytesLen: UInt32; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);  override;

    property _type: UInt32 read f_type write f_type;                            // 0x03

    property lm_resp_len1: UInt16 read flm_resp_len1 write flm_resp_len1;       // LanManager response length (always 0x18)
    property lm_resp_len2: UInt16 read flm_resp_len2 write flm_resp_len2;       // LanManager response length (always 0x18)
    property lm_resp_off: UInt32 read flm_resp_off write flm_resp_off;          // LanManager response offset

    property nt_resp_len1: UInt16 read fnt_resp_len1 write fnt_resp_len1;       // NT response length (always 0x18)
    property nt_resp_len2: UInt16 read fnt_resp_len2 write fnt_resp_len2;       // NT response length (always 0x18)
    property nt_resp_off: UInt32 read fnt_resp_off write fnt_resp_off;          // NT response offset

    property dom_len1: UInt16 read fdom_len1 write fdom_len1;                   // domain string length
    property dom_len2: UInt16 read fdom_len2 write fdom_len2;                   // domain string length
    property dom_off: UInt32 read fdom_off write fdom_off;                      // domain string offset (always 0x40)

    property user_len1: UInt16 read fuser_len1 write fuser_len1;                // username string length
    property user_len2: UInt16 read fuser_len2 write fuser_len2;                // username string length
    property user_off: UInt32 read fuser_off write fuser_off;                   // username string offset

    property host_len1: UInt16 read fhost_len1 write fhost_len1;                // host string length
    property host_len2: UInt16 read fhost_len2 write fhost_len2;                // host string length
    property host_off: UInt32 read fhost_off write fhost_off;                   // host string offset

    property key_len1: UInt16 read fkey_len1 write fkey_len1;                   // session key length
    property key_len2: UInt16 read fkey_len2 write fkey_len2;                   // session key length
    property key_off: UInt32 read fkey_off write fkey_off;                      // session key offset

    property flags: UInt32 read fflags write fflags;                            // 0xA0808205
  end;
{$ELSE}
  type_1_message_header = packed record
    protocol: array [1..8] of UInt8;    // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
    _type: UInt8;                       // 0x01
    pad  : packed Array[1..3] of UInt8; // 0x0
    flags: UInt16;                      // 0xb203
    pad2 : packed Array[1..2] of UInt8; // 0x0
    dom_len1: UInt16;                   // domain string length
    dom_len2: UInt16;                   // domain string length
    dom_off: UInt32;                    // domain string offset

    host_len1: UInt16;                  // host string length
    host_len2: UInt16;                  // host string length
    host_off: UInt32;                   // host string offset (always 0x20)
  end;

  type_2_message_header = packed record
    protocol: packed array [1..8] of UInt8;     // 'N', 'T', 'L', 'M', 'S', 'S', 'P', #0    {Do not Localize}
    _type: UInt8;                               // $2
    Pad: packed Array[1..3] of UInt8;
    host_len1: UInt16;
    host_len2: UInt16;
    host_off: UInt32;
    flags: UInt16;
    Pad2: packed Array[1..2] of UInt8;
    nonce: packed Array[1..8] of UInt8;
    reserved: packed Array[1..8] of UInt8;
    info_len1: UInt16;
    info_len2: UInt16;
    info_off: UInt32;
  end;

  type_3_message_header = packed record
    protocol: array [1..8] of UInt8;    // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
    _type: UInt32;                      // 0x03

    lm_resp_len1: UInt16;               // LanManager response length (always 0x18)
    lm_resp_len2: UInt16;               // LanManager response length (always 0x18)
    lm_resp_off: UInt32;                // LanManager response offset

    nt_resp_len1: UInt16;               // NT response length (always 0x18)
    nt_resp_len2: UInt16;               // NT response length (always 0x18)
    nt_resp_off: UInt32;                // NT response offset

    dom_len1: UInt16;                   // domain string length
    dom_len2: UInt16;                   // domain string length
    dom_off: UInt32;                    // domain string offset (always 0x40)

    user_len1: UInt16;                  // username string length
    user_len2: UInt16;                  // username string length
    user_off: UInt32;                   // username string offset

    host_len1: UInt16;                  // host string length
    host_len2: UInt16;                  // host string length
    host_off: UInt32;                   // host string offset

    key_len1: UInt16;                   // session key length
    key_len2: UInt16;                   // session key length
    key_off: UInt32;                    // session key offset

    flags: UInt32;                      // 0xA0808205
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
  MSG1_FLAGS : UInt16 = $b207;
  // S.G. 12/7/2002: was: flags := $A0808205;  (from BugID 577895 and packet trace)
  MSG3_FLAGS : UInt32 =  $018205;

implementation

uses
  SysUtils,
  {$IFDEF DOTNET}
  System.Text,
  {$ENDIF}
  IdFIPS,
  IdGlobalProtocols,
  IdHash,
  IdHashMessageDigest,
  IdCoderMIME
  {$IFNDEF DOTNET}
    {.$IFDEF USE_OPENSSL}
  , IdSSLOpenSSLHeaders
    {.$ENDIF}
  {$ENDIF}
  {$IFDEF HAS_GENERICS_TArray_Copy}
    {$IFDEF HAS_UNIT_Generics_Collections}
  , System.Generics.Collections
    {$ENDIF}
  {$ENDIF}
  ;

type
  Pdes_key_schedule = ^des_key_schedule;

const
  cProtocolStr: array[1..8] of Byte = (Ord('N'),Ord('T'),Ord('L'),Ord('M'),Ord('S'),Ord('S'),Ord('P'),$0); {Do not Localize}

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
//{$IFNDEF USE_OPENSSL}{$IFDEF USE_INLINE} inline; {$ENDIF}{$ENDIF}
begin
  {.$IFDEF USE_OPENSSL}
  Result := IdSSLOpenSSLHeaders.Load;
  if Result then begin
    Result := Assigned(DES_set_odd_parity) and
      Assigned(DES_set_key) and
      Assigned(DES_ecb_encrypt);
  end;
  {.$ELSE}
  //Result := False;
  {.$ENDIF}
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

  {$IFDEF HAS_GENERICS_TArray_Copy}
  TArray.Copy<Byte>(cProtocolStr, Type_1_Message.protocol, 8);
  {$ELSE}
    {$IFDEF USE_MARSHALLED_PTRS}
  buf := cProtocolStr;
  TMarshal.Copy(TBytesPtr(@buf)^, 0, TPtrWrapper.Create(@Type_1_Message.protocol[1]), 8);
    {$ELSE}
  Move(cProtocolStr[1], Type_1_Message.protocol[1], 8);
    {$ENDIF}
  {$ENDIF}

  Type_1_Message._type := 1;

  // S.G. 12/7/2002: Changed the flag to $B207 (from BugID 577895 and packet trace)
  Type_1_Message.flags := MSG1_FLAGS; //was $A000B207;     //b203;

  Type_1_Message.dom_len1 := UInt16(Length(lDomain));
  // dom_off := 0;
  Type_1_Message.dom_off := 32;

  Type_1_Message.host_len1 := UInt16(Length(lHost));
  Type_1_Message.host_off := UInt32(Type_1_Message.dom_off + Type_1_Message.dom_len1);

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

  {$IFDEF HAS_GENERICS_TArray_Copy}
  TArray.Copy<Byte>(cProtocolStr, Type3.protocol, 8);
  {$ELSE}
    {$IFDEF USE_MARSHALLED_PTRS}
  buf := cProtocolStr;
  TMarshal.Copy(TBytesPtr(@buf)^, 0, TPtrWrapper.Create(@Type3.protocol[1]), 8);
    {$ELSE}
  Move(cProtocolStr[1], Type3.protocol[1], 8);
    {$ENDIF}
  {$ENDIF}

  Type3._type := 3;

  Type3.lm_resp_len1 := UInt16(Length(lm_password));
  Type3.lm_resp_off := $40;

  Type3.nt_resp_len1 := UInt16(Length(nt_password));
  Type3.nt_resp_off := UInt32(Type3.lm_resp_off + Type3.lm_resp_len1);

  Type3.dom_len1 := UInt16(Length(lDomain));
  Type3.dom_off :=  UInt32(Type3.nt_resp_off + Type3.nt_resp_len1);

  Type3.user_len1 := UInt16(Length(lUsername));
  Type3.user_off := UInt32(Type3.dom_off + Type3.dom_len1);

  Type3.host_len1 := UInt16(Length(lHost));
  Type3.host_off := UInt32(Type3.user_off + Type3.user_len1);

  Type3.key_len1 := 0;
  Type3.key_off := UInt32(Type3.user_len1 + Type3.host_len1);

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

function ntlm_base.GetBytesLen: UInt32;
begin
  Result := 8;
end;

procedure ntlm_base.ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32);
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

procedure ntlm_base.WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);
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

function type_1_message_header.GetBytesLen: UInt32;
begin
  Result := inherited GetByesLen() + 24;
end;

procedure type_1_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32);
begin
  inherited ReadStruct(ABytes, VIndex);
  f_type := ABytes[VIndex];
  Inc(VIndex);
  BytesToByteArray(ABytes, fpad, VIndex);
  Inc(VIndex, Length(fpad));
  fflags := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  BytesToByteArray(ABytes, fpad2, VIndex);
  Inc(VIndex, Length(fpad2));
  fdom_len1 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fdom_len2 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fdom_off := BytesToUInt32(ABytes, VIndex);
  Inc(VIndex, 4);
  fhost_len1 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_len2 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_off := BytesToUInt32(ABytes, VIndex);
  Inc(VIndex, 4);
end;

procedure type_1_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := f_type;
  Inc(VIndex);
  ByteArrayToBytes(fpad, VBytes, VIndex);
  Inc(VIndex, Length(fpad));
  CopyTIdUInt16(fflags, VBytes, VIndex);
  Inc(VIndex, 2);
  ByteArrayToBytes(fpad2, VBytes, VIndex);
  Inc(VIndex, Length(fpad2));
  CopyTIdUInt16(fdom_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt16(fdom_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt32(fdom_off, VBytes, VIndex);
  Inc(VIndex, 4);
  CopyTIdUInt16(fhost_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt16(fhost_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt32(fhost_off, VBytes, VIndex);
  Inc(VIndex, 4);
end;

function type_2_message_header.GetBytesLen: UInt32;
begin
  Result := inherited GetBytesLen() + 40;
end;

procedure type_2_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32);
begin
  inherited ReadStruct(ABytes, VIndex);
  f_type := ABytes[VIndex];
  Inc(VIndex);
  BytesToByteArray(ABytes, fpad, VIndex);
  Inc(VIndex, Length(fpad));
  fhost_len1 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_len2 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  fhost_off := BytesToUInt32(ABytes, VIndex);
  Inc(VIndex, 4);
  fflags := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  BytesToByteArray(ABytes, fPad2, VIndex);
  Inc(VIndex, Length(fpad2));
  BytesToByteArray(ABytes, fnonce, VIndex);
  Inc(VIndex, Length(fnonce));
  BytesToByteArray(ABytes, freserved, VIndex);
  Inc(VIndex, Length(freserved));
  finfo_len1 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  finfo_len2 := BytesToUInt16(ABytes, VIndex);
  Inc(VIndex, 2);
  finfo_off := BytesToUInt32(ABytes, VIndex);
  Inc(VIndex, 4);
end;

procedure type_2_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := f_type;
  Inc(VIndex);
  ByteArrayToBytes(fPad, VBytes, VIndex);
  Inc(VIndex, Length(fpad));
  CopyTIdUInt16(fhost_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt16(fhost_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt32(fhost_off, VBytes, VIndex);
  Inc(VIndex, 4);
  CopyTIdUInt16(fflags, VBytes, VIndex);
  Inc(VIndex, 2);
  ByteArrayToBytes(fPad2, VBytes, VIndex);
  Inc(VIndex, Length(fPad2));
  ByteArrayToBytes(fnonce, VBytes, VIndex);
  Inc(VIndex, Length(fnonce));
  ByteArrayToBytes(freserved, VBytes, VIndex);
  Inc(VIndex, Length(freserved));
  CopyTIdUInt16(finfo_len1, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt16(finfo_len2, VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdUInt32(finfo_off, VBytes, VIndex);
  Inc(VIndex, 4);
end;

function type_3_message_header.GetBytesLen: UInt32;
begin
  Result := inherited GetByteLen() + ? ;
end;

procedure type_3_message_header.ReadStruct(const ABytes : TIdBytes; var VIndex : UInt32);
begin
{
    _type: UInt32;                      // 0x03

    lm_resp_len1: UInt16;               // LanManager response length (always 0x18)
    lm_resp_len2: UInt16;               // LanManager response length (always 0x18)
    lm_resp_off: UInt32;                // LanManager response offset

    nt_resp_len1: UInt16;               // NT response length (always 0x18)
    nt_resp_len2: UInt16;               // NT response length (always 0x18)
    nt_resp_off: UInt32;                // NT response offset

    dom_len1: UInt16;                   // domain string length
    dom_len2: UInt16;                   // domain string length
    dom_off: UInt32;                    // domain string offset (always 0x40)

    user_len1: UInt16;                  // username string length
    user_len2: UInt16;                  // username string length
    user_off: UInt32;                   // username string offset

    host_len1: UInt16;                  // host string length
    host_len2: UInt16;                  // host string length
    host_off: UInt32;                   // host string offset
    zero: UInt32;

    msg_len: UInt32;                    // message length

    flags: UInt32;                      // 0xA0808205
    }
end;

procedure type_3_message_header.WriteStruct(var VBytes : TIdBytes; var VIndex : UInt32);
begin
{
    _type: UInt32;                      // 0x03

    lm_resp_len1: UInt16;               // LanManager response length (always 0x18)
    lm_resp_len2: UInt16;               // LanManager response length (always 0x18)
    lm_resp_off: UInt32;                // LanManager response offset

    nt_resp_len1: UInt16;               // NT response length (always 0x18)
    nt_resp_len2: UInt16;               // NT response length (always 0x18)
    nt_resp_off: UInt32;                // NT response offset

    dom_len1: UInt16;                   // domain string length
    dom_len2: UInt16;                   // domain string length
    dom_off: UInt32;                    // domain string offset (always 0x40)

    user_len1: UInt16;                  // username string length
    user_len2: UInt16;                  // username string length
    user_off: UInt32;                   // username string offset

    host_len1: UInt16;                  // host string length
    host_len2: UInt16;                  // host string length
    host_off: UInt32;                   // host string offset
    zero: UInt32;

    msg_len: UInt32;                    // message length

    flags: UInt32;                      // 0xA0808205
}
end;

{$ENDIF}

end.
