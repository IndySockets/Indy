// Make this $DEFINE to use the 16 color icons required by Borland
// or DEFINE to use the 256 color Indy versions
{.$DEFINE Borland}

// When generating C++Builder output files, certain workarounds to compiler
// problems need to be enabled! When invoking DCC on the command-line, use
// the -DBCB parameter. When invoking MSBUILD, include the DCC_Define="BCB"
// attribute in the /p parameter.
{$IFDEF BCB}
  {$DEFINE CBUILDER}
{$ELSE}
  {$DEFINE DELPHI}
{$ENDIF}

// detect compiler versions

{$IF CompilerVersion < 20}
  {$MESSAGE ERROR 'Unsupported compiler version detected!'}
{$IFEND}

//Delphi & C++Builder 2009 (Tiburon)
{$IF CompilerVersion >= 20}
  {$IF CompilerVersion < 21}
    {$DEFINE DCC_2009}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_2009}
    {$ELSE}
      {$DEFINE DELPHI_2009}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_2009_OR_ABOVE}
{$IFEND}

//Delphi & C++Builder 2010 (Weaver)
{$IF CompilerVersion >= 21}
  {$IF CompilerVersion < 22}
    {$DEFINE DCC_2010}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_2010}
    {$ELSE}
      {$DEFINE DELPHI_2010}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_2010_OR_ABOVE}
{$IFEND}

//Delphi & C++Builder XE (Fulcrum)
{$IF CompilerVersion >= 22}
  {$IF CompilerVersion < 23}
    {$DEFINE DCC_XE}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE}
    {$ELSE}
      {$DEFINE DELPHI_XE}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE2 (Pulsar)
{$IF CompilerVersion >= 23}
  {$IF CompilerVersion < 24}
    {$DEFINE DCC_XE2}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE2}
    {$ELSE}
      {$DEFINE DELPHI_XE2}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE3 (Waterdragon)
//Delphi & CBuilder XE3.5 (Quintessence - early betas only)
{$IF CompilerVersion >= 24}
  {$IF CompilerVersion < 25}
    {$DEFINE DCC_XE3}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE3}
    {$ELSE}
      {$DEFINE DELPHI_XE3}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE3_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE4 (Quintessence)
{$IF CompilerVersion >= 25}
  {$IF CompilerVersion < 26}
    {$UNDEF DCC_XE3}
    {$DEFINE DCC_XE4}
    {$IFDEF CBUILDER}
      {$UNDEF CBUILDER_XE3}
      {$DEFINE CBUILDER_XE4}
    {$ELSE}
      {$UNDEF DELPHI_XE3}
      {$DEFINE DELPHI_XE4}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE4_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE5 (Zephyr)
//Delphi & C++Builder AppMethod is XE5 for mobile only, VCL is removed
{$IF CompilerVersion >= 26}
  {$IF CompilerVersion < 27}
    {$DEFINE DCC_XE5}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE5}
    {$ELSE}
      {$DEFINE DELPHI_XE5}
    {$ENDIF}
    {$IF CompilerVersion >= 26.5}
      {$DEFINE APPMETHOD}
    {$IFEND}
  {$IFEND}
  {$DEFINE DCC_XE5_OR_ABOVE}
  // TODO: figure out how to detect this version
  {.$DEFINE DCC_XE5_UPDATE2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE6 (Proteus)
{$IF CompilerVersion >= 27}
  {$IF CompilerVersion < 28}
    {$DEFINE DCC_XE6}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE6}
    {$ELSE}
      {$DEFINE DELPHI_XE6}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE6_OR_ABOVE}
  {$DEFINE DCC_XE5_UPDATE2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE7 (Carpathia)
{$IF CompilerVersion >= 28}
  {$IF CompilerVersion < 29}
    {$DEFINE DCC_XE7}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE7}
    {$ELSE}
      {$DEFINE DELPHI_XE7}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE7_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder XE8 (Elbrus)
{$IF CompilerVersion >= 29}
  {$IF CompilerVersion < 30}
    {$DEFINE DCC_XE8}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_XE8}
    {$ELSE}
      {$DEFINE DELPHI_XE8}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_XE8_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 10.0 Seattle (Aitana)
{$IF CompilerVersion >= 30}
  {$IF CompilerVersion < 31}
    {$DEFINE DCC_10_0}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_10_0}
    {$ELSE}
      {$DEFINE DELPHI_10_0}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_10_0_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 10.1 Berlin (BigBen)
{$IF CompilerVersion >= 31}
  {$IF CompilerVersion < 32}
    {$DEFINE DCC_10_1}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_10_1}
    {$ELSE}
      {$DEFINE DELPHI_10_1}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_10_1_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 10.2 Tokyo (Godzilla)
{$IF CompilerVersion >= 32}
  {$IF CompilerVersion < 33}
    {$DEFINE DCC_10_2}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_10_2}
    {$ELSE}
      {$DEFINE DELPHI_10_2}
    {$ENDIF}
  {$IFEND}
  {$DEFINE DCC_10_2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 10.3 Rio (Carnival)
{$IF CompilerVersion >= 33}
  {$IF CompilerVersion < 34}
    {$DEFINE DCC_10_3}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_10_3}
    {$ELSE}
      {$DEFINE DELPHI_10_3}
    {$ENDIF}
  {$ENDIF}
  {$DEFINE DCC_10_3_OR_ABOVE}
  // TODO: figure out how to detect this version
  {.$DEFINE DCC_10_3_UPDATE2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 10.4 Sydney (Denali)
{$IF CompilerVersion >= 34}
  {$IF CompilerVersion < 35}
    {$DEFINE DCC_10_4}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_10_4}
    {$ELSE}
      {$DEFINE DELPHI_10_4}
    {$ENDIF}
  {$ENDIF}
  {$DEFINE DCC_10_4_OR_ABOVE}
  // TODO: figure out how to detect this version
  {.$DEFINE DCC_10_4_UPDATE2_OR_ABOVE}
  {$DEFINE DCC_10_3_UPDATE2_OR_ABOVE}
{$IFEND}

//Delphi & CBuilder 11.0 Alexandria (Olympus)
{$IF CompilerVersion >= 35}
  {$IF CompilerVersion < 36}
    {$DEFINE DCC_11}
    {$IFDEF CBUILDER}
      {$DEFINE CBUILDER_11}
    {$ELSE}
      {$DEFINE DELPHI_11}
    {$ENDIF}
  {$ENDIF}
  {$DEFINE DCC_11_OR_ABOVE}
  {$DEFINE DCC_10_4_UPDATE2_OR_ABOVE}
{$IFEND}

{$IF CompilerVersion >= 36}
  {$MESSAGE ERROR 'Unsupported compiler version detected!'}
{$IFEND}

// Normalize Delphi compiler defines to match FPC for consistency:
//
// CPU32 - any 32-bit CPU
// CPU64 - any 64-bit CPU
// WINDOWS - any Windows platform (32-bit, 64-bit, CE)
// WIN32 - Windows 32-bit
// WIN64 - Windows 64-bit
// WINCE - Windows CE
//
// Consult the "Free Pascal Programmer's Guide", Appendix G for the complete
// list of defines that are used. Do not work on this unless you understand
// what the FreePascal developers are doing.  Not only do you have to
// descriminate with operating systems, but also with chip architectures
// are well.
//
// DCC Pulsar+ define the following values:
// ASSEMBLER
// DCC
// CONDITIONALEXPRESSIONS
// NATIVECODE
// UNICODE
// MACOS
// MACOS32
// MACOS64
// MSWINDOWS
// WIN32
// WIN64
// LINUX
// POSIX
// POSIX32
// CPU386
// CPUX86
// CPUX64
//
// Kylix defines the following values:
// LINUX
// (others??)
//

// TODO: We need to use ENDIAN_BIG for big endian chip architectures,
// such as 680x0, PowerPC, Sparc, and MIPS, once DCC supports them,
// provided it does not already define its own ENDIAN values by then...
{$DEFINE ENDIAN_LITTLE}
{$IFDEF MSWINDOWS}
  {$DEFINE WINDOWS}
{$ENDIF}
// TODO: map Pulsar's non-Windows platform defines...
{$IFDEF DCC_XE2_OR_ABOVE}
  {$IFDEF DCC_XE8_OR_ABOVE}
    {$IFDEF CPU32BITS}
      //any 32-bit CPU
      {$DEFINE CPU32}
    {$ENDIF}
    {$IFDEF CPU64BITS}
      //any 64-bit CPU
      {$DEFINE CPU64}
    {$ENDIF}
  {$ELSE}
    {$IFDEF CPU386}
      //any 32-bit CPU
      {$DEFINE CPU32}
      //Intel 386 compatible chip architecture
      {$DEFINE CPUI386}
    {$ENDIF}
    {$IFDEF CPUX86}
      {$DEFINE CPU32}
    {$ENDIF}
    {$IFDEF CPUX64}
      //any 64-bit CPU
      {$DEFINE CPU64}
      //AMD64 compatible chip architecture
      {$DEFINE CPUX86_64}  //historical name for AMD64
      {$DEFINE CPUAMD64}
    {$ENDIF}
  {$ENDIF}
{$ELSE}
  {$DEFINE I386}
  {$DEFINE CPU32}
{$ENDIF}

// Check for available features

{$DEFINE HAS_RemoveFreeNotification}
{$DEFINE HAS_IInterface}
{$DEFINE HAS_TSelectionEditor}
{$DEFINE HAS_SYMBOL_PLATFORM}
{$DEFINE HAS_UNIT_PLATFORM}

{$DEFINE HAS_NAMED_THREADS}
{$DEFINE HAS_TStrings_NameValueSeparator}
{$DEFINE HAS_TStrings_ValueFromIndex}

{$DEFINE USE_INLINE}
{$DEFINE HAS_2PARAM_FileAge}

{$IFDEF WINDOWS}
  // System.RegisterExpectedMemoryLeak() is only available on Windows at this time
  {$DEFINE HAS_System_RegisterExpectedMemoryLeak}
{$ENDIF}

{$DEFINE HAS_CLASSPROPERTIES}
// Native(U)Int exist but are buggy until D2010, so do not use them in D2009
{.$DEFINE HAS_NativeInt}
{.$DEFINE HAS_NativeUInt}
{$DEFINE HAS_DWORD_PTR}
{$DEFINE HAS_ULONG_PTR}
{$DEFINE HAS_ULONGLONG}
{$DEFINE HAS_PPAnsiChar}
{$DEFINE HAS_CurrentYear}
{$DEFINE HAS_TIMEUNITS}

{$DEFINE HAS_TEncoding}
{$DEFINE HAS_TCharacter}
{$DEFINE HAS_InterlockedCompareExchangePointer}
{$DEFINE HAS_WIDE_TCharArray}
{$DEFINE HAS_PUInt64}
{$IFDEF DCC_2009}
  // TODO: need to differentiate between RTM and Update 1
  // FmtStr() is broken in RTM but was fixed in Update 1
  {$DEFINE BROKEN_FmtStr}
{$ENDIF}
{$DEFINE HAS_CLASSVARS}
{$DEFINE HAS_TBytes}
// Native(U)Int are still buggy, so do not use them yet
{.$DEFINE HAS_NativeInt}
{.$DEFINE HAS_NativeUInt}
{$DEFINE HAS_UIntToStr}
{$DEFINE HAS_PRawByteString}
{$DEFINE HAS_TThreadProcedure}

{$IFDEF DCC_2010_OR_ABOVE}
  {$DEFINE HAS_CLASSCONSTRUCTOR}
  {$DEFINE HAS_CLASSDESTRUCTOR}
  {$DEFINE HAS_DELAYLOAD}
  {$DEFINE HAS_TThread_NameThreadForDebugging}
  {$DEFINE THREADNAME_IS_ANSISTRING} // NameThreadForDebugging() uses AnsiString
  {$DEFINE DEPRECATED_TThread_SuspendResume}
  // Native(U)Int are finally ok to use now
  {$DEFINE HAS_NativeInt}
  {$DEFINE HAS_NativeUInt}
  {$DEFINE HAS_USHORT}
  {$DEFINE HAS_IOUtils_TPath}
{$ENDIF}

{$IFDEF DCC_XE_OR_ABOVE}
  {$DEFINE HAS_TFormatSettings_Create}
  {$DEFINE HAS_LocaleCharsFromUnicode}
  {$DEFINE HAS_UnicodeFromLocaleChars}
  {$DEFINE HAS_PLongBool}
  {$DEFINE HAS_PVOID}
  {$DEFINE HAS_ULONG64}
  {$DEFINE HAS_TEncoding_GetEncoding_ByEncodingName}
  {$DEFINE HAS_DateUtils_TTimeZone}
  // Exception.RaiseOuterException() is now available on all platforms
  {$DEFINE HAS_Exception_RaiseOuterException}
  {$DEFINE HAS_TInterlocked}
{$ELSE}
  {$IFDEF WINDOWS}
    // Exception.RaiseOuterException() is only available on Windows at this time
    {$DEFINE HAS_Exception_RaiseOuterException}
  {$ENDIF}
{$ENDIF}

{$IFDEF DCC_XE2_OR_ABOVE}
  {$DEFINE HAS_SIZE_T}
  {$DEFINE HAS_PSIZE_T}
  {$DEFINE HAS_SSIZE_T}
  {$DEFINE HAS_PSSIZE_T}
  {$DEFINE HAS_LONG}
  {$DEFINE HAS_ComponentPlatformsAttribute}
  {$DEFINE HAS_System_ReturnAddress}
  {$DEFINE HAS_DIRECTIVE_WARN_DEFAULT}
{$ENDIF}

{$IFDEF DCC_XE3_OR_ABOVE}
  {$DEFINE HAS_SysUtils_TStringHelper}
  {$IFDEF NEXTGEN}
    {$DEFINE DCC_NEXTGEN}
    {$DEFINE HAS_MarshaledAString}
    {$DEFINE USE_MARSHALLED_PTRS}
    {$IFDEF AUTOREFCOUNT}
      {$DEFINE USE_OBJECT_ARC}
    {$ENDIF}
  {$ENDIF}
  {$DEFINE HAS_System_Pos_Offset}
  {$UNDEF THREADNAME_IS_ANSISTRING} // NameThreadForDebugging() now uses (Unicode)String
{$ENDIF}

{$IFDEF DCC_XE4_OR_ABOVE}
  {$DEFINE HAS_AnsiStrings_StrPLCopy}
  {$DEFINE HAS_AnsiStrings_StrLen}
  {$DEFINE HAS_Character_TCharHelper}
{$ENDIF}

{$IFDEF DCC_XE5_UPDATE2_OR_ABOVE}
  {$DEFINE HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
  {$DEFINE HAS_DIRECTIVE_HPPEMIT_NAMESPACE}
{$ENDIF}

{$IFDEF DCC_XE7_OR_ABOVE}
  {$DEFINE HAS_TNetEncoding}
{$ENDIF}

{$IFDEF DCC_10_0_OR_ABOVE}
  {$IFDEF ANDROID}
    {$DEFINE HAS_TAndroidHelper}
  {$ENDIF}
{$ENDIF}

{$IFDEF DCC_10_1_OR_ABOVE}
  {$DEFINE HAS_DIRECTIVE_HPPEMIT_LEGACYHPP}
  {$DEFINE HAS_TStrings_AddPair}
  {.$DEFINE HAS_UNSAFE_INTF_REF}
  {.$DEFINE HAS_WEAK_INTF_REF}
{$ENDIF}

{$IFDEF DCC_10_2_OR_ABOVE}
  {.$WARN IMPLICIT_INTEGER_CAST_LOSS OFF}
  {.$WARN IMPLICIT_CONVERSION_LOSS OFF}
  {.$WARN COMBINING_SIGNED_UNSIGNED64 OFF}
  {$DEFINE HAS_STATIC_TThread_ForceQueue}
  // In Delphi 10.2 Tokyo, TThread.ForceQueue() is broken on Android, the
  // passed in procedure is called immediately instead of being delayed!
  {$IFDEF ANDROID}
    {$DEFINE BROKEN_TThread_ForceQueue}
  {$ENDIF}
{$ENDIF}

{$IFDEF DCC_10_3_OR_ABOVE}
  {$IFDEF LINUX}
    // RLebeau 9/25/2019: there is a bug in the IDE when debugging Linux projects
    // where the EThreadNameException exception raised by TThread.NameThreadForDebugging()
    // is not handled correctly.
    {$UNDEF HAS_NAMED_THREADS}
  {$ENDIF}
  {$IFDEF ANDROID}
    {$UNDEF BROKEN_TThread_ForceQueue}
  {$ENDIF}
{$ENDIF}

// Delphi XE+ cross-compiling
{$IFDEF POSIX}
  {$IF RTLVersion >= 22.0}
    {$DEFINE UNIX}
    {$UNDEF USE_BASEUNIX}
    {$DEFINE DCC_CROSS_COMPILE}
    {$DEFINE USE_VCL_POSIX}
  {$IFEND}
{$ENDIF}
{$IFDEF LINUX}
  {$IF RTLVersion >= 22.0}
    {$DEFINE DCC_CROSS_COMPILE}
    {$DEFINE USE_VCL_POSIX}
  {$IFEND}
{$ENDIF}

{$IFDEF DCC_CROSS_COMPILE}
  {$UNDEF KYLIXCOMPAT}
{$ENDIF}

{$IFDEF NEXTGEN}
  {$DEFINE DCC_NEXTGEN}
  {$IFDEF DCC_XE3_OR_ABOVE}
    {$DEFINE HAS_MarshaledAString}
    {$DEFINE USE_MARSHALLED_PTRS}
  {$ENDIF}
  {$DEFINE NO_ANSI_TYPES}
  {.$DEFINE STRING_IS_IMMUTABLE} // Strings are NOT immutable in NEXTGEN yet
{$ENDIF}

// ARC *may* come to the desktop compilers someday, so separating AUTOREFCOUNT
// handling from NEXTGEN handling...
{$IFDEF AUTOREFCOUNT}
  {$DEFINE USE_OBJECT_ARC}
  // For TComponent descendants that have references to external components,
  // we can reduce some runtime overhead, and reuse some code with non-ARC
  // systems, by using [Unsafe] references with TComponent.FreeNotification(),
  // instead of using less-efficient [Weak] references...
  {$DEFINE HAS_UNSAFE_OBJECT_REF}
  {$DEFINE HAS_WEAK_OBJECT_REF}
  // TODO: move these to an appropriate section. Not doing this yet because
  // it is a major interface change to switch to Generics and we should
  // maintain backwards compatibility with earlier compilers for the time
  // being. Defining them only here for now because the non-Generic versions
  // of these classes have become deprecated by ARC and so we need to start
  // taking advantage of the Generics versions...
  {$DEFINE HAS_UNIT_Generics_Collections}
  {$DEFINE HAS_UNIT_Generics_Defaults}
  {$DEFINE HAS_GENERICS_TDictionary}
  {$DEFINE HAS_GENERICS_TList}
  {$DEFINE HAS_GENERICS_TObjectList}
  {$DEFINE HAS_GENERICS_TThreadList}
  // TArray<T>.Copy() was introduced in XE7 but was buggy. It was fixed in XE8:
  //
  // RSP-9763 TArray.Copy<T> copies from destination to source for unmanaged types
  // https://quality.embarcadero.com/browse/RSP-9763
  //
  {$IFDEF DCC_XE8_OR_ABOVE}
    {$DEFINE HAS_GENERICS_TArray_Copy}
  {$ENDIF}
{$ENDIF}

{$DEFINE WIDGET_VCL}

// TODO: Ansi data types were disabled on mobile platforms in XE3, but
// UTF8String and RawByteString were re-enabled in 10.1 Berlin! What else,
// if anything, was re-enabled to facilitate that?
//
// UPDATE: In 10.4 Sydney, AnsiChar and AnsiString were re-enabled on
// mobile platforms!  NEXTGEN is no longer defined in the mobile compilers.
{$IFDEF NO_ANSI_TYPES}
  {$UNDEF HAS_AnsiString}
  {$UNDEF HAS_AnsiChar}
  {$UNDEF HAS_PAnsiChar}
  {$UNDEF HAS_PPAnsiChar}
  {$UNDEF HAS_AnsiStrings_StrPLCopy}
  {$UNDEF HAS_AnsiStrings_StrLen}
{$ENDIF}

//IMPORTANT!!!!
//
//In DCC, MACOS means OS X.  In FreePascal, MACOS means MacIntosh System OS Classic.

// DCC defines MACOS for both iOS and OS X platforms, need to differentiate
{$IF DEFINED(MACOS) AND NOT DEFINED(IOS)}
  {$DEFINE OSX}
  {$DEFINE DARWIN}
{$IFEND}

{$IFDEF KYLIXCOMPAT}
  {$linklib c}
{$ENDIF}

// RLebeau 9/5/2013: it would take a lot of work to re-write Indy to support
// both 0-based and 1-based string indexing, so we'll just turn off 0-based
// indexing for now...
//
// RLebeau 5/26/2020: 0-based string indexing via '[]' is turned off by default
// in Delphi 10.4. TStringHelper is always 0-indexed, flat RTL functions are
// always 1-indexed, and now '[]' is 1-indexed again on all platforms -
// {$ZEROBASEDSTRINGS OFF} is the default.

{$IF DEFINED(DCC_XE3_OR_ABOVE) AND (NOT DEFINED(DCC_10_4_OR_ABOVE))}
  {$ZEROBASEDSTRINGS OFF}
{$ENDIF}