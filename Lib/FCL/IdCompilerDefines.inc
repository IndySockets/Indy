// General

// Make this $DEFINE to use the 16 color icons required by Borland
// or DEFINE to use the 256 color Indy versions
{.$DEFINE Borland}

// S.G. 4/9/2002: IPv4/IPv6 general switch (for defaults only)
{$DEFINE IdIPv4}

{$DEFINE INDY100}
{$DEFINE 10_5_6}  //so developers can IFDEF for this specific version

{$IFDEF BCB}
  {$DEFINE CBUILDER}
{$ELSE}
  {$DEFINE DELPHI}
{$ENDIF}

{$UNDEF USE_OPENSSL}
{$UNDEF USE_ZLIB_UNIT}

// $DEFINE the following if the global objects in the IdStack and IdThread
// units should be freed on finalization
{.$DEFINE FREE_ON_FINAL}
{$UNDEF FREE_ON_FINAL}

// Make sure the following is $DEFINE'd only for suitable environments
// as specified further below.  This works in conjunction with the
// FREE_ON_FINAL define above.
{$UNDEF REGISTER_EXPECTED_MEMORY_LEAK}

// FastMM is natively available in BDS 2006 and higher.  $DEFINE the
// following if FastMM has been installed manually
{.$DEFINE USE_FASTMM4}
{$UNDEF USE_FASTMM4}

// Make sure the following is $DEFINE'd only for Delphi/C++Builder 2009 onwards
// as specified further below.  The VCL is fully Unicode, where the 'String'
// type maps to System.UnicodeString, not System.AnsiString anymore
{$UNDEF STRING_IS_UNICODE}
{$UNDEF STRING_IS_ANSI}

// Make sure the following are $DEFINE'd only for suitable environments
// as specified further below.  This works in conjunction with the
// STRING_IS_ANSI and STRING_IS_UNICODE defines above.
{$UNDEF UNICODE_BUT_STRING_IS_ANSI}
{$UNDEF HAS_TEncoding}

// Make sure that this is defined only for environments where we are using
// the iconv library to charactor conversions.
{.$UNDEF USE_ICONV}

// Delphi 4
{$IFDEF VER120}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_40}
  {$DEFINE DELPHI_4}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE MSWINDOWS}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL}
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
{$ENDIF}

// C++ Builder 4
{$IFDEF VER125}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_40}
  {$DEFINE CBUILDER_4}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE MSWINDOWS}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL}
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
{$ENDIF}

// Delphi 5 & CBuilder 5
{$IFDEF VER130}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_5}
  {$IFDEF CBUILDER}
    {$DEFINE CBUILDER_5}
  {$ELSE}
    {$DEFINE DELPHI_5}
  {$ENDIF}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE MSWINDOWS}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL}
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 6
{$IFDEF VER140}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$IFDEF CBUILDER}
    {$DEFINE CBUILDER_6}
    {$DEFINE HAS_NAMED_THREADS}
  {$ELSE}
    {$DEFINE DELPHI_6}
  {$ENDIF}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_60}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL}
  {$DEFINE VCL_60_PLUS}
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 7
{$IFDEF VER150}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_70}
  {$DEFINE DELPHI_7} // there was no C++ Builder 7
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
  {$DEFINE WIDGET_VCL}
  {$DEFINE VCL_60_PLUS}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 8
{$IFDEF VER160}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_80}
  {$DEFINE DELPHI_8} // there was no C++ Builder 8
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  //Widget defines are omitted since D8 only supports NET
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 2005
{$IFDEF VER170}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2005}
  {$DEFINE DELPHI_2005} // there was no C++Builder 2005
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$IFNDEF CIL}
    {$DEFINE WIDGET_VCL_LIKE} // LCL included.
    {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
    {$DEFINE WIDGET_VCL}
    {$DEFINE VCL_60_PLUS}
  {$ENDIF}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

// NOTE: CodeGear decided to make Highlander be a non-breaking release
// (no interface changes, thus fully backwards compatible without any
// end user code changes), so VER180 applies to both BDS 2006 and
// Highlander prior to the release of RAD Studio 2007.  Use VER185 to
// identify Highlanger specifically.

//Delphi 2006, Delphi 2007 (Highlander)
{$IFDEF VER180}
  {$DEFINE USE_INLINE}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2006_OR_ABOVE}
  {$DEFINE VCL_2006}
  {$IFDEF CBUILDER}
    {$DEFINE CBUILDER_2006}
  {$ELSE}
    {$DEFINE DELPHI_2006}
  {$ENDIF}
  {$DEFINE HAS_OPTIONALPARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$IFNDEF FREE_ON_FINAL}
    {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
  {$ENDIF}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL}
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
  {$DEFINE VCL_60_PLUS}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 2007 (Highlander)
{$IFDEF VER185}
  {$DEFINE USE_INLINE}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2006_OR_ABOVE}
  {$DEFINE VCL_2007_OR_ABOVE}
  {$UNDEF CBUILDER_2006}
  {$UNDEF DELPHI_2006}
  {$UNDEF VCL_2006}
  {$DEFINE VCL_2007}
  {$IFDEF CBUILDER}
    {$DEFINE CBUILDER_2007}
  {$ELSE}
    {$DEFINE DELPHI_2007}
  {$ENDIF}
  {$DEFINE HAS_OPTIONALPARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$IFNDEF FREE_ON_FINAL}
    {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
  {$ENDIF}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$IFNDEF CIL}
    {$DEFINE WIDGET_VCL_LIKE} // LCL included.
    {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
    {$DEFINE WIDGET_VCL}
    {$DEFINE VCL_60_PLUS}
  {$ENDIF}
  {$IFNDEF CBUILDER}
    // class properties are broken in C++Builder 2007, causing AVs at compile-time
    {$DEFINE HAS_CLASSPROPERTIES}
  {$ENDIF}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

// BDS 2007 NET personality uses VER190 instead of 185.
//Delphi .NET 2007
{$IFDEF VER190}
  {$DEFINE USE_INLINE}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2006_OR_ABOVE}
  {$DEFINE VCL_2007_OR_ABOVE}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$IFDEF CIL}
    //Delphi 2007
    {$DEFINE VCL_2007}
    {$DEFINE DELPHI_2007}
  {$ENDIF}
  {$IFNDEF CBUILDER}
    // class properties are broken in C++Builder 2007, causing AVs at compile-time
    {$DEFINE HAS_CLASSPROPERTIES}
  {$ENDIF}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 2009 (Tiburon)
{$IFDEF VER200}
  {$DEFINE USE_INLINE}
  {$DEFINE STRING_IS_UNICODE} // 'String' type is Unicode now
  {$DEFINE HAS_TEncoding}
  {$DEFINE HAS_TCharacter}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2006_OR_ABOVE}
  {$DEFINE VCL_2007_OR_ABOVE}
  {$DEFINE VCL_2009_OR_ABOVE}
  {$DEFINE VCL_2009}
  {$IFDEF CBUILDER}
    {$DEFINE CBUILDER_2009}
  {$ELSE}
    {$DEFINE DELPHI_2009}
  {$ENDIF}
  {$DEFINE HAS_OPTIONALPARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$IFNDEF FREE_ON_FINAL}
    {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
  {$ENDIF}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE BROKEN_FmtStr} // TODO: need to differentiate between RTM and Update 1
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$IFNDEF CIL}
    {$DEFINE WIDGET_VCL_LIKE} // LCL included.
    {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
    {$DEFINE WIDGET_VCL}
    {$DEFINE VCL_60_PLUS}
  {$ENDIF}
  {$DEFINE HAS_CLASSPROPERTIES}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_DEPRECATED_MSG}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi 2010 (Weaver)
{$IFDEF VER210}
  {$DEFINE USE_INLINE}
  {$DEFINE STRING_IS_UNICODE} // 'String' type is Unicode now
  {$DEFINE HAS_TEncoding}
  {$DEFINE HAS_TCharacter}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_8_OR_ABOVE}
  {$DEFINE VCL_2005_OR_ABOVE}
  {$DEFINE VCL_2006_OR_ABOVE}
  {$DEFINE VCL_2007_OR_ABOVE}
  {$DEFINE VCL_2009_OR_ABOVE}
  {$DEFINE VCL_2010_OR_ABOVE}
  {$DEFINE VCL_2010}
  {$IFDEF CBUILDER}
    {$DEFINE DELPHI_2010}
  {$ELSE}
    {$DEFINE DELPHI_2010}
  {$ENDIF}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {$DEFINE HAS_NAMED_THREADS}
  {$DEFINE HAS_TThread_NameThreadForDebugging}
  {$IFNDEF FREE_ON_FINAL}
    {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
  {$ENDIF}
  {$DEFINE HAS_TFormatSettings}
  {$DEFINE HAS_TSelectionEditor}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$IFNDEF CIL}
    {$DEFINE WIDGET_VCL_LIKE} // LCL included.
    {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
    {$DEFINE WIDGET_VCL}
    {$DEFINE VCL_60_PLUS}
  {$ENDIF}
  {$DEFINE HAS_CLASSPROPERTIES}
  {$DEFINE HAS_DEPRECATED}
  {$DEFINE HAS_DEPRECATED_MSG}
  {$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

//Delphi.NET
// Covers D8+
{$IFDEF CIL}
  {$DEFINE STRING_IS_UNICODE}
  {$DEFINE CPUI386}
  {$DEFINE ENDIAN_LITTLE}
  {$DEFINE CPU32}
  {$DEFINE WIDGET_WINFORMS}
  // Platform specific conditional. Used for platform specific code.
  {$DEFINE DOTNET}
  //differences in DotNET Framework versions.
  {$IFDEF VCL_2007_OR_ABOVE}
    {$DEFINE DOTNET_2}
    {$DEFINE DOTNET_2_OR_ABOVE}
  {$ELSE}
    {$DEFINE DOTNET_1_1}
  {$ENDIF}
  {$DEFINE DOTNET_1_1_OR_ABOVE}
  // Extra include used in D7 for testing. Remove later when all comps are
  // ported. Used to selectively exclude non ported parts. Allowed in places
  // IFDEFs are otherwise not permitted.
  {$DEFINE DOTNET_EXCLUDE}
{$ENDIF}

// FPC (2+)

{$IFDEF FPC}
  {$DEFINE USE_INLINE}
  {$DEFINE USE_CLASSINLINE}
  {$MODE Delphi}
  {$DEFINE WIDGET_VCL_LIKE} // LCL included.
  {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
  {$DEFINE USE_TBitBtn} //use Bit Buttons instead of Buttons
  {$DEFINE WIDGET_LCL}
  //note that we may need further defines for widget types depending on
  //what we do and what platforms we support in FPC.
  //I'll let Marco think about that one.
  {$IFDEF UNIX}
    {$DEFINE USE_BASEUNIX}
    {$DEFINE USE_OPENSSL}
    {$DEFINE USE_ZLIB_UNIT}
    {$IFDEF LINUX}
      //In Linux for I386, you can choose between a Kylix-libc API or
      //the standard RTL Unix API.  Just pass -dKYLIXCOMPAT to the FPC compiler.
      //I will see what I can do about the Makefile.
      {$IFDEF KYLIXCOMPAT}
        {$IFDEF CPUI386}
          {$UNDEF USE_BASEUNIX}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
    {$IFDEF USE_BASEUNIX}
      {$UNDEF KYLIXCOMPAT}
    {$ENDIF}
  {$ENDIF}
  //so we can use IdWinsock2 in WinCE, maybe in other places in Indy as well -CYA
  {$IFDEF WINCE}
    //CE is UNICODE ONLY - UNICODE is already defined though.
    {$DEFINE WIN32_OR_WIN64_OR_WINCE}
  {$ENDIF}
  {$DEFINE VCL_4_OR_ABOVE}
  {$DEFINE VCL_5_OR_ABOVE}
  {$DEFINE VCL_6_OR_ABOVE}
  {$DEFINE VCL_7_OR_ABOVE}
  {$DEFINE VCL_70}
  {$DEFINE DELPHI_7}
  {$DEFINE HAS_OPTIONAL_PARAMS}
  {$DEFINE HAS_SAMETEXT}
  {.$DEFINE HAS_NAMED_THREADS}
  {$DEFINE NO_TMultiReadExclusiveWriteSynchronizer}
  {$DEFINE FPC_REINTRODUCE_BUG}
  {$DEFINE FPC_CIRCULAR_BUG}
  {$DEFINE NO_REDECLARE}
  {$DEFINE BYTE_COMPARE_SETS}
  {.$DEFINE HAS_DEPRECATED}
  {.$DEFINE HAS_REMOVEFREENOTIFICATION}
{$ENDIF}

// Kylix
//
//Important:  Don't use CompilerVersion here as
//IF's are evaluated before IFDEF's
//and Kylix 1 does not have CompilerVersion defined at all.
{$IFNDEF FPC}
  {$IFDEF LINUX}
    {$IFDEF CONDITIONALEXPRESSIONS}
      {$IF RTLVersion = 14.0}
        {$DEFINE KYLIX_1}
        {$DEFINE KYLIX_1_OR_ABOVE}
      {$IFEND}
      {$IF RTLVersion = 14.2}
        {$DEFINE KYLIX_2}
        {$DEFINE USE_ZLIB_UNIT}
        {$DEFINE KYLIX_1_OR_ABOVE}
        {$DEFINE KYLIX_2_OR_ABOVE}
      {$IFEND}
      {$IF RTLVersion = 14.5}
        {$DEFINE KYLIX_3}
        {$DEFINE USE_ZLIB_UNIT}
        {$DEFINE KYLIX_1_OR_ABOVE}
        {$DEFINE KYLIX_2_OR_ABOVE}
        {$DEFINE KYLIX_3_OR_ABOVE}
      {$IFEND}
    {$ENDIF}
    {$DEFINE VCL_4_OR_ABOVE}
    {$DEFINE VCL_5_OR_ABOVE}
    {$DEFINE VCL_6_OR_ABOVE}
    {$DEFINE VCL_60}
    {$DEFINE HAS_OPTIONALPARAMS}
    {$DEFINE HAS_SAMETEXT}
    {$DEFINE UNIX}
    {$DEFINE KYLIXCOMPAT}
    {$DEFINE WIDGET_KYLIX}
    {$DEFINE WIDGET_VCL_LIKE_OR_KYLIX}
    {$DEFINE INT_THREAD_PRIORITY}
    {$DEFINE KYLIX}
    {$DEFINE CPUI386}
    {$UNDEF USE_BASEUNIX}
    {.$DEFINE HAS_DEPRECATED}
    {.$DEFINE HAS_REMOVEFREENOTIFICATION}
  {$ENDIF}
{$ENDIF}

{$IFDEF KYLIXCOMPAT}
  {$linklib c}
{$ENDIF}

// .NET and Delphi 2009+ support UNICODE strings natively!
// NOTE: Do not define UNICODE here.  The compiler defines
// the symbol automatically.
{$IFNDEF STRING_IS_UNICODE}
  {$DEFINE STRING_IS_ANSI}
  {$IFDEF UNICODE}
    {$DEFINE UNICODE_BUT_STRING_IS_ANSI}
  {$ENDIF}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE WIN32_OR_WIN64}
{$ENDIF}
{$IFDEF WIN64}
  {$DEFINE WIN32_OR_WIN64}
{$ENDIF}

{$IFDEF WIN32_OR_WIN64}
  {$DEFINE USE_OPENSSL}
  {$DEFINE USE_ZLIB_UNIT}
  {$DEFINE WIN32_OR_WIN64_OR_WINCE}
{$ENDIF}

{
BSD 4.4 introduced a minor API change.  sa_family was changed from a 16bit
word to an 8 bit byte and an 8 bit byte field named sa_len was added.
}
{$IFDEF FREEBSD}
   {$DEFINE SOCK_HAS_SINLEN}
{$ENDIF}
{$IFDEF DARWIN}
   {$DEFINE SOCK_HAS_SINLEN}
{$ENDIF}

{$IFDEF FPC_REQUIRES_PROPER_ALIGNMENT}
  {$DEFINE REQUIRES_PROPER_ALIGNMENT}
{$ENDIF}

// Do NOT remove these IFDEF's.  They are here because InterlockedExchange
// only handles 32bit values.  Some Operating Systems may have 64bit  
// THandles.  This is not always tied to the platform architecture.

{$IFDEF AMIGA}
  {$DEFINE THANDLE_CPUBITS}
{$ENDIF}
{$IFDEF ATARI}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF BEOS}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF BSD}
  //I think BSD might handle FreeBSD, NetBSD, OpenBSD, and Darwin
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF EMBEDDED}
  {$DEFINE THANDLE_CPUBITS}
{$ENDIF}
{$IFDEF EMX}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF GBA}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF GO32}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF LINUX}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF MACOS}
   {$DEFINE THANDLE_CPUBITS}
{$ENDIF}
{$IFDEF MORPHOS}
  {$DEFINE THANDLE_CPUBITS}
{$ENDIF}
{$IFDEF NDS}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF NETWARE}
  {$DEFINE THANDLE32}
{$ENDIF}
{$IFDEF NETWARELIBC}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF OS2}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF PALMOS}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF SOLARIS}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF WATCOM}
  {$DEFINE THANDLE_32}
{$ENDIF}
{$IFDEF WIN32_OR_WIN64_OR_WINCE}
  {$DEFINE THANDLE_CPUBITS}
{$ENDIF}

// end platform specific stuff for THandle size

{$IFDEF THANDLE_CPUBITS}
  {$IFDEF CPU64}
    {$DEFINE THANDLE_64}
  {$ELSE}
    {$DEFINE THANDLE_32}
  {$ENDIF}
{$ENDIF}
//
//iconv defines section.
{$DEFINE USE_ICONV_UNIT}
{$DEFINE USE_ICONV_ENC}
{$IFDEF UNIX}
  {$DEFINE USE_ICONV}
  {$IFDEF USE_BASEUNIX}
    {$IFDEF FPC}
      {$UNDEF USE_ICONV_UNIT}
    {$ELSE}
      {$UNDEF USE_ICONV_ENC}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF KYLIXCOMPAT}
    //important!!  Iconv functions are defined in the libc.pas Kylix compatible unit.
    {$UNDEF USE_ICONV_ENC}
    {$UNDEF USE_ICONV_UNIT}
  {$ENDIF}
{$ENDIF}
{$IFDEF NETWARELIBC}
  {$DEFINE USE_ICONV}
  //important!!! iconv functions are defined in the libc.pas Novell Netware header.
  //Do not define USE_ICONVUNIT
  {$UNDEF USE_ICONV_UNIT}
  {$UNDEF USE_ICONV_ENC}
{$ENDIF}
{$IFNDEF USE_ICONV}
  {$UNDEF USE_ICONV_UNIT}
  {$UNDEF USE_ICONV_ENC}
{$ENDIF}
{$IFDEF WIN32_OR_WIN64_OR_WINCE}
  {$UNDEF USE_ICONV_ENC}
{$ENDIF}

{$IFDEF DOTNET}
  {$DEFINE DOTNET_OR_ICONV}
{$ENDIF}
{$IFDEF USE_ICONV}
  {$DEFINE DOTNET_OR_ICONV}
{$ENDIF}

{$UNDEF STREAM_SIZE_64}
{$IFDEF FPC}
  {$DEFINE STREAM_SIZE_64}
{$ENDIF}
{$IFDEF VCL_6_OR_ABOVE}
  {$DEFINE STREAM_SIZE_64}
{$ENDIF}

{$IFNDEF FREE_ON_FINAL}
  {$IFNDEF REGISTER_EXPECTED_MEMORY_LEAK}
    {$IFDEF USE_FASTMM4}
      {$DEFINE REGISTER_EXPECTED_MEMORY_LEAK}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
  {$IFDEF DOTNET}
    {$UNDEF REGISTER_EXPECTED_MEMORY_LEAK}
  {$ENDIF}
{$ENDIF}

{$IFDEF DEBUG}
  {$UNDEF USE_INLINE}
{$ENDIF}
