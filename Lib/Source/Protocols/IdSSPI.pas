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
  {$NODEFINE PPVOID}
  PVOID = Pointer;
  {$NODEFINE PVOID}

  PUSHORT = ^USHORT;
  {$NODEFINE PUSHORT}
  USHORT = Word;
  {$NODEFINE USHORT}

  PUCHAR = ^UCHAR;
  {$NODEFINE PUCHAR}
  UCHAR = Byte;
  {$NODEFINE UCHAR}

(*$HPPEMIT '//#define SECURITY_WIN32'*)
(*$HPPEMIT '#include <security.h>'*)

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
  {$EXTERNALSYM NTLMSP_NAME}

  MICROSOFT_KERBEROS_NAME   = 'Kerberos';    {Do not Localize}
  {$EXTERNALSYM MICROSOFT_KERBEROS_NAME}

  NEGOSSP_NAME              = 'Negotiate';    {Do not Localize}
  {$EXTERNALSYM NEGOSSP_NAME}

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
  {$NODEFINE PSEC_WCHAR}
  SEC_WCHAR = WideChar;
  {$EXTERNALSYM SEC_WCHAR}

  PSEC_CHAR = PAnsiChar;
  {$NODEFINE PSEC_CHAR}
  SEC_CHAR = AnsiChar;
  {$EXTERNALSYM SEC_CHAR}

  PSECURITY_STATUS = ^SECURITY_STATUS;
  {$NODEFINE PSECURITY_STATUS}
  SECURITY_STATUS = Longint{LONG}; // LONG is not defined in Windows.pas prior to Delphi 8
  {$EXTERNALSYM SECURITY_STATUS}

//
// Decide what a string - 32 bits only since for 16 bits it is clear.
//

type
  {$IFDEF SSPI_UNICODE}
  SECURITY_PSTR = ^SEC_WCHAR;
  {$ELSE}
  SECURITY_PSTR = ^SEC_CHAR;
  {$ENDIF}
  {$EXTERNALSYM SECURITY_PSTR}
//
// Okay, security specific types:
//

type

  PSecHandle = ^SecHandle;
  {$EXTERNALSYM PSecHandle}
  //Define ULONG_PTR as PtrUInt so we can use this unit in FreePascal.
  SecHandle = record
    dwLower: PtrUInt; // ULONG_PTR
    dwUpper: PtrUInt; // ULONG_PTR
  end;
  {$EXTERNALSYM SecHandle}

  CredHandle = SecHandle;
  {$EXTERNALSYM CredHandle}
  PCredHandle = PSecHandle;
  {$EXTERNALSYM PCredHandle}

  CtxtHandle = SecHandle;
  {$EXTERNALSYM CtxtHandle}
  PCtxtHandle = PSecHandle;
  {$EXTERNALSYM PCtxtHandle}

  PSECURITY_INTEGER = ^SECURITY_INTEGER;
  {$EXTERNALSYM PSECURITY_INTEGER}
  SECURITY_INTEGER = LARGE_INTEGER;
  {$EXTERNALSYM SECURITY_INTEGER}

  PTimeStamp = ^TimeStamp;
  {$EXTERNALSYM PTimeStamp}
  TimeStamp = SECURITY_INTEGER;
  {$EXTERNALSYM TimeStamp}

  procedure SecInvalidateHandle(var x: SecHandle);  {$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM SecInvalidateHandle}
  function SecIsValidHandle(x : SecHandle) : Boolean; {$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM SecIsValidHandle}
  function SEC_SUCCESS(Status: SECURITY_STATUS): Boolean;  {$IFDEF USE_INLINE} inline; {$ENDIF}
  {$EXTERNALSYM SEC_SUCCESS}

type

//
// If we are in 32 bit mode, define the SECURITY_STRING structure,
// as a clone of the base UNICODE_STRING structure.  This is used
// internally in security components, an as the string interface
// for kernel components (e.g. FSPs)
//

  PSECURITY_STRING = ^SECURITY_STRING;
  {$EXTERNALSYM PSECURITY_STRING}
  SECURITY_STRING = record
    Length: USHORT;
    MaximumLength: USHORT;
    Buffer: PUSHORT;
  end;
  {$EXTERNALSYM SECURITY_STRING}

//
// SecPkgInfo structure
//
//  Provides general information about a security provider
//

type

  PPSecPkgInfoW = ^PSecPkgInfoW;
  {$NODEFINE PPSecPkgInfoW}
  PSecPkgInfoW = ^SecPkgInfoW;
  {$EXTERNALSYM PSecPkgInfoW}
  SecPkgInfoW = record
    fCapabilities: ULONG;        // Capability bitmask
    wVersion: USHORT;            // Version of driver
    wRPCID: USHORT;              // ID for RPC Runtime
    cbMaxToken: ULONG;           // Size of authentication token (max)
    Name: PSEC_WCHAR;            // Text name
    Comment: PSEC_WCHAR;         // Comment
  end;
  {$EXTERNALSYM SecPkgInfoW}

  PPSecPkgInfoA = ^PSecPkgInfoA;
  {$NODEFINE PPSecPkgInfoA}
  PSecPkgInfoA = ^SecPkgInfoA;
  {$EXTERNALSYM PSecPkgInfoA}
  SecPkgInfoA = record
    fCapabilities: ULONG;        // Capability bitmask
    wVersion: USHORT;            // Version of driver
    wRPCID: USHORT;              // ID for RPC Runtime
    cbMaxToken: ULONG;           // Size of authentication token (max)
    Name: PSEC_CHAR;             // Text name
    Comment: PSEC_CHAR;          // Comment
  end;
  {$EXTERNALSYM SecPkgInfoA}

{$IFDEF SSPI_UNICODE}
  SecPkgInfo = SecPkgInfoW;
  PSecPkgInfo = PSecPkgInfoW;
{$ELSE}
  SecPkgInfo = SecPkgInfoA;
  PSecPkgInfo = PSecPkgInfoA;
{$ENDIF}
  {$EXTERNALSYM SecPkgInfo}
  {$EXTERNALSYM PSecPkgInfo}


//
//  Security Package Capabilities
//

const

  SECPKG_FLAG_INTEGRITY         = $00000001; // Supports integrity on messages
  {$EXTERNALSYM SECPKG_FLAG_INTEGRITY}
  SECPKG_FLAG_PRIVACY           = $00000002; // Supports privacy (confidentiality)
  {$EXTERNALSYM SECPKG_FLAG_PRIVACY}
  SECPKG_FLAG_TOKEN_ONLY        = $00000004; // Only security token needed
  {$EXTERNALSYM SECPKG_FLAG_TOKEN_ONLY}
  SECPKG_FLAG_DATAGRAM          = $00000008; // Datagram RPC support
  {$EXTERNALSYM SECPKG_FLAG_DATAGRAM}
  SECPKG_FLAG_CONNECTION        = $00000010; // Connection oriented RPC support
  {$EXTERNALSYM SECPKG_FLAG_CONNECTION}
  SECPKG_FLAG_MULTI_REQUIRED    = $00000020; // Full 3-leg required for re-auth.
  {$EXTERNALSYM SECPKG_FLAG_MULTI_REQUIRED}
  SECPKG_FLAG_CLIENT_ONLY       = $00000040; // Server side functionality not available
  {$EXTERNALSYM SECPKG_FLAG_CLIENT_ONLY}
  SECPKG_FLAG_EXTENDED_ERROR    = $00000080; // Supports extended error msgs
  {$EXTERNALSYM SECPKG_FLAG_EXTENDED_ERROR}
  SECPKG_FLAG_IMPERSONATION     = $00000100; // Supports impersonation
  {$EXTERNALSYM SECPKG_FLAG_IMPERSONATION}
  SECPKG_FLAG_ACCEPT_WIN32_NAME = $00000200; // Accepts Win32 names
  {$EXTERNALSYM SECPKG_FLAG_ACCEPT_WIN32_NAME}
  SECPKG_FLAG_STREAM            = $00000400; // Supports stream semantics
  {$EXTERNALSYM SECPKG_FLAG_STREAM}
  SECPKG_FLAG_NEGOTIABLE        = $00000800; // Can be used by the negotiate package
  {$EXTERNALSYM SECPKG_FLAG_NEGOTIABLE}
  SECPKG_FLAG_GSS_COMPATIBLE    = $00001000; // GSS Compatibility Available
  {$EXTERNALSYM SECPKG_FLAG_GSS_COMPATIBLE}
  SECPKG_FLAG_LOGON             = $00002000; // Supports common LsaLogonUser
  {$EXTERNALSYM SECPKG_FLAG_LOGON}
  SECPKG_FLAG_ASCII_BUFFERS     = $00004000; // Token Buffers are in ASCII
  {$EXTERNALSYM SECPKG_FLAG_ASCII_BUFFERS}
  SECPKG_FLAG_FRAGMENT          = $00008000; // Package can fragment to fit
  {$EXTERNALSYM SECPKG_FLAG_FRAGMENT}
  SECPKG_FLAG_MUTUAL_AUTH       = $00010000; // Package can perform mutual authentication
  {$EXTERNALSYM SECPKG_FLAG_MUTUAL_AUTH}
  SECPKG_FLAG_DELEGATION        = $00020000; // Package can delegate
  {$EXTERNALSYM SECPKG_FLAG_DELEGATION}
  SECPKG_FLAG_READONLY_WITH_CHECKSUM = $00040000; // Package can delegate
  {$EXTERNALSYM SECPKG_FLAG_READONLY_WITH_CHECKSUM}
  SECPKG_FLAG_RESTRICTED_TOKENS = $00080000; // Package supports restricted callers
  {$EXTERNALSYM SECPKG_FLAG_RESTRICTED_TOKENS}
  SECPKG_FLAG_NEGO_EXTENDER     = $00100000; // this package extends SPNEGO, there is at most one
  {$EXTERNALSYM SECPKG_FLAG_NEGO_EXTENDER}
  SECPKG_FLAG_NEGOTIABLE2       = $00200000; // this package is negotiated under the NegoExtender
  {$EXTERNALSYM SECPKG_FLAG_NEGOTIABLE2}

  SECPKG_ID_NONE                = $FFFF;
  {$EXTERNALSYM SECPKG_ID_NONE}

//
// SecBuffer
//
//  Generic memory descriptors for buffers passed in to the security
//  API
//

type

  PSecBuffer = ^SecBuffer;
  {$EXTERNALSYM PSecBuffer}
  SecBuffer = record
    cbBuffer: ULONG;                  // Size of the buffer, in bytes
    BufferType: ULONG;                // Type of the buffer (below)
    pvBuffer: PVOID;                  // Pointer to the buffer
  end;
  {$EXTERNALSYM SecBuffer}

  PSecBufferDesc = ^SecBufferDesc;
  {$EXTERNALSYM PSecBufferDesc}
  SecBufferDesc = record
    ulVersion: ULONG;                 // Version number
    cBuffers: ULONG;                  // Number of buffers
    pBuffers: PSecBuffer;             // Pointer to array of buffers
  end;
  {$EXTERNALSYM SecBufferDesc}

const

  SECBUFFER_VERSION            = 0;
  {$EXTERNALSYM SECBUFFER_VERSION}

  SECBUFFER_EMPTY              = 0;   // Undefined, replaced by provider
  {$EXTERNALSYM SECBUFFER_EMPTY}
  SECBUFFER_DATA               = 1;   // Packet data
  {$EXTERNALSYM SECBUFFER_DATA}
  SECBUFFER_TOKEN              = 2;   // Security token
  {$EXTERNALSYM SECBUFFER_TOKEN}
  SECBUFFER_PKG_PARAMS         = 3;   // Package specific parameters
  {$EXTERNALSYM SECBUFFER_PKG_PARAMS}
  SECBUFFER_MISSING            = 4;   // Missing Data indicator
  {$EXTERNALSYM SECBUFFER_MISSING}
  SECBUFFER_EXTRA              = 5;   // Extra data
  {$EXTERNALSYM SECBUFFER_EXTRA}
  SECBUFFER_STREAM_TRAILER     = 6;   // Security Trailer
  {$EXTERNALSYM SECBUFFER_STREAM_TRAILER}
  SECBUFFER_STREAM_HEADER      = 7;   // Security Header
  {$EXTERNALSYM SECBUFFER_STREAM_HEADER}
  SECBUFFER_NEGOTIATION_INFO   = 8;   // Hints from the negotiation pkg
  {$EXTERNALSYM SECBUFFER_NEGOTIATION_INFO}
  SECBUFFER_PADDING            = 9;   // non-data padding
  {$EXTERNALSYM SECBUFFER_PADDING}
  SECBUFFER_STREAM             = 10;  // whole encrypted message
  {$EXTERNALSYM SECBUFFER_STREAM}
  SECBUFFER_MECHLIST           = 11;
  {$EXTERNALSYM SECBUFFER_MECHLIST}
  SECBUFFER_MECHLIST_SIGNATURE = 12;
  {$EXTERNALSYM SECBUFFER_MECHLIST_SIGNATURE}
  SECBUFFER_TARGET           = 13;  // obsolete
  {$EXTERNALSYM SECBUFFER_TARGET}
  SECBUFFER_CHANNEL_BINDINGS = 14;
  {$EXTERNALSYM SECBUFFER_CHANNEL_BINDINGS}
  SECBUFFER_CHANGE_PASS_RESPONSE = 15;
  {$EXTERNALSYM SECBUFFER_CHANGE_PASS_RESPONSE}
  SECBUFFER_TARGET_HOST      = 16;
  {$EXTERNALSYM SECBUFFER_TARGET_HOST}
  SECBUFFER_ALERT            = 17;
  {$EXTERNALSYM SECBUFFER_ALERT}

  SECBUFFER_ATTRMASK           = $F0000000;
  {$EXTERNALSYM SECBUFFER_ATTRMASK}
  SECBUFFER_READONLY           = $80000000;  // Buffer is read-only
  {$EXTERNALSYM SECBUFFER_READONLY}
  SECBUFFER_READONLY_WITH_CHECKSUM = $10000000;  // Buffer is read-only, and checksummed;
  {$EXTERNALSYM SECBUFFER_READONLY_WITH_CHECKSUM}
  SECBUFFER_RESERVED           = $40000000;
  {$EXTERNALSYM SECBUFFER_RESERVED}

type

  PSEC_NEGOTIATION_INFO = ^SEC_NEGOTIATION_INFO;
  {$EXTERNALSYM PSEC_NEGOTIATION_INFO}
  SEC_NEGOTIATION_INFO = record
    Size: ULONG;                      // Size of this structure
    NameLength: ULONG;                // Length of name hint
    Name: PSEC_WCHAR;                 // Name hint
    Reserved: PVOID;                  // Reserved
  end;
  {$EXTERNALSYM SEC_NEGOTIATION_INFO}

  PSEC_CHANNEL_BINDINGS = ^SEC_CHANNEL_BINDINGS;
  {$EXTERNALSYM PSEC_CHANNEL_BINDINGS}
  SEC_CHANNEL_BINDINGS = record
    dwInitiatorAddrType: ULONG;
    cbInitiatorLength: ULONG;
    dwInitiatorOffset: ULONG;
    dwAcceptorAddrType: ULONG;
    cbAcceptorLength: ULONG;
    dwAcceptorOffset: ULONG;
    cbApplicationDataLength: ULONG;
    dwApplicationDataOffset: ULONG;
  end;
  {$EXTERNALSYM SEC_CHANNEL_BINDINGS}

//
//  Data Representation Constant:
//

const

  SECURITY_NATIVE_DREP        = $00000010;
  {$EXTERNALSYM SECURITY_NATIVE_DREP}
  SECURITY_NETWORK_DREP       = $00000000;
  {$EXTERNALSYM SECURITY_NETWORK_DREP}

//
//  Credential Use Flags
//

const

  SECPKG_CRED_INBOUND         = $00000001;
  {$EXTERNALSYM SECPKG_CRED_INBOUND}
  SECPKG_CRED_OUTBOUND        = $00000002;
  {$EXTERNALSYM SECPKG_CRED_OUTBOUND}
  SECPKG_CRED_BOTH            = $00000003;
  {$EXTERNALSYM SECPKG_CRED_BOTH}
  SECPKG_CRED_DEFAULT         = $00000004;
  {$EXTERNALSYM SECPKG_CRED_DEFAULT}
  SECPKG_CRED_RESERVED        = $F0000000;
  {$EXTERNALSYM SECPKG_CRED_RESERVED}

//
//  SSP SHOULD prompt the user for credentials/consent, independent
//  of whether credentials to be used are the 'logged on' credentials
//  or retrieved from credman.
//
//  An SSP may choose not to prompt, however, in circumstances determined
//  by the SSP.
//

  SECPKG_CRED_AUTOLOGON_RESTRICTED    = $00000010;
  {$EXTERNALSYM SECPKG_CRED_AUTOLOGON_RESTRICTED}

//
// auth will always fail, ISC() is called to process policy data only
//

  SECPKG_CRED_PROCESS_POLICY_ONLY     = $00000020;
  {$EXTERNALSYM SECPKG_CRED_PROCESS_POLICY_ONLY}

const
//
//  InitializeSecurityContext Requirement and return flags:
//
  ISC_REQ_DELEGATE                = $00000001;
  {$EXTERNALSYM ISC_REQ_DELEGATE}
  ISC_REQ_MUTUAL_AUTH             = $00000002;
  {$EXTERNALSYM ISC_REQ_MUTUAL_AUTH}
  ISC_REQ_REPLAY_DETECT           = $00000004;
  {$EXTERNALSYM ISC_REQ_REPLAY_DETECT}
  ISC_REQ_SEQUENCE_DETECT         = $00000008;
  {$EXTERNALSYM ISC_REQ_SEQUENCE_DETECT}
  ISC_REQ_CONFIDENTIALITY         = $00000010;
  {$EXTERNALSYM ISC_REQ_CONFIDENTIALITY}
  ISC_REQ_USE_SESSION_KEY         = $00000020;
  {$EXTERNALSYM ISC_REQ_USE_SESSION_KEY}
  ISC_REQ_PROMPT_FOR_CREDS        = $00000040;
  {$EXTERNALSYM ISC_REQ_PROMPT_FOR_CREDS}
  ISC_REQ_USE_SUPPLIED_CREDS      = $00000080;
  {$EXTERNALSYM ISC_REQ_USE_SUPPLIED_CREDS}
  ISC_REQ_ALLOCATE_MEMORY         = $00000100;
  {$EXTERNALSYM ISC_REQ_ALLOCATE_MEMORY}
  ISC_REQ_USE_DCE_STYLE           = $00000200;
  {$EXTERNALSYM ISC_REQ_USE_DCE_STYLE}
  ISC_REQ_DATAGRAM                = $00000400;
  {$EXTERNALSYM ISC_REQ_DATAGRAM}
  ISC_REQ_CONNECTION              = $00000800;
  {$EXTERNALSYM ISC_REQ_CONNECTION}
  ISC_REQ_CALL_LEVEL              = $00001000;
  {$EXTERNALSYM ISC_REQ_CALL_LEVEL}
  ISC_REQ_FRAGMENT_SUPPLIED       = $00002000;
  {$EXTERNALSYM ISC_REQ_FRAGMENT_SUPPLIED}
  ISC_REQ_EXTENDED_ERROR          = $00004000;
  {$EXTERNALSYM ISC_REQ_EXTENDED_ERROR}
  ISC_REQ_STREAM                  = $00008000;
  {$EXTERNALSYM ISC_REQ_STREAM}
  ISC_REQ_INTEGRITY               = $00010000;
  {$EXTERNALSYM ISC_REQ_INTEGRITY}
  ISC_REQ_IDENTIFY                = $00020000;
  {$EXTERNALSYM ISC_REQ_IDENTIFY}
  ISC_REQ_NULL_SESSION            = $00040000;
  {$EXTERNALSYM ISC_REQ_NULL_SESSION}
  ISC_REQ_MANUAL_CRED_VALIDATION  = $00080000;
  {$EXTERNALSYM ISC_REQ_MANUAL_CRED_VALIDATION}
  ISC_REQ_RESERVED1               = $00100000;
  {$EXTERNALSYM ISC_REQ_RESERVED1}
  ISC_REQ_FRAGMENT_TO_FIT         = $00200000;
  {$EXTERNALSYM ISC_REQ_FRAGMENT_TO_FIT}
// This exists only in Windows Vista and greater
  ISC_REQ_FORWARD_CREDENTIALS     = $00400000;
  {$EXTERNALSYM ISC_REQ_FORWARD_CREDENTIALS}
  ISC_REQ_NO_INTEGRITY            = $00800000; // honored only by SPNEGO
  {$EXTERNALSYM ISC_REQ_NO_INTEGRITY}
  ISC_REQ_USE_HTTP_STYLE          = $01000000;
  {$EXTERNALSYM ISC_REQ_USE_HTTP_STYLE}

  ISC_RET_DELEGATE                = $00000001;
  {$EXTERNALSYM ISC_RET_DELEGATE}
  ISC_RET_MUTUAL_AUTH             = $00000002;
  {$EXTERNALSYM ISC_RET_MUTUAL_AUTH}
  ISC_RET_REPLAY_DETECT           = $00000004;
  {$EXTERNALSYM ISC_RET_REPLAY_DETECT}
  ISC_RET_SEQUENCE_DETECT         = $00000008;
  {$EXTERNALSYM ISC_RET_SEQUENCE_DETECT}
  ISC_RET_CONFIDENTIALITY         = $00000010;
  {$EXTERNALSYM ISC_RET_CONFIDENTIALITY}
  ISC_RET_USE_SESSION_KEY         = $00000020;
  {$EXTERNALSYM ISC_RET_USE_SESSION_KEY}
  ISC_RET_USED_COLLECTED_CREDS    = $00000040;
  {$EXTERNALSYM ISC_RET_USED_COLLECTED_CREDS}
  ISC_RET_USED_SUPPLIED_CREDS     = $00000080;
  {$EXTERNALSYM ISC_RET_USED_SUPPLIED_CREDS}
  ISC_RET_ALLOCATED_MEMORY        = $00000100;
  {$EXTERNALSYM ISC_RET_ALLOCATED_MEMORY}
  ISC_RET_USED_DCE_STYLE          = $00000200;
  {$EXTERNALSYM ISC_RET_USED_DCE_STYLE}
  ISC_RET_DATAGRAM                = $00000400;
  {$EXTERNALSYM ISC_RET_DATAGRAM}
  ISC_RET_CONNECTION              = $00000800;
  {$EXTERNALSYM ISC_RET_CONNECTION}
  ISC_RET_INTERMEDIATE_RETURN     = $00001000;
  {$EXTERNALSYM ISC_RET_INTERMEDIATE_RETURN}
  ISC_RET_CALL_LEVEL              = $00002000;
  {$EXTERNALSYM ISC_RET_CALL_LEVEL}
  ISC_RET_EXTENDED_ERROR          = $00004000;
  {$EXTERNALSYM ISC_RET_EXTENDED_ERROR}
  ISC_RET_STREAM                  = $00008000;
  {$EXTERNALSYM ISC_RET_STREAM}
  ISC_RET_INTEGRITY               = $00010000;
  {$EXTERNALSYM ISC_RET_INTEGRITY}
  ISC_RET_IDENTIFY                = $00020000;
  {$EXTERNALSYM ISC_RET_IDENTIFY}
  ISC_RET_NULL_SESSION            = $00040000;
  {$EXTERNALSYM ISC_RET_NULL_SESSION}
  ISC_RET_MANUAL_CRED_VALIDATION  = $00080000;
  {$EXTERNALSYM ISC_RET_MANUAL_CRED_VALIDATION}
  ISC_RET_RESERVED1               = $00100000;
  {$EXTERNALSYM ISC_RET_RESERVED1}
  ISC_RET_FRAGMENT_ONLY           = $00200000;
  {$EXTERNALSYM ISC_RET_FRAGMENT_ONLY}
// This exists only in Windows Vista and greater
  ISC_RET_FORWARD_CREDENTIALS     = $00400000;
  {$EXTERNALSYM ISC_RET_FORWARD_CREDENTIALS}

  ISC_RET_USED_HTTP_STYLE         = $01000000;
  {$EXTERNALSYM ISC_RET_USED_HTTP_STYLE}
  ISC_RET_NO_ADDITIONAL_TOKEN     = $02000000;  // *INTERNAL*
  {$EXTERNALSYM ISC_RET_NO_ADDITIONAL_TOKEN}
  ISC_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*
  {$EXTERNALSYM ISC_RET_REAUTHENTICATION}

  ASC_REQ_DELEGATE                = $00000001;
  {$EXTERNALSYM ASC_REQ_DELEGATE}
  ASC_REQ_MUTUAL_AUTH             = $00000002;
  {$EXTERNALSYM ASC_REQ_MUTUAL_AUTH}
  ASC_REQ_REPLAY_DETECT           = $00000004;
  {$EXTERNALSYM ASC_REQ_REPLAY_DETECT}
  ASC_REQ_SEQUENCE_DETECT         = $00000008;
  {$EXTERNALSYM ASC_REQ_SEQUENCE_DETECT}
  ASC_REQ_CONFIDENTIALITY         = $00000010;
  {$EXTERNALSYM ASC_REQ_CONFIDENTIALITY}
  ASC_REQ_USE_SESSION_KEY         = $00000020;
  {$EXTERNALSYM ASC_REQ_USE_SESSION_KEY}
  ASC_REQ_ALLOCATE_MEMORY         = $00000100;
  {$EXTERNALSYM ASC_REQ_ALLOCATE_MEMORY}
  ASC_REQ_USE_DCE_STYLE           = $00000200;
  {$EXTERNALSYM ASC_REQ_USE_DCE_STYLE}
  ASC_REQ_DATAGRAM                = $00000400;
  {$EXTERNALSYM ASC_REQ_DATAGRAM}
  ASC_REQ_CONNECTION              = $00000800;
  {$EXTERNALSYM ASC_REQ_CONNECTION}
  ASC_REQ_CALL_LEVEL              = $00001000;
  {$EXTERNALSYM ASC_REQ_CALL_LEVEL}
  ASC_REQ_EXTENDED_ERROR          = $00008000;
  {$EXTERNALSYM ASC_REQ_EXTENDED_ERROR}
  ASC_REQ_STREAM                  = $00010000;
  {$EXTERNALSYM ASC_REQ_STREAM}
  ASC_REQ_INTEGRITY               = $00020000;
  {$EXTERNALSYM ASC_REQ_INTEGRITY}
  ASC_REQ_LICENSING               = $00040000;
  {$EXTERNALSYM ASC_REQ_LICENSING}
  ASC_REQ_IDENTIFY                = $00080000;
  {$EXTERNALSYM ASC_REQ_IDENTIFY}
  ASC_REQ_ALLOW_NULL_SESSION      = $00100000;
  {$EXTERNALSYM ASC_REQ_ALLOW_NULL_SESSION}
  ASC_REQ_ALLOW_NON_USER_LOGONS   = $00200000;
  {$EXTERNALSYM ASC_REQ_ALLOW_NON_USER_LOGONS}
  ASC_REQ_ALLOW_CONTEXT_REPLAY    = $00400000;
  {$EXTERNALSYM ASC_REQ_ALLOW_CONTEXT_REPLAY}
  ASC_REQ_FRAGMENT_TO_FIT         = $00800000;
  {$EXTERNALSYM ASC_REQ_FRAGMENT_TO_FIT}
  ASC_REQ_FRAGMENT_SUPPLIED       = $00002000;
  {$EXTERNALSYM ASC_REQ_FRAGMENT_SUPPLIED}
  ASC_REQ_NO_TOKEN                = $01000000;
  {$EXTERNALSYM ASC_REQ_NO_TOKEN}
  ASC_REQ_PROXY_BINDINGS          = $04000000;
  {$EXTERNALSYM ASC_REQ_PROXY_BINDINGS}
//      SSP_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*
  {.$EXTERNALSYM SSP_RET_REAUTHENTICATION}
  ASC_REQ_ALLOW_MISSING_BINDINGS  = $10000000;
  {$EXTERNALSYM ASC_REQ_ALLOW_MISSING_BINDINGS}

  ASC_RET_DELEGATE                = $00000001;
  {$EXTERNALSYM ASC_RET_DELEGATE}
  ASC_RET_MUTUAL_AUTH             = $00000002;
  {$EXTERNALSYM ASC_RET_MUTUAL_AUTH}
  ASC_RET_REPLAY_DETECT           = $00000004;
  {$EXTERNALSYM ASC_RET_REPLAY_DETECT}
  ASC_RET_SEQUENCE_DETECT         = $00000008;
  {$EXTERNALSYM ASC_RET_SEQUENCE_DETECT}
  ASC_RET_CONFIDENTIALITY         = $00000010;
  {$EXTERNALSYM ASC_RET_CONFIDENTIALITY}
  ASC_RET_USE_SESSION_KEY         = $00000020;
  {$EXTERNALSYM ASC_RET_USE_SESSION_KEY}
  ASC_RET_ALLOCATED_MEMORY        = $00000100;
  {$EXTERNALSYM ASC_RET_ALLOCATED_MEMORY}
  ASC_RET_USED_DCE_STYLE          = $00000200;
  {$EXTERNALSYM ASC_RET_USED_DCE_STYLE}
  ASC_RET_DATAGRAM                = $00000400;
  {$EXTERNALSYM ASC_RET_DATAGRAM}
  ASC_RET_CONNECTION              = $00000800;
  {$EXTERNALSYM ASC_RET_CONNECTION}
  ASC_RET_CALL_LEVEL              = $00002000; // skipped 1000 to be like ISC_
  {$EXTERNALSYM ASC_RET_CALL_LEVEL}
  ASC_RET_THIRD_LEG_FAILED        = $00004000;
  {$EXTERNALSYM ASC_RET_THIRD_LEG_FAILED}
  ASC_RET_EXTENDED_ERROR          = $00008000;
  {$EXTERNALSYM ASC_RET_EXTENDED_ERROR}
  ASC_RET_STREAM                  = $00010000;
  {$EXTERNALSYM ASC_RET_STREAM}
  ASC_RET_INTEGRITY               = $00020000;
  {$EXTERNALSYM ASC_RET_INTEGRITY}
  ASC_RET_LICENSING               = $00040000;
  {$EXTERNALSYM ASC_RET_LICENSING}
  ASC_RET_IDENTIFY                = $00080000;
  {$EXTERNALSYM ASC_RET_IDENTIFY}
  ASC_RET_NULL_SESSION            = $00100000;
  {$EXTERNALSYM ASC_RET_NULL_SESSION}
  ASC_RET_ALLOW_NON_USER_LOGONS   = $00200000;
  {$EXTERNALSYM ASC_RET_ALLOW_NON_USER_LOGONS}
  ASC_RET_ALLOW_CONTEXT_REPLAY    = $00400000;
  {$EXTERNALSYM ASC_RET_ALLOW_CONTEXT_REPLAY}
  ASC_RET_FRAGMENT_ONLY           = $00800000;
  {$EXTERNALSYM ASC_RET_FRAGMENT_ONLY}
  ASC_RET_NO_TOKEN                = $01000000;
  {$EXTERNALSYM ASC_RET_NO_TOKEN}
  ASC_RET_NO_ADDITIONAL_TOKEN     = $02000000;  // *INTERNAL*
  {$EXTERNALSYM ASC_RET_NO_ADDITIONAL_TOKEN}
  ASC_RET_NO_PROXY_BINDINGS       = $04000000;
  {$EXTERNALSYM ASC_RET_NO_PROXY_BINDINGS}
//  SSP_RET_REAUTHENTICATION        = $08000000;  // *INTERNAL*
  {.$EXTERNALSYM SSP_RET_REAUTHENTICATION}
  ASC_RET_MISSING_BINDINGS        = $10000000;
  {$EXTERNALSYM ASC_RET_MISSING_BINDINGS}

//
//  Security Credentials Attributes:
//

const
  SECPKG_CRED_ATTR_NAMES = 1;
  {$EXTERNALSYM SECPKG_CRED_ATTR_NAMES}
  SECPKG_CRED_ATTR_SSI_PROVIDER = 2;
  {$EXTERNALSYM SECPKG_CRED_ATTR_SSI_PROVIDER}

type

  PSecPkgCredentials_NamesW = ^SecPkgCredentials_NamesW;
  {$EXTERNALSYM PSecPkgCredentials_NamesW}
  SecPkgCredentials_NamesW = record
    sUserName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgCredentials_NamesW}

  PSecPkgCredentials_NamesA = ^SecPkgCredentials_NamesA;
  {$EXTERNALSYM PSecPkgCredentials_NamesA}
  SecPkgCredentials_NamesA = record
    sUserName: PSEC_CHAR;
  end;
  {$EXTERNALSYM SecPkgCredentials_NamesA}

{$IFDEF SSPI_UNICODE}
  SecPkgCredentials_Names = SecPkgCredentials_NamesW;
  PSecPkgCredentials_Names = PSecPkgCredentials_NamesW;
{$ELSE}
  SecPkgCredentials_Names = SecPkgCredentials_NamesA;
  PSecPkgCredentials_Names = PSecPkgCredentials_NamesA;
{$ENDIF}
  {$EXTERNALSYM SecPkgCredentials_Names}
  {$EXTERNALSYM PSecPkgCredentials_Names}

  PSecPkgCredentials_SSIProviderW = ^SecPkgCredentials_SSIProviderW;
  {$EXTERNALSYM PSecPkgCredentials_SSIProviderW}
  SecPkgCredentials_SSIProviderW = record
    sProviderName: PSEC_WCHAR;
    ProviderInfoLength: ULONG;
    ProviderInfo: PAnsiChar;
  end;
  {$EXTERNALSYM SecPkgCredentials_SSIProviderW}

  PSecPkgCredentials_SSIProviderA = ^SecPkgCredentials_SSIProviderA;
  {$EXTERNALSYM PSecPkgCredentials_SSIProviderA}
  SecPkgCredentials_SSIProviderA = record
    sProviderName: PSEC_CHAR;
    ProviderInfoLength: ULONG;
    ProviderInfo: PAnsiChar;
  end;
  {$EXTERNALSYM SecPkgCredentials_SSIProviderA}

{$IFDEF SSPI_UNICODE}
  SecPkgCredentials_SSIProvider = SecPkgCredentials_SSIProviderW;
  PSecPkgCredentials_SSIProvider = PSecPkgCredentials_SSIProviderW;
{$ELSE}
  SecPkgCredentials_SSIProvider = SecPkgCredentials_SSIProviderA;
  PSecPkgCredentials_SSIProvider = PSecPkgCredentials_SSIProviderA;
{$ENDIF}
  {$EXTERNALSYM SecPkgCredentials_SSIProvider}
  {$EXTERNALSYM PSecPkgCredentials_SSIProvider}

//
//  Security Context Attributes:
//

const

  SECPKG_ATTR_SIZES            = 0;
  {$EXTERNALSYM SECPKG_ATTR_SIZES}
  SECPKG_ATTR_NAMES            = 1;
  {$EXTERNALSYM SECPKG_ATTR_NAMES}
  SECPKG_ATTR_LIFESPAN         = 2;
  {$EXTERNALSYM SECPKG_ATTR_LIFESPAN}
  SECPKG_ATTR_DCE_INFO         = 3;
  {$EXTERNALSYM SECPKG_ATTR_DCE_INFO}
  SECPKG_ATTR_STREAM_SIZES     = 4;
  {$EXTERNALSYM SECPKG_ATTR_STREAM_SIZES}
  SECPKG_ATTR_KEY_INFO         = 5;
  {$EXTERNALSYM SECPKG_ATTR_KEY_INFO}
  SECPKG_ATTR_AUTHORITY        = 6;
  {$EXTERNALSYM SECPKG_ATTR_AUTHORITY}
  SECPKG_ATTR_PROTO_INFO       = 7;
  {$EXTERNALSYM SECPKG_ATTR_PROTO_INFO}
  SECPKG_ATTR_PASSWORD_EXPIRY  = 8;
  {$EXTERNALSYM SECPKG_ATTR_PASSWORD_EXPIRY}
  SECPKG_ATTR_SESSION_KEY      = 9;
  {$EXTERNALSYM SECPKG_ATTR_SESSION_KEY}
  SECPKG_ATTR_PACKAGE_INFO     = 10;
  {$EXTERNALSYM SECPKG_ATTR_PACKAGE_INFO}
  SECPKG_ATTR_USER_FLAGS       = 11;
  {$EXTERNALSYM SECPKG_ATTR_USER_FLAGS}
  SECPKG_ATTR_NEGOTIATION_INFO = 12;
  {$EXTERNALSYM SECPKG_ATTR_NEGOTIATION_INFO}
  SECPKG_ATTR_NATIVE_NAMES     = 13;
  {$EXTERNALSYM SECPKG_ATTR_NATIVE_NAMES}
  SECPKG_ATTR_FLAGS            = 14;
  {$EXTERNALSYM SECPKG_ATTR_FLAGS}
// These attributes exist only in Win XP and greater
  SECPKG_ATTR_USE_VALIDATED   = 15;
  {$EXTERNALSYM SECPKG_ATTR_USE_VALIDATED}
  SECPKG_ATTR_CREDENTIAL_NAME = 16;
  {$EXTERNALSYM SECPKG_ATTR_CREDENTIAL_NAME}
  SECPKG_ATTR_TARGET_INFORMATION = 17;
  {$EXTERNALSYM SECPKG_ATTR_TARGET_INFORMATION}
  SECPKG_ATTR_ACCESS_TOKEN    = 18;
  {$EXTERNALSYM SECPKG_ATTR_ACCESS_TOKEN}
// These attributes exist only in Win2K3 and greater
  SECPKG_ATTR_TARGET          = 19;
  {$EXTERNALSYM SECPKG_ATTR_TARGET}
  SECPKG_ATTR_AUTHENTICATION_ID  = 20;
  {$EXTERNALSYM SECPKG_ATTR_AUTHENTICATION_ID}
// These attributes exist only in Win2K3SP1 and greater
  SECPKG_ATTR_LOGOFF_TIME     = 21;
  {$EXTERNALSYM SECPKG_ATTR_LOGOFF_TIME}
//
// win7 or greater
//
  SECPKG_ATTR_NEGO_KEYS         = 22;
  {$EXTERNALSYM SECPKG_ATTR_NEGO_KEYS}
  SECPKG_ATTR_PROMPTING_NEEDED  = 24;
  {$EXTERNALSYM SECPKG_ATTR_PROMPTING_NEEDED}
  SECPKG_ATTR_UNIQUE_BINDINGS   = 25;
  {$EXTERNALSYM SECPKG_ATTR_UNIQUE_BINDINGS}
  SECPKG_ATTR_ENDPOINT_BINDINGS = 26;
  {$EXTERNALSYM SECPKG_ATTR_ENDPOINT_BINDINGS}
  SECPKG_ATTR_CLIENT_SPECIFIED_TARGET = 27;
  {$EXTERNALSYM SECPKG_ATTR_CLIENT_SPECIFIED_TARGET}

  SECPKG_ATTR_LAST_CLIENT_TOKEN_STATUS = 30;
  {$EXTERNALSYM SECPKG_ATTR_LAST_CLIENT_TOKEN_STATUS}
  SECPKG_ATTR_NEGO_PKG_INFO        = 31; // contains nego info of packages
  {$EXTERNALSYM SECPKG_ATTR_NEGO_PKG_INFO}
  SECPKG_ATTR_NEGO_STATUS          = 32; // contains the last error
  {$EXTERNALSYM SECPKG_ATTR_NEGO_STATUS}
  SECPKG_ATTR_CONTEXT_DELETED      = 33; // a context has been deleted
  {$EXTERNALSYM SECPKG_ATTR_CONTEXT_DELETED}

  SECPKG_ATTR_SUBJECT_SECURITY_ATTRIBUTES = 128;
  {$EXTERNALSYM SECPKG_ATTR_SUBJECT_SECURITY_ATTRIBUTES}

type

  PSecPkgContext_SubjectAttributes = ^SecPkgContext_SubjectAttributes;
  {$EXTERNALSYM PSecPkgContext_SubjectAttributes}
  SecPkgContext_SubjectAttributes = record
    AttributeInfo: PVOID; // contains a PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION structure
  end;
  {$EXTERNALSYM SecPkgContext_SubjectAttributes}

const
  SECPKG_ATTR_NEGO_INFO_FLAG_NO_KERBEROS = $1;
  {$EXTERNALSYM SECPKG_ATTR_NEGO_INFO_FLAG_NO_KERBEROS}
  SECPKG_ATTR_NEGO_INFO_FLAG_NO_NTLM = $2;
  {$EXTERNALSYM SECPKG_ATTR_NEGO_INFO_FLAG_NO_NTLM}

type

//
// types of credentials, used by SECPKG_ATTR_PROMPTING_NEEDED
//

  PSECPKG_CRED_CLASS = ^SECPKG_CRED_CLASS;
  {$EXTERNALSYM PSECPKG_CRED_CLASS}
  SECPKG_CRED_CLASS = ULONG;
  {$EXTERNALSYM SECPKG_CRED_CLASS}

const
  SecPkgCredClass_None = 0;               // no creds
  {$EXTERNALSYM SecPkgCredClass_None}
  SecPkgCredClass_Ephemeral = 10;         // logon creds
  {$EXTERNALSYM SecPkgCredClass_Ephemeral}
  SecPkgCredClass_PersistedGeneric = 20;  // saved creds, not target specific
  {$EXTERNALSYM SecPkgCredClass_PersistedGeneric}
  SecPkgCredClass_PersistedSpecific = 30; // saved creds, target specific
  {$EXTERNALSYM SecPkgCredClass_PersistedSpecific}
  SecPkgCredClass_Explicit = 40;          // explicitly supplied creds
  {$EXTERNALSYM SecPkgCredClass_Explicit}

type

  PSecPkgContext_CredInfo = ^SecPkgContext_CredInfo;
  {$EXTERNALSYM PSecPkgContext_CredInfo}
  SecPkgContext_CredInfo = record
    CredClass: SECPKG_CRED_CLASS;
    IsPromptingNeeded: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_CredInfo}

  PSecPkgContext_NegoPackageInfo = ^SecPkgContext_NegoPackageInfo;
  {$EXTERNALSYM PSecPkgContext_NegoPackageInfo}
  SecPkgContext_NegoPackageInfo = record
    PackageMask: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_NegoPackageInfo}

  PSecPkgContext_NegoStatus = ^SecPkgContext_NegoStatus;
  {$EXTERNALSYM PSecPkgContext_NegoStatus}
  SecPkgContext_NegoStatus = record
    LastStatus: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_NegoStatus}

  PSecPkgContext_Sizes = ^SecPkgContext_Sizes;
  {$EXTERNALSYM PSecPkgContext_Sizes}
  SecPkgContext_Sizes = record
    cbMaxToken: ULONG;
    cbMaxSignature: ULONG;
    cbBlockSize: ULONG;
    cbSecurityTrailer: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_Sizes}

  PSecPkgContext_StreamSizes = ^SecPkgContext_StreamSizes;
  {$EXTERNALSYM PSecPkgContext_StreamSizes}
  SecPkgContext_StreamSizes = record
    cbHeader: ULONG;
    cbTrailer: ULONG;
    cbMaximumMessage: ULONG;
    cBuffers: ULONG;
    cbBlockSize: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_StreamSizes}

  PSecPkgContext_NamesW = ^SecPkgContext_NamesW;
  {$EXTERNALSYM PSecPkgContext_NamesW}
  SecPkgContext_NamesW = record
    sUserName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_NamesW}

  PSECPKG_ATTR_LCT_STATUS = ^SECPKG_ATTR_LCT_STATUS;
  {$EXTERNALSYM PSECPKG_ATTR_LCT_STATUS}
  SECPKG_ATTR_LCT_STATUS = (
    SecPkgAttrLastClientTokenYes,
    SecPkgAttrLastClientTokenNo,
    SecPkgAttrLastClientTokenMaybe
  );
  {$EXTERNALSYM SECPKG_ATTR_LCT_STATUS}

  PSecPkgContext_LastClientTokenStatus = ^SecPkgContext_LastClientTokenStatus;
  {$EXTERNALSYM PSecPkgContext_LastClientTokenStatus}
  SecPkgContext_LastClientTokenStatus = record
    LastClientTokenStatus: SECPKG_ATTR_LCT_STATUS;
  end;
  {$EXTERNALSYM SecPkgContext_LastClientTokenStatus}

  PSecPkgContext_NamesA = ^SecPkgContext_NamesA;
  {$EXTERNALSYM PSecPkgContext_NamesA}
  SecPkgContext_NamesA = record
    sUserName: PSEC_CHAR;
  end;
  {$EXTERNALSYM SecPkgContext_NamesA}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_Names = SecPkgContext_NamesW;
  PSecPkgContext_Names = PSecPkgContext_NamesW;
{$ELSE}
  SecPkgContext_Names = SecPkgContext_NamesA;
  PSecPkgContext_Names = PSecPkgContext_NamesA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_Names}
  {$EXTERNALSYM PSecPkgContext_Names}

  PSecPkgContext_Lifespan = ^SecPkgContext_Lifespan;
  {$EXTERNALSYM PSecPkgContext_Lifespan}
  SecPkgContext_Lifespan = record
    tsStart: TimeStamp;
    tsExpiry: TimeStamp;
  end;
  {$EXTERNALSYM SecPkgContext_Lifespan}

  PSecPkgContext_DceInfo = ^SecPkgContext_DceInfo;
  {$EXTERNALSYM PSecPkgContext_DceInfo}
  SecPkgContext_DceInfo = record
    AuthzSvc: ULONG;
    pPac: PVOID;
  end;
  {$EXTERNALSYM SecPkgContext_DceInfo}

  PSecPkgContext_KeyInfoA = ^SecPkgContext_KeyInfoA;
  {$EXTERNALSYM PSecPkgContext_KeyInfoA}
  SecPkgContext_KeyInfoA = record
    sSignatureAlgorithmName: PSEC_CHAR;
    sEncryptAlgorithmName: PSEC_CHAR;
    KeySize: ULONG;
    SignatureAlgorithm: ULONG;
    EncryptAlgorithm: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_KeyInfoA}

  PSecPkgContext_KeyInfoW = ^SecPkgContext_KeyInfoW;
  {$EXTERNALSYM PSecPkgContext_KeyInfoW}
  SecPkgContext_KeyInfoW = record
    sSignatureAlgorithmName: PSEC_WCHAR;
    sEncryptAlgorithmName: PSEC_WCHAR;
    KeySize: ULONG;
    SignatureAlgorithm: ULONG;
    EncryptAlgorithm: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_KeyInfoW}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_KeyInfo = SecPkgContext_KeyInfoW;
  PSecPkgContext_KeyInfo = PSecPkgContext_KeyInfoW;
{$ELSE}
  SecPkgContext_KeyInfo = SecPkgContext_KeyInfoA;
  PSecPkgContext_KeyInfo = PSecPkgContext_KeyInfoA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_KeyInfo}
  {$EXTERNALSYM PSecPkgContext_KeyInfo}

  PSecPkgContext_AuthorityA = ^SecPkgContext_AuthorityA;
  {$EXTERNALSYM PSecPkgContext_AuthorityA}
  SecPkgContext_AuthorityA = record
    sAuthorityName: PSEC_CHAR;
  end;
  {$EXTERNALSYM SecPkgContext_AuthorityA}

  PSecPkgContext_AuthorityW = ^SecPkgContext_AuthorityW;
  {$EXTERNALSYM PSecPkgContext_AuthorityW}
  SecPkgContext_AuthorityW = record
    sAuthorityName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_AuthorityW}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_Authority = SecPkgContext_AuthorityW;
  PSecPkgContext_Authority = PSecPkgContext_AuthorityW;
{$ELSE}
  SecPkgContext_Authority = SecPkgContext_AuthorityA;
  PSecPkgContext_Authority = PSecPkgContext_AuthorityA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_Authority}
  {$EXTERNALSYM PSecPkgContext_Authority}

  PSecPkgContext_ProtoInfoA = ^SecPkgContext_ProtoInfoA;
  {$EXTERNALSYM PSecPkgContext_ProtoInfoA}
  SecPkgContext_ProtoInfoA = record
    sProtocolName: PSEC_CHAR;
    majorVersion: ULONG;
    minorVersion: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_ProtoInfoA}

  PSecPkgContext_ProtoInfoW = ^SecPkgContext_ProtoInfoW;
  {$EXTERNALSYM PSecPkgContext_ProtoInfoW}
  SecPkgContext_ProtoInfoW = record
    sProtocolName: PSEC_WCHAR;
    majorVersion: ULONG;
    minorVersion: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_ProtoInfoW}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_ProtoInfo = SecPkgContext_ProtoInfoW;
  PSecPkgContext_ProtoInfo = PSecPkgContext_ProtoInfoW;
{$ELSE}
  SecPkgContext_ProtoInfo = SecPkgContext_ProtoInfoA;
  PSecPkgContext_ProtoInfo = PSecPkgContext_ProtoInfoA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_ProtoInfo}
  {$EXTERNALSYM PSecPkgContext_ProtoInfo}

  PSecPkgContext_PasswordExpiry = ^SecPkgContext_PasswordExpiry;
  {$EXTERNALSYM PSecPkgContext_PasswordExpiry}
  SecPkgContext_PasswordExpiry = record
    tsPasswordExpires: TimeStamp;
  end;
  {$EXTERNALSYM SecPkgContext_PasswordExpiry}

  PSecPkgContext_LogoffTime = ^SecPkgContext_LogoffTime;
  {$EXTERNALSYM PSecPkgContext_LogoffTime}
  SecPkgContext_LogoffTime = record
    tsLogoffTime: TimeStamp;
  end;
  {$EXTERNALSYM SecPkgContext_LogoffTime}

  PSecPkgContext_SessionKey = ^SecPkgContext_SessionKey;
  {$EXTERNALSYM PSecPkgContext_SessionKey}
  SecPkgContext_SessionKey = record
    SessionKeyLength: ULONG;
    SessionKey: PUCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_SessionKey}

  // used by nego2
  PSecPkgContext_NegoKeys = ^SecPkgContext_NegoKeys;
  {$EXTERNALSYM PSecPkgContext_NegoKeys}
  SecPkgContext_NegoKeys = record
    KeyType: ULONG;
    KeyLength: USHORT;
    KeyValue: PUCHAR;
    VerifyKeyType: ULONG;
    VerifyKeyLength: USHORT;
    VerifyKeyValue: PUCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_NegoKeys}

  PSecPkgContext_PackageInfoW = ^SecPkgContext_PackageInfoW;
  {$EXTERNALSYM PSecPkgContext_PackageInfoW}
  SecPkgContext_PackageInfoW = record
    PackageInfo: PSecPkgInfoW;
  end;
  {$EXTERNALSYM SecPkgContext_PackageInfoW}

  PSecPkgContext_PackageInfoA = ^SecPkgContext_PackageInfoA;
  {$EXTERNALSYM PSecPkgContext_PackageInfoA}
  SecPkgContext_PackageInfoA = record
    PackageInfo: PSecPkgInfoA;
  end;
  {$EXTERNALSYM SecPkgContext_PackageInfoA}

  PSecPkgContext_UserFlags = ^SecPkgContext_UserFlags;
  {$EXTERNALSYM PSecPkgContext_UserFlags}
  SecPkgContext_UserFlags = record
    UserFlags: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_UserFlags}

  PSecPkgContext_Flags = ^SecPkgContext_Flags;
  {$EXTERNALSYM PSecPkgContext_Flags}
  SecPkgContext_Flags = record
    Flags: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_Flags}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_PackageInfo = SecPkgContext_PackageInfoW;
  PSecPkgContext_PackageInfo = PSecPkgContext_PackageInfoW;
{$ELSE}
  SecPkgContext_PackageInfo = SecPkgContext_PackageInfoA;
  PSecPkgContext_PackageInfo = PSecPkgContext_PackageInfoA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_PackageInfo}
  {$EXTERNALSYM PSecPkgContext_PackageInfo}

  PSecPkgContext_NegotiationInfoA = ^SecPkgContext_NegotiationInfoA;
  {$EXTERNALSYM PSecPkgContext_NegotiationInfoA}
  SecPkgContext_NegotiationInfoA = record
    PackageInfo: PSecPkgInfoA;
    NegotiationState: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_NegotiationInfoA}

  PSecPkgContext_NegotiationInfoW = ^SecPkgContext_NegotiationInfoW;
  {$EXTERNALSYM PSecPkgContext_NegotiationInfoW}
  SecPkgContext_NegotiationInfoW = record
    PackageInfo: PSecPkgInfoW;
    NegotiationState: ULONG;
  end;
  {$EXTERNALSYM SecPkgContext_NegotiationInfoW}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_NegotiationInfo = SecPkgContext_NegotiationInfoW;
  PSecPkgContext_NegotiationInfo = PSecPkgContext_NegotiationInfoW;
{$ELSE}
  SecPkgContext_NegotiationInfo = SecPkgContext_NegotiationInfoA;
  PSecPkgContext_NegotiationInfo = PSecPkgContext_NegotiationInfoA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_NegotiationInfo}
  {$EXTERNALSYM PSecPkgContext_NegotiationInfo}

const

  SECPKG_NEGOTIATION_COMPLETE     = 0;
  {$EXTERNALSYM SECPKG_NEGOTIATION_COMPLETE}
  SECPKG_NEGOTIATION_OPTIMISTIC   = 1;
  {$EXTERNALSYM SECPKG_NEGOTIATION_OPTIMISTIC}
  SECPKG_NEGOTIATION_IN_PROGRESS  = 2;
  {$EXTERNALSYM SECPKG_NEGOTIATION_IN_PROGRESS}
  SECPKG_NEGOTIATION_DIRECT       = 3;
  {$EXTERNALSYM SECPKG_NEGOTIATION_DIRECT}
  SECPKG_NEGOTIATION_TRY_MULTICRED = 4;
  {$EXTERNALSYM SECPKG_NEGOTIATION_TRY_MULTICRED}

type

  PSecPkgContext_NativeNamesW = ^SecPkgContext_NativeNamesW;
  {$EXTERNALSYM PSecPkgContext_NativeNamesW}
  SecPkgContext_NativeNamesW = record
    sClientName: PSEC_WCHAR;
    sServerName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_NativeNamesW}

  PSecPkgContext_NativeNamesA = ^SecPkgContext_NativeNamesA;
  {$EXTERNALSYM PSecPkgContext_NativeNamesA}
  SecPkgContext_NativeNamesA = record
    sClientName: PSEC_CHAR;
    sServerName: PSEC_CHAR;
  end;
  {$EXTERNALSYM SecPkgContext_NativeNamesA}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_NativeNames = SecPkgContext_NativeNamesW;
  PSecPkgContext_NativeNames = PSecPkgContext_NativeNamesW;
{$ELSE}
  SecPkgContext_NativeNames = SecPkgContext_NativeNamesA;
  PSecPkgContext_NativeNames = PSecPkgContext_NativeNamesA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_NativeNames}
  {$EXTERNALSYM PSecPkgContext_NativeNames}

  PSecPkgContext_CredentialNameW = ^SecPkgContext_CredentialNameW;
  {$EXTERNALSYM PSecPkgContext_CredentialNameW}
  SecPkgContext_CredentialNameW = record
    CredentialType: ULONG;
    sCredentialName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_CredentialNameW}

  PSecPkgContext_CredentialNameA = ^SecPkgContext_CredentialNameA;
  {$EXTERNALSYM PSecPkgContext_CredentialNameA}
  SecPkgContext_CredentialNameA = record
    CredentialType: ULONG;
    sCredentialName: PSEC_CHAR;
  end;
  {$EXTERNALSYM SecPkgContext_CredentialNameA}

{$IFDEF SSPI_UNICODE}
  SecPkgContext_CredentialName = SecPkgContext_CredentialNameW;
  PSecPkgContext_CredentialName = PSecPkgContext_CredentialNameW;
{$ELSE}
  SecPkgContext_CredentialName = SecPkgContext_CredentialNameA;
  PSecPkgContext_CredentialName = PSecPkgContext_CredentialNameA;
{$ENDIF}
  {$EXTERNALSYM SecPkgContext_CredentialName}
  {$EXTERNALSYM PSecPkgContext_CredentialName}

  PSecPkgContext_AccessToken = ^SecPkgContext_AccessToken;
  {$EXTERNALSYM PSecPkgContext_AccessToken}
  SecPkgContext_AccessToken = record
    AccessToken: PVOID;
  end;
  {$EXTERNALSYM SecPkgContext_AccessToken}

  PSecPkgContext_TargetInformation = ^SecPkgContext_TargetInformation;
  {$EXTERNALSYM PSecPkgContext_TargetInformation}
  SecPkgContext_TargetInformation = record
    MarshalledTargetInfoLength: ULONG;
    MarshalledTargetInfo: PUCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_TargetInformation}

  PSecPkgContext_AuthzID = ^SecPkgContext_AuthzID;
  {$EXTERNALSYM PSecPkgContext_AuthzID}
  SecPkgContext_AuthzID = record
    AuthzIDLength: ULONG;
    AuthzID: PAnsiChar;
  end;
  {$EXTERNALSYM SecPkgContext_AuthzID}

  PSecPkgContext_Target = ^SecPkgContext_Target;
  {$EXTERNALSYM PSecPkgContext_Target}
  SecPkgContext_Target = record
    TargetLength: ULONG;
    Target: PAnsiChar;
  end;
  {$EXTERNALSYM SecPkgContext_Target}

  PSecPkgContext_ClientSpecifiedTarget = ^SecPkgContext_ClientSpecifiedTarget;
  {$EXTERNALSYM PSecPkgContext_ClientSpecifiedTarget}
  SecPkgContext_ClientSpecifiedTarget = record
    sTargetName: PSEC_WCHAR;
  end;
  {$EXTERNALSYM SecPkgContext_ClientSpecifiedTarget}

  PSecPkgContext_Bindings = ^SecPkgContext_Bindings;
  {$EXTERNALSYM PSecPkgContext_Bindings}
  SecPkgContext_Bindings = record
    BindingsLength: ULONG;
    Bindings: PSEC_CHANNEL_BINDINGS;
  end;
  {$EXTERNALSYM SecPkgContext_Bindings}

  SEC_GET_KEY_FN = procedure(
    Arg: PVOID;                   // Argument passed in
    Principal: PVOID;             // Principal ID
    KeyVer: ULONG;                // Key Version
    Key: PPVOID;               // Returned ptr to key
    Status: PSECURITY_STATUS   // returned status
  ); stdcall;
  {$EXTERNALSYM SEC_GET_KEY_FN}

//
// Flags for ExportSecurityContext
//

const

  SECPKG_CONTEXT_EXPORT_RESET_NEW   = $00000001;  // New context is reset to initial state
  {$EXTERNALSYM SECPKG_CONTEXT_EXPORT_RESET_NEW}
  SECPKG_CONTEXT_EXPORT_DELETE_OLD  = $00000002;  // Old context is deleted during export
  {$EXTERNALSYM SECPKG_CONTEXT_EXPORT_DELETE_OLD}
  // This is only valid in W2K3SP1 and greater
  SECPKG_CONTEXT_EXPORT_TO_KERNEL   = $00000004;      // Context is to be transferred to the kernel
  {$EXTERNALSYM SECPKG_CONTEXT_EXPORT_TO_KERNEL}


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
  {$EXTERNALSYM ACQUIRE_CREDENTIALS_HANDLE_FN_W}

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
  {$EXTERNALSYM ACQUIRE_CREDENTIALS_HANDLE_FN_A}

{$IFDEF SSPI_UNICODE}
  ACQUIRE_CREDENTIALS_HANDLE_FN = ACQUIRE_CREDENTIALS_HANDLE_FN_W;
{$ELSE}
  ACQUIRE_CREDENTIALS_HANDLE_FN = ACQUIRE_CREDENTIALS_HANDLE_FN_A;
{$ENDIF}
  {$EXTERNALSYM ACQUIRE_CREDENTIALS_HANDLE_FN}

  FREE_CREDENTIALS_HANDLE_FN = function( // FreeCredentialsHandle
    phCredential: PCredHandle            // Handle to free
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM FREE_CREDENTIALS_HANDLE_FN}

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
  {$EXTERNALSYM ADD_CREDENTIALS_FN_W}

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
  {$EXTERNALSYM ADD_CREDENTIALS_FN_A}

{$IFDEF SSPI_UNICODE}
  ADD_CREDENTIALS_FN = ADD_CREDENTIALS_FN_W;
{$ELSE}
  ADD_CREDENTIALS_FN = ADD_CREDENTIALS_FN_A;
{$ENDIF}
  {$EXTERNALSYM ADD_CREDENTIALS_FN}

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
/// Password Change Functions
///
////////////////////////////////////////////////////////////////////////

  CHANGE_PASSWORD_FN_W = function( // ChangeAccountPasswordW
    pszPackageName: PSEC_WCHAR;
    pszDomainName: PSEC_WCHAR;
    pszAccountName: PSEC_WCHAR;
    pszOldPassword: PSEC_WCHAR;
    pszNewPassword: PSEC_WCHAR;
    bImpersonating: BOOLEAN;
    dwReserved: ULONG;
    pOutput: PSecBufferDesc
    ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM CHANGE_PASSWORD_FN_W}

  CHANGE_PASSWORD_FN_A = function( // ChangeAccountPasswordA
    pszPackageName: PSEC_CHAR;
    pszDomainName: PSEC_CHAR;
    pszAccountName: PSEC_CHAR;
    pszOldPassword: PSEC_CHAR;
    pszNewPassword: PSEC_CHAR;
    bImpersonating: BOOLEAN;
    dwReserved: ULONG;
    pOutput: PSecBufferDesc
    ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM CHANGE_PASSWORD_FN_A}

{$IFDEF SSPI_UNICODE}
  CHANGE_PASSWORD_FN = CHANGE_PASSWORD_FN_W;
{$ELSE}
  CHANGE_PASSWORD_FN = CHANGE_PASSWORD_FN_A;
{$ENDIF}
  {$EXTERNALSYM CHANGE_PASSWORD_FN}

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
  {$EXTERNALSYM INITIALIZE_SECURITY_CONTEXT_FN_W}

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
  {$EXTERNALSYM INITIALIZE_SECURITY_CONTEXT_FN_A}

{$IFDEF SSPI_UNICODE}
  INITIALIZE_SECURITY_CONTEXT_FN = INITIALIZE_SECURITY_CONTEXT_FN_W;
{$ELSE}
  INITIALIZE_SECURITY_CONTEXT_FN = INITIALIZE_SECURITY_CONTEXT_FN_A;
{$ENDIF}
  {$EXTERNALSYM INITIALIZE_SECURITY_CONTEXT_FN}

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
  {$EXTERNALSYM ACCEPT_SECURITY_CONTEXT_FN}

  COMPLETE_AUTH_TOKEN_FN = function( // CompleteAuthToken
    phContext: PCtxtHandle;     // Context to complete
    pToken: PSecBufferDesc      // Token to complete
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM COMPLETE_AUTH_TOKEN_FN}

  IMPERSONATE_SECURITY_CONTEXT_FN = function( // ImpersonateSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM IMPERSONATE_SECURITY_CONTEXT_FN}

  REVERT_SECURITY_CONTEXT_FN = function( // RevertSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM REVERT_SECURITY_CONTEXT_FN}

  QUERY_SECURITY_CONTEXT_TOKEN_FN = function( // QuerySecurityContextToken
    phContext: PCtxtHandle;
    Token: PPVOID
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_SECURITY_CONTEXT_TOKEN_FN}

  DELETE_SECURITY_CONTEXT_FN = function( // DeleteSecurityContext
    phContext: PCtxtHandle
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM DELETE_SECURITY_CONTEXT_FN}

  APPLY_CONTROL_TOKEN_FN = function( // ApplyControlToken
    phContext: PCtxtHandle;     // Context to modify
    pInput: PSecBufferDesc      // Input token to apply
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM APPLY_CONTROL_TOKEN_FN}

  QUERY_CONTEXT_ATTRIBUTES_FN_W = function( // QueryContextAttributesW
    phContext: PCtxtHandle;     // Context to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_CONTEXT_ATTRIBUTES_FN_W}

  QUERY_CONTEXT_ATTRIBUTES_FN_A = function( // QueryContextAttributesA
    phContext: PCtxtHandle;     // Context to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_CONTEXT_ATTRIBUTES_FN_A}

{$IFDEF SSPI_UNICODE}
  QUERY_CONTEXT_ATTRIBUTES_FN = QUERY_CONTEXT_ATTRIBUTES_FN_W;
{$ELSE}
  QUERY_CONTEXT_ATTRIBUTES_FN = QUERY_CONTEXT_ATTRIBUTES_FN_A;
{$ENDIF}
  {$EXTERNALSYM QUERY_CONTEXT_ATTRIBUTES_FN}

  SET_CONTEXT_ATTRIBUTES_FN_W = function( // SetContextAttributesW
    phContext: PCtxtHandle;     // Context to Set
    ulAttribute: ULONG;         // Attribute to Set
    pBuffer: PVOID;             // Buffer for attributes
    cbBuffer: ULONG             // Size (in bytes) of Buffer
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM SET_CONTEXT_ATTRIBUTES_FN_W}

  SET_CONTEXT_ATTRIBUTES_FN_A = function( // SetContextAttributesA
    phContext: PCtxtHandle;     // Context to Set
    ulAttribute: ULONG;         // Attribute to Set
    pBuffer: PVOID;             // Buffer for attributes
    cbBuffer: ULONG             // Size (in bytes) of Buffer
    ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM SET_CONTEXT_ATTRIBUTES_FN_A}

  QUERY_CREDENTIALS_ATTRIBUTES_FN_W = function( // QueryCredentialsAttributesW
    phCredential: PCredHandle;  // Credential to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_CREDENTIALS_ATTRIBUTES_FN_W}

  QUERY_CREDENTIALS_ATTRIBUTES_FN_A = function( // QueryCredentialsAttributesA
    phCredential: PCredHandle;  // Credential to query
    ulAttribute: ULONG;         // Attribute to query
    pBuffer: PVOID              // Buffer for attributes
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_CREDENTIALS_ATTRIBUTES_FN_A}

{$IFDEF SSPI_UNICODE}
  QUERY_CREDENTIALS_ATTRIBUTES_FN = QUERY_CREDENTIALS_ATTRIBUTES_FN_W;
{$ELSE}
  QUERY_CREDENTIALS_ATTRIBUTES_FN = QUERY_CREDENTIALS_ATTRIBUTES_FN_A;
{$ENDIF}
  {$EXTERNALSYM QUERY_CREDENTIALS_ATTRIBUTES_FN}

  SET_CREDENTIALS_ATTRIBUTES_FN_W = function( // SetCredentialsAttributesW
    phCredential: PCredHandle;  // Credential to Set
    ulAttribute: ULONG;         // Attribute to Set
    pBuffer: PVOID;             // Buffer for attributes
    cbBuffer: ULONG             // Size (in bytes) of Buffer
    ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM SET_CREDENTIALS_ATTRIBUTES_FN_W}

  SET_CREDENTIALS_ATTRIBUTES_FN_A = function( // SetCredentialsAttributesA
    phCredential: PCredHandle;  // Credential to Set
    ulAttribute: ULONG;         // Attribute to Set
    pBuffer: PVOID;             // Buffer for attributes
    cbBuffer: ULONG             // Size (in bytes) of Buffer
    ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM SET_CREDENTIALS_ATTRIBUTES_FN_A}

  FREE_CONTEXT_BUFFER_FN = function( // FreeContextBuffer
    pvContextBuffer: PVOID      // buffer to free
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM FREE_CONTEXT_BUFFER_FN}

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
  {$EXTERNALSYM MAKE_SIGNATURE_FN}

  VERIFY_SIGNATURE_FN = function( // VerifySignature
    phContext: PCtxtHandle;     // Context to use
    pMessage: PSecBufferDesc;   // Message to verify
    MessageSeqNo: ULONG;        // Sequence Num.
    pfQOP: PULONG               // QOP used
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM VERIFY_SIGNATURE_FN}

  ENCRYPT_MESSAGE_FN = function( // EncryptMessage
    phContext: PCtxtHandle;
    fQOP: ULONG;
    pMessage: PSecBufferDesc;
    MessageSeqNo: ULONG
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM ENCRYPT_MESSAGE_FN}

  DECRYPT_MESSAGE_FN = function( // DecryptMessage
    phContext: PCtxtHandle;
    pMessage: PSecBufferDesc;
    MessageSeqNo: ULONG;
    pfQOP: PULONG
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM DECRYPT_MESSAGE_FN}

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
  {$EXTERNALSYM ENUMERATE_SECURITY_PACKAGES_FN_W}

  ENUMERATE_SECURITY_PACKAGES_FN_A = function( // EnumerateSecurityPackagesA
    pcPackages: PULONG;         // Receives num. packages
    ppPackageInfo: PPSecPkgInfoA // Receives array of info
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM ENUMERATE_SECURITY_PACKAGES_FN_A}

{$IFDEF SSPI_UNICODE}
  ENUMERATE_SECURITY_PACKAGES_FN = ENUMERATE_SECURITY_PACKAGES_FN_W;
{$ELSE}
  ENUMERATE_SECURITY_PACKAGES_FN = ENUMERATE_SECURITY_PACKAGES_FN_A;
{$ENDIF}
  {$EXTERNALSYM ENUMERATE_SECURITY_PACKAGES_FN}

  QUERY_SECURITY_PACKAGE_INFO_FN_W = function( // QuerySecurityPackageInfoW
    pszPackageName: PSEC_WCHAR; // Name of package
    ppPackageInfo: PPSecPkgInfoW // Receives package info
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_SECURITY_PACKAGE_INFO_FN_W}

  QUERY_SECURITY_PACKAGE_INFO_FN_A = function( // QuerySecurityPackageInfoA
    pszPackageName: PSEC_CHAR; // Name of package
    ppPackageInfo: PPSecPkgInfoA // Receives package info
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM QUERY_SECURITY_PACKAGE_INFO_FN_A}

{$IFDEF SSPI_UNICODE}
  QUERY_SECURITY_PACKAGE_INFO_FN = QUERY_SECURITY_PACKAGE_INFO_FN_W;
{$ELSE}
  QUERY_SECURITY_PACKAGE_INFO_FN = QUERY_SECURITY_PACKAGE_INFO_FN_A;
{$ENDIF}
  {$EXTERNALSYM QUERY_SECURITY_PACKAGE_INFO_FN}

  PSecDelegationType = ^SecDelegationType;
  {$EXTERNALSYM PSecDelegationType}
  SecDelegationType = (
    SecFull,
    SecService,
    SecTree,
    SecDirectory,
    SecObject
  );
  {$EXTERNALSYM SecDelegationType}

  DELEGATE_SECURITY_CONTEXT_FN = function( // DelegateSecurityContext
    phContext: PCtxtHandle;     // IN Active context to delegate
    pszTarget: PSEC_CHAR;
    DelegationType: SecDelegationType; // IN Type of delegation
    pExpiry: PTimeStamp;        // IN OPTIONAL time limit
    pPackageParameters: PSecBuffer; // IN OPTIONAL package specific
    pOutput: PSecBufferDesc     // OUT Token for applycontroltoken.
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM DELEGATE_SECURITY_CONTEXT_FN}

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
  {$EXTERNALSYM EXPORT_SECURITY_CONTEXT_FN}

  IMPORT_SECURITY_CONTEXT_FN_W = function( // ImportSecurityContextW
    pszPackage: PSEC_WCHAR;
    pPackedContext: PSecBuffer; // (in) marshalled context
    Token: PVOID;               // (in, optional) handle to token for context
    phContext: PCtxtHandle      // (out) new context handle
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM IMPORT_SECURITY_CONTEXT_FN_W}

  IMPORT_SECURITY_CONTEXT_FN_A = function( // ImportSecurityContextA
    pszPackage: PSEC_CHAR;
    pPackedContext: PSecBuffer; // (in) marshalled context
    Token: PVOID;               // (in, optional) handle to token for context
    phContext: PCtxtHandle      // (out) new context handle
  ): SECURITY_STATUS; stdcall;
  {$EXTERNALSYM IMPORT_SECURITY_CONTEXT_FN_A}

{$IFDEF SSPI_UNICODE}
  IMPORT_SECURITY_CONTEXT_FN = IMPORT_SECURITY_CONTEXT_FN_W;
{$ELSE}
  IMPORT_SECURITY_CONTEXT_FN = IMPORT_SECURITY_CONTEXT_FN_A;
{$ENDIF}
  {$EXTERNALSYM IMPORT_SECURITY_CONTEXT_FN}

///////////////////////////////////////////////////////////////////////////////
////
////  Fast access for RPC:
////
///////////////////////////////////////////////////////////////////////////////

const

  SECURITY_ENTRYPOINT_ANSIW  = 'InitSecurityInterfaceW';    {Do not Localize}
  {$EXTERNALSYM SECURITY_ENTRYPOINT_ANSIW}
  SECURITY_ENTRYPOINT_ANSIA  = 'InitSecurityInterfaceA';    {Do not Localize}
  {$EXTERNALSYM SECURITY_ENTRYPOINT_ANSIA}
  SECURITY_ENTRYPOINTW       = 'InitSecurityInterfaceW';    {Do not Localize}
  {$EXTERNALSYM SECURITY_ENTRYPOINTW}
  SECURITY_ENTRYPOINTA       = 'InitSecurityInterfaceA';    {Do not Localize}
  {$EXTERNALSYM SECURITY_ENTRYPOINTA}
  SECURITY_ENTRYPOINT16      = 'INITSECURITYINTERFACEA';    {Do not Localize}
  {$EXTERNALSYM SECURITY_ENTRYPOINT16}

{$IFDEF SSPI_UNICODE}
  SECURITY_ENTRYPOINT = SECURITY_ENTRYPOINTW;
  SECURITY_ENTRYPOINT_ANSI = SECURITY_ENTRYPOINTW;
{$ELSE}
  SECURITY_ENTRYPOINT = SECURITY_ENTRYPOINTA;
  SECURITY_ENTRYPOINT_ANSI = SECURITY_ENTRYPOINTA;
{$ENDIF}
  {$EXTERNALSYM SECURITY_ENTRYPOINT}
  {$EXTERNALSYM SECURITY_ENTRYPOINT_ANSI}

type

  PSecurityFunctionTableW = ^SecurityFunctionTableW;
  {$EXTERNALSYM PSecurityFunctionTableW}
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
    // Fields below this are available in OSes after w2k
    SetContextAttributesW: SET_CONTEXT_ATTRIBUTES_FN_W;
    // Fields below this are available in OSes after W2k3SP1
    SetCredentialsAttributesW: SET_CREDENTIALS_ATTRIBUTES_FN_W;
    ChangeAccountPasswordW: CHANGE_PASSWORD_FN_W;
  end;
  {$EXTERNALSYM SecurityFunctionTableW}

  PSecurityFunctionTableA = ^SecurityFunctionTableA;
  {$EXTERNALSYM PSecurityFunctionTableA}
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
    SetContextAttributesA: SET_CONTEXT_ATTRIBUTES_FN_A;
    SetCredentialsAttributesA: SET_CREDENTIALS_ATTRIBUTES_FN_A;
    ChangeAccountPasswordA: CHANGE_PASSWORD_FN_A;
  end;
  {$EXTERNALSYM SecurityFunctionTableA}

{$IFDEF SSPI_UNICODE}
  SecurityFunctionTable = SecurityFunctionTableW;
  PSecurityFunctionTable = PSecurityFunctionTableW;
{$ELSE}
  SecurityFunctionTable = SecurityFunctionTableA;
  PSecurityFunctionTable = PSecurityFunctionTableA;
{$ENDIF}
  {$EXTERNALSYM SecurityFunctionTable}
  {$EXTERNALSYM PSecurityFunctionTable}

const

  // Function table has all routines through DecryptMessage
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION = 1;
  {$EXTERNALSYM SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION}

  // Function table has all routines through SetContextAttributes
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_2 = 2;
  {$EXTERNALSYM SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_2}

  // Function table has all routines through SetCredentialsAttributes
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_3 = 3;
  {$EXTERNALSYM SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_3}

  // Function table has all routines through ChangeAccountPassword
  SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_4 = 4;
  {$EXTERNALSYM SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_4}

type

  INIT_SECURITY_INTERFACE_A = function // InitSecurityInterfaceA
  : PSecurityFunctionTableA; stdcall;
  {$EXTERNALSYM INIT_SECURITY_INTERFACE_A}

  INIT_SECURITY_INTERFACE_W = function // InitSecurityInterfaceW
  : PSecurityFunctionTableW; stdcall;
  {$EXTERNALSYM INIT_SECURITY_INTERFACE_W}

{$IFDEF SSPI_UNICODE}
  INIT_SECURITY_INTERFACE = INIT_SECURITY_INTERFACE_W;
{$ELSE}
  INIT_SECURITY_INTERFACE = INIT_SECURITY_INTERFACE_A;
{$ENDIF}
  {$EXTERNALSYM INIT_SECURITY_INTERFACE}


(* TODO

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

#define SASL_OPTION_SEND_SIZE       1       // Maximum size to send to peer
#define SASL_OPTION_RECV_SIZE       2       // Maximum size willing to receive
#define SASL_OPTION_AUTHZ_STRING    3       // Authorization string
#define SASL_OPTION_AUTHZ_PROCESSING    4       // Authorization string processing

typedef enum _SASL_AUTHZID_STATE {
    Sasl_AuthZIDForbidden,             // allow no AuthZID strings to be specified - error out (default)
    Sasl_AuthZIDProcessed             // AuthZID Strings processed by Application or SSP
} SASL_AUTHZID_STATE ;

SECURITY_STATUS
SEC_ENTRY
SaslSetContextOption(
    __in PCtxtHandle ContextHandle,
    __in ULONG Option,
    __in PVOID Value,
    __in ULONG Size
    );


SECURITY_STATUS
SEC_ENTRY
SaslGetContextOption(
    __in      PCtxtHandle ContextHandle,
    __in      ULONG Option,
    __out     PVOID Value,
    __in      ULONG Size,
    __out_opt PULONG Needed OPTIONAL
    );

*)

//
// This is the legacy credentials structure.
// The EX version below is preferred.

const

  SEC_WINNT_AUTH_IDENTITY_VERSION_2 = $201;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_VERSION_2}

type

  PSEC_WINNT_AUTH_IDENTITY_EX2 = ^SEC_WINNT_AUTH_IDENTITY_EX2;
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY_EX2}
  SEC_WINNT_AUTH_IDENTITY_EX2 = record
    Version: ULONG;                           // contains SEC_WINNT_AUTH_IDENTITY_VERSION_2
    cbHeaderLength: USHORT;
    cbStructureLength: ULONG;
    UserOffset: ULONG;                        // Non-NULL terminated string, unicode only
    UserLength: USHORT;                       // # of bytes (NOT WCHARs), not including NULL.
    DomainOffset: ULONG;                      // Non-NULL terminated string, unicode only
    DomainLength: USHORT;                     // # of bytes (NOT WCHARs), not including NULL.
    PackedCredentialsOffset: ULONG;           // Non-NULL terminated string, unicode only
    PackedCredentialsLength: USHORT;          // # of bytes (NOT WCHARs), not including NULL.
    Flags: ULONG;
    PackageListOffset: ULONG;                 // Non-NULL terminated string, unicode only
    PackageListLength: USHORT;
  end;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_EX2}

//
// This was not defined in NTIFS.h for windows 2000 however
// this struct has always been there and are safe to use
// in windows 2000 and above.
//

const

  SEC_WINNT_AUTH_IDENTITY_ANSI = $1;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_ANSI}
  SEC_WINNT_AUTH_IDENTITY_UNICODE = $2;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_UNICODE}

type

  PSEC_WINNT_AUTH_IDENTITY_W = ^SEC_WINNT_AUTH_IDENTITY_W;
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY_W}
  SEC_WINNT_AUTH_IDENTITY_W = record
    User: PUSHORT;                //  Non-NULL terminated string.
    UserLength: ULONG;            //  # of characters (NOT bytes), not including NULL.
    Domain: PUSHORT;              //  Non-NULL terminated string.
    DomainLength: ULONG;          //  # of characters (NOT bytes), not including NULL.
    Password: PUSHORT;            //  Non-NULL terminated string.
    PasswordLength: ULONG;        //  # of characters (NOT bytes), not including NULL.
    Flags: ULONG;
  end;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_W}

  PSEC_WINNT_AUTH_IDENTITY_A = ^SEC_WINNT_AUTH_IDENTITY_A;
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY_A}
  SEC_WINNT_AUTH_IDENTITY_A = record
    User: PUCHAR;                 //  Non-NULL terminated string.
    UserLength: ULONG;            //  # of characters (NOT bytes), not including NULL.
    Domain: PUCHAR;               //  Non-NULL terminated string.
    DomainLength: ULONG;          //  # of characters (NOT bytes), not including NULL.
    Password: PUCHAR;             //  Non-NULL terminated string.
    PasswordLength: ULONG;        //  # of characters (NOT bytes), not including NULL.
    Flags: ULONG;
  end;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_A}

{$IFDEF SSPI_UNICODE}
  SEC_WINNT_AUTH_IDENTITY = SEC_WINNT_AUTH_IDENTITY_W;
  PSEC_WINNT_AUTH_IDENTITY = PSEC_WINNT_AUTH_IDENTITY_W;
{$ELSE}
  SEC_WINNT_AUTH_IDENTITY = SEC_WINNT_AUTH_IDENTITY_A;
  PSEC_WINNT_AUTH_IDENTITY = PSEC_WINNT_AUTH_IDENTITY_A;
{$ENDIF}
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY}
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY}

//
// This is the combined authentication identity structure that may be
// used with the negotiate package, NTLM, Kerberos, or SCHANNEL
//

const

  SEC_WINNT_AUTH_IDENTITY_VERSION = $200;
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_VERSION}

type

  PSEC_WINNT_AUTH_IDENTITY_EXW = ^SEC_WINNT_AUTH_IDENTITY_EXW;
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY_EXW}
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
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_EXW}

  PSEC_WINNT_AUTH_IDENTITY_EXA = ^SEC_WINNT_AUTH_IDENTITY_EXA;
  {$EXTERNALSYM PSEC_WINNT_AUTH_IDENTITY_EXA}
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
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_EXA}

{$IFDEF SSPI_UNICODE}
  SEC_WINNT_AUTH_IDENTITY_EX = SEC_WINNT_AUTH_IDENTITY_EXW;
{$ELSE}
  SEC_WINNT_AUTH_IDENTITY_EX = SEC_WINNT_AUTH_IDENTITY_EXA;
{$ENDIF}
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_EX}

(* TODO

//
// the procedure for how to parse a SEC_WINNT_AUTH_IDENTITY_INFO structure:
//
// 1) First check the first DWORD of SEC_WINNT_AUTH_IDENTITY_INFO, if the first
//   DWORD is 0x200, it is either an AuthIdExw or AuthIdExA, otherwise if the first
//   DWORD is 0x201, the structure is an AuthIdEx2 structure. Otherwise the structure
//   is either an AuthId_a or an AuthId_w.
//
// 2) Secondly check the flags for SEC_WINNT_AUTH_IDENTITY_ANSI or
//   SEC_WINNT_AUTH_IDENTITY_UNICODE, the presence of the former means the structure
//   is an ANSI structure. Otherwise, the structure is the wide version.  Note that
//   AuthIdEx2 does not have an ANSI version so this check does not apply to it.
//

typedef union _SEC_WINNT_AUTH_IDENTITY_INFO {
    SEC_WINNT_AUTH_IDENTITY_EXW AuthIdExw;
    SEC_WINNT_AUTH_IDENTITY_EXA AuthIdExa;
    SEC_WINNT_AUTH_IDENTITY_A AuthId_a;
    SEC_WINNT_AUTH_IDENTITY_W AuthId_w;
    SEC_WINNT_AUTH_IDENTITY_EX2 AuthIdEx2;
} SEC_WINNT_AUTH_IDENTITY_INFO, *PSEC_WINNT_AUTH_IDENTITY_INFO;

// the credential structure is encrypted via
// RtlEncryptMemory(OptionFlags = 0)
#define SEC_WINNT_AUTH_IDENTITY_FLAGS_PROCESS_ENCRYPTED 0x10

// the credential structure is protected by local system via
// RtlEncryptMemory(OptionFlags =
// IOCTL_KSEC_ENCRYPT_MEMORY_SAME_LOGON)
#define SEC_WINNT_AUTH_IDENTITY_FLAGS_SYSTEM_PROTECTED  0x20

#define SEC_WINNT_AUTH_IDENTITY_FLAGS_RESERVED       0x10000
#define SEC_WINNT_AUTH_IDENTITY_FLAGS_NULL_USER      0x20000
#define SEC_WINNT_AUTH_IDENTITY_FLAGS_NULL_DOMAIN    0x40000

//
//  These bits are for communication between SspiPromptForCredentials()
//  and the credential providers. Do not use these bits for any other
//  purpose.
//

#define SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_USE_MASK  0xFF000000

//
//  Instructs the credential provider to not save credentials itself
//  when caller selects the "Remember my credential" checkbox.
//

#define SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_BY_CALLER   0x80000000

//
//  State of the "Remember my credentials" checkbox.
//  When set, indicates checked; when cleared, indicates unchecked.
//

#define SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_CHECKED     0x40000000

#define SEC_WINNT_AUTH_IDENTITY_FLAGS_VALID_SSPIPFC_FLAGS   \
                (SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_BY_CALLER | \
                 SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_CHECKED)


#endif // _AUTH_IDENTITY_INFO_DEFINED

#ifndef _SSPIPFC_NONE_ // the public view

// begin_ntifs

typedef PVOID PSEC_WINNT_AUTH_IDENTITY_OPAQUE; // the credential structure is opaque

// end_ntifs

#else  // the internal view

typedef PSEC_WINNT_AUTH_IDENTITY_INFO PSEC_WINNT_AUTH_IDENTITY_OPAQUE;

#endif // _SSPIPFC_NONE_

//
//  dwFlags parameter of SspiPromptForCredentials():
//

//
//  Indicates that the credentials should not be saved if
//  the user selects the 'save' (or 'remember my password')
//  checkbox in the credential dialog box. The location pointed
//  to by the pfSave parameter indicates whether or not the user
//  selected the checkbox.
//
//  Note that some credential providers won't honour this flag and
//  may save the credentials in a persistent manner anyway if the
//  user selects the 'save' checbox.
//

#define SSPIPFC_SAVE_CRED_BY_CALLER     0x00000001

#define SSPIPFC_VALID_FLAGS (SSPIPFC_SAVE_CRED_BY_CALLER)

#ifndef _SSPIPFC_NONE_ // the public view

// Use SspiFreeAuthIdentity() to free the buffer returned
// in ppAuthIdentity.

unsigned long
SEC_ENTRY
SspiPromptForCredentialsW(
    __in PCWSTR pszTargetName,
#ifdef _CREDUI_INFO_DEFINED
    __in_opt PCREDUI_INFOW pUiInfo,
#else
    __in_opt PVOID pUiInfo,
#endif // _CREDUI_INFO_DEFINED
    __in unsigned long dwAuthError,
    __in PCWSTR pszPackage,
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE pInputAuthIdentity,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* ppAuthIdentity,
    __inout_opt int* pfSave,
    __in unsigned long dwFlags
    );

// Use SspiFreeAuthIdentity() to free the buffer returned
// in ppAuthIdentity.

unsigned long
SEC_ENTRY
SspiPromptForCredentialsA(
    __in PCSTR pszTargetName,
#ifdef _CREDUI_INFO_DEFINED
    __in_opt PCREDUI_INFOA pUiInfo,
#else
    __in_opt PVOID pUiInfo,
#endif // _CREDUI_INFO_DEFINED
    __in unsigned long dwAuthError,
    __in PCSTR pszPackage,
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE pInputAuthIdentity,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* ppAuthIdentity,
    __inout_opt int* pfSave,
    __in unsigned long dwFlags
    );
#endif // _SSPIPFC_NONE_

#ifdef UNICODE
#define SspiPromptForCredentials   SspiPromptForCredentialsW
#else
#define SspiPromptForCredentials   SspiPromptForCredentialsA
#endif

#ifdef _SEC_WINNT_AUTH_TYPES

typedef struct _SEC_WINNT_AUTH_BYTE_VECTOR {
    unsigned long ByteArrayOffset; // each element is a byte
    unsigned short ByteArrayLength; //
} SEC_WINNT_AUTH_BYTE_VECTOR, *PSEC_WINNT_AUTH_BYTE_VECTOR;

typedef struct _SEC_WINNT_AUTH_DATA {
   GUID CredType;
   SEC_WINNT_AUTH_BYTE_VECTOR CredData;
} SEC_WINNT_AUTH_DATA, *PSEC_WINNT_AUTH_DATA;

typedef struct _SEC_WINNT_AUTH_PACKED_CREDENTIALS {
   unsigned short cbHeaderLength;    // the length of the header
   unsigned short cbStructureLength; // pay load length including the header
   SEC_WINNT_AUTH_DATA AuthData;
} SEC_WINNT_AUTH_PACKED_CREDENTIALS, *PSEC_WINNT_AUTH_PACKED_CREDENTIALS;

// {28BFC32F-10F6-4738-98D1-1AC061DF716A}
static const GUID SEC_WINNT_AUTH_DATA_TYPE_PASSWORD =
   { 0x28bfc32f, 0x10f6, 0x4738, { 0x98, 0xd1, 0x1a, 0xc0, 0x61, 0xdf, 0x71, 0x6a } };

// {235F69AD-73FB-4dbc-8203-0629E739339B}
static const GUID SEC_WINNT_AUTH_DATA_TYPE_CERT =
   { 0x235f69ad, 0x73fb, 0x4dbc, { 0x82, 0x3, 0x6, 0x29, 0xe7, 0x39, 0x33, 0x9b } };

typedef struct _SEC_WINNT_AUTH_DATA_PASSWORD {
   SEC_WINNT_AUTH_BYTE_VECTOR UnicodePassword;
} SEC_WINNT_AUTH_DATA_PASSWORD, PSEC_WINNT_AUTH_DATA_PASSWORD;

//
// smartcard cred data
//
// {68FD9879-079C-4dfe-8281-578AADC1C100}

static const GUID SEC_WINNT_AUTH_DATA_TYPE_CSP_DATA =
   { 0x68fd9879, 0x79c, 0x4dfe, { 0x82, 0x81, 0x57, 0x8a, 0xad, 0xc1, 0xc1, 0x0 } };

typedef struct _SEC_WINNT_AUTH_CERTIFICATE_DATA {
   unsigned short cbHeaderLength;
   unsigned short cbStructureLength;
   SEC_WINNT_AUTH_BYTE_VECTOR Certificate;
} SEC_WINNT_AUTH_CERTIFICATE_DATA, *PSEC_WINNT_AUTH_CERTIFICATE_DATA;

typedef struct _SEC_WINNT_CREDUI_CONTEXT_VECTOR
{
   ULONG CredUIContextArrayOffset; // offset starts at the beginning of
   // this structure, and each element is a SEC_WINNT_AUTH_BYTE_VECTOR that
   // describes the flat CredUI context returned by SpGetCredUIContext()
   USHORT CredUIContextCount;
} SEC_WINNT_CREDUI_CONTEXT_VECTOR, *PSEC_WINNT_CREDUI_CONTEXT_VECTOR;

typedef struct _SEC_WINNT_AUTH_SHORT_VECTOR
{
    ULONG ShortArrayOffset; // each element is a short
    USHORT ShortArrayCount; // number of characters
} SEC_WINNT_AUTH_SHORT_VECTOR, *PSEC_WINNT_AUTH_SHORT_VECTOR;

// free the returned memory using SspiLocalFree

SECURITY_STATUS
SEC_ENTRY
SspiGetCredUIContext(
   __in HANDLE ContextHandle,
   __in GUID* CredType,
   __in_opt LUID* LogonId, // use this LogonId, the caller must be localsystem to supply a logon id
   __deref_out PSEC_WINNT_CREDUI_CONTEXT_VECTOR* CredUIContexts,
   __out_opt HANDLE* TokenHandle
   );

SECURITY_STATUS
SEC_ENTRY
SspiUpdateCredentials(
   __in HANDLE ContextHandle,
   __in GUID* CredType,
   __in ULONG FlatCredUIContextLength,
   __in_bcount(FlatCredUIContextLength) PUCHAR FlatCredUIContext
   );

typedef struct _CREDUIWIN_MARSHALED_CONTEXT
{
    GUID StructureType;
    USHORT cbHeaderLength;
    LUID LogonId; // user's logon id
    GUID MarshaledDataType;
    ULONG MarshaledDataOffset;
    USHORT MarshaledDataLength;
} CREDUIWIN_MARSHALED_CONTEXT, *PCREDUIWIN_MARSHALED_CONTEXT;

typedef struct _SEC_WINNT_CREDUI_CONTEXT
{
    USHORT cbHeaderLength;
    HANDLE CredUIContextHandle; // the handle to call SspiGetCredUIContext()
#ifdef _CREDUI_INFO_DEFINED
    PCREDUI_INFOW UIInfo; // input from SspiPromptForCredentials()
#else
    PVOID UIInfo;
#endif // _CREDUI_INFO_DEFINED
    ULONG dwAuthError; // the authentication error
    PSEC_WINNT_AUTH_IDENTITY_OPAQUE pInputAuthIdentity;
    PUNICODE_STRING TargetName;
} SEC_WINNT_CREDUI_CONTEXT, *PSEC_WINNT_CREDUI_CONTEXT;

// {3C3E93D9-D96B-49b5-94A7-458592088337}
static const GUID CREDUIWIN_STRUCTURE_TYPE_SSPIPFC  =
{ 0x3c3e93d9, 0xd96b, 0x49b5, { 0x94, 0xa7, 0x45, 0x85, 0x92, 0x8, 0x83, 0x37 } };

// {C2FFFE6F-503D-4c3d-A95E-BCE821213D44}
static const GUID SSPIPFC_STRUCTURE_TYPE_CREDUI_CONTEXT =
{ 0xc2fffe6f, 0x503d, 0x4c3d, { 0xa9, 0x5e, 0xbc, 0xe8, 0x21, 0x21, 0x3d, 0x44 } };

typedef struct _SEC_WINNT_AUTH_PACKED_CREDENTIALS_EX {
   unsigned short cbHeaderLength;
   unsigned long Flags; // contains the Flags field in
                        // SEC_WINNT_AUTH_IDENTITY_EX
   SEC_WINNT_AUTH_BYTE_VECTOR PackedCredentials;
   SEC_WINNT_AUTH_SHORT_VECTOR PackageList;
} SEC_WINNT_AUTH_PACKED_CREDENTIALS_EX, *PSEC_WINNT_AUTH_PACKED_CREDENTIALS_EX;

//
// free the returned memory using SspiLocalFree
//

SECURITY_STATUS
SEC_ENTRY
SspiUnmarshalCredUIContext(
    __in_bcount(MarshaledCredUIContextLength) PUCHAR MarshaledCredUIContext,
    __in ULONG MarshaledCredUIContextLength,
    __deref_out PSEC_WINNT_CREDUI_CONTEXT* CredUIContext
    );

#endif // _SEC_WINNT_AUTH_TYPES

SECURITY_STATUS
SEC_ENTRY
SspiPrepareForCredRead(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity,
    __in PCWSTR pszTargetName,
    __out PULONG pCredmanCredentialType,
    __deref_out PCWSTR* ppszCredmanTargetName
    );

SECURITY_STATUS
SEC_ENTRY
SspiPrepareForCredWrite(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity,
    __in_opt PCWSTR pszTargetName, // supply NULL for username-target credentials
    __out PULONG pCredmanCredentialType,
    __deref_out PCWSTR* ppszCredmanTargetName,
    __deref_out PCWSTR* ppszCredmanUserName,
    __deref_out_bcount(*pCredentialBlobSize) PUCHAR *ppCredentialBlob,
    __out PULONG pCredentialBlobSize
    );

SECURITY_STATUS
SEC_ENTRY
SspiEncryptAuthIdentity(
    __inout PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthData
    );

SECURITY_STATUS
SEC_ENTRY
SspiDecryptAuthIdentity(
    __inout PSEC_WINNT_AUTH_IDENTITY_OPAQUE EncryptedAuthData
    );

BOOLEAN
SEC_ENTRY
SspiIsAuthIdentityEncrypted(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE EncryptedAuthData
    );

// begin_ntifs

#if (NTDDI_VERSION >= NTDDI_WIN7)
//
//  Convert the _OPAQUE structure passed in to the
//  3 tuple <username, domainname, 'password'>.
//
//  Note: The 'strings' returned need not necessarily be
//  in user recognisable form. The purpose of this API
//  is to 'flatten' the _OPAQUE structure into the 3 tuple.
//  User recognisable <username, domainname> can always be
//  obtained by passing NULL to the pszPackedCredentialsString
//  parameter.
//
// zero out the pszPackedCredentialsString then
// free the returned memory using SspiLocalFree()
//

SECURITY_STATUS
SEC_ENTRY
SspiEncodeAuthIdentityAsStrings(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE pAuthIdentity,
    __deref_out_opt PCWSTR* ppszUserName,
    __deref_out_opt PCWSTR* ppszDomainName,
    __deref_opt_out_opt PCWSTR* ppszPackedCredentialsString
    );

SECURITY_STATUS
SEC_ENTRY
SspiValidateAuthIdentity(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthData
    );

//
// free the returned memory using SspiFreeAuthIdentity()
//

SECURITY_STATUS
SEC_ENTRY
SspiCopyAuthIdentity(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthData,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* AuthDataCopy
    );

//
// use only for the memory returned by SspiCopyAuthIdentity().
// Internally calls SspiZeroAuthIdentity().
//

VOID
SEC_ENTRY
SspiFreeAuthIdentity(
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthData
    );

VOID
SEC_ENTRY
SspiZeroAuthIdentity(
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthData
    );

VOID
SEC_ENTRY
SspiLocalFree(
    __in_opt PVOID DataBuffer
    );

//
// call SspiFreeAuthIdentity to free the returned AuthIdentity
// which zeroes out the credentials blob before freeing it
//

SECURITY_STATUS
SEC_ENTRY
SspiEncodeStringsAsAuthIdentity(
    __in_opt PCWSTR pszUserName,
    __in_opt PCWSTR pszDomainName,
    __in_opt PCWSTR pszPackedCredentialsString,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* ppAuthIdentity
    );

SECURITY_STATUS
SEC_ENTRY
SspiCompareAuthIdentities(
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity1,
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity2,
    __out_opt PBOOLEAN SameSuppliedUser,
    __out_opt PBOOLEAN SameSuppliedIdentity
    );

//
// zero out the returned AuthIdentityByteArray then
// free the returned memory using SspiLocalFree()
//

SECURITY_STATUS
SEC_ENTRY
SspiMarshalAuthIdentity(
    __in PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity,
    __out unsigned long* AuthIdentityLength,
    __deref_out_bcount(*AuthIdentityLength) char** AuthIdentityByteArray
    );

//
// free the returned auth identity using SspiFreeAuthIdentity()
//

SECURITY_STATUS
SEC_ENTRY
SspiUnmarshalAuthIdentity(
    __in unsigned long AuthIdentityLength,
    __in_bcount(AuthIdentityLength) char* AuthIdentityByteArray,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* ppAuthIdentity
    );

BOOLEAN
SEC_ENTRY
SspiIsPromptingNeeded(
    __in unsigned long ErrorOrNtStatus
    );

SECURITY_STATUS
SEC_ENTRY
SspiGetTargetHostName(
    __in PCWSTR pszTargetName,
    __deref_out PWSTR* pszHostName
    );

SECURITY_STATUS
SEC_ENTRY
SspiExcludePackage(
    __in_opt PSEC_WINNT_AUTH_IDENTITY_OPAQUE AuthIdentity,
    __in PCWSTR pszPackageName,
    __deref_out PSEC_WINNT_AUTH_IDENTITY_OPAQUE* ppNewAuthIdentity
    );

*)

//
// Common types used by negotiable security packages
//

const

  SEC_WINNT_AUTH_IDENTITY_MARSHALLED = $4;     // all data is in one buffer
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_MARSHALLED}
  SEC_WINNT_AUTH_IDENTITY_ONLY       = $8;     // these credentials are for identity only - no PAC needed
  {$EXTERNALSYM SEC_WINNT_AUTH_IDENTITY_ONLY}


(* TODO

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

implementation

procedure SecInvalidateHandle(var x: SecHandle);
begin
  x.dwLower := PtrUInt(-1);
  x.dwUpper := PtrUInt(-1);
end;

function SecIsValidHandle(x : SecHandle) : Boolean;
begin
  // RLebeau: workaround for a bug in D2009. Comparing PtrUInt values does not always work correctly.
  // Sometimes it causes "W1023 Comparing signed and unsigned types" warnings, other times it causes
  // "F2084 Internal Error: C12079" errors
  {$IFDEF VCL_2009}
  Result := (Integer(x.dwLower) <> Integer(PtrUInt(-1))) and
            (Integer(x.dwUpper) <> Integer(PtrUInt(-1)));
  {$ELSE}
  Result := (x.dwLower <> PtrUInt(-1)) and (x.dwUpper <> PtrUInt(-1));
  {$ENDIF}
end;

function SEC_SUCCESS(Status: SECURITY_STATUS): Boolean;
begin
  Result := Status >= 0;
end;

end.
