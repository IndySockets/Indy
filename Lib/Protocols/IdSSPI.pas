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
  Rev 1.1    13.1.2004 17:26:00  DBondzhev
  Added Domain property

  Rev 1.0    11/13/2002 08:01:52 AM  JPMugaas
}

{
  SSPI interface and objects Unit
  Copyright (c) 1999-2001, Eventree Systems
  Translator: Eventree Systems

  this unit contains translation of:
  Security.h, sspi.h, secext.h, rpcdce.h (some of)
}

unit IdSSPI;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface
{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  Windows;

type
  PPVOID = ^PVOID;
  PVOID = Pointer;

  PUSHORT = ^USHORT;
  USHORT = Word;

  PUCHAR = ^UCHAR;
  UCHAR = Byte;

//+-----------------------------------------------------------------------
//
// Microsoft Windows
//
// Copyright (c) Microsoft Corporation 1991-1999
//
// File:        Security.h
//
// Contents:    Toplevel include file for security aware components
//
//
// History:     06 Aug 92   RichardW    Created
//              23 Sep 92   PeterWi     Add security object include files
//
//------------------------------------------------------------------------

//
// These are name that can be used to refer to the builtin packages
//

const

  NTLMSP_NAME               = 'NTLM';    {Do not Localize}

  MICROSOFT_KERBEROS_NAME   = 'Kerberos';    {Do not Localize}

  NEGOSSP_NAME              = 'Negotiate';    {Do not Localize}

//+---------------------------------------------------------------------------
//
//  Microsoft Windows
//  Copyright (C) Microsoft Corporation, 1992-1997.
//
//  File:       sspi.h
//
//  Contents:   Security Support Provider Interface
//              Prototypes and structure definitions
//
//  Functions:  Security Support Provider API
//
//  History:    11-24-93   RichardW   Created
//
//----------------------------------------------------------------------------

type

  PSEC_WCHAR = PWideChar;
  SEC_WCHAR = WideChar;

  PSEC_CHAR = PAnsiChar;
  SEC_CHAR = AnsiChar;

  PSECURITY_STATUS = ^SECURITY_STATUS;
  SECURITY_STATUS = Longint;

//
// Decide what a string - 32 bits only since for 16 bits it is clear.
//

type
  {$IFDEF UNICODE}
  SECURITY_PSTR = ^SEC_WCHAR;
  {$ELSE}
  SECURITY_PSTR = ^SEC_CHAR;
  {$ENDIF}
//
// Okay, security specific types:
//

type

  PSecHandle = ^SecHandle;
  //Define ULONG_PTR as PtrUInt so we can use this unit in FreePascal.
  SecHandle = record
    dwLower: PtrUInt; // ULONG_PTR
    dwUpper: PtrUInt; // ULONG_PTR
  end;

  CredHandle = SecHandle;
  PCredHandle = PSecHandle;

  CtxtHandle = SecHandle;
  PCtxtHandle = PSecHandle;

  PSECURITY_INTEGER = ^SECURITY_INTEGER;
  SECURITY_INTEGER = LARGE_INTEGER;

  PTimeStamp = ^TimeStamp;
  TimeStamp = SECURITY_INTEGER;

  procedure SecInvalidateHandle(var x: SecHandle);  {$IFDEF USE_INLINE} inline; {$ENDIF}
  function SecIsValidHandle(x : SecHandle) : Boolean; {$IFDEF USE_INLINE} inline; {$ENDIF}
  function SEC_SUCCESS(Status: SECURITY_STATUS): Boolean;  {$IFDEF USE_INLINE} inline; {$ENDIF}

type

//
// If we are in 32 bit mode, define the SECURITY_STRING structure,
// as a clone of the base UNICODE_STRING structure.  This is used
// internally in security components, an as the string interface
// for kernel components (e.g. FSPs)
//

  PSECURITY_STRING = ^SECURITY_STRING;
  SECURITY_STRING = record
    Length: USHORT;
    MaximumLength: USHORT;
    Buffer: PUSHORT;
  end;

//
// SecPkgInfo structure
//
//  Provides general information about a security provider
//

type

  PPSecPkgInfoW = ^PSecPkgInfoW;
  PSecPkgInfoW = ^SecPkgInfoW;
  SecPkgInfoW = record
    fCapabilities: ULONG;        // Capability bitmask
    wVersion: USHORT;            // Version of driver
    wRPCID: USHORT;              // ID for RPC Runtime
    cbMaxToken: ULONG;           // Size of authentication token (max)
    Name: PSEC_WCHAR;            // Text name
    Comment: SEC_WCHAR;          // Comment
  end;

  PPSecPkgInfoA = ^PSecPkgInfoA;
  PSecPkgInfoA = ^SecPkgInfoA;
  SecPkgInfoA = record
    fCapabilities: ULONG;        // Capability bitmask
    wVersion: USHORT;            // Version of driver
    wRPCID: USHORT;              // ID for RPC Runtime
    cbMaxToken: ULONG;           // Size of authentication token (max)
    Name: PSEC_CHAR;             // Text name
    Comment: PSEC_CHAR;          // Comment
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgInfo = SecPkgInfoW;
  PSecPkgInfo = PSecPkgInfoW;
{$ELSE}
  SecPkgInfo = SecPkgInfoA;
  PSecPkgInfo = PSecPkgInfoA;
{$ENDIF}


//
//  Security Package Capabilities
//

const

  SECPKG_FLAG_INTEGRITY         = $00000001; // Supports integrity on messages
  SECPKG_FLAG_PRIVACY           = $00000002; // Supports privacy (confidentiality)
  SECPKG_FLAG_TOKEN_ONLY        = $00000004; // Only security token needed
  SECPKG_FLAG_DATAGRAM          = $00000008; // Datagram RPC support
  SECPKG_FLAG_CONNECTION        = $00000010; // Connection oriented RPC support
  SECPKG_FLAG_MULTI_REQUIRED    = $00000020; // Full 3-leg required for re-auth.
  SECPKG_FLAG_CLIENT_ONLY       = $00000040; // Server side functionality not available
  SECPKG_FLAG_EXTENDED_ERROR    = $00000080; // Supports extended error msgs
  SECPKG_FLAG_IMPERSONATION     = $00000100; // Supports impersonation
  SECPKG_FLAG_ACCEPT_WIN32_NAME = $00000200; // Accepts Win32 names
  SECPKG_FLAG_STREAM            = $00000400; // Supports stream semantics
  SECPKG_FLAG_NEGOTIABLE        = $00000800; // Can be used by the negotiate package
  SECPKG_FLAG_GSS_COMPATIBLE    = $00001000; // GSS Compatibility Available
  SECPKG_FLAG_LOGON             = $00002000; // Supports common LsaLogonUser
  SECPKG_FLAG_ASCII_BUFFERS     = $00004000; // Token Buffers are in ASCII
  SECPKG_FLAG_FRAGMENT          = $00008000; // Package can fragment to fit
  SECPKG_FLAG_MUTUAL_AUTH       = $00010000; // Package can perform mutual authentication
  SECPKG_FLAG_DELEGATION        = $00020000; // Package can delegate

  SECPKG_ID_NONE                = $FFFF;

//
// SecBuffer
//
//  Generic memory descriptors for buffers passed in to the security
//  API
//

type

  PSecBuffer = ^SecBuffer;
  SecBuffer = record
    cbBuffer: ULONG;                   // Size of the buffer, in bytes
    BufferType: ULONG;                // Type of the buffer (below)
    pvBuffer: PVOID;                  // Pointer to the buffer
  end;

  PSecBufferDesc = ^SecBufferDesc;
  SecBufferDesc = record
    ulVersion: ULONG;                 // Version number
    cBuffers: ULONG;                  // Number of buffers
    pBuffers: PSecBuffer;             // Pointer to array of buffers
  end;

const

  SECBUFFER_VERSION            = 0;

  SECBUFFER_EMPTY              = 0;   // Undefined, replaced by provider
  SECBUFFER_DATA               = 1;   // Packet data
  SECBUFFER_TOKEN              = 2;   // Security token
  SECBUFFER_PKG_PARAMS         = 3;   // Package specific parameters
  SECBUFFER_MISSING            = 4;   // Missing Data indicator
  SECBUFFER_EXTRA              = 5;   // Extra data
  SECBUFFER_STREAM_TRAILER     = 6;   // Security Trailer
  SECBUFFER_STREAM_HEADER      = 7;   // Security Header
  SECBUFFER_NEGOTIATION_INFO   = 8;   // Hints from the negotiation pkg
  SECBUFFER_PADDING            = 9;   // non-data padding
  SECBUFFER_STREAM             = 10;  // whole encrypted message
  SECBUFFER_MECHLIST           = 11;
  SECBUFFER_MECHLIST_SIGNATURE = 12;
  SECBUFFER_TARGET           = 13;  // obsolete
  SECBUFFER_CHANNEL_BINDINGS = 14;
  SECBUFFER_CHANGE_PASS_RESPONSE = 15;
  SECBUFFER_TARGET_HOST      = 16;
  SECBUFFER_ALERT            = 17;

  SECBUFFER_ATTRMASK           = $F0000000;
  SECBUFFER_READONLY           = $80000000;  // Buffer is read-only
  SECBUFFER_READONLY_WITH_CHECKSUM = $10000000;  // Buffer is read-only, and checksummed;
  SECBUFFER_RESERVED           = $40000000;

type

  PSEC_NEGOTIATION_INFO = ^SEC_NEGOTIATION_INFO;
  SEC_NEGOTIATION_INFO = record
    Size: ULONG;                      // Size of this structure
    NameLength: ULONG;                // Length of name hint
    Name: PSEC_WCHAR;                 // Name hint
    Reserved: PVOID;                  // Reserved
  end;

//
//  Data Representation Constant:
//

const

  SECURITY_NATIVE_DREP        = $00000010;
  SECURITY_NETWORK_DREP       = $00000000;

//
//  Credential Use Flags
//

const

  SECPKG_CRED_INBOUND         = $00000001;
  SECPKG_CRED_OUTBOUND        = $00000002;
  SECPKG_CRED_BOTH            = $00000003;
  SECPKG_CRED_DEFAULT         = $00000004;
  SECPKG_CRED_RESERVED        = $F0000000;

//
//  SSP SHOULD prompt the user for credentials/consent, independent
//  of whether credentials to be used are the 'logged on' credentials
//  or retrieved from credman.
//
//  An SSP may choose not to prompt, however, in circumstances determined
//  by the SSP.
//

  SECPKG_CRED_AUTOLOGON_RESTRICTED    = $00000010;

//
// auth will always fail, ISC() is called to process policy data only
//

  SECPKG_CRED_PROCESS_POLICY_ONLY     = $00000020;

const
//
//  InitializeSecurityContext Requirement and return flags:
//
  ISC_REQ_DELEGATE                = $00000001;
  ISC_REQ_MUTUAL_AUTH             = $00000002;
  ISC_REQ_REPLAY_DETECT           = $00000004;
  ISC_REQ_SEQUENCE_DETECT         = $00000008;
  ISC_REQ_CONFIDENTIALITY         = $00000010;
  ISC_REQ_USE_SESSION_KEY         = $00000020;
  ISC_REQ_PROMPT_FOR_CREDS        = $00000040;
  ISC_REQ_USE_SUPPLIED_CREDS      = $00000080;
  ISC_REQ_ALLOCATE_MEMORY         = $00000100;
  ISC_REQ_USE_DCE_STYLE           = $00000200;
  ISC_REQ_DATAGRAM                = $00000400;
  ISC_REQ_CONNECTION              = $00000800;
  ISC_REQ_CALL_LEVEL              = $00001000;
  ISC_REQ_FRAGMENT_SUPPLIED       = $00002000;
  ISC_REQ_EXTENDED_ERROR          = $00004000;
  ISC_REQ_STREAM                  = $00008000;
  ISC_REQ_INTEGRITY               = $00010000;
  ISC_REQ_IDENTIFY                = $00020000;
  ISC_REQ_NULL_SESSION            = $00040000;
  ISC_REQ_MANUAL_CRED_VALIDATION  = $00080000;
  ISC_REQ_RESERVED1               = $00100000;
  ISC_REQ_FRAGMENT_TO_FIT         = $00200000;
// This exists only in Windows Vista and greater
  ISC_REQ_FORWARD_CREDENTIALS     = $00400000;
  ISC_REQ_NO_INTEGRITY            = $00800000; // honored only by SPNEGO
  ISC_REQ_USE_HTTP_STYLE          = $01000000;

  ISC_RET_DELEGATE                = $00000001;
  ISC_RET_MUTUAL_AUTH             = $00000002;
  ISC_RET_REPLAY_DETECT           = $00000004;
  ISC_RET_SEQUENCE_DETECT         = $00000008;
  ISC_RET_CONFIDENTIALITY         = $00000010;
  ISC_RET_USE_SESSION_KEY         = $00000020;
  ISC_RET_USED_COLLECTED_CREDS    = $00000040;
  ISC_RET_USED_SUPPLIED_CREDS     = $00000080;
  ISC_RET_ALLOCATED_MEMORY        = $00000100;
  ISC_RET_USED_DCE_STYLE          = $00000200;
  ISC_RET_DATAGRAM                = $00000400;
  ISC_RET_CONNECTION              = $00000800;
  ISC_RET_INTERMEDIATE_RETURN     = $00001000;
  ISC_RET_CALL_LEVEL              = $00002000;
  ISC_RET_EXTENDED_ERROR          = $00004000;
  ISC_RET_STREAM                  = $00008000;
  ISC_RET_INTEGRITY               = $00010000;
  ISC_RET_IDENTIFY                = $00020000;
  ISC_RET_NULL_SESSION            = $00040000;
  ISC_RET_MANUAL_CRED_VALIDATION  = $00080000;
  ISC_RET_RESERVED1               = $00100000;
  ISC_RET_FRAGMENT_ONLY           = $00200000;
// This exists only in Windows Vista and greater
  ISC_RET_FORWARD_CREDENTIALS     = $00400000;

  ISC_RET_USED_HTTP_STYLE         = $01000000;
  ISC_RET_NO_ADDITIONAL_TOKEN     = $02000000;  // *INTERNAL*
  ISC_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*

  ASC_REQ_DELEGATE                = $00000001;
  ASC_REQ_MUTUAL_AUTH             = $00000002;
  ASC_REQ_REPLAY_DETECT           = $00000004;
  ASC_REQ_SEQUENCE_DETECT         = $00000008;
  ASC_REQ_CONFIDENTIALITY         = $00000010;
  ASC_REQ_USE_SESSION_KEY         = $00000020;
  ASC_REQ_ALLOCATE_MEMORY         = $00000100;
  ASC_REQ_USE_DCE_STYLE           = $00000200;
  ASC_REQ_DATAGRAM                = $00000400;
  ASC_REQ_CONNECTION              = $00000800;
  ASC_REQ_CALL_LEVEL              = $00001000;
  ASC_REQ_EXTENDED_ERROR          = $00008000;
  ASC_REQ_STREAM                  = $00010000;
  ASC_REQ_INTEGRITY               = $00020000;
  ASC_REQ_LICENSING               = $00040000;
  ASC_REQ_IDENTIFY                = $00080000;
  ASC_REQ_ALLOW_NULL_SESSION      = $00100000;
  ASC_REQ_ALLOW_NON_USER_LOGONS   = $00200000;
  ASC_REQ_ALLOW_CONTEXT_REPLAY    = $00400000;
  ASC_REQ_FRAGMENT_TO_FIT         = $00800000;
  ASC_REQ_FRAGMENT_SUPPLIED       = $00002000;
  ASC_REQ_NO_TOKEN                = $01000000;
  ASC_REQ_PROXY_BINDINGS          = $04000000;
//      SSP_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*
  ASC_REQ_ALLOW_MISSING_BINDINGS  = $10000000;

  ASC_RET_DELEGATE                = $00000001;
  ASC_RET_MUTUAL_AUTH             = $00000002;
  ASC_RET_REPLAY_DETECT           = $00000004;
  ASC_RET_SEQUENCE_DETECT         = $00000008;
  ASC_RET_CONFIDENTIALITY         = $00000010;
  ASC_RET_USE_SESSION_KEY         = $00000020;
  ASC_RET_ALLOCATED_MEMORY        = $00000100;
  ASC_RET_USED_DCE_STYLE          = $00000200;
  ASC_RET_DATAGRAM                = $00000400;
  ASC_RET_CONNECTION              = $00000800;
  ASC_RET_CALL_LEVEL              = $00002000; // skipped 1000 to be like ISC_
  ASC_RET_THIRD_LEG_FAILED        = $00004000;
  ASC_RET_EXTENDED_ERROR          = $00008000;
  ASC_RET_STREAM                  = $00010000;
  ASC_RET_INTEGRITY               = $00020000;
  ASC_RET_LICENSING               = $00040000;
  ASC_RET_IDENTIFY                = $00080000;
  ASC_RET_NULL_SESSION            = $00100000;
  ASC_RET_ALLOW_NON_USER_LOGONS   = $00200000;
  ASC_RET_ALLOW_CONTEXT_REPLAY    = $00400000;
  ASC_RET_FRAGMENT_ONLY           = $00800000;
  ASC_RET_NO_TOKEN                = $01000000;
  ASC_RET_NO_ADDITIONAL_TOKEN     = $02000000;  // *INTERNAL*
  ASC_RET_NO_PROXY_BINDINGS       = $04000000;
//  SSP_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*
  ASC_RET_MISSING_BINDINGS        = $10000000;
//
//  Security Credentials Attributes:
//

const
  SECPKG_CRED_ATTR_NAMES = 1;
  SECPKG_CRED_ATTR_SSI_PROVIDER = 2;

type

  PSecPkgCredentials_NamesW = ^SecPkgCredentials_NamesW;
  SecPkgCredentials_NamesW = record
    sUserName: PSEC_WCHAR;
  end;

  PSecPkgCredentials_NamesA = ^SecPkgCredentials_NamesA;
  SecPkgCredentials_NamesA = record
    sUserName: PSEC_CHAR;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgCredentials_Names = SecPkgCredentials_NamesW;
  PSecPkgCredentials_Names = PSecPkgCredentials_NamesW;
{$ELSE}
  SecPkgCredentials_Names = SecPkgCredentials_NamesA;
  PSecPkgCredentials_Names = PSecPkgCredentials_NamesA;
{$ENDIF}

//
//  Security Context Attributes:
//

const

  SECPKG_ATTR_SIZES            = 0;
  SECPKG_ATTR_NAMES            = 1;
  SECPKG_ATTR_LIFESPAN         = 2;
  SECPKG_ATTR_DCE_INFO         = 3;
  SECPKG_ATTR_STREAM_SIZES     = 4;
  SECPKG_ATTR_KEY_INFO         = 5;
  SECPKG_ATTR_AUTHORITY        = 6;
  SECPKG_ATTR_PROTO_INFO       = 7;
  SECPKG_ATTR_PASSWORD_EXPIRY  = 8;
  SECPKG_ATTR_SESSION_KEY      = 9;
  SECPKG_ATTR_PACKAGE_INFO     = 10;
  SECPKG_ATTR_USER_FLAGS       = 11;
  SECPKG_ATTR_NEGOTIATION_INFO = 12;
  SECPKG_ATTR_NATIVE_NAMES     = 13;
  SECPKG_ATTR_FLAGS            = 14;
// These attributes exist only in Win XP and greater
  SECPKG_ATTR_USE_VALIDATED   = 15;
  SECPKG_ATTR_CREDENTIAL_NAME = 16;
  SECPKG_ATTR_TARGET_INFORMATION = 17;
  SECPKG_ATTR_ACCESS_TOKEN    = 18;
// These attributes exist only in Win2K3 and greater
  SECPKG_ATTR_TARGET          = 19;
  SECPKG_ATTR_AUTHENTICATION_ID  = 20;
// These attributes exist only in Win2K3SP1 and greater
  SECPKG_ATTR_LOGOFF_TIME     = 21;
//
// win7 or greater
//
  SECPKG_ATTR_NEGO_KEYS         = 22;
  SECPKG_ATTR_PROMPTING_NEEDED  = 24;
  SECPKG_ATTR_UNIQUE_BINDINGS   = 25;
  SECPKG_ATTR_ENDPOINT_BINDINGS = 26;
  SECPKG_ATTR_CLIENT_SPECIFIED_TARGET = 27;

  SECPKG_ATTR_LAST_CLIENT_TOKEN_STATUS = 30;
  SECPKG_ATTR_NEGO_PKG_INFO        = 31; // contains nego info of packages
  SECPKG_ATTR_NEGO_STATUS          = 32; // contains the last error
  SECPKG_ATTR_CONTEXT_DELETED      = 33; // a context has been deleted

  SECPKG_ATTR_SUBJECT_SECURITY_ATTRIBUTES = 128;

type

  PSecPkgContext_Sizes = ^SecPkgContext_Sizes;
  SecPkgContext_Sizes = record
    cbMaxToken: ULONG;
    cbMaxSignature: ULONG;
    cbBlockSize: ULONG;
    cbSecurityTrailer: ULONG;
  end;

  PSecPkgContext_StreamSizes = ^SecPkgContext_StreamSizes;
  SecPkgContext_StreamSizes = record
    cbHeader: ULONG;
    cbTrailer: ULONG;
    cbMaximumMessage: ULONG;
    cBuffers: ULONG;
    cbBlockSize: ULONG;
  end;

  PSecPkgContext_NamesW = ^SecPkgContext_NamesW;
  SecPkgContext_NamesW = record
    sUserName: PSEC_WCHAR;
  end;

  PSecPkgContext_NamesA = ^SecPkgContext_NamesA;
  SecPkgContext_NamesA = record
    sUserName: PSEC_CHAR;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_Names = SecPkgContext_NamesW;
  PSecPkgContext_Names = PSecPkgContext_NamesW;
{$ELSE}
  SecPkgContext_Names = SecPkgContext_NamesA;
  PSecPkgContext_Names = PSecPkgContext_NamesA;
{$ENDIF}

  PSecPkgContext_Lifespan = ^SecPkgContext_Lifespan;
  SecPkgContext_Lifespan = record
    tsStart: TimeStamp;
    tsExpiry: TimeStamp;
  end;

  PSecPkgContext_DceInfo = ^SecPkgContext_DceInfo;
  SecPkgContext_DceInfo = record
    AuthzSvc: ULONG;
    pPac: PVOID;
  end;

  PSecPkgContext_KeyInfoA = ^SecPkgContext_KeyInfoA;
  SecPkgContext_KeyInfoA = record
    sSignatureAlgorithmName: PSEC_CHAR;
    sEncryptAlgorithmName: PSEC_CHAR;
    KeySize: ULONG;
    SignatureAlgorithm: ULONG;
    EncryptAlgorithm: ULONG;
  end;

  PSecPkgContext_KeyInfoW = ^SecPkgContext_KeyInfoW;
  SecPkgContext_KeyInfoW = record
    sSignatureAlgorithmName: PSEC_WCHAR;
    sEncryptAlgorithmName: PSEC_WCHAR;
    KeySize: ULONG;
    SignatureAlgorithm: ULONG;
    EncryptAlgorithm: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_KeyInfo = SecPkgContext_KeyInfoW;
  PSecPkgContext_KeyInfo = PSecPkgContext_KeyInfoW;
{$ELSE}
  SecPkgContext_KeyInfo = SecPkgContext_KeyInfoA;
  PSecPkgContext_KeyInfo = PSecPkgContext_KeyInfoA;
{$ENDIF}

  PSecPkgContext_AuthorityA = ^SecPkgContext_AuthorityA;
  SecPkgContext_AuthorityA = record
    sAuthorityName: PSEC_CHAR;
  end;

  PSecPkgContext_AuthorityW = ^SecPkgContext_AuthorityW;
  SecPkgContext_AuthorityW = record
    sAuthorityName: PSEC_WCHAR;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_Authority = SecPkgContext_AuthorityW;
  PSecPkgContext_Authority = PSecPkgContext_AuthorityW;
{$ELSE}
  SecPkgContext_Authority = SecPkgContext_AuthorityA;
  PSecPkgContext_Authority = PSecPkgContext_AuthorityA;
{$ENDIF}

  PSecPkgContext_ProtoInfoA = ^SecPkgContext_ProtoInfoA;
  SecPkgContext_ProtoInfoA = record
    sProtocolName: PSEC_CHAR;
    majorVersion: ULONG;
    minorVersion: ULONG;
  end;

  PSecPkgContext_ProtoInfoW = ^SecPkgContext_ProtoInfoW;
  SecPkgContext_ProtoInfoW = record
    sProtocolName: PSEC_WCHAR;
    majorVersion: ULONG;
    minorVersion: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_ProtoInfo = SecPkgContext_ProtoInfoW;
  PSecPkgContext_ProtoInfo = PSecPkgContext_ProtoInfoW;
{$ELSE}
  SecPkgContext_ProtoInfo = SecPkgContext_ProtoInfoA;
  PSecPkgContext_ProtoInfo = PSecPkgContext_ProtoInfoA;
{$ENDIF}

  PSecPkgContext_PasswordExpiry = ^SecPkgContext_PasswordExpiry;
  SecPkgContext_PasswordExpiry = record
    tsPasswordExpires: TimeStamp;
  end;

  PSecPkgContext_SessionKey = ^SecPkgContext_SessionKey;
  SecPkgContext_SessionKey = record
    SessionKeyLength: ULONG;
    SessionKey: PUCHAR;
  end;

  PSecPkgContext_PackageInfoW = ^SecPkgContext_PackageInfoW;
  SecPkgContext_PackageInfoW = record
    PackageInfo: PSecPkgInfoW;
  end;

  PSecPkgContext_PackageInfoA = ^SecPkgContext_PackageInfoA;
  SecPkgContext_PackageInfoA = record
    PackageInfo: PSecPkgInfoA;
  end;

  PSecPkgContext_UserFlags = ^SecPkgContext_UserFlags;
  SecPkgContext_UserFlags = record
    UserFlags: ULONG;
  end;

  PSecPkgContext_Flags = ^SecPkgContext_Flags;
  SecPkgContext_Flags = record
    Flags: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_PackageInfo = SecPkgContext_PackageInfoW;
  PSecPkgContext_PackageInfo = PSecPkgContext_PackageInfoW;
{$ELSE}
  SecPkgContext_PackageInfo = SecPkgContext_PackageInfoA;
  PSecPkgContext_PackageInfo = PSecPkgContext_PackageInfoA;
{$ENDIF}

  PSecPkgContext_NegotiationInfoA = ^SecPkgContext_NegotiationInfoA;
  SecPkgContext_NegotiationInfoA = record
    PackageInfo: PSecPkgInfoA;
    NegotiationState: ULONG;
  end;

  PSecPkgContext_NegotiationInfoW = ^SecPkgContext_NegotiationInfoW;
  SecPkgContext_NegotiationInfoW = record
    PackageInfo: PSecPkgInfoW;
    NegotiationState: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_NegotiationInfo = SecPkgContext_NegotiationInfoW;
  PSecPkgContext_NegotiationInfo = PSecPkgContext_NegotiationInfoW;
{$ELSE}
  SecPkgContext_NegotiationInfo = SecPkgContext_NegotiationInfoA;
  PSecPkgContext_NegotiationInfo = PSecPkgContext_NegotiationInfoA;
{$ENDIF}

const

  SECPKG_NEGOTIATION_COMPLETE     = 0;
  SECPKG_NEGOTIATION_OPTIMISTIC   = 1;
  SECPKG_NEGOTIATION_IN_PROGRESS  = 2;
  SECPKG_NEGOTIATION_DIRECT       = 3;
  SECPKG_NEGOTIATION_TRY_MULTICRED = 4;

type

  PSecPkgContext_NativeNamesW = ^SecPkgContext_NativeNamesW;
  SecPkgContext_NativeNamesW = record
    sClientName: PSEC_WCHAR;
    sServerName: PSEC_WCHAR;
  end;

  PSecPkgContext_NativeNamesA = ^SecPkgContext_NativeNamesA;
  SecPkgContext_NativeNamesA = record
    sClientName: PSEC_CHAR;
    sServerName: PSEC_CHAR;
  end;

{$IFDEF SSPI_UNICODE}
  SecPkgContext_NativeNames = SecPkgContext_NativeNamesW;
  PSecPkgContext_NativeNames = PSecPkgContext_NativeNamesW;
{$ELSE}
  SecPkgContext_NativeNames = SecPkgContext_NativeNamesA;
  PSecPkgContext_NativeNames = PSecPkgContext_NativeNamesA;
{$ENDIF}

  SEC_GET_KEY_FN = function(
    Arg: PVOID;                   // Argument passed in
    Principal: PVOID;             // Principal ID
    KeyVer: ULONG;                // Key Version
    Key: PPVOID;               // Returned ptr to key
    Status: PSECURITY_STATUS   // returned status
  ): PVOID; stdcall;

//
// Flags for ExportSecurityContext
//

const

  SECPKG_CONTEXT_EXPORT_RESET_NEW   = $00000001;  // New context is reset to initial state
  SECPKG_CONTEXT_EXPORT_DELETE_OLD  = $00000002;  // Old context is deleted during export
  // This is only valid in W2K3SP1 and greater
  SECPKG_CONTEXT_EXPORT_TO_KERNEL   = $00000004;      // Context is to be transferred to the kernel


type

  ACQUIRE_CREDENTIALS_HANDLE_FN_W = function( // AcquireCredentialsHandleW
    pszPrincipal: PSEC_WCHAR;   // Name of principal
    pszPackage: PSEC_WCHAR;     // Name of package
    fCredentialUse: ULONG;      // Flags indicating use
    pvLogonId: PVOID;           // Pointer to logon ID
    pAuthData: PVOID;           // Package specific data
    pGetKeyFn: SEC_GET_KEY_FN;  // Pointer to GetKey() func
    pvGetKeyArgument: PVOID;    // Value to pass to GetKey()
    phCredential: PCredHandle;  // (out) Cred Handle
    ptsExpiry: PTimeStamp       // (out) Lifetime (optional)
  ): SECURITY_STATUS; stdcall;

  ACQUIRE_CREDENTIALS_HANDLE_FN_A = function( // AcquireCredentialsHandleW
    pszPrincipal: PSEC_CHAR;   // Name of principal
    pszPackage: PSEC_CHAR;     // Name of package
    fCredentialUse: ULONG;      // Flags indicating use
    pvLogonId: PVOID;           // Pointer to logon ID
    pAuthData: PVOID;           // Package specific data
    pGetKeyFn: SEC_GET_KEY_FN;  // Pointer to GetKey() func
    pvGetKeyArgument: PVOID;    // Value to pass to GetKey()
    phCredential: PCredHandle;  // (out) Cred Handle
    ptsExpiry: PTimeStamp       // (out) Lifetime (optional)
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  ACQUIRE_CREDENTIALS_HANDLE_FN = ACQUIRE_CREDENTIALS_HANDLE_FN_W;
{$ELSE}
  ACQUIRE_CREDENTIALS_HANDLE_FN = ACQUIRE_CREDENTIALS_HANDLE_FN_A;
{$ENDIF}

  FREE_CREDENTIALS_HANDLE_FN = function( // FreeCredentialsHandle
    phCredential: PCredHandle            // Handle to free
  ): SECURITY_STATUS; stdcall;

  ADD_CREDENTIALS_FN_W = function( // AddCredentialsW
    hCredentials: PCredHandle;
    pszPrincipal: PSEC_WCHAR;   // Name of principal
    pszPackage: PSEC_WCHAR;     // Name of package
    fCredentialUse: ULONG;      // Flags indicating use
    pAuthData: PVOID;           // Package specific data
    pGetKeyFn: SEC_GET_KEY_FN;  // Pointer to GetKey() func
    pvGetKeyArgument: PVOID;    // Value to pass to GetKey()
    ptsExpiry: PTimeStamp       // (out) Lifetime (optional)
  ): SECURITY_STATUS; stdcall;

  ADD_CREDENTIALS_FN_A = function( // AddCredentialsA
    hCredentials: PCredHandle;
    pszPrincipal: PSEC_CHAR;   // Name of principal
    pszPackage: PSEC_CHAR;     // Name of package
    fCredentialUse: ULONG;      // Flags indicating use
    pAuthData: PVOID;           // Package specific data
    pGetKeyFn: SEC_GET_KEY_FN;  // Pointer to GetKey() func
    pvGetKeyArgument: PVOID;    // Value to pass to GetKey()
    ptsExpiry: PTimeStamp       // (out) Lifetime (optional)
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  ADD_CREDENTIALS_FN = ADD_CREDENTIALS_FN_W;
{$ELSE}
  ADD_CREDENTIALS_FN = ADD_CREDENTIALS_FN_A;
{$ENDIF}

(*
#ifdef WIN32_CHICAGO
SECURITY_STATUS SEC_ENTRY
SspiLogonUserW(
    SEC_WCHAR SEC_FAR * pszPackage,     // Name of package
    SEC_WCHAR SEC_FAR * pszUserName,     // Name of package
    SEC_WCHAR SEC_FAR * pszDomainName,     // Name of package
    SEC_WCHAR SEC_FAR * pszPassword      // Name of package
    );

typedef SECURITY_STATUS
(SEC_ENTRY * SSPI_LOGON_USER_FN_W)(
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR * );

SECURITY_STATUS SEC_ENTRY
SspiLogonUserA(
    SEC_CHAR SEC_FAR * pszPackage,     // Name of package
    SEC_CHAR SEC_FAR * pszUserName,     // Name of package
    SEC_CHAR SEC_FAR * pszDomainName,     // Name of package
    SEC_CHAR SEC_FAR * pszPassword      // Name of package
    );

typedef SECURITY_STATUS
(SEC_ENTRY * SSPI_LOGON_USER_FN_A)(
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR *,
    SEC_CHAR SEC_FAR * );

#ifdef UNICODE
#define SspiLogonUser SspiLogonUserW            // ntifs
#define SSPI_LOGON_USER_FN SSPI_LOGON_USER_FN_W
#else
#define SspiLogonUser SspiLogonUserA
#define SSPI_LOGON_USER_FN SSPI_LOGON_USER_FN_A
#endif // !UNICODE
#endif // WIN32_CHICAGO
*)

////////////////////////////////////////////////////////////////////////
///
/// Context Management Functions
///
////////////////////////////////////////////////////////////////////////

  INITIALIZE_SECURITY_CONTEXT_FN_W = function( // InitializeSecurityContextW
    phCredential: PCredHandle;  // Cred to base context
    phContext: PCtxtHandle;     // Existing context (OPT)
    pszTargetName: PSEC_WCHAR;  // Name of target
    fContextReq: ULONG;         // Context Requirements
    Reserved1: ULONG;           // Reserved, MBZ
    TargetDataRep: ULONG;       // Data rep of target
    pInput: PSecBufferDesc;     // Input Buffers
    Reserved2: ULONG;           // Reserved, MBZ
    phNewContext: PCtxtHandle;  // (out) New Context handle
    pOutput: PSecBufferDesc;    // (inout) Output Buffers
    pfContextAttr: PULONG;      // (out) Context attrs
    ptsExpiry: PTimeStamp       // (out) Life span (OPT)
  ): SECURITY_STATUS; stdcall;

  INITIALIZE_SECURITY_CONTEXT_FN_A = function( // InitializeSecurityContextA
    phCredential: PCredHandle;  // Cred to base context
    phContext: PCtxtHandle;     // Existing context (OPT)
    pszTargetName: PSEC_CHAR;   // Name of target
    fContextReq: ULONG;         // Context Requirements
    Reserved1: ULONG;           // Reserved, MBZ
    TargetDataRep: ULONG;       // Data rep of target
    pInput: PSecBufferDesc;     // Input Buffers
    Reserved2: ULONG;           // Reserved, MBZ
    phNewContext: PCtxtHandle;  // (out) New Context handle
    pOutput: PSecBufferDesc;    // (inout) Output Buffers
    pfContextAttr: PULONG;      // (out) Context attrs
    ptsExpiry: PTimeStamp       // (out) Life span (OPT)
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  INITIALIZE_SECURITY_CONTEXT_FN = INITIALIZE_SECURITY_CONTEXT_FN_W;
{$ELSE}
  INITIALIZE_SECURITY_CONTEXT_FN = INITIALIZE_SECURITY_CONTEXT_FN_A;
{$ENDIF}

  ACCEPT_SECURITY_CONTEXT_FN = function( // AcceptSecurityContext
    phCredential: PCredHandle;  // Cred to base context
    phContext: PCtxtHandle;     // Existing context (OPT)
    pInput: PSecBufferDesc;     // Input buffer
    fContextReq: ULONG;         // Context Requirements
    TargetDataRep: ULONG;       // Target Data Rep
    phNewContext: PCtxtHandle;  // (out) New context handle
    pOutput: PSecBufferDesc;    // (inout) Output buffers
    pfContextAttr: PULONG;      // (out) Context attributes
    ptsExpiry: PTimeStamp       // (out) Life span (OPT)
  ): SECURITY_STATUS; stdcall;

  COMPLETE_AUTH_TOKEN_FN = function( // CompleteAuthToken
    phContext: PCtxtHandle;     // Context to complete
    pToken: PSecBufferDesc      // Token to complete
  ): SECURITY_STATUS; stdcall;

  IMPERSONATE_SECURITY_CONTEXT_FN = function( // ImpersonateSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;

  REVERT_SECURITY_CONTEXT_FN = function( // RevertSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;

  QUERY_SECURITY_CONTEXT_TOKEN_FN = function( // QuerySecurityContextToken
    phContext: PCtxtHandle;
    Token: PPVOID
  ): SECURITY_STATUS; stdcall;

  DELETE_SECURITY_CONTEXT_FN = function( // DeleteSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;

  APPLY_CONTROL_TOKEN_FN = function( // ApplyControlToken
    phContext: PCtxtHandle;     // Context to modify
    pInput: PSecBufferDesc      // Input token to apply
  ): SECURITY_STATUS; stdcall;

  QUERY_CONTEXT_ATTRIBUTES_FN_W = function( // QueryContextAttributesW
    phContext: PCtxtHandle;     // Context to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;

  QUERY_CONTEXT_ATTRIBUTES_FN_A = function( // QueryContextAttributesA
    phContext: PCtxtHandle;     // Context to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  QUERY_CONTEXT_ATTRIBUTES_FN = QUERY_CONTEXT_ATTRIBUTES_FN_W;
{$ELSE}
  QUERY_CONTEXT_ATTRIBUTES_FN = QUERY_CONTEXT_ATTRIBUTES_FN_A;
{$ENDIF}

  QUERY_CREDENTIALS_ATTRIBUTES_FN_W = function( // QueryCredentialsAttributesW
    phCredential: PCredHandle;  // Credential to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;

  QUERY_CREDENTIALS_ATTRIBUTES_FN_A = function( // QueryCredentialsAttributesA
    phCredential: PCredHandle;  // Credential to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  QUERY_CREDENTIALS_ATTRIBUTES_FN = QUERY_CREDENTIALS_ATTRIBUTES_FN_W;
{$ELSE}
  QUERY_CREDENTIALS_ATTRIBUTES_FN = QUERY_CREDENTIALS_ATTRIBUTES_FN_A;
{$ENDIF}

  FREE_CONTEXT_BUFFER_FN = function( // FreeContextBuffer
    pvContextBuffer: PVOID      // buffer to free
  ): SECURITY_STATUS; stdcall;

///////////////////////////////////////////////////////////////////
////
////    Message Support API
////
//////////////////////////////////////////////////////////////////

type

  MAKE_SIGNATURE_FN = function( // MakeSignature
    phContext: PCtxtHandle;     // Context to use
    fQOP: ULONG;                // Quality of Protection
    pMessage: PSecBufferDesc;   // Message to sign
    MessageSeqNo: ULONG         // Message Sequence Num.
  ): SECURITY_STATUS; stdcall;

  VERIFY_SIGNATURE_FN = function( // VerifySignature
    phContext: PCtxtHandle;     // Context to use
    pMessage: PSecBufferDesc;   // Message to verify
    MessageSeqNo: ULONG;        // Sequence Num.
    pfQOP: PULONG               // QOP used
  ): SECURITY_STATUS; stdcall;

  ENCRYPT_MESSAGE_FN = function( // EncryptMessage
    phContext: PCtxtHandle;
    fQOP: ULONG;
    pMessage: PSecBufferDesc;
    MessageSeqNo: ULONG
  ): SECURITY_STATUS; stdcall;

  DECRYPT_MESSAGE_FN = function( // DecryptMessage
    phContext: PCtxtHandle;
    pMessage: PSecBufferDesc;
    MessageSeqNo: ULONG;
    pfQOP: PULONG
  ): SECURITY_STATUS; stdcall;

///////////////////////////////////////////////////////////////////////////
////
////    Misc.
////
///////////////////////////////////////////////////////////////////////////

type

  ENUMERATE_SECURITY_PACKAGES_FN_W = function( // EnumerateSecurityPackagesW
    pcPackages: PULONG;         // Receives num. packages
    ppPackageInfo: PPSecPkgInfoW // Receives array of info
  ): SECURITY_STATUS; stdcall;

  ENUMERATE_SECURITY_PACKAGES_FN_A = function( // EnumerateSecurityPackagesA
    pcPackages: PULONG;         // Receives num. packages
    ppPackageInfo: PPSecPkgInfoA // Receives array of info
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  ENUMERATE_SECURITY_PACKAGES_FN = ENUMERATE_SECURITY_PACKAGES_FN_W;
{$ELSE}
  ENUMERATE_SECURITY_PACKAGES_FN = ENUMERATE_SECURITY_PACKAGES_FN_A;
{$ENDIF}

  QUERY_SECURITY_PACKAGE_INFO_FN_W = function( // QuerySecurityPackageInfoW
    pszPackageName: PSEC_WCHAR; // Name of package
    ppPackageInfo: PPSecPkgInfoW // Receives package info
  ): SECURITY_STATUS; stdcall;

  QUERY_SECURITY_PACKAGE_INFO_FN_A = function( // QuerySecurityPackageInfoA
    pszPackageName: PSEC_CHAR; // Name of package
    ppPackageInfo: PPSecPkgInfoA // Receives package info
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  QUERY_SECURITY_PACKAGE_INFO_FN = QUERY_SECURITY_PACKAGE_INFO_FN_W;
{$ELSE}
  QUERY_SECURITY_PACKAGE_INFO_FN = QUERY_SECURITY_PACKAGE_INFO_FN_A;
{$ENDIF}

  PSecDelegationType = ^SecDelegationType;
  SecDelegationType = (
    SecFull,
    SecService,
    SecTree,
    SecDirectory,
    SecObject
  );

  DELEGATE_SECURITY_CONTEXT_FN = function( // DelegateSecurityContext
    phContext: PCtxtHandle;     // IN Active context to delegate
    pszTarget: PSEC_CHAR;
    DelegationType: SecDelegationType; // IN Type of delegation
    pExpiry: PTimeStamp;        // IN OPTIONAL time limit
    pPackageParameters: PSecBuffer; // IN OPTIONAL package specific
    pOutput: PSecBufferDesc     // OUT Token for applycontroltoken.
  ): SECURITY_STATUS; stdcall;

///////////////////////////////////////////////////////////////////////////
////
////    Proxies
////
///////////////////////////////////////////////////////////////////////////

//
// Proxies are only available on NT platforms
//

///////////////////////////////////////////////////////////////////////////
////
////    Context export/import
////
///////////////////////////////////////////////////////////////////////////

type

  EXPORT_SECURITY_CONTEXT_FN = function( // ExportSecurityContext
    phContext: PCtxtHandle;     // (in) context to export
    fFlags: ULONG;              // (in) option flags
    pPackedContext: PSecBuffer; // (out) marshalled context
    pToken: PPVOID              // (out, optional) token handle for impersonation
  ): SECURITY_STATUS; stdcall;

  IMPORT_SECURITY_CONTEXT_FN_W = function( // ImportSecurityContextW
    pszPackage: PSEC_WCHAR;
    pPackedContext: PSecBuffer; // (in) marshalled context
    Token: PVOID;               // (in, optional) handle to token for context
    phContext: PCtxtHandle      // (out) new context handle
  ): SECURITY_STATUS; stdcall;

  IMPORT_SECURITY_CONTEXT_FN_A = function( // ImportSecurityContextA
    pszPackage: PSEC_CHAR;
    pPackedContext: PSecBuffer; // (in) marshalled context
    Token: PVOID;               // (in, optional) handle to token for context
    phContext: PCtxtHandle      // (out) new context handle
  ): SECURITY_STATUS; stdcall;

{$IFDEF SSPI_UNICODE}
  IMPORT_SECURITY_CONTEXT_FN = IMPORT_SECURITY_CONTEXT_FN_W;
{$ELSE}
  IMPORT_SECURITY_CONTEXT_FN = IMPORT_SECURITY_CONTEXT_FN_A;
{$ENDIF}

///////////////////////////////////////////////////////////////////////////////
////
////  Fast access for RPC:
////
///////////////////////////////////////////////////////////////////////////////

const

  SECURITY_ENTRYPOINT_ANSIW  = 'InitSecurityInterfaceW';    {Do not Localize}
  SECURITY_ENTRYPOINT_ANSIA  = 'InitSecurityInterfaceA';    {Do not Localize}
  SECURITY_ENTRYPOINTW       = 'InitSecurityInterfaceW';    {Do not Localize}
  SECURITY_ENTRYPOINTA       = 'InitSecurityInterfaceA';    {Do not Localize}
  SECURITY_ENTRYPOINT16      = 'INITSECURITYINTERFACEA';    {Do not Localize}

{$IFDEF SSPI_UNICODE}
  SECURITY_ENTRYPOINT = SECURITY_ENTRYPOINTW;
  SECURITY_ENTRYPOINT_ANSI = SECURITY_ENTRYPOINTW;
{$ELSE}
  SECURITY_ENTRYPOINT = SECURITY_ENTRYPOINTA;
  SECURITY_ENTRYPOINT_ANSI = SECURITY_ENTRYPOINTA;
{$ENDIF}

type

  PSecurityFunctionTableW = ^SecurityFunctionTableW;
  SecurityFunctionTableW = record
    dwVersion: ULONG;
    EnumerateSecurityPackagesW: ENUMERATE_SECURITY_PACKAGES_FN_W;
    QueryCredentialsAttributesW: QUERY_CREDENTIALS_ATTRIBUTES_FN_W;
    AcquireCredentialsHandleW: ACQUIRE_CREDENTIALS_HANDLE_FN_W;
    FreeCredentialsHandle: FREE_CREDENTIALS_HANDLE_FN;
    Reserved2: PVOID;
    InitializeSecurityContextW: INITIALIZE_SECURITY_CONTEXT_FN_W;
    AcceptSecurityContext: ACCEPT_SECURITY_CONTEXT_FN;
    CompleteAuthToken: COMPLETE_AUTH_TOKEN_FN;
    DeleteSecurityContext: DELETE_SECURITY_CONTEXT_FN;
    ApplyControlToken: APPLY_CONTROL_TOKEN_FN;
    QueryContextAttributesW: QUERY_CONTEXT_ATTRIBUTES_FN_W;
    ImpersonateSecurityContext: IMPERSONATE_SECURITY_CONTEXT_FN;
    RevertSecurityContext: REVERT_SECURITY_CONTEXT_FN;
    MakeSignature: MAKE_SIGNATURE_FN;
    VerifySignature: VERIFY_SIGNATURE_FN;
    FreeContextBuffer: FREE_CONTEXT_BUFFER_FN;
    QuerySecurityPackageInfoW: QUERY_SECURITY_PACKAGE_INFO_FN_W;
    Reserved3: PVOID;
    Reserved4: PVOID;
    ExportSecurityContext: EXPORT_SECURITY_CONTEXT_FN;
    ImportSecurityContextW: IMPORT_SECURITY_CONTEXT_FN_W;
    AddCredentialsW: ADD_CREDENTIALS_FN_W;
    Reserved8: PVOID;
    QuerySecurityContextToken: QUERY_SECURITY_CONTEXT_TOKEN_FN;
    EncryptMessage: ENCRYPT_MESSAGE_FN;
    DecryptMessage: DECRYPT_MESSAGE_FN;
  end;

  PSecurityFunctionTableA = ^SecurityFunctionTableA;
  SecurityFunctionTableA = record
    dwVersion: ULONG;
    EnumerateSecurityPackagesA: ENUMERATE_SECURITY_PACKAGES_FN_A;
    QueryCredentialsAttributesA: QUERY_CREDENTIALS_ATTRIBUTES_FN_A;
    AcquireCredentialsHandleA: ACQUIRE_CREDENTIALS_HANDLE_FN_A;
    FreeCredentialsHandle: FREE_CREDENTIALS_HANDLE_FN;
    Reserved2: PVOID;
    InitializeSecurityContextA: INITIALIZE_SECURITY_CONTEXT_FN_A;
    AcceptSecurityContext: ACCEPT_SECURITY_CONTEXT_FN;
    CompleteAuthToken: COMPLETE_AUTH_TOKEN_FN;
    DeleteSecurityContext: DELETE_SECURITY_CONTEXT_FN;
    ApplyControlToken: APPLY_CONTROL_TOKEN_FN;
    QueryContextAttributesA: QUERY_CONTEXT_ATTRIBUTES_FN_A;
    ImpersonateSecurityContext: IMPERSONATE_SECURITY_CONTEXT_FN;
    RevertSecurityContext: REVERT_SECURITY_CONTEXT_FN;
    MakeSignature: MAKE_SIGNATURE_FN;
    VerifySignature: VERIFY_SIGNATURE_FN;
    FreeContextBuffer: FREE_CONTEXT_BUFFER_FN;
    QuerySecurityPackageInfoA: QUERY_SECURITY_PACKAGE_INFO_FN_A;
    Reserved3: PVOID;
    Reserved4: PVOID;
    ExportSecurityContext: EXPORT_SECURITY_CONTEXT_FN;
    ImportSecurityContextA: IMPORT_SECURITY_CONTEXT_FN_A;
    AddCredentialsA: ADD_CREDENTIALS_FN_A;
    Reserved8: PVOID;
    QuerySecurityContextToken: QUERY_SECURITY_CONTEXT_TOKEN_FN;
    EncryptMessage: ENCRYPT_MESSAGE_FN;
    DecryptMessage: DECRYPT_MESSAGE_FN;
  end;

{$IFDEF SSPI_UNICODE}
  SecurityFunctionTable = SecurityFunctionTableW;
  PSecurityFunctionTable = PSecurityFunctionTableW;
{$ELSE}
  SecurityFunctionTable = SecurityFunctionTableA;
  PSecurityFunctionTable = PSecurityFunctionTableA;
{$ENDIF}

const

  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION = 1;

type

  INIT_SECURITY_INTERFACE_A = function // InitSecurityInterfaceA
  : PSecurityFunctionTableA; stdcall;

  INIT_SECURITY_INTERFACE_W = function // InitSecurityInterfaceW
  : PSecurityFunctionTableW; stdcall;

{$IFDEF SSPI_UNICODE}
  INIT_SECURITY_INTERFACE = INIT_SECURITY_INTERFACE_W;
{$ELSE}
  INIT_SECURITY_INTERFACE = INIT_SECURITY_INTERFACE_A;
{$ENDIF}


{ TODO : SASL Profile Support }

(*

//
// SASL Profile Support
//


SECURITY_STATUS
SEC_ENTRY
SaslEnumerateProfilesA(
    OUT LPSTR * ProfileList,
    OUT ULONG * ProfileCount
    );

SECURITY_STATUS
SEC_ENTRY
SaslEnumerateProfilesW(
    OUT LPWSTR * ProfileList,
    OUT ULONG * ProfileCount
    );

#ifdef UNICODE
#define SaslEnumerateProfiles   SaslEnumerateProfilesW
#else
#define SaslEnumerateProfiles   SaslEnumerateProfilesA
#endif


SECURITY_STATUS
SEC_ENTRY
SaslGetProfilePackageA(
    IN LPSTR ProfileName,
    OUT PSecPkgInfoA * PackageInfo
    );


SECURITY_STATUS
SEC_ENTRY
SaslGetProfilePackageW(
    IN LPWSTR ProfileName,
    OUT PSecPkgInfoW * PackageInfo
    );

#ifdef UNICODE
#define SaslGetProfilePackage   SaslGetProfilePackageW
#else
#define SaslGetProfilePackage   SaslGetProfilePackageA
#endif

SECURITY_STATUS
SEC_ENTRY
SaslIdentifyPackageA(
    IN PSecBufferDesc pInput,
    OUT PSecPkgInfoA * PackageInfo
    );

SECURITY_STATUS
SEC_ENTRY
SaslIdentifyPackageW(
    IN PSecBufferDesc pInput,
    OUT PSecPkgInfoW * PackageInfo
    );

#ifdef UNICODE
#define SaslIdentifyPackage SaslIdentifyPackageW
#else
#define SaslIdentifyPackage SaslIdentifyPackageA
#endif

SECURITY_STATUS
SEC_ENTRY
SaslInitializeSecurityContextW(
    PCredHandle                 phCredential,       // Cred to base context
    PCtxtHandle                 phContext,          // Existing context (OPT)
    LPWSTR                      pszTargetName,      // Name of target
    unsigned long               fContextReq,        // Context Requirements
    unsigned long               Reserved1,          // Reserved, MBZ
    unsigned long               TargetDataRep,      // Data rep of target
    PSecBufferDesc              pInput,             // Input Buffers
    unsigned long               Reserved2,          // Reserved, MBZ
    PCtxtHandle                 phNewContext,       // (out) New Context handle
    PSecBufferDesc              pOutput,            // (inout) Output Buffers
    unsigned long SEC_FAR *     pfContextAttr,      // (out) Context attrs
    PTimeStamp                  ptsExpiry           // (out) Life span (OPT)
    );

SECURITY_STATUS
SEC_ENTRY
SaslInitializeSecurityContextA(
    PCredHandle                 phCredential,       // Cred to base context
    PCtxtHandle                 phContext,          // Existing context (OPT)
    LPSTR                       pszTargetName,      // Name of target
    unsigned long               fContextReq,        // Context Requirements
    unsigned long               Reserved1,          // Reserved, MBZ
    unsigned long               TargetDataRep,      // Data rep of target
    PSecBufferDesc              pInput,             // Input Buffers
    unsigned long               Reserved2,          // Reserved, MBZ
    PCtxtHandle                 phNewContext,       // (out) New Context handle
    PSecBufferDesc              pOutput,            // (inout) Output Buffers
    unsigned long SEC_FAR *     pfContextAttr,      // (out) Context attrs
    PTimeStamp                  ptsExpiry           // (out) Life span (OPT)
    );

#ifdef UNICODE
#define SaslInitializeSecurityContext   SaslInitializeSecurityContextW
#else
#define SaslInitializeSecurityContext   SaslInitializeSecurityContextA
#endif


SECURITY_STATUS
SEC_ENTRY
SaslAcceptSecurityContext(
    PCredHandle                 phCredential,       // Cred to base context
    PCtxtHandle                 phContext,          // Existing context (OPT)
    PSecBufferDesc              pInput,             // Input buffer
    unsigned long               fContextReq,        // Context Requirements
    unsigned long               TargetDataRep,      // Target Data Rep
    PCtxtHandle                 phNewContext,       // (out) New context handle
    PSecBufferDesc              pOutput,            // (inout) Output buffers
    unsigned long SEC_FAR *     pfContextAttr,      // (out) Context attributes
    PTimeStamp                  ptsExpiry           // (out) Life span (OPT)
    );

*)


//+-----------------------------------------------------------------------
//
// Microsoft Windows
//
// Copyright (c) Microsoft Corporation 1991-1999
//
// File:        secext.h
//
// Contents:    Security function prototypes for functions not part of
//              the SSPI interface. This file should not be directly
//              included - include security.h instead.
//
//
// History:     22 Dec 92   RichardW    Created
//
//------------------------------------------------------------------------

//
// This is the combined authentication identity structure that may be
// used with the negotiate package, NTLM, Kerberos, or SCHANNEL
//

const

  SEC_WINNT_AUTH_IDENTITY_VERSION = $200;

type

  PSEC_WINNT_AUTH_IDENTITY_EXW = ^SEC_WINNT_AUTH_IDENTITY_EXW;
  SEC_WINNT_AUTH_IDENTITY_EXW = record
    Version: ULONG;
    Length: ULONG;
    User: PUSHORT;
    UserLength: ULONG;
    Domain: PUSHORT;
    DomainLength: ULONG;
    Password: PUSHORT;
    PasswordLength: ULONG;
    Flags: ULONG;
    PackageList: PUSHORT;
    PackageListLength: ULONG;
  end;

  PSEC_WINNT_AUTH_IDENTITY_EXA = ^SEC_WINNT_AUTH_IDENTITY_EXA;
  SEC_WINNT_AUTH_IDENTITY_EXA = record
    Version: ULONG;
    Length: ULONG;
    User: PUCHAR;
    UserLength: ULONG;
    Domain: PUCHAR;
    DomainLength: ULONG;
    Password: PUCHAR;
    PasswordLength: ULONG;
    Flags: ULONG;
    PackageList: PUCHAR;
    PackageListLength: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SEC_WINNT_AUTH_IDENTITY_EX = SEC_WINNT_AUTH_IDENTITY_EXW;
{$ELSE}
  SEC_WINNT_AUTH_IDENTITY_EX = SEC_WINNT_AUTH_IDENTITY_EXA;
{$ENDIF}

//
// Common types used by negotiable security packages
//

const

  SEC_WINNT_AUTH_IDENTITY_MARSHALLED = $4;     // all data is in one buffer
  SEC_WINNT_AUTH_IDENTITY_ONLY       = $8;     // these credentials are for identity only - no PAC needed


{ TODO : Routines for manipulating packages }
(*


//
// Routines for manipulating packages
//

typedef struct _SECURITY_PACKAGE_OPTIONS {
    unsigned long   Size;
    unsigned long   Type;
    unsigned long   Flags;
    unsigned long   SignatureSize;
    void SEC_FAR *  Signature;
} SECURITY_PACKAGE_OPTIONS, SEC_FAR * PSECURITY_PACKAGE_OPTIONS;

#define SECPKG_OPTIONS_TYPE_UNKNOWN 0
#define SECPKG_OPTIONS_TYPE_LSA     1
#define SECPKG_OPTIONS_TYPE_SSPI    2

#define SECPKG_OPTIONS_PERMANENT    0x00000001

SECURITY_STATUS
SEC_ENTRY
AddSecurityPackageA(
    SEC_CHAR SEC_FAR *  pszPackageName,
    SECURITY_PACKAGE_OPTIONS SEC_FAR * Options
    );

SECURITY_STATUS
SEC_ENTRY
AddSecurityPackageW(
    SEC_WCHAR SEC_FAR * pszPackageName,
    SECURITY_PACKAGE_OPTIONS SEC_FAR * Options
    );

#ifdef UNICODE
#define AddSecurityPackage  AddSecurityPackageW
#else
#define AddSecurityPackage  AddSecurityPackageA
#endif

SECURITY_STATUS
SEC_ENTRY
DeleteSecurityPackageA(
    SEC_CHAR SEC_FAR *  pszPackageName );

SECURITY_STATUS
SEC_ENTRY
DeleteSecurityPackageW(
    SEC_WCHAR SEC_FAR * pszPackageName );

#ifdef UNICODE
#define DeleteSecurityPackage   DeleteSecurityPackageW
#else
#define DeleteSecurityPackage   DeleteSecurityPackageA
#endif


//
// Extended Name APIs for ADS
//


typedef enum
{
    // Examples for the following formats assume a fictitous company
    // which hooks into the global X.500 and DNS name spaces as follows.
    //
    // Enterprise root domain in DNS is
    //
    //      widget.com
    //
    // Enterprise root domain in X.500 (RFC 1779 format) is
    //
    //      O=Widget, C=US
    //
    // There exists the child domain
    //
    //      engineering.widget.com
    //
    // equivalent to
    //
    //      OU=Engineering, O=Widget, C=US
    //
    // There exists a container within the Engineering domain
    //
    //      OU=Software, OU=Engineering, O=Widget, C=US
    //
    // There exists the user
    //
    //      CN=John Doe, OU=Software, OU=Engineering, O=Widget, C=US
    //
    // And this user's downlevel (pre-ADS) user name is    {Do not Localize}
    //
    //      Engineering\JohnDoe

    // unknown name type
    NameUnknown = 0,

    // CN=John Doe, OU=Software, OU=Engineering, O=Widget, C=US
    NameFullyQualifiedDN = 1,

    // Engineering\JohnDoe
    NameSamCompatible = 2,

    // Probably "John Doe" but could be something else.  I.e. The
    // display name is not necessarily the defining RDN.
    NameDisplay = 3,


    // String-ized GUID as returned by IIDFromString().
    // eg: {4fa050f0-f561-11cf-bdd9-00aa003a77b6}
    NameUniqueId = 6,

    // engineering.widget.com/software/John Doe
    NameCanonical = 7,

    // johndoe@engineering.com
    NameUserPrincipal = 8,

    // Same as NameCanonical except that rightmost '/' is    {Do not Localize}
    // replaced with '\n' - even in domain-only case.    {Do not Localize}
    // eg: engineering.widget.com/software\nJohn Doe
    NameCanonicalEx = 9,

    // www/srv.engineering.com/engineering.com
    NameServicePrincipal = 10

} EXTENDED_NAME_FORMAT, * PEXTENDED_NAME_FORMAT ;

BOOLEAN
SEC_ENTRY
GetUserNameExA(
    EXTENDED_NAME_FORMAT  NameFormat,
    LPSTR lpNameBuffer,
    PULONG nSize
    );
BOOLEAN
SEC_ENTRY
GetUserNameExW(
    EXTENDED_NAME_FORMAT NameFormat,
    LPWSTR lpNameBuffer,
    PULONG nSize
    );

#ifdef UNICODE
#define GetUserNameEx   GetUserNameExW
#else
#define GetUserNameEx   GetUserNameExA
#endif

BOOLEAN
SEC_ENTRY
GetComputerObjectNameA(
    EXTENDED_NAME_FORMAT  NameFormat,
    LPSTR lpNameBuffer,
    PULONG nSize
    );
BOOLEAN
SEC_ENTRY
GetComputerObjectNameW(
    EXTENDED_NAME_FORMAT NameFormat,
    LPWSTR lpNameBuffer,
    PULONG nSize
    );

#ifdef UNICODE
#define GetComputerObjectName   GetComputerObjectNameW
#else
#define GetComputerObjectName   GetComputerObjectNameA
#endif

BOOLEAN
SEC_ENTRY
TranslateNameA(
    LPCSTR lpAccountName,
    EXTENDED_NAME_FORMAT AccountNameFormat,
    EXTENDED_NAME_FORMAT DesiredNameFormat,
    LPSTR lpTranslatedName,
    PULONG nSize
    );
BOOLEAN
SEC_ENTRY
TranslateNameW(
    LPCWSTR lpAccountName,
    EXTENDED_NAME_FORMAT AccountNameFormat,
    EXTENDED_NAME_FORMAT DesiredNameFormat,
    LPWSTR lpTranslatedName,
    PULONG nSize
    );
#ifdef UNICODE
#define TranslateName   TranslateNameW
#else
#define TranslateName   TranslateNameA
#endif


*)

{ TODO : following are only minor extracts from rpcdce.h
         to be able to implement WinNT authentication NTLM/Kerberos
}

(*

/*++

Copyright (c) 1991-1999 Microsoft Corporation

Module Name:

    rpcdce.h

Abstract:

    This module contains the DCE RPC runtime APIs.

--*/

*)

const

  SEC_WINNT_AUTH_IDENTITY_ANSI    = 1;
  SEC_WINNT_AUTH_IDENTITY_UNICODE = 2;

type

  PSEC_WINNT_AUTH_IDENTITY_W = ^SEC_WINNT_AUTH_IDENTITY_W;
  SEC_WINNT_AUTH_IDENTITY_W = record
    User: PWideChar;
    UserLength: ULONG;
    Domain: PWideChar;
    DomainLength: ULONG;
    Password: PWideChar;
    PasswordLength: ULONG;
    Flags: ULONG;
  end;

  PSEC_WINNT_AUTH_IDENTITY_A = ^SEC_WINNT_AUTH_IDENTITY_A;
  SEC_WINNT_AUTH_IDENTITY_A = record
    User: PAnsiChar;
    UserLength: ULONG;
    Domain: PAnsiChar;
    DomainLength: ULONG;
    Password: PAnsiChar;
    PasswordLength: ULONG;
    Flags: ULONG;
  end;

{$IFDEF SSPI_UNICODE}
  SEC_WINNT_AUTH_IDENTITY = SEC_WINNT_AUTH_IDENTITY_W;
  PSEC_WINNT_AUTH_IDENTITY = PSEC_WINNT_AUTH_IDENTITY_W;
{$ELSE}
  SEC_WINNT_AUTH_IDENTITY = SEC_WINNT_AUTH_IDENTITY_A;
  PSEC_WINNT_AUTH_IDENTITY = PSEC_WINNT_AUTH_IDENTITY_A;
{$ENDIF}

implementation

procedure SecInvalidateHandle(Var x: SecHandle);
begin
  with x do begin
    dwLower := PtrUInt(-1);
    dwUpper := PtrUInt(-1);
  end;
end;

function SecIsValidHandle(x : SecHandle) : Boolean;
begin
  with x do begin
    Result := (dwLower <> PtrUInt(-1)) and (dwUpper <> PtrUInt(-1));
  end;
end;

function SEC_SUCCESS(Status: SECURITY_STATUS): Boolean;
begin
  Result := Status >= 0;
end;

end.
