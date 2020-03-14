unit IdNTLMv2;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdStruct
  {$IFNDEF DOTNET}, IdCTypes, IdSSLOpenSSLHeaders{$ENDIF}
  ;

type
  ProtocolArray = array [ 1.. 8] of TIdAnsiChar;
  nonceArray = Array[ 1.. 8] of TIdAnsiChar;

const
//These are from:
//  http://svn.xmpp.ru/repos/tkabber/trunk/tkabber/jabberlib/ntlm.tcl
// and the code is under a BSD license
  IdNTLMSSP_NEGOTIATE_UNICODE                  = $00000001;  //A - NTLMSSP_NEGOTIATE_UNICODE
  IdNTLM_NEGOTIATE_OEM                         = $00000002;  //B - NTLM_NEGOTIATE_OEM
  IdNTLMSSP_REQUEST_TARGET                     = $00000004;  //C - NTLMSSP_REQUEST_TARGET
  IdNTLM_Unknown1                              = $00000008;  //r9 - should be zero
  IdNTLMSSP_NEGOTIATE_SIGN                     = $00000010;  //D - NTLMSSP_NEGOTIATE_SIGN
  IdNTLMSSP_NEGOTIATE_SEAL                     = $00000020;  //E - NTLMSSP_NEGOTIATE_SEAL
  IdNTLMSSP_NEGOTIATE_DATAGRAM                 = $00000040;  //F - NTLMSSP_NEGOTIATE_DATAGRAM
  IdNTLMSSP_NEGOTIATE_LM_KEY                   = $00000080;  //G - NTLMSSP_NEGOTIATE_LM_KEY
  //mentioned in http://svn.xmpp.ru/repos/tkabber/trunk/tkabber/jabberlib/ntlm.tcl
  //and http://doc.ddart.net/msdn/header/include/ntlmsp.h.html from an old ntlmsp.h
  //header.  MS now says that is unused so it should be zero.
  IdNTLMSSP_NEGOTIATE_NETWARE                  = $00000100;  //r8 - should be zero
  IdNTLMSSP_NEGOTIATE_NTLM                     = $00000200;  //H - NTLMSSP_NEGOTIATE_NTLM
  IdNTLMSSP_NEGOTIATE_NT_ONLY                  = $00000400;  //I - NTLMSSP_NEGOTIATE_NT_ONLY
  IdNTLMSSP_ANONYMOUS                          = $00000800;  //J -
  IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED      = $00001000;  //K - NTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED
  IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED = $00002000;  //L - NTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED
//mentioned in http://svn.xmpp.ru/repos/tkabber/trunk/tkabber/jabberlib/ntlm.tcl
  //and http://doc.ddart.net/msdn/header/include/ntlmsp.h.html from an old ntlmsp.h
  //header.  MS now says that is unused so it should be zero.
  IdNTLMSSP_NEGOTIATE_LOCAL_CALL               = $00004000;  //r6 - should be zero

  IdNTLMSSP_NEGOTIATE_ALWAYS_SIGN              = $00008000;  //M - NTLMSSP_NEGOTIATE_ALWAYS_SIGN
  IdNTLMSSP_TARGET_TYPE_DOMAIN                 = $00010000;  //N - NTLMSSP_TARGET_TYPE_DOMAIN
  IdNTLMSSP_TARGET_TYPE_SERVER                 = $00020000;  //O - NTLMSSP_TARGET_TYPE_SERVER
  IdNTLMSSP_TARGET_TYPE_SHARE                  = $00040000;  //P - NTLMSSP_TARGET_TYPE_SHARE
  IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY = $00080000;  //Q - NTLMSSP_NEGOTIATE_NTLM2
//was  NTLMSSP_REQUEST_INIT_RESPONSE          0x100000
  IdNTLMSSP_NEGOTIATE_IDENTIFY                 = $00100000;  //R - NTLMSSP_NEGOTIATE_IDENTIFY

  IdNTLMSSP_REQUEST_ACCEPT_RESPONSE            = $00200000;  //r5 - should be zero
  //mentioned in http://doc.ddart.net/msdn/header/include/ntlmsp.h.html from an old ntlmsp.h
  //header.  MS now says that is unused so it should be zero.
  IdIdNTLMSSP_REQUEST_NON_NT_SESSION_KEY       = $00400000;  //S  - NTLMSSP_REQUEST_NON_NT_SESSION_KEY
  IdNTLMSSP_NEGOTIATE_TARGET_INFO              = $00800000;  //T  - NTLMSSP_NEGOTIATE_TARGET_INFO
  IdNTLM_Unknown4                              = $01000000;  //r4 - should be zero
  IdNTLMSSP_NEGOTIATE_VERSION                  = $02000000;  //U  - NTLMSSP_NEGOTIATE_VERSION
                                    //     400000
  IdNTLM_Unknown6                              = $04000000;  //r3 - should be zero

  IdNTLM_Unknown7                              = $08000000;  //r2 - should be zero
  IdNTLM_Unknown8                              = $10000000;  //r1 - should be zero
  IdNTLMSSP_NEGOTIATE_128                      = $20000000;  //V - NTLMSSP_NEGOTIATE_128
  IdNTLMSSP_NEGOTIATE_KEY_EXCH                 = $40000000;  //W - NTLMSSP_NEGOTIATE_KEY_EXCH
  IdNTLMSSP_NEGOTIATE_56                       = $80000000;  //X - NTLMSSP_NEGOTIATE_56

const
    //LC2 supports NTLMv2 only
  IdNTLM_TYPE1_FLAGS_LC2 = IdNTLMSSP_NEGOTIATE_UNICODE or
    IdNTLM_NEGOTIATE_OEM or
    IdNTLMSSP_REQUEST_TARGET or
    IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY;
  IdNTLM_TYPE1_FLAGS = IdNTLMSSP_NEGOTIATE_UNICODE or
    IdNTLM_NEGOTIATE_OEM or
    IdNTLMSSP_REQUEST_TARGET or
    IdNTLMSSP_NEGOTIATE_NTLM or
   // IdNTLMSSP_NEGOTIATE_ALWAYS_SIGN or
    IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY;
  IdNTLM_TYPE1_MARKER : UInt32 = 1;
  IdNTLM_TYPE2_MARKER : UInt32 = 2;
  IdNTLM_TYPE3_MARKER : UInt32 = 3;

  IdNTLM_NTLMSSP_DES_KEY_LENGTH =7;

  IdNTLM_NTLMSSP_CHALLENGE_SIZE = 8;

  IdNTLM_LM_HASH_SIZE = 16;
  IdNTLM_LM_SESS_HASH_SIZE = 16;
  IdNTLM_LM_RESPONSE_SIZE = 24;

  IdNTLM_NTLMSSP_HASH_SIZE	= 16;
  IdNTLM_NTLMSSP_RESPONSE_SIZE	= 24;

  IdNTLM_NTLMSSP_V2_HASH_SIZE = 6;
  IdNTLM_NTLMSSP_V2_RESPONSE_SIZE = 16;

  IdNTLM_NONCE_LEN = 8;
  IdNTLM_TYPE2_TNAME_LEN_OFS = 12;
  IdNTLM_TYPE2_TNAME_OFFSET_OFS = 16;
  IdNTLM_TYPE2_FLAGS_OFS = 20;
  IdNTLM_TYPE2_NONCE_OFS = 24;
  IdNTLM_TYPE2_TINFO_LEN_OFS = 40;
  IdNTLM_TYPE2_TINFO_OFFSET_OFS = 44;

  IdNTLM_TYPE3_DOM_OFFSET = 64;

  //version info constants
  IdNTLM_WINDOWS_MAJOR_VERSION_5 = $05;
  IdNTLM_WINDOWS_MAJOR_VERSION_6 = $06;
  IdNTLM_WINDOWS_MINOR_VERSION_0 = $00;
  IdNTLM_WINDOWS_MINOR_VERSION_1 = $01;
  IdNTLM_WINDOWS_MINOR_VERSION_2 = $02;
  //original rel.  build version of Vista
  //This isn't in the headers but I found easy enough.
  //It's provided because some NTLM servers might want ver info
  //from us.  So we want to provide some dummy version and
  //Windows Vista is logical enough.
  IdNTLM_WINDOWS_BUILD_ORIG_VISTA = 6000;

var
  IdNTLM_SSP_SIG : TIdBytes;
  UnixEpoch : TDateTime;

{$DEFINE TESTSUITE}
{$IFDEF TESTSUITE}
procedure TestNTLM;
{$ENDIF}

function BuildType1Msg(const ADomain : String = ''; const AHost : String = ''; const ALMCompatibility : UInt32 = 0) : TIdBytes;
procedure ReadType2Msg(const AMsg : TIdBytes; var VFlags : UInt32; var VTargetName : TIdBytes; var VTargetInfo : TIdBytes; var VNonce : TIdBytes );
function BuildType3Msg(const ADomain, AHost, AUsername, APassword : String;
  const AFlags : UInt32; const AServerNonce : TIdBytes;
  const ATargetName, ATargetInfo : TIdBytes;
  const ALMCompatibility : UInt32 = 0) : TIdBytes;


{
function BuildType1Message( ADomain, AHost: String; const AEncodeMsg : Boolean = True): String;
procedure ReadType2Message(const AMsg : String; var VNonce : nonceArray; var Flags : UInt32);
function BuildType3Message( ADomain, AHost, AUsername: TIdUnicodeString; APassword : String; AServerNonce : nonceArray): String;
 }

function NTLMFunctionsLoaded : Boolean;

procedure GetDomain(const AUserName : String; var VUserName, VDomain : String);

function DumpFlags(const ABytes : TIdBytes): String; overload;
function DumpFlags(const AFlags : UInt32): String; overload;

function LoadRC4 : Boolean;
function RC4FunctionsLoaded : Boolean;

{$IFNDEF DOTNET}
//const char *RC4_options(void);
var
  GRC4_Options : function () : PIdAnsiChar; cdecl = nil;
//void RC4_set_key(RC4_KEY *key, int len, const unsigned char *data);
  GRC4_set_key : procedure(key : PRC4_KEY; len : TIdC_INT; data : PIdAnsiChar); cdecl = nil;
//void RC4(RC4_KEY *key, unsigned long len, const unsigned char *indata,
//		unsigned char *outdata);
  GRC4 : procedure (key : PRC4_KEY; len : TIdC_ULONG; indata, outdata : PIdAnsiChar) ; cdecl = nil;
{$ENDIF}

implementation

uses
  SysUtils,
   {$IFDEF USE_VCL_POSIX}
  PosixTime,
   {$ENDIF}
  {$IFDEF DOTNET}
  Classes,
  System.Runtime.InteropServices,
  System.Runtime.InteropServices.ComTypes,
  System.Security.Cryptography,
  System.Text,
  {$ELSE}
    {$IFDEF FPC}
  DynLibs,  // better add DynLibs only for fpc
    {$ENDIF}
    {$IFDEF WINDOWS}
    //Windows should really not be included but this protocol does use
    //some windows internals and is Windows-based.
  Windows,
    {$ENDIF}
  {$ENDIF}
  IdFIPS,
  IdGlobalProtocols,
  IdHash,
  IdHMACMD5,
  IdHashMessageDigest,
  IdCoderMIME;

const
{$IFDEF DOTNET}
  MAGIC : array [ 0.. 7] of byte = ( $4b, $47, $53, $21, $40, $23, $24, $25);
{$ELSE}
  Magic: des_cblock = ( $4B, $47, $53, $21, $40, $23, $24, $25 );
  Magic_const : array [0..7] of byte = ( $4b, $47, $53, $21, $40, $23, $24, $25 );
{$ENDIF}
  TYPE1_MARKER = 1;
  TYPE2_MARGER = 2;
  TYPE3_MARKER = 3;

//const
//  NUL_USER_SESSION_KEY : TIdBytes[0..15] = ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00);

{$IFNDEF DOTNET}
type
  Pdes_key_schedule = ^des_key_schedule;
  {$IFNDEF WINDOWS}
  FILETIME = record
    dwLowDateTime : UInt32;
    dwHighDateTime : UInt32;
  end;
  {$ENDIF}
{$ENDIF}

function NulUserSessionKey : TIdBytes;
begin
  SetLength(Result,16);
  FillChar(Result,16,0);
end;

//misc routines that might be helpful in some other places
//===================
{$IFDEF DOTNET}
function Int64ToFileTime(const AInt64 : Int64) : System.Runtime.InteropServices.ComTypes.FILETIME;
var
  LBytes : TIdBytes;
begin
  LBytes := BitConverter.GetBytes(AInt64);
  Result.dwLowDateTime := BitConverter.ToInt32(Lbytes, 0);
  Result.dwHighDateTime := BitConverter.ToInt32(Lbytes, 4);
end;

function UnixTimeToFileTime(const AUnixTime : UInt32) : System.Runtime.InteropServices.ComTypes.FILETIME;
{$ELSE}
{
We do things this way because in Win64, FILETIME may not be a simple typecast
of Int64.  It might be a two dword record that's aligned on an 8-byte
boundery.
}
{$UNDEF USE_FILETIME_TYPECAST}
{$IFDEF WINCE}
  {$DEFINE USE_FILETIME_TYPECAST}
{$ENDIF}
{$IFDEF WIN32}
  {$DEFINE USE_FILETIME_TYPECAST}
{$ENDIF}

function UnixTimeToFileTime(const AUnixTime : UInt32) : FILETIME;
var
  i : Int64;
{$ENDIF}
begin
  {$IFDEF DOTNET}
  Result := Int64ToFileTime((AUnixTime + 11644473600) * 10000000);
  {$ELSE}
  i := (AUnixTime + 11644473600) * 10000000;
    {$IFDEF USE_FILETIME_TYPECAST}
  Result := FILETIME(i);
    {$ELSE}
  Result.dwLowDateTime := i and $FFFFFFFF;
  Result.dwHighDateTime := i shr 32;
    {$ENDIF}
  {$ENDIF}
end;

function NowAsFileTime : FILETIME;
{$IFDEF DOTNET}
  {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ENDIF}

{$IFDEF UNIX}
  {$IFNDEF USE_VCL_POSIX}
var
  TheTms: tms;
  {$ENDIF}
{$ENDIF}
begin
  {$IFDEF WINDOWS}
    {$IFDEF WINCE}
    // TODO
    {$ELSE}
  Windows.GetSystemTimeAsFileTime(Result);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF UNIX}
    {$IFDEF USE_VCL_BASEUNIX}
  Result := UnixTimeToFileTime( fptimes (TheTms));
    {$ENDIF}
  //Is the following correct?
    {$IFDEF KYLIXCOMPAT}
  Result := UnixTimeToFileTime(Times(TheTms));
     {$ENDIF}
      {$IFDEF USE_VCL_POSIX}
  Result := UnixTimeToFileTime(PosixTime.time(nil));
      {$ENDIF}
  {$ENDIF}
  {$IFDEF DOTNET}
   Result := Int64ToFileTime(DateTime.Now.ToFileTimeUtc);
 // Result := System.DateTime.Now.Ticks;
  {$ENDIF}
end;

function ConcateBytes(const A1, A2 : TIdBytes) : TIdBytes;
begin
  Result := A1;
  IdGlobal.AppendBytes(Result,A2);
end;

procedure CharArrayToBytes(const AArray : Array of char;  var VBytes : TIdBytes; const AIndex : Integer=0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low( AArray);
  lh := High( AArray);
  for i := ll to lh do begin
    VBytes[i] := Ord( AArray[ i]);
  end;
end;

procedure BytesToCharArray(const ABytes : TIdBytes; var VArray : Array of char; const AIndex : Integer=0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low( VArray);
  lh := High( Varray);
  for i := ll to lh do begin
    VArray[ i] := Char( Abytes[ (i - ll) + AIndex]);
  end;
end;

procedure BytesToByteArray(const ABytes : TIdBytes; var VArray : Array of byte; const AIndex : Integer=0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low(VArray);
  lh := High(Varray);
  for i := ll to lh do begin
    VArray[i] := Abytes[ (i - ll) + AIndex];
  end;
end;

procedure ByteArrayToBytes(const VArray : array of byte; const ABytes : TIdBytes; const AIndex : Integer=0);
var
  i, ll, lh : Integer;
begin
  ll :=  Low( VArray);
  lh := High( Varray);
  for i := ll to lh do begin
    Abytes[ (i - ll) + AIndex] := VArray[i];
  end;
end;

//---------------------------
//end misc routines

function DumpFlags(const ABytes : TIdBytes): String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DumpFlags( LittleEndianToHost(BytesToUInt32(ABytes)));
end;

function DumpFlags(const AFlags : UInt32): String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IntToHex(AFlags,8)+' -';
  if AFlags and IdNTLMSSP_NEGOTIATE_UNICODE <> 0 then
  begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_UNICODE';
  end;
  if AFlags and IdNTLM_NEGOTIATE_OEM <> 0 then begin
    Result := Result + ' IdNTLM_NEGOTIATE_OEM';
  end;
  if AFlags and IdNTLMSSP_REQUEST_TARGET <> 0 then begin
    Result := Result + ' IdNTLMSSP_REQUEST_TARGET';
  end;
  if AFlags and IdNTLM_Unknown1 <> 0 then begin
    Result := Result + ' IdNTLM_Unknown1';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_SIGN <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_SIGN';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_SEAL <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_SEAL';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_DATAGRAM <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_DATAGRAM';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_LM_KEY <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_LM_KEY';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_NETWARE <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_NETWARE';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_NTLM <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_NTLM';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_NT_ONLY <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_NT_ONLY';
  end;
  if AFlags and IdNTLMSSP_ANONYMOUS <> 0 then begin
    Result := Result + ' IdNTLMSSP_ANONYMOUS';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_LOCAL_CALL <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_LOCAL_CALL';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_ALWAYS_SIGN <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_ALWAYS_SIGN';
  end;
  if AFlags and IdNTLMSSP_TARGET_TYPE_DOMAIN <> 0 then begin
    Result := Result + ' IdNTLMSSP_TARGET_TYPE_DOMAIN';
  end;
  if AFlags and IdNTLMSSP_TARGET_TYPE_SERVER <> 0 then begin
    Result := Result + ' IdNTLMSSP_TARGET_TYPE_SERVER';
  end;
  if AFlags and IdNTLMSSP_TARGET_TYPE_SHARE <> 0 then begin
    Result := Result + ' IdNTLMSSP_TARGET_TYPE_SHARE';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_IDENTIFY <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_IDENTIFY';
  end;
  if AFlags and IdNTLMSSP_REQUEST_ACCEPT_RESPONSE <> 0 then begin
    Result := Result + ' IdNTLMSSP_REQUEST_ACCEPT_RESPONSE';
  end;
  if AFlags and IdIdNTLMSSP_REQUEST_NON_NT_SESSION_KEY <> 0 then begin
    Result := Result + ' IdIdNTLMSSP_REQUEST_NON_NT_SESSION_KEY';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_TARGET_INFO <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_TARGET_INFO';
  end;
  if AFlags and IdNTLM_Unknown4 <> 0 then begin
    Result := Result + ' IdNTLM_Unknown4';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_VERSION <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_VERSION';
  end;
  if AFlags and IdNTLM_Unknown8 <> 0 then begin
    Result := Result + ' IdNTLM_Unknown8';
  end;
  if AFlags and IdNTLM_Unknown7 <> 0 then begin
    Result := Result + ' IdNTLM_Unknown7';
  end;
  if AFlags and IdNTLM_Unknown8 <> 0 then begin
    Result := Result + ' IdNTLM_Unknown8';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_128 <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_128';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_KEY_EXCH <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_KEY_EXCH';
  end;
  if AFlags and IdNTLMSSP_NEGOTIATE_56 <> 0 then begin
    Result := Result + ' IdNTLMSSP_NEGOTIATE_56';
  end;
end;

{$IFDEF DOTNET}
const
  DES_ODD_PARITY : array[ 0.. 255] of byte =
    ( 1,   1,   2,   2,   4,   4,   7,   7,   8,   8,  11,  11,  13,  13,  14, 14,
     16,  16,  19,  19,  21,  21,  22,  22,  25,  25,  26,  26,  28,  28,  31,  31,
     32,  32,  35,  35,  37,  37,  38,  38,  41,  41,  42,  42,  44,  44,  47,  47,
     49,  49,  50,  50,  52,  52,  55,  55,  56,  56,  59,  59,  61,  61,  62,  62,
     64,  64,  67,  67,  69,  69,  70,  70,  73,  73,  74,  74,  76,  76,  79,  79,
     81,  81,  82,  82,  84,  84,  87,  87,  88,  88,  91,  91,  93,  93,  94,  94,
     97,  97,  98,  98, 100, 100, 103, 103, 104, 104, 107, 107, 109, 109, 110, 110,
    112, 112, 115, 115, 117, 117, 118, 118, 121, 121, 122, 122, 124, 124, 127, 127,
    128, 128, 131, 131, 133, 133, 134, 134, 137, 137, 138, 138, 140, 140, 143, 143,
    145, 145, 146, 146, 148, 148, 151, 151, 152, 152, 155, 155, 157, 157, 158, 158,
    161, 161, 162, 162, 164, 164, 167, 167, 168, 168, 171, 171, 173, 173, 174, 174,
    176, 176, 179, 179, 181, 181, 182, 182, 185, 185, 186, 186, 188, 188, 191, 191,
    193, 193, 194, 194, 196, 196, 199, 199, 200, 200, 203, 203, 205, 205, 206, 206,
    208, 208, 211, 211, 213, 213, 214, 214, 217, 217, 218, 218, 220, 220, 223, 223,
    224, 224, 227, 227, 229, 229, 230, 230, 233, 233, 234, 234, 236, 236, 239, 239,
    241, 241, 242, 242, 244, 244, 247, 247, 248, 248, 251, 251, 253, 253, 254, 254);

{
IMPORTANT!!!

In the NET framework, the DES API will not accept a weak key.  Unfortunately,
in NTLM's LM password, if a password is less than 8 charactors, the second key
is weak.  This is one flaw in that protocol.

To workaround this, we use a precalculated key of zeros with the parity bit set
and encrypt the MAGIC value with it.  The Mono framework also does this.
}
const
  MAGIC_NUL_KEY : array [ 0.. 7] of byte = ($AA,$D3,$B4,$35,$B5,$14,$04,$EE);

{barrowed from OpenSSL source-code - crypto/des/set_key.c 0.9.8g}
{
I barrowed it since it seems to work better than the NTLM sample code and because
Microsoft.NET does not have this functionality when it really should have it.
}

procedure SetDesKeyOddParity(var VKey : TIdBytes);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i, l : Integer;
begin
  l := Length( VKey);
  for i := 0 to l - 1 do begin
    VKey[ i] := DES_ODD_PARITY[ VKey[ i]];
  end;
end;
{$ENDIF}

procedure GetDomain(const AUserName : String; var VUserName, VDomain : String);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  i : Integer;
begin
{
Can be like this:
DOMAIN\user
domain.com\user
user@DOMAIN
}
   i := IndyPos('\', AUsername);
   if i > 0 then begin    //was -1
     VDomain := Copy( AUsername, 1, i - 1);
     VUserName := Copy( AUsername, i + 1, Length( AUserName));
   end else begin
     i := IndyPos('@',AUsername);
     if i > 0 then   //was -1 
     begin
       VUsername := Copy( AUsername, 1, i - 1);
       VDomain := Copy( AUsername, i + 1, Length( AUserName));
     end
     else
     begin
       VDomain := '';         {do not localize}
       VUserName := AUserName;
     end;
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
    Result := Assigned(des_set_odd_parity) and
      Assigned(DES_set_key) and
      Assigned(DES_ecb_encrypt);
  end;
end;

function LoadRC4 : Boolean;
var
  h : Integer;
begin
  Result := IdSSLOpenSSLHeaders.Load;
  if Result then begin
    h := IdSSLOpenSSLHeaders.GetCryptLibHandle;
    GRC4_Options := LoadLibFunction(h,'RC4_options');
    GRC4_set_key := LoadLibFunction(h,'RC4_set_key');
    GRC4 := LoadLibFunction(h,'RC4');
  end;
  Result := RC4FunctionsLoaded;
end;

function RC4FunctionsLoaded : Boolean;
begin
  Result := Assigned(GRC4_Options) and
     Assigned(GRC4_set_key) and
     Assigned(GRC4);
end;
{$ENDIF}

//* create NT hashed password */
function NTOWFv1(const APassword : String): TIdBytes;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LHash: TIdHashMessageDigest4;
begin
  CheckMD4Permitted;
  LHash := TIdHashMessageDigest4.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    Result := LHash.HashBytes(IndyTextEncoding_UTF16LE.GetBytes(APassword));
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHash.Free;
  end;
  {$ENDIF}
end;

{$IFNDEF DOTNET}
{/*
 * turns a 56 bit key into the 64 bit, odd parity key and sets the key.
 * The key schedule ks is also set.
 */}
procedure setup_des_key(key_56: des_cblock; Var ks: des_key_schedule);
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
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

//Returns 8 bytes in length
procedure _DES(var Res : TIdBytes; const Akey, AData : array of byte; const AKeyIdx, ADataIdx, AResIdx : Integer);
var
  Lks: des_key_schedule;
begin
  setup_des_key(pdes_cblock(@Akey[AKeyIdx])^, Lks);
  DES_ecb_encrypt(@AData[ADataIdx], Pconst_DES_cblock(@Res[AResIdx]), Lks, DES_ENCRYPT);

end;

function LMOWFv1(const Passwd, User, UserDom : TIdBytes) : TIdBytes;
//       ConcatenationOf( DES( UpperCase( Passwd)[0..6],"KGS!@#$%"),
//                 DES( UpperCase( Passwd)[7..13],"KGS!@#$%"))
var
  LBuf : TIdBytes;
begin
  SetLength(Result,16);
  SetLength(LBuf,14);
  FillBytes( LBuf, 14, 0);
  CopyTIdBytes(Passwd,0,LBuf, 0,14);
  _DES(Result,LBuf, Magic_const,0,0,0);
  _DES(Result,LBuf, Magic_const,7,0,8);

end;

{/*
 * takes a 21 byte array and treats it as 3 56-bit DES keys. The
 * 8 byte plaintext is encrypted with each key and the resulting 24
 * bytes are stored in the results array.
 */}
procedure DESL(const Akeys: TIdBytes; const AServerNonce: TIdBytes; out results: TIdBytes);
//procedure DESL(keys: TIdBytes; AServerNonce: TIdBytes; results: TIdBytes);
//procedure DESL(keys: TIdBytes; AServerNonce: TIdBytes; results: Pdes_key_schedule);
var
  ks: des_key_schedule;
begin
  SetLength(Results,24);
  setup_des_key(PDES_cblock(@Akeys[0])^, ks);
  DES_ecb_encrypt(@AServerNonce[0], Pconst_DES_cblock(results), ks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(Integer(Akeys) + 7)^, ks);
  DES_ecb_encrypt(@AServerNonce[0], Pconst_DES_cblock(PtrUInt(results) + 8), ks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(Integer(Akeys) + 14)^, ks);
  DES_ecb_encrypt(@AServerNonce[0], Pconst_DES_cblock(PtrUInt(results) + 16), ks, DES_ENCRYPT);
end;



//* setup LanManager password */
function SetupLMResponse(var vlmHash : TIdBytes; const APassword : String; AServerNonce : TIdBytes): TIdBytes;
var
  lm_hpw : TIdBytes;
  lm_pw : TIdBytes;
  ks: des_key_schedule;
begin
  SetLength( lm_hpw,21);
  FillBytes( lm_hpw, 14, 0);
  SetLength( lm_pw, 21);
  FillBytes( lm_pw, 14, 0);
  SetLength( vlmHash, 16);
  CopyTIdString( UpperCase( APassword), lm_pw, 0, 14);

  //* create LanManager hashed password */
  setup_des_key(pdes_cblock(@lm_pw[0])^, ks);
  DES_ecb_encrypt(@magic, pconst_des_cblock(@lm_hpw[0]), ks, DES_ENCRYPT);

  setup_des_key(pdes_cblock(@lm_pw[7])^, ks);
  DES_ecb_encrypt(@magic, pconst_des_cblock(@lm_hpw[8]), ks, DES_ENCRYPT);
  CopyTIdBytes(lm_pw,0,vlmHash,0,16);
 // FillChar(lm_hpw[17], 5, 0);
  SetLength(Result,24);
  DESL(lm_hpw, AServerNonce, Result);
//  DESL(PDes_cblock(@lm_hpw[0]), AServerNonce, Pdes_key_schedule(@Result[0]));
//
end;

//* create NT hashed password */
function CreateNTLMResponse(var vntlmhash : TIdBytes; const APassword : String; const nonce : TIdBytes): TIdBytes;
var
  nt_pw : TIdBytes;
  nt_hpw : TIdBytes; //array [1..21] of Char;
 // nt_hpw128 : TIdBytes;
  LHash: TIdHashMessageDigest4;
begin
  CheckMD4Permitted;
  nt_pw := IndyTextEncoding_UTF16LE.GetBytes(APassword);
  LHash := TIdHashMessageDigest4.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    vntlmhash := LHash.HashBytes(nt_pw);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHash.Free;
  end;
  {$ENDIF}
  SetLength( nt_hpw, 21);
  FillChar( nt_hpw[ 17], 5, 0);
  CopyTIdBytes( vntlmhash, 0, nt_hpw, 0, 16);
  // done in DESL
  SetLength( Result, 24);

//  DESL(pdes_cblock(@nt_hpw[0]), nonce, Pdes_key_schedule(@Result[0]));

  DESL(nt_hpw, nonce, Result);
end;

{
function CreateNTLMResponse(const APassword : String; const nonce : TIdBytes): TIdBytes;
var
  nt_pw : TIdBytes;
  nt_hpw : array [ 1.. 21] of AnsiChar;
  nt_hpw128 : TIdBytes;
  LHash: TIdHashMessageDigest4;
begin
  CheckMD4Permitted;
  SetLength(Result,24);
  nt_pw := IndyTextEncoding_UTF16LE.GetBytes(APassword);
  LHash := TIdHashMessageDigest4.Create;
  {$IFNDEF USE_OBJECT_ARC
  try
  {$ENDIF
    nt_hpw128 := LHash.HashBytes(nt_pw);//LHash.HashString( nt_pw);
  {$IFNDEF USE_OBJECT_ARC
  finally
    LHash.Free;
  end;
  {$ENDIF
  Move( nt_hpw128[ 0], nt_hpw[ 1], 16);
  FillChar( nt_hpw[ 17], 5, 0);
  DESL(pdes_cblock( @nt_hpw[1]), nonce, Pdes_key_schedule( @Result[ 0]));
end;    }

{$ELSE}


procedure setup_des_key(const Akey_56: TIdBytes; out Key : TIdBytes; const AIndex : Integer = 0);
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  SetLength( key, 8);
  key[0] := Akey_56[ AIndex];
  key[1] := (( Akey_56[ AIndex] SHL 7) and $FF) or (Akey_56[ AIndex + 1] SHR 1);
  key[2] := (( Akey_56[ AIndex + 1] SHL 6) and $FF) or (Akey_56[ AIndex + 2] SHR 2);
  key[3] := (( Akey_56[ AIndex + 2] SHL 5) and $FF) or (Akey_56[ AIndex + 3] SHR 3);
  key[4] := (( Akey_56[ AIndex + 3] SHL 4) and $FF) or (Akey_56[ AIndex + 4] SHR 4);
  key[5] := (( Akey_56[ AIndex + 4] SHL 3) and $FF) or (Akey_56[ AIndex + 5] SHR 5);
  key[6] := (( Akey_56[ AIndex + 5] SHL 2) and $FF) or (Akey_56[ AIndex + 6] SHR 6);
  key[7] :=  ( AKey_56[ AIndex + 6] SHL 1) and $FF;
  SetDesKeyOddParity( Key);
end;



procedure DESL(const Akeys: TIdBytes; const AServerNonce: TIdBytes; out results: TIdBytes);
var
  LKey : TIdBytes;
  LDes : System.Security.Cryptography.DES;
  LEnc : ICryptoTransform;
begin
  SetLength( Results, 24);
  SetLength( LKey, 8);
  LDes := DESCryptoServiceProvider.Create;
  LDes.Mode := CipherMode.ECB;
  LDes.Padding := PaddingMode.None;
  setup_des_key( AKeys, LKey, 0);
  LDes.Key := LKey;
  LEnc := LDes.CreateEncryptor;
  LEnc.TransformBlock( AServerNonce, 0, 8, Results, 0);
  setup_des_key( AKeys, LKey, 7);
  LDes.Key := LKey;
  LEnc := LDes.CreateEncryptor;
  LEnc.TransformBlock( AServerNonce, 0, 8, Results, 8);

  setup_des_key(AKeys,LKey,14);
  LDes.Key := LKey;
  LEnc := LDes.CreateEncryptor;
  LEnc.TransformBlock( AServerNonce, 0, 8, Results, 16);
end;

function SetupLMResponse(const APassword : String; AServerNonce : TIdBytes): TIdBytes;
var
  lm_hpw : TIdBytes; //array[1..21] of Char;
  lm_pw : TIdBytes; //array[1..21] of Char;
  LDes : System.Security.Cryptography.DES;
  LEnc : ICryptoTransform;
  LKey : TIdBytes;
begin
  SetLength( lm_hpw,21);
  FillBytes( lm_hpw, 14, 0);
  SetLength( lm_pw, 21);
  FillBytes( lm_pw, 14, 0);
  CopyTIdString( UpperCase( APassword), lm_pw, 0, 14);
  LDes := DESCryptoServiceProvider.Create;
  LDes.Mode := CipherMode.ECB;
  LDes.Padding := PaddingMode.None;
  setup_des_key( lm_pw, LKey, 0);
  LDes.BlockSize := 64;
  LDes.Key := LKey;
  LEnc := LDes.CreateEncryptor;
  LEnc.TransformBlock( MAGIC, 0, 8, lm_hpw, 0);
  setup_des_key( lm_pw, LKey,7);
  if Length( APassword) > 7 then begin
    LDes.Key := LKey;
    LEnc := LDes.CreateEncryptor;
    LEnc.TransformBlock( MAGIC, 0, 8, lm_hpw, 8);
  end else begin
    CopyTIdBytes( MAGIC_NUL_KEY, 0, lm_hpw, 8, 8);
  end;
  DESL( lm_hpw, nonce, Result);
end;

function CreateNTLMResponse(const APassword : String; const nonce : TIdBytes): TIdBytes;
var
  nt_pw : TIdBytes;
  nt_hpw : TIdBytes; //array [1..21] of Char;
  nt_hpw128 : TIdBytes;
begin
  CheckMD4Permitted;
  nt_pw := System.Text.Encoding.Unicode.GetBytes( APassword);
  with TIdHashMessageDigest4.Create do try
    nt_hpw128 := HashString( nt_pw);
  finally
    Free;
  end;
  SetLength( nt_hpw, 21);
  FillBytes( nt_hpw, 21, 0);
  CopyTIdBytes( nt_hpw128, 0, nt_hpw, 0, 16);
  // done in DESL
  //SetLength( nt_resp, 24);
  DESL( nt_hpw,nonce, Result);
end;

{$ENDIF}


procedure AddUInt16(var VBytes: TIdBytes; const AWord : UInt16);
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LBytes : TIdBytes;
begin
  SetLength(LBytes,SizeOf(AWord));
  CopyTIdUInt16(HostToLittleEndian(AWord),LBytes,0);
  AppendBytes( VBytes,LBytes);
end;

procedure AddUInt32(var VBytes: TIdBytes; const ALongWord : UInt32);
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LBytes : TIdBytes;
begin
  SetLength(LBytes,SizeOf(ALongWord));
  CopyTIdUInt32(HostToLittleEndian(ALongWord),LBytes,0);
  AppendBytes( VBytes,LBytes);
end;

procedure AddInt64(var VBytes: TIdBytes; const AInt64 : Int64);
var
  LBytes : TIdBytes;
begin
  SetLength(LBytes,SizeOf(AInt64));
  {$IFDEF ENDIAN_LITTLE}
  IdGlobal.CopyTIdInt64(AInt64,LBytes,0);
  {$ELSE}
    //done this way since we need this in little endian byte-order
  CopyTIdUInt32(HostToLittleEndian(Lo( AInt64)));
  CopyTIdUInt32(HostToLittleEndian(Hi( AInt64)));
  {$ENDIF}
  AppendBytes( VBytes,LBytes);
end;

{
IMPORTANT!!! I think the time feilds in the NTLM blob are really FILETIME
records.

MSDN says that a Contains a 64-bit value representing the number of
100-nanosecond intervals since January 1, 1601 (UTC).

http://davenport.sourceforge.net/ntlm.html says that the time feild is
Little-endian, 64-bit signed value representing the number of tenths of a
microsecond since January 1, 1601.

In other words, they are the same.  We use FILETIME for the API so that
we can easily obtain a the timestamp for the blob in Microsoft.NET as well as
Delphi (the work on proper format is already done for us.
}

const
  NTLMv2_BLOB_Sig : array [0..3] of byte = ($01,$01,$00,$00);
  NTLMv2_BLOB_Res : array [0..3] of byte = ($00,$00,$00,$00);

function IndyByteArrayLength(const ABuffer: array of byte; const ALength: Integer = -1; const AIndex: Integer = 0): Integer;
var
  LAvailable: Integer;
begin
  Assert(AIndex >= 0);
  LAvailable := IndyMax(Length(ABuffer)-AIndex, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := IndyMin(LAvailable, ALength);
  end;
end;

procedure AddByteArray(var VBytes : TIdBytes; const AToAdd : array of byte; const AIndex: Integer = 0);
var
  LOldLen, LAddLen : Integer;
begin
  LAddLen := IndyByteArrayLength(AToAdd, -1, AIndex);

  if LAddLen > 0 then begin
    LOldLen := Length(VBytes);
    SetLength(VBytes, LOldLen + LAddLen);
    CopyTIdByteArray(AToAdd, AIndex, VBytes, LOldLen, LAddLen);
  end;
end;

{$IFDEF DOTNET}
function MakeBlob(const ANTLMTimeStamp :  System.Runtime.InteropServices.ComTypes.FileTime;
 const ATargetInfo : TIdBytes;const cnonce : TIdBytes) : TIdBytes;
{$ELSE}
function MakeBlob(const ANTLMTimeStamp : FILETIME; const ATargetInfo : TIdBytes;const cnonce : TIdBytes) : TIdBytes;
{$ENDIF}
begin
  SetLength(Result,0);

  //blob signature - offset 0
  //   RespType - offset 0
  //   HiRespType - offset 1
  //   Reserved1 - offset 2
  AddByteArray( Result, NTLMv2_BLOB_Sig);
  // reserved  - offset 4
  //   Reserved2  - offset 4
  AddByteArray( Result, NTLMv2_BLOB_Res);

  // time - offset 8
  IdNTLMv2.AddUInt32(Result, ANTLMTimeStamp.dwLowDateTime );
  IdNTLMv2.AddUInt32(Result, ANTLMTimeStamp.dwHighDateTime );

  //client nonce (challange)
  // cnonce - offset 16
  IdGlobal.AppendBytes(Result,cnonce);
  // reserved 3
  //   offset - offset 24
  AddUInt32(Result,0);
//  AddByteArray( Result, NTLMv2_BLOB_Res);
  // targetinfo - offset 28
  //    av pairs - offset 28
  IdGlobal.AppendBytes(Result,ATargetInfo);
  // unknown (0 works)
  AddByteArray( Result, NTLMv2_BLOB_Res);
end;

function InternalCreateNTLMv2Response(var Vntlm2hash : TIdBytes;
  const AUsername, ADomain, APassword : String;
  const ATargetInfo : TIdBytes;
  const ATimestamp : FILETIME;
  const cnonce, nonce : TIdBytes): TIdBytes;
var
  LLmUserDom : TIdBytes;
  Blob : TIdBytes;
  LEncoding: IIdTextEncoding;
  LHMac: TIdHMACMD5;
begin
  LEncoding := IndyTextEncoding_UTF16LE;
  LLmUserDom := LEncoding.GetBytes(UpperCase(AUsername));
  AppendBytes(LLmUserDom, LEncoding.GetBytes(ADomain));
  LEncoding := nil;

  LHMac := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHMac.Key := NTOWFv1(APassword);
    Vntlm2hash := LHMac.HashValue(LLmUserDom);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHMac.Free;
  end;
  {$ENDIF}
  Blob := MakeBlob(ATimestamp,ATargetInfo,cnonce);
  LHMac := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHMac.Key := Vntlm2hash;
    Result := LHMac.HashValue(ConcateBytes(nonce,Blob));
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHMac.Free;
  end;
  {$ENDIF}
  AppendBytes(Result,Blob);

end;

function CreateNTLMv2Response(var Vntlm2hash : TIdBytes;
  const AUsername, ADomain, APassword : String;
  const TargetName, ATargetInfo : TIdBytes;
  const cnonce, nonce : TIdBytes): TIdBytes;
begin
  Result := InternalCreateNTLMv2Response(Vntlm2hash, AUsername, ADomain, APassword, ATargetInfo, NowAsFileTime,cnonce, nonce);
end;

function LMUserSessionKey(const AHash : TIdBytes) : TIdBytes;
{$IFDEF USE_INLINE} inline; {$ENDIF}
//   1. The 16-byte LM hash (calculated previously) is truncated to 8 bytes.
//   2. This is null-padded to 16 bytes. This value is the LM User Session Key.
begin
  SetLength(Result,16);
  FillBytes(Result,16,0);
  CopyTIdBytes(AHash,0,Result,0,8);
end;

function UserNTLMv1SessionKey(const AHash : TIdBytes) : TIdBytes;
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LHash: TIdHashMessageDigest4;
begin
  CheckMD4Permitted;
  LHash := TIdHashMessageDigest4.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    Result := LHash.HashBytes(AHash);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHash.Free;
  end;
  {$ENDIF}
end;

function UserLMv2SessionKey(const AHash : TIdBytes; const ABlob : TIdBytes; ACNonce : TIdBytes) : TIdBytes;
 {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LBuf : TIdBytes;
  LHMac: TIdHMACMD5;
begin
  LBuf := ABlob;
  AppendBytes(LBuf,ACNonce);
  LHMac := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHMac.Key := AHash;
    Result := LHMac.HashValue(LHMac.HashValue(LBuf));
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHMac.Free;
  end;
  {$ENDIF}
end;

function UserNTLMv2SessionKey(const AHash : TIdBytes; const ABlob : TIdBytes; const AServerNonce : TIdBytes) : TIdBytes;
 {$IFDEF USE_INLINE} inline; {$ENDIF}
//extremely similar to the above except that the nonce is used.
begin
  Result := UserLMv2SessionKey(AHash,ABlob,AServerNonce);
end;

function UserNTLM2SessionSecSessionKey(const ANTLMv1SessionKey : TIdBytes; const AServerNonce : TIdBytes): TIdBytes;
 {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LHash: TIdHMACMD5;
begin
  LHash := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHash.Key := ANTLMv1SessionKey;
    Result := LHash.HashValue(AServerNonce);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHash.Free;
  end;
  {$ENDIF}
end;

function LanManagerSessionKey(const ALMHash : TIdBytes) : TIdBytes;
var
  LKey : TIdBytes;
  ks : des_key_schedule;
  LHash8 : TIdBytes;
begin
  LHash8 := ALMHash;
  SetLength(LHash8,8);
  SetLength(LKey,14);
  FillChar(LKey,14,$bd);
  CopyTIdBytes(LHash8,0,LKey,0,8);
  SetLength(Result,16);
  setup_des_key(pdes_cblock(@LKey[0])^, ks);
  DES_ecb_encrypt(@LHash8, pconst_des_cblock(@Result[0]), ks, DES_ENCRYPT);

  setup_des_key(pdes_cblock(@LKey[7])^, ks);
  DES_ecb_encrypt(@LHash8, pconst_des_cblock(@Result[8]), ks, DES_ENCRYPT);

end;

function SetupLMv2Response(var VntlmHash : TIdBytes; const AUsername, ADomain : String; const APassword : String; cnonce, AServerNonce : TIdBytes): TIdBytes;
var
  LLmUserDom : TIdBytes;
  LChall : TIdBytes;
  LEncoding: IIdTextEncoding;
  LHMac: TIdHMACMD5;
begin
  LEncoding := IndyTextEncoding_UTF16LE;
  LLmUserDom := LEncoding.GetBytes(UpperCase(AUsername));
  AppendBytes(LLmUserDom, LEncoding.GetBytes(ADomain));
  LEncoding := nil;

  LHMac := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHMac.Key := NTOWFv1(APassword);
    VntlmHash := LHMac.HashValue(LLmUserDom);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHMac.Free;
  end;
  {$ENDIF}
  LChall := AServerNonce;
  IdGlobal.AppendBytes(LChall,cnonce);
  LHMac := TIdHMACMD5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    LHMac.Key := vntlmhash;
    Result := LHMac.HashValue(LChall);
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHMac.Free;
  end;
  {$ENDIF}
  AppendBytes(Result,cnonce);
end;

//function SetupLMResponse(const APassword : String; nonce : TIdBytes): TIdBytes;
function CreateModNTLMv1Response(var Vntlmseshash : TIdBytes; const AUsername : String; const APassword : String; cnonce, nonce : TIdBytes; var LMFeild : TIdBytes): TIdBytes;
var
  LChall, LTmp : TIdBytes;
  lntlmseshash : TIdBytes;
  LPassHash : TIdBytes;
  LHash: TIdHashMessageDigest5;
begin
  CheckMD5Permitted;
  //LM feild value for Type3 message
  SetLength(LMFeild,24);
  FillBytes( LMFeild,24, 0);
  IdGlobal.CopyTIdBytes(cnonce,0,LMFeild,0,8);
  //
  LChall := nonce;
  IdGlobal.AppendBytes(LChall,cnonce);
  LHash := TIdHashMessageDigest5.Create;
  {$IFNDEF USE_OBJECT_ARC}
  try
  {$ENDIF}
    Vntlmseshash := LHash.HashBytes(LChall);
    //we do this copy because we may need the value later.
    lntlmseshash := Vntlmseshash;
  {$IFNDEF USE_OBJECT_ARC}
  finally
    LHash.Free;
  end;
  {$ENDIF}
  SetLength(lntlmseshash,8);
  SetLength(LPassHash,21);
  FillBytes( LPassHash,21, 0);
  LTmp := NTOWFv1(APassword);
  IdGlobal.CopyTIdBytes(LTmp,0,LPassHash,0,Length(LTmp));
  {$IFNDEF DOTNET}
  SetLength(Result,24);
  DESL( LPassHash,lntlmseshash, Result);
 // DESL(PDes_cblock(@LPassHash[0]), lntlmseshash, Pdes_key_schedule(@Result[0]));
   {$ELSE}
  DESL( LPassHash,ntlmseshash, Result);
  {$ENDIF}
end;

//Todo:  This does not match the results from
//http://davenport.sourceforge.net/ntlm.html
function TDateTimeToNTLMTime(const ADateTime : TDateTime):Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := DateTimeToUnix((ADateTime+11644473600)* 10000);
end;


function BuildType1Msg(const ADomain : String = ''; const AHost : String = ''; const ALMCompatibility : UInt32 = 0) : TIdBytes;
var
  LDomain, LWorkStation: TIdBytes;
  LDomLen, LWorkStationLen: UInt16;
  LFlags : UInt32;
  LEncoding: IIdTextEncoding;
begin
  SetLength(Result,0);

  LEncoding := IndyTextEncoding_OSDefault;
  LDomain := LEncoding.GetBytes(ADomain); //UpperCase(ADomain));
  LWorkStation := LEncoding.GetBytes(AHost); //UpperCase(AHost));
  LEncoding := nil;

  LFlags := IdNTLM_TYPE1_FLAGS_LC2;
  case ALMCompatibility of
    0, 1 : LFlags := IdNTLM_TYPE1_FLAGS;
  end;

  LDomLen := Length(LDomain);
  if LDomLen > 0 then begin
    LFlags := LFlags or IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED;
  end;

  LWorkStationLen := Length(LWorkStation);
  if LWorkStationLen > 0 then begin
    LFlags := LFlags or IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED;
  end;
  //signature
  AppendBytes(Result,IdNTLM_SSP_SIG);
  //type
  AddUInt32(Result,IdNTLM_TYPE1_MARKER);
  //flags
  AddUInt32(Result,LFlags);
  //Supplied Domain security buffer
  //   - length
  AddUInt16(Result,LDomLen);
  //   - allocated space
  AddUInt16(Result,LDomLen);
  //   - offset
  AddUInt32(Result,LWorkStationLen+$20);
  //Supplied Workstation security buffer (host)
  //   - length
  AddUInt16(Result,LWorkStationLen);
  //   - allocated space
  AddUInt16(Result,LWorkStationLen);
  //   - offset
  if LWorkStationLen > 0 then begin
     AddUInt32(Result,$20);
  end else begin
     AddUInt32(Result,$08);
  end;
  // Supplied Workstation  (host)
  if LWorkStationLen > 0 then begin
    AppendBytes(Result,LWorkStation,0,LWorkStationLen);
  end;
  // Supplied Domain
  if LDomLen > 0 then begin
    AppendBytes(Result,LDomain,0,LDomLen);
  end;
end;

procedure ReadType2Msg(const AMsg : TIdBytes; var VFlags : UInt32; var VTargetName : TIdBytes; var VTargetInfo : TIdBytes; var VNonce : TIdBytes );
var
  LLen : UInt16;
  LOfs : UInt32;
begin
  //extract flags
  VFlags := LittleEndianToHost(BytesToUInt32(AMsg,IdNTLM_TYPE2_FLAGS_OFS));

  //extract target name

  // - security buffer
  LLen := LittleEndianToHost( BytesToUInt16(AMsg,IdNTLM_TYPE2_TNAME_LEN_OFS));
  LOfs := LittleEndianToHost( BytesToUInt32(AMsg,IdNTLM_TYPE2_TNAME_OFFSET_OFS));
  // - the buffer itself
  SetLength(VTargetName,LLen);
  CopyTIdBytes(AMsg,LOfs,VTargetName,0,LLen);
  //extract targetinfo
  //Note that we should ignore TargetInfo if it is not required.
  if VFlags and IdNTLMSSP_NEGOTIATE_TARGET_INFO > 0 then begin
    // - security buffer
    LLen := LittleEndianToHost( BytesToUInt16(AMsg,IdNTLM_TYPE2_TINFO_LEN_OFS));
    LOfs := LittleEndianToHost( BytesToUInt32(AMsg,IdNTLM_TYPE2_TINFO_OFFSET_OFS));
    // - the buffer itself
    SetLength(VTargetInfo,LLen);
    CopyTIdBytes(AMsg,LOfs,VTargetInfo,0,LLen);
  end else begin
    SetLength(VTargetInfo,0);
  end;
  //extract nonce
  SetLength(VNonce,IdNTLM_NONCE_LEN);
  CopyTIdBytes(AMsg,IdNTLM_TYPE2_NONCE_OFS,VNonce,0,IdNTLM_NONCE_LEN);
end;

function CreateData(const ABytes : TIdBytes; const AOffset : UInt32; var VBuffer : TIdBytes) : UInt32;
//returns the next buffer value
//adds security value ptr to Vbuffer
var
  LLen : UInt16;
begin
  LLen := Length(ABytes);
  //   - length
  AddUInt16(VBuffer,LLen);
  //   - allocated space
  AddUInt16(VBuffer,LLen);
  //   - offset
  AddUInt32(VBuffer,AOffset);
  Result := AOffset + Llen;
end;

function GenerateCNonce : TIdBytes;
begin
  SetLength(Result,8);
  Randomize;
  Result[0] := Random(127)+1;
  Result[1] := Random(127)+1;
  Result[2] := Random(127)+1;
  Result[3] := Random(127)+1;
  Result[4] := Random(127)+1;
  Result[5] := Random(127)+1;
  Result[6] := Random(127)+1;
  Result[7] := Random(127)+1;
end;

const
  IdNTLM_IGNORE_TYPE_2_3_MASK = not
    (IdNTLMSSP_TARGET_TYPE_DOMAIN or
    IdNTLMSSP_TARGET_TYPE_SERVER or
    IdNTLMSSP_TARGET_TYPE_SHARE);

function BuildType3Msg(const ADomain, AHost, AUsername, APassword : String;
  const AFlags : UInt32; const AServerNonce : TIdBytes;
  const ATargetName, ATargetInfo : TIdBytes;
  const ALMCompatibility : UInt32 = 0) : TIdBytes;
var
  LDom, LHost, LUser, LLMData, LNTLMData, LCNonce : TIdBytes;
  llmhash, lntlmhash : TIdBytes;
  ll_len, ln_len, ld_len, lh_len, lu_len : UInt16;
  ll_ofs, ln_ofs, ld_ofs, lh_ofs, lu_ofs : UInt32;
  LFlags : UInt32;
  LEncoding: IIdTextEncoding;
begin
  LFlags := AFlags and IdNTLM_IGNORE_TYPE_2_3_MASK;
  if AFlags and IdNTLMSSP_REQUEST_TARGET > 0 then begin
   LFlags := LFlags or IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED;
  end;
  if LFlags and IdNTLMSSP_NEGOTIATE_UNICODE <> 0 then begin
    LEncoding := IndyTextEncoding_UTF16LE;
    if LFlags and IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED > 0 then begin
      if Length(ATargetName) > 0 then begin
        LDom := ATargetName;
      end else begin
        LDom := LEncoding.GetBytes(UpperCase(ADomain));
      end;
    end;
    if LFlags and IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED > 0 then begin
      LHost := LEncoding.GetBytes(UpperCase(AHost));
    end;
    LUser := LEncoding.GetBytes(UpperCase(AUsername));
    LEncoding := nil;
  end else begin
    if LFlags and IdNTLMSSP_NEGOTIATE_OEM_DOMAIN_SUPPLIED > 0 then begin
      LDom :=  ToBytes(UpperCase(ADomain));
    end;
    if LFlags and IdNTLMSSP_NEGOTIATE_OEM_WORKSTATION_SUPPLIED > 0 then begin
      LHost := ToBytes(UpperCase(AHost));
    end;
    LUser := ToBytes(UpperCase(AUsername));
  end;
  if (ALMCompatibility < 3) and
    (AFlags and IdNTLMSSP_NEGOTIATE_EXTENDED_SESSIONSECURITY > 0) then
  begin
    LCNonce := GenerateCNonce;
    LNTLMData := CreateModNTLMv1Response(lntlmhash,AUserName,APassword,LCNonce,AServerNonce,LLMData);
//    LLMData := IdNTLMv2.SetupLMv2Response(AUsername,ADomain,APassword,LCNonce,AServerNonce);
//    LNTLMData := CreateNTLMv2Response(AUserName,ADomain,APassword,ATargetName,ATargetName, ATargetInfo,LCNonce);
  end else begin
    case ALMCompatibility of
    0 :
      begin
        if AFlags and IdNTLMSSP_NEGOTIATE_NT_ONLY <> 0 then
        begin
          SetLength(LLMData,0);
        end
        else
        begin
          LLMData :=  SetupLMResponse(llmhash, APassword, AServerNonce);
        end;
        LNTLMData := CreateNTLMResponse(lntlmhash, APassword, AServerNonce);
      end;
    1 :
      begin
        if AFlags and IdNTLMSSP_NEGOTIATE_NT_ONLY <> 0 then
        begin
          SetLength(LLMData,0);
        end
        else
        begin
          LLMData :=  SetupLMResponse(llmhash, APassword, AServerNonce);
        end;
        LNTLMData := CreateNTLMResponse(lntlmhash,APassword, AServerNonce);
      end;
    2 : //Send NTLM response only
      begin
        LNTLMData := CreateNTLMResponse(lntlmhash,APassword, AServerNonce);
        if AFlags and IdNTLMSSP_NEGOTIATE_NT_ONLY <> 0 then
        begin
          SetLength(LLMData,0);
        end
        else
        begin
          LLMData := LNTLMData;
        //  LLMData :=  SetupLMResponse(APassword, ANonce);
        end;
      end;
     3,4,5 : //Send NTLMv2 response only
      begin
//        LFlags := LFlags and (not IdNTLMSSP_NEGOTIATE_NTLM);
        LCNonce := GenerateCNonce;
        LLMData := IdNTLMv2.SetupLMv2Response(llmhash,AUsername,ADomain,APassword,LCNonce,AServerNonce);
        LNTLMData := CreateNTLMv2Response(lntlmhash,AUserName,ADomain,APassword,ATargetName,ATargetInfo,LCNonce,AServerNonce);

      end;
      //        LCNonce := GenerateCNonce;
//        LNTLMData := IdNTLMv2.CreateModNTLMv1Response(AUserName,APassword,LCNonce,ANonce,LLMData);
    end;
  end;
  //calculations for security buffer pointers
  //We do things this way because the security buffers are in a different order
  //than the data buffers themselves.  In theory, you could change it but it's
  //not a good idea.
  ll_len := Length(LLMData);
  ln_len := Length(LNTLMData);
  ld_len := Length(LDom);
  lh_len := Length(LHost);
  lu_len := Length(LUser);

  LFlags := LFlags and (not IdNTLMSSP_NEGOTIATE_VERSION);
  ld_ofs :=  IdNTLM_TYPE3_DOM_OFFSET;

{  if LFlags and IdNTLMSSP_NEGOTIATE_VERSION <> 0 then
  begin
    ld_ofs :=  IdNTLM_TYPE3_DOM_OFFSET + 8;
    AppendByte(Result, IdNTLM_WINDOWS_MAJOR_VERSION_6);
    AppendByte(Result, IdNTLM_WINDOWS_MINOR_VERSION_0);
    AddUInt16(Result,IdNTLM_WINDOWS_BUILD_ORIG_VISTA);
    AddUInt32(Result,$F);
  end;   }
  lu_ofs := ld_len + ld_ofs;
  lh_ofs := lu_len + lu_ofs;
  ll_ofs := lh_len + lh_ofs;
  ln_ofs := ll_len + ll_ofs;

  SetLength(Result,0);
  // 0 - signature
  AppendBytes(Result,IdNTLM_SSP_SIG);
  // 8 - type
  AddUInt32(Result,IdNTLM_TYPE3_MARKER);

  //12 - LM Response Security Buffer:
  //   - length
   AddUInt16(Result,ll_len);
  //   - allocated space
   AddUInt16(Result,ll_len);
  //   - offset
   AddUInt32(Result,ll_ofs);

  //20 - NTLM Response Security Buffer:
  //   - length
   AddUInt16(Result,ln_len);
  //   - allocated space
   AddUInt16(Result,ln_len);
  //   - offset
   AddUInt32(Result,ln_ofs);

  //28 - Domain Name Security Buffer:  (target)
  //   - length
   AddUInt16(Result,ld_len);
  //   - allocated space
   AddUInt16(Result,ld_len);
  //   - offset
  AddUInt32(Result,ld_ofs);

  //36 - User Name Security Buffer:
  //   - length
   AddUInt16(Result,lu_len);
  //   - allocated space
   AddUInt16(Result,lu_len);
  //   - offset
   AddUInt32(Result,lu_ofs);

  //44 - Workstation Name (host) Security Buffer:
  //   - length
   AddUInt16(Result,lh_len);
  //   - allocated space
   AddUInt16(Result,lh_len);
  //   - offset
  AddUInt32(Result,lh_ofs);
  //52 - Session Key Security Buffer:
  //   - length
   AddUInt16(Result,0);
  //   - allocated space
   AddUInt16(Result,0);
  //   - offset
   AddUInt32(Result,ln_ofs+ln_len);
  //60 - Flags:
  //The flags feild is strictly optional.  About the only time it matters is
  //with Datagram authentication.
  AddUInt32(Result,LFlags);
  if ld_len > 0 then
  begin
    //64 - Domain Name Data ("DOMAIN")
    AppendBytes(Result,LDom);
  end;
  if lu_len >0 then
  begin
    //User Name Data ("user")
    AppendBytes(Result,LUser);
  end;
  if lh_len > 0 then
  begin
    //Workstation Name Data  (host)
    AppendBytes(Result,LHost);
  end;
  //LM Response Data
  AppendBytes(Result,LLMData);
  //NTLM Response Data
  AppendBytes(Result,LNTLMData);
end;

{$IFDEF TESTSUITE}
const
  TEST_TARGETINFO : array [0..97] of byte = (
  $02,$00,$0c,$00,$44,$00,$4f,$00,
  $4d,$00,$41,$00,$49,$00,$4e,$00,
  $01,$00,$0c,$00,$53,$00,$45,$00,
  $52,$00,$56,$00,$45,$00,$52,$00,
  $04,$00,$14,$00,$64,$00,$6f,$00,
  $6d,$00,$61,$00,$69,$00,$6e,$00,
  $2e,$00,$63,$00,$6f,$00,$6d,$00,
  $03,$00,$22,$00,$73,$00,$65,$00,
  $72,$00,$76,$00,$65,$00,$72,$00,
  $2e,$00,$64,$00,$6f,$00,$6d,$00,
  $61,$00,$69,$00,$6e,$00,$2e,$00,
  $63,$00,$6f,$00,$6d,$00,$00,$00,
  $00,$00);

{function StrToHex(const AStr : AnsiString) : AnsiString;
var
  i : Integer;
begin
  Result := '';
  for i := 1 to Length(AStr) do begin
    Result := Result + IntToHex(Ord(AStr[i]),2)+ ' ';
  end;
end;  }

function BytesToHex(const ABytes : array of byte) : String;
var
  i : Integer;
begin
  for i := Low(ABytes) to High(ABytes) do
  begin
    Result := Result + IntToHex(ABytes[i],2)+ ' ';
  end;
end;

procedure DoDavePortTests;
var
  LNonce,LCNonce, lmhash : TIdBytes;
  LMResp : TIdBytes;
  LTargetINfo : TIdBytes;
  Ltst : String;
begin
  SetLength(LNonce,8);
   LNonce[0] := $01;
   LNonce[1] := $23;
   LNonce[2] := $45;
   LNonce[3] := $67;
   LNonce[4] := $89;
   LNonce[5] := $ab;
   LNonce[6] := $cd;
   LNonce[7] := $ef;

   SetLength(LCNonce,8);
   LCNonce[0] := $ff;
   LCNonce[1] := $ff;
   LCNonce[2] := $ff;
   LCNonce[3] := $00;
   LCNonce[4] := $11;
   LCNonce[5] := $22;
   LCNonce[6] := $33;
   LCNonce[7] := $44;

   SetLength(LTargetInfo,Length(TEST_TARGETINFO));
   CopyTIdByteArray(TEST_TARGETINFO,0,LTargetInfo,0,Length(TEST_TARGETINFO));

   if ToHex(SetupLMResponse(lmhash,'SecREt01',LNonce)) <> 'C337CD5CBD44FC9782A667AF6D427C6DE67C20C2D3E77C56' then
   begin
     DebugOutput(BytesToHex(LNonce));
     raise Exception.Create('LM Response test failed');
   end;
   if ToHex(CreateNTLMResponse(lmhash,'SecREt01',LNonce)) <> '25A98C1C31E81847466B29B2DF4680F39958FB8C213A9CC6' then
   begin
     raise Exception.Create('NTLM Response test failed');
   end;
   if ToHex(CreateModNTLMv1Response(lmhash,'user','SecREt01',LCNonce,LNonce,LMResp)) <> '10D550832D12B2CCB79D5AD1F4EED3DF82ACA4C3681DD455' then
   begin
     raise Exception.Create ('NTLM2 Session Response failed');
   end;
   if ToHex(LMResp) <> 'FFFFFF001122334400000000000000000000000000000000'  then
   begin
     raise Exception.Create ('LM Response for NTLM2 reponse failed');
   end;

   if ToHex(SetupLMv2Response(lmhash,'user','DOMAIN','SecREt01',LCNonce,LNonce)) <> 'D6E6152EA25D03B7C6BA6629C2D6AAF0FFFFFF0011223344' then
   begin
     raise Exception.Create ( 'LMv2 Response failed');
   end;
   Ltst := ToHex(InternalCreateNTLMv2Response(lmhash,'user','DOMAIN','SecREt01',LTargetInfo,UnixTimeToFileTime(1055844000),LCNonce,LNonce ));
   if LTst <>
      'CBABBCA713EB795D04C97ABC01EE4983'+
      '01010000000000000090D336B734C301'+
      'FFFFFF00112233440000000002000C00' +
      '44004F004D00410049004E0001000C00' +
      '53004500520056004500520004001400' +
      '64006F006D00610069006E002E006300' +
      '6F006D00030022007300650072007600' +
      '650072002E0064006F006D0061006900' +
      '6E002E0063006F006D00000000000000' +
      '0000' then
   begin
     raise Exception.Create ('NTLMv2 Response failed' );
   end;
end;

function ConstArray(const AArray : array of byte) : TIdBytes;
var
  i : Integer;
begin
  SetLength(Result,0);
  for i := Low(AArray) to High(AArray) do begin
    AppendByte(Result,AArray[i]);
  end;
end;


{
Microsoft tests
User

0000000: 55 00 73 00 65 00 72 00                           U.s.e.r.
0000000: 55 00 53 00 45 00 52 00                           U.S.E.R.
0000000: 55 73 65 72                                       User

UserDom
0000000: 44 00 6f 00 6d 00 61 00 69 00 6e 00               D.o.m.a.i.n

Password
0000000: 50 00 61 00 73 00 73 00 77 00 6f 00 72 00 64 00   P.a.s.s.w.o.r.d.
0000000: 50 41 53 53 57 4f 52 44 00 00 00 00 00 00         PASSWORD......

Server Name
00000000: 53 00 65 00 72 00 76 00 65 00 72 00              S.e.r.v.e.r.

Workstation Name
0000000: 43 00 4f 00 4d 00 50 00 55 00 54 00 45 00 52 00   C.O.M.P.U.T.E.R.

Random Session Key
0000000: 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55   UUUUUUUUUUUUUUUU

Time
0000000: 00 00 00 00 00 00 00 00                           ........

Client Challange
0000000: aa aa aa aa aa aa aa aa                           ........

Server Challange
0000000: 01 23 45 67 89 ab cd ef                           .#Eg..&#x2550;.

4.2.2 NTLM v1 Authentication

# NTLMSSP_NEGOTIATE_KEY_EXCH
# NTLMSSP_NEGOTIATE_56
# NTLMSSP_NEGOTIATE_128
# NTLMSSP_NEGOTIATE_VERSION
# NTLMSSP_TARGET_TYPE_SERVER
# NTLMSSP_NEGOTIATE_ALWAYS_SIGN
# NTLM NTLMSSP_NEGOTIATE_NTLM
# NTLMSSP_NEGOTIATE_SEAL
# NTLMSSP_NEGOTIATE_SIGN
# NTLM_NEGOTIATE_OEM
# NTLMSSP_NEGOTIATE_UNICOD

NTLMv1 data flags
33 82 02 e2
}

procedure DoMSTests;
var
  LFlags : UInt32;
  LEncoding: IIdTextEncoding;
begin
  LFlags := IdNTLMSSP_NEGOTIATE_KEY_EXCH or
    IdNTLMSSP_NEGOTIATE_56 or IdNTLMSSP_NEGOTIATE_128 or
    IdNTLMSSP_NEGOTIATE_VERSION or IdNTLMSSP_TARGET_TYPE_SERVER or
    IdNTLMSSP_NEGOTIATE_ALWAYS_SIGN or IdNTLMSSP_NEGOTIATE_NTLM or
    IdNTLMSSP_NEGOTIATE_SEAL or IdNTLMSSP_NEGOTIATE_SIGN or
    IdNTLM_NEGOTIATE_OEM or IdNTLMSSP_NEGOTIATE_UNICODE;
  if ToHex(ToBytes(LFlags))<>'338202E2' then
  begin
    raise Exception.Create('MS Tests failed - NTLMv1 data flags');
  end;
//  if ToHex(NTOWFv1('Password') ) <> UpperCase('e52cac67419a9a224a3b108f3fa6cb6d') then
  LEncoding := IndyTextEncoding_ASCII;
  if ToHex(LMOWFv1(
    LEncoding.GetBytes(Uppercase( 'Password')),
    LEncoding.GetBytes(Uppercase( 'User')),
    LEncoding.GetBytes(Uppercase( 'Domain')))) <>
    Uppercase('e52cac67419a9a224a3b108f3fa6cb6d') then

  begin
    raise Exception.Create('MS Tests failed - LMOWFv1');
  end;
end;

procedure TestNTLM;
begin
 // DoMSTests;
  DoDavePortTests;
end;


{$ENDIF}

initialization
  SetLength(IdNTLM_SSP_SIG,8);
  IdNTLM_SSP_SIG[0] :=$4e;  //N
  IdNTLM_SSP_SIG[1] :=$54;  //T
  IdNTLM_SSP_SIG[2] :=$4c;  //L
  IdNTLM_SSP_SIG[3] :=$4d;  //M
  IdNTLM_SSP_SIG[4] :=$53;  //S
  IdNTLM_SSP_SIG[5] :=$53;  //S
  IdNTLM_SSP_SIG[6] :=$50;  //P
  IdNTLM_SSP_SIG[7] :=$00;  //#00
  UnixEpoch := EncodeDate(1970, 1, 1);
end.
