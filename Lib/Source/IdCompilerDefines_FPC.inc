// In FreePascal 3.0.0+, a Delphi-like UnicodeString type is supported.
// String/(P)Char map to UnicodeString/(P)WideChar if {$MODE DelphiUnicode}
// or {$MODESWITCH UnicodeStrings} is used.  We are enabling them so Indy
// uses the same Unicode logic in Delphi 2009+ and FreePascal 3.0.0+ and
// reduces IFDEFs (in particular, STRING_UNICODE_MISMATCH, see further below).
// However, FreePascal's RTL is largely not UnicodeString-enabled yet, so we
// will have to deal with that as needed...
{$MODE DelphiUnicode}

//note that we may need further defines for widget types depending on
//what we do and what platforms we support in FPC.
//I'll let Marco think about that one.
{$IFDEF UNIX}
  //In Linux for I386, you can choose between a Kylix-libc API or
  //the standard RTL Unix API.  Just pass -dKYLIXCOMPAT to the FPC compiler.
  //I will see what I can do about the Makefile.
  {$IF DEFINED(LINUX) AND DEFINED(KYLIXCOMPAT) AND DEFINED(CPUI386)}
    {$UNDEF USE_BASEUNIX}
  {$ELSE}
    {$DEFINE USE_BASEUNIX}
  {$IFEND}
  {$IFDEF USE_BASEUNIX}
    {$UNDEF KYLIXCOMPAT}
  {$ENDIF}
{$ENDIF}

// detect compiler version

{$MACRO ON} // must be on in order to use versioning macros

{$IF FPC_FULLVERSION < 30000}
  {$Warning Unsupported compiler version detected!}
{$IFEND}

{$DEFINE FPC_2_1_5_OR_ABOVE}
{$DEFINE FPC_2_2_0_OR_ABOVE}
{$DEFINE FPC_2_2_2_OR_ABOVE}
{$DEFINE FPC_2_2_4_OR_ABOVE}
{$DEFINE FPC_2_4_0_OR_ABOVE}
{$DEFINE FPC_2_4_2_OR_ABOVE}
{$DEFINE FPC_2_4_4_OR_ABOVE}
{$DEFINE FPC_2_6_0_OR_ABOVE}
{$DEFINE FPC_2_6_2_OR_ABOVE}
{$DEFINE FPC_2_6_4_OR_ABOVE}
{$DEFINE FPC_2_7_1_OR_ABOVE}
{$DEFINE FPC_3_0_0_OR_ABOVE}

// FreePascal's RTL mimic D7's RTL
// TODO: replace these with appropriate HAS_xxx defines instead...
{$DEFINE DCC_7}
{$DEFINE DELPHI_7}
{$DEFINE DCC_4_OR_ABOVE}
{$DEFINE DCC_5_OR_ABOVE}
{$DEFINE DCC_6_OR_ABOVE}
{$DEFINE DCC_7_OR_ABOVE}

// support for RawByteString and UnicodeString
// note enabling these yet since FreePascal's RTL does not mimic D2009's RTL yet
{.$DEFINE DCC_8_OR_ABOVE}
{.$DEFINE DCC_2005_OR_ABOVE}
{.$DEFINE DCC_2006_OR_ABOVE}
{.$DEFINE DCC_2007_OR_ABOVE}
{.$DEFINE DCC_2009}
{.$DEFINE DCC_2009_OR_ABOVE}
{.$DEFINE DELPHI_2009}

// available features

{.$DEFINE HAS_RemoveFreeNotification}
{$DEFINE STREAM_SIZE_64}
{$DEFINE HAS_GetObjectProp}
{$DEFINE HAS_TObjectList}
{$DEFINE HAS_PCardinal}
{$DEFINE HAS_PByte}
{$DEFINE HAS_PWord}
{$DEFINE HAS_PPointer}
{$DEFINE HAS_TList_Assign}
{$DEFINE HAS_sLineBreak}
{$DEFINE HAS_RaiseLastOSError}
{$DEFINE HAS_SysUtils_IncludeExcludeTrailingPathDelimiter}
{$DEFINE HAS_SysUtils_DirectoryExists}
{$DEFINE HAS_UNIT_DateUtils}
{$DEFINE HAS_UNIT_StrUtils}
{$DEFINE HAS_UNIT_Types}
{$DEFINE HAS_TryStrToInt}
{$DEFINE HAS_TryStrToInt64}
{$DEFINE HAS_TryEncodeDate}
{$DEFINE HAS_TryEncodeTime}
{$DEFINE HAS_ENUM_ELEMENT_VALUES}
{.$DEFINE HAS_IInterface}
{.$DEFINE HAS_TSelectionEditor}
{.$DEFINE HAS_TStringList_CaseSensitive}
{.$DEFINE HAS_SYMBOL_PLATFORM}
{.$DEFINE HAS_UNIT_PLATFORM}
{$DEFINE HAS_TFormatSettings}
{$DEFINE HAS_PosEx}
{$DEFINE HAS_STATIC_TThread_Queue}
{$DEFINE HAS_STATIC_TThread_Synchronize}
{$DEFINE USE_INLINE}
{$DEFINE USE_CLASSINLINE}
{$DEFINE USE_TBitBtn} //use Bit Buttons instead of Buttons
{$DEFINE FPC_REINTRODUCE_BUG}
{$DEFINE FPC_CIRCULAR_BUG}
{$DEFINE NO_REDECLARE}
{$DEFINE BYTE_COMPARE_SETS}
{$DEFINE HAS_QWord}
{$DEFINE HAS_PQWord}
{$DEFINE HAS_UInt64}
{.$DEFINE HAS_PUInt64} // TODO: is this defined?
{$DEFINE HAS_InterlockedCompareExchange_Pointers}
{$DEFINE HAS_SharedSuffix}
// size_t and psize_t are only available on Unix systems (FreeBSD, Linux, etc)
{$IFDEF UNIX}
  {$DEFINE HAS_SIZE_T}
  {$DEFINE HAS_PSIZE_T}
{$ENDIF}
{$DEFINE HAS_PtrInt}
{$DEFINE HAS_PtrUInt}
{$DEFINE HAS_PGUID}
{$DEFINE HAS_LPGUID}
{$DEFINE HAS_PPAnsiChar}
{$DEFINE HAS_ENUM_ELEMENT_VALUES}
{$DEFINE HAS_AcquireExceptionObject}
{$IFDEF WINDOWS}
  {$DEFINE HAS_ULONG_PTR}
  {.$DEFINE HAS_ULONGLONG} // TODO: is this defined?
{$ENDIF}
{$DEFINE HAS_UNIT_ctypes}
{$DEFINE HAS_sLineBreak}
{$DEFINE HAS_UnicodeString}
{$DEFINE DEPRECATED_TThread_SuspendResume}
{$DEFINE HAS_STATIC_TThread_Synchronize}
{$DEFINE HAS_NativeInt}
{$DEFINE HAS_NativeUInt}
{$DEFINE HAS_Int8}
{$DEFINE HAS_UInt8}
{$DEFINE HAS_Int16}
{$DEFINE HAS_UInt16}
{$DEFINE HAS_Int32}
{$DEFINE HAS_UInt32}
{$DEFINE HAS_PInt8}
{$DEFINE HAS_PUInt8}
{$DEFINE HAS_PInt16}
{$DEFINE HAS_PUInt16}
{$DEFINE HAS_PInt32}
{$DEFINE HAS_PUInt32}
{$DEFINE HAS_STATIC_TThread_Queue}

{$IFDEF FPC_REQUIRES_PROPER_ALIGNMENT}
  {$DEFINE REQUIRES_PROPER_ALIGNMENT}
{$ENDIF}

//IMPORTANT!!!!
//
//In DCC, MACOS means OS X.  In FreePascal, MACOS means MacIntosh System OS Classic.
{$IFDEF MACOS}
  {$DEFINE MACOS_CLASSIC}
{$ENDIF}

{$DEFINE WIDGET_VCL_LIKE} // LCL included.
{$DEFINE WIDGET_LCL}

{$IFDEF KYLIXCOMPAT}
  {$linklib c}
{$ENDIF}
