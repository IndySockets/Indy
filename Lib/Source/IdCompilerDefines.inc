{$IFDEF CONDITIONALEXPRESSIONS}
  // Must be at the top...
  {$IF CompilerVersion >= 24.0}
    {$LEGACYIFEND ON}
  {$IFEND}
{$ENDIF}

// General

// S.G. 4/9/2002: IPv4/IPv6 general switch (for defaults only)
{$DEFINE IdIPv4} // use IPv4 by default
{.$IFDEF IdIPv6} // use IPv6 by default

{$DEFINE INDY110}
{$DEFINE 11_0_0}  //so developers can IFDEF for this specific version

{$UNDEF USE_OPENSSL}
{$UNDEF STATICLOAD_OPENSSL}

{$UNDEF USE_ZLIB_UNIT}
{$UNDEF USE_SSPI}

// $DEFINE the following if the global objects in the IdStack and IdThread
// units should be freed on finalization
// TODO: can this be enabled by default now?
{.$DEFINE FREE_ON_FINAL}
{$UNDEF FREE_ON_FINAL}

// Make sure the following is $DEFINE'd only for suitable environments
// as specified further below.  This works in conjunction with the
// FREE_ON_FINAL define above.
{$UNDEF REGISTER_EXPECTED_MEMORY_LEAK}
{$UNDEF HAS_System_RegisterExpectedMemoryLeak}

// FastMM is natively available in BDS 2006 and higher.  $DEFINE the
// following if FastMM has been installed manually in earlier versions
{.$DEFINE USE_FASTMM4}
{$UNDEF USE_FASTMM4}

// $DEFINE the following if MadExcept has been installed manually in
// BDS 2005 or earlier (System.RegisterExpectedMemoryLeak() was introduced
// in BDS 2006)
{.$DEFINE USE_MADEXCEPT}
{$UNDEF USE_MADEXCEPT}

// $DEFINE the following if LeakCheck has been installed manually in
// BDS 2005 or earlier (System.RegisterExpectedMemoryLeak() was introduced
// in BDS 2006)
{.$DEFINE USE_LEAKCHECK}
{$UNDEF USE_LEAKCHECK}

// Make sure the following are $DEFINE'd only for Delphi/C++Builder 2009 onwards
// as specified further below.  The VCL is fully Unicode, where the 'String'
// type maps to System.UnicodeString, not System.AnsiString anymore
{$UNDEF STRING_IS_UNICODE}
{$UNDEF STRING_IS_ANSI}
{$UNDEF STRING_UNICODE_MISMATCH}

// Make sure the following are $DEFINE'd only for suitable environments
// as specified further below.  Delphi/C++Builder Mobile/NextGen compilers
// do not support Ansi data types anymore, and is moving away from raw
// pointers as well.
//
// UPDATE: in Delphi/C++Builder 10.4, all Ansi types are supported again on
// all platforms, including the mobile compilers.
{$DEFINE HAS_AnsiString}
{$DEFINE HAS_AnsiChar}
{$DEFINE HAS_PAnsiChar}
{$UNDEF HAS_PPAnsiChar}
{$UNDEF NO_ANSI_TYPES}

// Make sure the following are $DEFINE'd only for suitable environments
// as specified further below.  Delphi/C++Builder Mobile/NextGen compilers
// use ARC for TObject life time management.
//
// UPDATE: ARC for TObject lifetime management has been removed in
// Delphi/C++Builder 10.4 mobile compilers.  All platforms now use a single
// unified memory management model!
{$UNDEF USE_MARSHALLED_PTRS}
{$UNDEF HAS_MarshaledAString}
{$UNDEF USE_OBJECT_ARC}
{$UNDEF HAS_UNSAFE_OBJECT_REF}
{$UNDEF HAS_WEAK_OBJECT_REF}
{$UNDEF USE_OBJECT_REF_FREENOTIF}

// Make sure the following is $DEFINE'd only for suitable environments
// as specified further below.
{$UNDEF STRING_IS_IMMUTABLE}

// Make sure the following are $DEFINE'd only for suitable environments
// as specified further below.
{$UNDEF HAS_TEncoding}
{$UNDEF HAS_TEncoding_GetEncoding_ByEncodingName}
{$UNDEF HAS_TEncoding_EncodingName}
{$UNDEF HAS_TEncoding_CodePage}
{$UNDEF HAS_Exception_RaiseOuterException}
{$UNDEF HAS_System_ReturnAddress}
{$UNDEF HAS_TCharacter}
{$UNDEF HAS_TInterlocked}
{$UNDEF HAS_TNetEncoding}

// Make sure that this is defined only for environments where we are using
// the iconv library to charactor conversions.
{.$UNDEF USE_ICONV}
{.$UNDEF USE_LCONVENC}

//Define for Delphi cross-compiler targetting Posix
{$UNDEF USE_VCL_POSIX}
{$UNDEF HAS_ComponentPlatformsAttribute}
{$UNDEF HAS_ComponentPlatformsAttribute_Win32}
{$UNDEF HAS_ComponentPlatformsAttribute_Win64}
{$UNDEF HAS_ComponentPlatformsAttribute_OSX32}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Simulator}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Simulator32}
{$UNDEF HAS_ComponentPlatformsAttribute_Android}
{$UNDEF HAS_ComponentPlatformsAttribute_Android32Arm}
{$UNDEF HAS_ComponentPlatformsAttribute_Linux32}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Device}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Device32}
{$UNDEF HAS_ComponentPlatformsAttribute_Linux64}
{$UNDEF HAS_ComponentPlatformsAttribute_WinNX32}
{$UNDEF HAS_ComponentPlatformsAttribute_WinIoT32}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Device64}
{$UNDEF HAS_ComponentPlatformsAttribute_WinARM}
{$UNDEF HAS_ComponentPlatformsAttribute_WinARM32}
{$UNDEF HAS_ComponentPlatformsAttribute_OSX64}
{$UNDEF HAS_ComponentPlatformsAttribute_OSXNX64}
{$UNDEF HAS_ComponentPlatformsAttribute_Linux32Arm}
{$UNDEF HAS_ComponentPlatformsAttribute_Linux64Arm}
{$UNDEF HAS_ComponentPlatformsAttribute_Android64}
{$UNDEF HAS_ComponentPlatformsAttribute_Android64Arm}
{$UNDEF HAS_ComponentPlatformsAttribute_iOS_Simulator64}
{$UNDEF HAS_ComponentPlatformsAttribute_AndroidArm32}
{$UNDEF HAS_ComponentPlatformsAttribute_AndroidArm64}
{$UNDEF HAS_ComponentPlatformsAttribute_OSXArm64}
{$UNDEF HAS_ComponentPlatformsAttribute_AllPlatforms}
{$UNDEF HAS_DIRECTIVE_WARN_DEFAULT}
{$UNDEF HAS_DIRECTIVE_ZEROBASEDSTRINGS}

// Define for Delphi to auto-generate platform-appropriate '#pragma link' statements in HPP files
{$UNDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}

// detect compiler versions and features

{$IFDEF FPC}
  {$I IdCompilerDefines_FPC.inc}
{$ELSE}
  // DCC is not defined by Delphi until XE2. Check for earlier compiler
  // versions and define DCC manually if detected...
  {$I IdCompilerDetectDCC.inc}
  {$IFDEF DCC}
    {$I IdCompilerDefines_DCC.inc}
  {$ELSE}
    {$MESSAGE FATAL 'Unknown compiler!'}
  {$ENDIF}
{$ENDIF}

{$IF (NOT DEFINED(USE_OBJECT_ARC)) OR DEFINED(HAS_UNSAFE_OBJECT_REF)}
  {$DEFINE USE_OBJECT_REF_FREENOTIF}
{$IFEND}

{$IFNDEF UNICODE}
  {$DEFINE STRING_UNICODE_MISMATCH}
{$ENDIF}

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  {$DEFINE WIN32_OR_WIN64}
  {$DEFINE USE_ZLIB_UNIT}
  {$IFNDEF DCC_NEXTGEN}
    {$DEFINE USE_OPENSSL} // !!!·MOVED·HERE·BY·EMBT
    {$DEFINE USE_SSPI}
    {$DEFINE SSPI_UNICODE}
  {$ENDIF}
{$ELSEIF DEFINED(WINCE)}
  {$DEFINE USE_OPENSSL}
  // RLebeau: not sure if the above Win32/64 defines also apply to WinCE,
  // so keeping them separate for now...
{$IFEND}

// High-performance counters are not reliable on multi-core systems, and have
// been known to cause problems with TIdIOHandler.ReadLn() timeouts in Windows
// XP SP3, both 32-bit and 64-bit.  Refer to these discussions for more info:
//
// http://www.virtualdub.org/blog/pivot/entry.php?id=106
// http://blogs.msdn.com/oldnewthing/archive/2008/09/08/8931563.aspx
//
// Do not enable thus unless you know it will work correctly on your systems!
{$IFDEF WINDOWS}
  {.$DEFINE USE_HI_PERF_COUNTER_FOR_TICKS}
{$ENDIF}

{$IFDEF UNIX}
  {$DEFINE USE_OPENSSL}
  {$DEFINE USE_ZLIB_UNIT}
{$ENDIF}

{$IF DEFINED(MACOS) OR DEFINED(LINUX) OR DEFINED(IOS) OR DEFINED(FREEBSD)}
  {$DEFINE HAS_getifaddrs}
{$IFEND}

{$IFDEF IOS}
  {$DEFINE USE_OPENSSL}

  // Support for 64-bit ARM iOS Simulator was added in Delphi 11.2
  // TODO: how to detect iOS Simulator in FPC? Does it support 64-bit ARM?
  {$IF DEFINED(CPUARM) AND (NOT DEFINED(IOSSIMULATOR))}
    // RLebeau: For iOS devices, OpenSSL cannot be used as an external library,
    // it must be statically linked into the app.  For the iOS simulator, this
    // is not true.  Users who want to use OpenSSL in iOS device apps will need
    // to add the static OpenSSL library to the project and then include the
    // IdSSLOpenSSLHeaders_static unit in their uses clause. It hooks up the
    // statically linked functions for the IdSSLOpenSSLHeaders unit to use...
    {$DEFINE STATICLOAD_OPENSSL}
  {$IFEND}
{$ENDIF}

//
//iconv defines section.
{$DEFINE USE_ICONV_UNIT}
{$DEFINE USE_ICONV_ENC}
{$IFDEF UNIX}
  {$DEFINE USE_ICONV}
  {$IF DEFINED(USE_BASEUNIX)}
    {$IFDEF FPC}
      {$UNDEF USE_ICONV_UNIT}
    {$ELSE}
      {$UNDEF USE_ICONV_ENC}
    {$ENDIF}
  {$ELSEIF DEFINED(KYLIXCOMPAT)}
    //important!!  Iconv functions are defined in the libc.pas Kylix compatible unit.
    {$UNDEF USE_ICONV_ENC}
    {$UNDEF USE_ICONV_UNIT}
  {$IFEND}
{$ENDIF}
{$IFDEF NETWARELIBC}
  {$DEFINE USE_ICONV}
  //important!!! iconv functions are defined in the libc.pas Novell Netware header.
  //Do not define USE_ICONV_UNIT
  {$UNDEF USE_ICONV_UNIT}
  {$UNDEF USE_ICONV_ENC}
{$ENDIF}

{$UNDEF USE_INVALIDATE_MOD_CACHE}
{$UNDEF USE_SAFELOADLIBRARY}

{$IFDEF WINDOWS}
  {$UNDEF USE_ICONV_ENC}
  {$DEFINE USE_SAFELOADLIBRARY}
{$ENDIF}
// Use here for all *nix systems that you do not want to use iconv library
{$IFDEF ANDROID}
  {$UNDEF USE_ICONV}
  {$DEFINE USE_LCONVENC}
{$ENDIF}

//This must come after the iconv defines because this compiler targets a Unix-like
//operating system.  One key difference is that it does have a TEncoding class.
//If this comes before the ICONV defines, it creates problems.
//This also must go before the THandle size calculations.
{$IFDEF DCC_CROSS_COMPILE}
  {$IFDEF POSIX}
    {$IFNDEF LINUX}
      {$DEFINE BSD}
    {$ENDIF}
    {$DEFINE USE_SAFELOADLIBRARY}
    {$DEFINE USE_INVALIDATE_MOD_CACHE}
  {$ENDIF}
  //important!!! iconv functions are defined in the libc.pas Novell Netware header.
  //Do not define USE_ICONVUNIT
  {$UNDEF USE_ICONV}
  {$UNDEF USE_ICONV_UNIT}
  {$UNDEF USE_ICONV_ENC}
  {$DEFINE INT_THREAD_PRIORITY}
{$ENDIF}

{$IFNDEF USE_ICONV}
  {$UNDEF USE_ICONV_UNIT}
  {$UNDEF USE_ICONV_ENC}
{$ENDIF}

{
BSD 4.4 introduced a minor API change.  sa_family was changed from a 16bit
word to an 8 bit byte and an 8 bit byte field named sa_len was added.
}
//Place this only after DARWIN has been defined for Delphi MACOS
{$IF DEFINED(FREEBSD)
     OR DEFINED(DARWIN)
     OR DEFINED(HAIKU)
     OR DEFINED(MORPHOS)}
  {$DEFINE SOCK_HAS_SINLEN}
{$IFEND}

// Do NOT remove these IFDEF's.  They are here because InterlockedExchange
// only handles 32bit values.  Some Operating Systems may have 64bit
// THandles.  This is not always tied to the platform architecture.

{$IF DEFINED(AMIGA)
  OR DEFINED(EMBEDDED)
  OR DEFINED(MACOS_CLASSIC)
  OR DEFINED(MORPHOS)
  OR DEFINED(NATIVENT)
  OR DEFINED(WINDOWS)}
  {$DEFINE THANDLE_CPUBITS}
{$IFEND}

{$IF DEFINED(BSD)}
  //I think BSD might handle FreeBSD, NetBSD, OpenBSD, and Darwin
  {$IF DEFINED(IOS)}
    {$IFDEF CPUARM64}
      {$DEFINE CPU64}
      {$DEFINE THANDLE_64}
    {$ELSE}
      {$IFDEF CPUARM32}
        {$DEFINE CPU32}
      {$ENDIF}
      {$DEFINE THANDLE_32}
    {$ENDIF}
  {$ELSEIF DEFINED(OSX)}
    {$IFDEF FPC}
      {$DEFINE THANDLE_32}
	{$ELSE}
      {$DEFINE THANDLE_CPUBITS} // !!! ADDED OSX BY EMBT
	{$ENDIF}
  {$IFEND}

{$ELSEIF DEFINED(LINUX)}
  {$IFDEF LINUX64}
    {$DEFINE CPU64}
    {$DEFINE THANDLE_64}
  {$ELSE}
    {$IFDEF LINUX32}
      {$DEFINE CPU32}
    {$ENDIF}
    {$DEFINE THANDLE_32}
  {$ENDIF}

{$ELSEIF DEFINED(ATARI)
      OR DEFINED(BEOS)
      OR DEFINED(EMX)
      OR DEFINED(GBA)
      OR DEFINED(GO32)
      OR DEFINED(HAIKU)
      OR DEFINED(NDS)
      OR DEFINED(NETWARE)
      OR DEFINED(NETWARELIBC)
      OR DEFINED(OS2)
      OR DEFINED(PALMOS)
      OR DEFINED(SOLARIS)
      OR DEFINED(SYMBIAN)
      OR DEFINED(WII)
      OR DEFINED(WATCOM)}
  {$DEFINE THANDLE_32}
{$IFEND}

// end platform specific stuff for THandle size

{$IFDEF THANDLE_CPUBITS}
  {$IFDEF CPU64}
    {$DEFINE THANDLE_64}
  {$ELSE}
    {$DEFINE THANDLE_32}
  {$ENDIF}
{$ENDIF}

{$IF (NOT DEFINED(FREE_ON_FINAL))
  AND (DEFINED(HAS_System_RegisterExpectedMemoryLeak) OR DEFINED(USE_FASTMM4) OR DEFINED(USE_MADEXCEPT) OR DEFINED(USE_LEAKCHECK))}
  {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
{$IFEND}

{
We must determine what the SocketType parameter is for the Socket function.
In Kylix and the libc.pas Kylix-compatibility library, it's a __socket_type.
In BaseUnix, it's a C-type Integer.  In Windows, it's a LongInt.

}
{$UNDEF SOCKETTYPE_IS_CINT}
{$UNDEF SOCKETTYPE_IS___SOCKETTYPE}
{$UNDEF SOCKETTYPE_IS_LONGINT}
{$UNDEF SOCKETTYPE_IS_NUMERIC}
{$UNDEF SOCKET_LEN_IS_socklen_t}

{$IF DEFINED(USE_BASEUNIX)}
  {$DEFINE SOCKETTYPE_IS_CINT}
  {$DEFINE SOCKETTYPE_IS_NUMERIC}
{$ELSEIF DEFINED(KYLIXCOMPAT)}
  {$DEFINE SOCKETTYPE_IS___SOCKETTYPE}
{$ELSEIF DEFINED(USE_VCL_POSIX)}
  {$DEFINE SOCKETTYPE_IS_NUMERIC}
  {$DEFINE SOCKETTYPE_IS_LONGINT}
  {$DEFINE SOCKET_LEN_IS_socklen_t}
{$ELSEIF DEFINED(WINDOWS)}
  {$DEFINE SOCKETTYPE_IS_LONGINT}
  {$DEFINE SOCKETTYPE_IS_NUMERIC}
{$ELSEIF DEFINED(OS2)}
  {$DEFINE SOCKETTYPE_IS_LONGINT}
  {$DEFINE SOCKETTYPE_IS_NUMERIC}
{$ELSEIF DEFINED(NETWARE)}
  {$DEFINE SOCKETTYPE_IS_LONGINT}
  {$DEFINE SOCKETTYPE_IS_NUMERIC}
{$IFEND}

{Take advantage of some TCP features specific to some stacks.
They work somewhat similarly but there's a key difference.
In Linux, TCP_CORK is turned on to send fixed packet sizes and
when turned-off (uncorked), any remaining data is sent. With
TCP_NOPUSH, this might not happen and remaining data is only sent
before disconnect.  TCP_KEEPIDLE and TCP_KEEPINTVL so the IFDEF LINUX and IFDEF
SOLARIS instead of IFDEF UNIX is not an error, it's deliberate.}

{$IF DEFINED(BSD) OR DEFINED(HAIKU)}
  {$DEFINE HAS_TCP_NOPUSH}
{$ELSE}
  {$UNDEF HAS_TCP_NOPUSH}
{$IFEND}

{$IF DEFINED(LINUX) OR DEFINED(SOLARIS) OR DEFINED(NETBSD)}
  {$DEFINE HAS_TCP_CORK}
{$ELSE}
  {$UNDEF HAS_TCP_CORK}
{$IFEND}

{$IF DEFINED(LINUX) OR DEFINED(NETBSD)}
  {$DEFINE HAS_TCP_KEEPIDLE}
  {$DEFINE HAS_TCP_KEEPINTVL}
{$ELSE}
  {$UNDEF HAS_TCP_KEEPIDLE}
  {$UNDEF HAS_TCP_KEEPINTVL}
{$IFEND}

{$IFDEF USE_VCL_POSIX}
  // TODO: which POSIX platforms actually have SO_NOSIGPIPE available?
  {$IF DEFINED(ANDROID) OR DEFINED(LINUX)}
    {$UNDEF HAS_SOCKET_NOSIGPIPE}
  {$ELSE}
    {$DEFINE HAS_SOCKET_NOSIGPIPE}
  {$IFEND}
{$ELSE}
  // TODO: which FPC platforms actually have SO_NOSIGPIPE available?
  {$UNDEF HAS_SOCKET_NOSIGPIPE}
{$ENDIF}

{end Unix OS specific stuff}

{$IFDEF DEBUG}
  {$UNDEF USE_INLINE}
{$ENDIF}
