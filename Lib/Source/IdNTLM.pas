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
function BuildType3Message(const ADomain, AHost, AUsername: UnicodeString; const APassword: String; const ANonce: TIdBytes): String;

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
  IdFIPS,
  IdGlobalProtocols,
  IdHash,
  IdHashMessageDigest,
  IdCoderMIME
  {.$IFDEF USE_OPENSSL}
  , IdSSLOpenSSLHeaders
  {.$ENDIF}
  {$IF DEFINED(HAS_GENERICS_TArray_Copy) AND DEFINED(HAS_UNIT_Generics_Collections)}
  , System.Generics.Collections
  {$IFEND}
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
  lPassword: TIdBytes;
begin
  lPassword := IndyTextEncoding_OSDefault.GetBytes(UpperCase(APassword));

  len := IndyMin(Length(lPassword), 14);
  if len > 0 then begin
    Move(lPassword[0], lm_pw[0], len);
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
    nt_hpw128 := LMD4.HashString(APassword, IndyTextEncoding_UTF16LE);
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

  {$IF DEFINED(HAS_GENERICS_TArray_Copy)}
  TArray.Copy<Byte>(cProtocolStr, Type_1_Message.protocol, 8);
  {$ELSEIF DEFINED(USE_MARSHALLED_PTRS)}
  buf := cProtocolStr;
  TMarshal.Copy(TBytesPtr(@buf)^, 0, TPtrWrapper.Create(@Type_1_Message.protocol[1]), 8);
  {$ELSE}
  Move(cProtocolStr[1], Type_1_Message.protocol[1], 8);
  {$IFEND}

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

function BuildType3Message(const ADomain, AHost, AUsername: UnicodeString;
  const APassword: String; const ANonce: TIdBytes): String;
var
  type3: type_3_message_header;
  buf: TIdBytes;
  lm_password: TIdBytes;
  nt_password: TIdBytes;
  lDomain: TIdBytes;
  lHost: TIdBytes;
  lUsername: TIdBytes;
  LEncoding: IIdTextEncoding;
begin
  lm_password := SetupLanManagerPassword(APassword, ANonce);
  nt_password := CreateNTPassword(APassword, ANonce);

  LEncoding := IndyTextEncoding_UTF16LE;
  lDomain := LEncoding.GetBytes(UpperCase(ADomain));
  lHost := LEncoding.GetBytes(UpperCase(AHost));
  lUsername := LEncoding.GetBytes(AUsername);

  {$IF DEFINED(HAS_GENERICS_TArray_Copy)}
  TArray.Copy<Byte>(cProtocolStr, Type3.protocol, 8);
  {$ELSEIF DEFINED(USE_MARSHALLED_PTRS)}
  buf := cProtocolStr;
  TMarshal.Copy(TBytesPtr(@buf)^, 0, TPtrWrapper.Create(@Type3.protocol[1]), 8);
  {$ELSE}
  Move(cProtocolStr[1], Type3.protocol[1], 8);
  {$IFEND}

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

end.
