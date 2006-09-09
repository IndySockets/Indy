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

Uses
  IdSSLOpenSSLHeaders;

Type

  type_1_message_header = packed record
    protocol: array [1..8] of Char;     // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
    _type: Byte;                        // 0x01
    pad  : packed Array[1..3] of byte;  // 0x0
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
    protocol: packed array [1..8] of Char;      // 'N', 'T', 'L', 'M', 'S', 'S', 'P', #0    {Do not Localize}
    _type: Byte;                                // $2
    Pad  : packed Array[1..7] of byte;          // 0x0
    msg_len: Word;                              // 0x28
    Pad2 : packed Array [1..2] of byte;         // 0x0
    flags: word;                                // 0x8201
    Pad3: Packed array [1..2] of byte;          // 0x0
    nonce: Array[1..8] of char;                 // nonce
    pad4: packed Array[1..8] of byte            // 0x0
  end;

  type_3_message_header = packed record
    protocol: array [1..8] of Char;     // 'N', 'T', 'L', 'M', 'S', 'S', 'P', '\0'    {Do not Localize}
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
  end;

  Pdes_key_schedule = ^des_key_schedule;

function BuildType1Message(ADomain, AHost: String): String;
function BuildType3Message(ADomain, AHost, AUsername: WideString; APassword, ANonce: String): String;

implementation

Uses
  SysUtils,
  IdGlobal,
  IdHash,
  IdHashMessageDigest,
  IdCoderMIME;

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

  iddes_set_odd_parity(key);
  iddes_set_key(key, ks);
end;

{/*
 * takes a 21 byte array and treats it as 3 56-bit DES keys. The
 * 8 byte plaintext is encrypted with each key and the resulting 24
 * bytes are stored in the results array.
 */}
procedure calc_resp(keys: PDES_cblock; Anonce: String; results: Pdes_key_schedule);
Var
  ks: des_key_schedule;
  nonce: des_cblock;
begin
  setup_des_key(keys^, ks);
  move(ANonce[1], nonce, 8);
  iddes_ecb_encrypt(nonce, Pdes_cblock(results)^, ks, OPENSSL_DES_ENCRYPT);

  setup_des_key(PDES_cblock(Integer(keys) + 7)^, ks);
  iddes_ecb_encrypt(nonce, Pdes_cblock(Integer(results) + 8)^, ks, OPENSSL_DES_ENCRYPT);

  setup_des_key(PDES_cblock(Integer(keys) + 14)^, ks);
  iddes_ecb_encrypt(nonce, Pdes_cblock(Integer(results) + 16)^, ks, OPENSSL_DES_ENCRYPT);
end;

Const
  Magic: des_cblock = ($4B, $47, $53, $21, $40, $23, $24, $25 );

//* setup LanManager password */
function SetupLanManagerPassword(APassword, nonce: String): String;
Var
  lm_hpw: array[1..21] of Char;
  lm_pw: array[1..14] of Char;
  idx, len: Integer;
  ks: des_key_schedule;
  lm_resp: array [1..24] of Char;
begin
  APassword := Copy(UpperCase(APassword), 1, 14);
  len := Length(APassword);
  if (len > 0) then begin
    Move(APassword[1], lm_pw, len);
  end;
  if len < 14 then begin
    for idx := len + 1 to 14 do lm_pw[idx] := #0;
  end;

  //* create LanManager hashed password */

  setup_des_key(pdes_cblock(@lm_pw[1])^, ks);
  iddes_ecb_encrypt(magic, pdes_cblock(@lm_hpw[1])^, ks, OPENSSL_DES_ENCRYPT);

  setup_des_key(pdes_cblock(integer(@lm_pw[1]) + 7)^, ks);
  iddes_ecb_encrypt(magic, pdes_cblock(integer(@lm_hpw[1]) + 8)^, ks, OPENSSL_DES_ENCRYPT);

  FillChar(lm_hpw[17], 5, 0);

  calc_resp(PDes_cblock(@lm_hpw[1]), nonce, Pdes_key_schedule(@lm_resp[1]));

  result := lm_resp;
end;

function BuildUnicode(S: String): string;
Var
  i: integer;
  S1: String;
begin
  S1 := S;
  for i := 1 to Length(S) do
    Insert(#0, S1, i * 2);
  result := S1;
end;

//* create NT hashed password */
function CreateNTPassword(APassword, nonce: String): String;
var
  nt_pw: String;
  nt_hpw: array [1..21] of Char;
  nt_hpw128: TIdBytes;
  nt_resp: array [1..24] of Char;
begin
  nt_pw := BuildUnicode(APassword);

  with TIdHashMessageDigest4.Create do
  try
    nt_hpw128 := HashValue(nt_pw);
  finally
    Free;
  end;

  Move(nt_hpw[1], nt_hpw128[0], 16);
  FillChar(nt_hpw[17], 5, 0);

  calc_resp(pdes_cblock(@nt_hpw[1]), nonce, Pdes_key_schedule(@nt_resp[1]));

  Result := nt_resp;
end;

function BuildType1Message(ADomain, AHost: String): String;
Var
  Type_1_Message: type_1_message_header;
  S: String;
begin
  FillChar(Type_1_Message, SizeOf(Type_1_Message), #0);
  with Type_1_Message do
  begin
    protocol := 'NTLMSSP'#0;    {Do not Localize}
    _type := 1;
    // S.G. 12/7/2002: Changed the flag to $B207 (from BugID 577895 and packet trace)
    flags := $b207; //was $A000B207;     //b203;

    dom_len1 := Length(ADomain);
    dom_len2 := Length(ADomain);
    // dom_off := 0;
    dom_off := Length(AHost) + 32;

    host_len1 := Length(AHost);
    host_len2 := Length(AHost);
    host_off := 32;
  end;

  SetLength(S, SizeOf(Type_1_Message));
  UniqueString(S);
  Move(Type_1_Message, S[1], SizeOf(Type_1_Message));
  with TIdEncoderMIME.Create do try
    result := Encode(S + UpperCase(AHost) + UpperCase(ADomain));
  finally Free; end;
end;

function BuildType3Message(ADomain, AHost, AUsername: WideString; APassword, ANonce: String): String;
Var
  type3: type_3_message_header;
  S: String;
  lm_password: String;
  nt_password: String;
begin
  lm_password := SetupLanManagerPassword(APassword, ANonce);
  nt_password := CreateNTPassword(APassword, ANonce);

  ADomain := BuildUnicode(UpperCase(ADomain));
  AHost := BuildUnicode(UpperCase(AHost));
  AUsername := BuildUnicode(AUsername);

  with Type3 do begin
    protocol := 'NTLMSSP'#0;    {Do not Localize}
    _type := 3;
    lm_resp_len1 := $18;// S.G. 12/7/2002: was: Length(lm_password);  (from BugID 577895)
    lm_resp_len2 := $18;// S.G. 12/7/2002: was: Length(lm_password);  (from BugID 577895)
    lm_resp_off := Length(ADomain) + Length(AUsername) + Length(AHost) + $40;

    nt_resp_len1 := $18;// S.G. 12/7/2002: was: Length(nt_password);  (from BugID 577895)
    nt_resp_len2 := $18;// S.G. 12/7/2002: was: Length(nt_password);  (from BugID 577895)
    nt_resp_off := Length(ADomain) + Length(AUsername) + Length(AHost) + Length(lm_password) + $40;

    dom_len1 := Length(ADomain);
    dom_len2 := Length(ADomain);
    dom_off := $40;

    user_len1 := Length(AUsername);
    user_len2 := Length(AUsername);
    user_off := Length(ADomain) + $40;

    host_len1 := Length(AHost);
    host_len2 := Length(AHost);
    host_off := Length(ADomain) + Length(AUsername) + $40;
    zero := 0;

    msg_len := SIZEOf(Type3) + Length(ADomain) + Length(AUsername) + Length(Ahost) + Length(lm_password) + Length(nt_password);
    flags := $018205; // S.G. 12/7/2002: was: flags := $A0808205;  (from BugID 577895 and packet trace)
  end;

  SetLength(S, SizeOf(Type3));
  Move(Type3, S[1], SizeOf(Type3));
  with TIdEncoderMIME.Create do try
    result := Encode(S + ADomain + AUsername + AHost + lm_password + nt_password);
  finally Free; end;
end;

end.
