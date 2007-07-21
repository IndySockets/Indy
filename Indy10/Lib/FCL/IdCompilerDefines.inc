// General

// Make this $DEFINE to use the 16 color icons required by Borland
// or DEFINE to use the 256 color Indy versions
{DEFINE Borland}

// S.G. 4/9/2002: IPv4/IPv6 general switch (for defaults only)
{$DEFINE IdIPv4}

{$DEFINE INDY100}

{$IFDEF BCB}
  {$DEFINE CBUILDER}
{$ELSE}
  {$DEFINE DELPHI}
{$ENDIF}

// Delphi 4
{$IFDEF VER120}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL40}
  {$DEFINE DELPHI4}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE MSWINDOWS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
 {$define win32_or_win64}
  {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCL}
{$ENDIF}

// C++ Builder 4
{$IFDEF VER125}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL40}
  {$DEFINE CBUILDER4}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE MSWINDOWS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
 {$define win32_or_win64}
  {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCL}
  {$define WidgetVCLLikeOrKylix}
{$ENDIF}

// Delphi 5 & CBuilder 5
{$IFDEF VER130}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL5}
  {$IFDEF BCB}
    {$DEFINE CBUILDER5}
  {$ELSE}
    {$DEFINE DELPHI5}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE MSWINDOWS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
 {$define win32_or_win64}
   {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCL}
  {$define WidgetVCLLikeOrKylix}
{$ENDIF}

//Delphi 6
{$IFDEF VER140}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER6}
    {$DEFINE ALLOW_NAMED_THREADS}
  {$ELSE}
    {$DEFINE DELPHI6}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL60}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
 {$define win32_or_win64}
   {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCL}
  {$define VCL60plus}
  {$define WidgetVCLLikeOrKylix}
{$ENDIF}

//Delphi 7
{$IFDEF VER150}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL70}
  {$IFDEF BCB}
    {$DEFINE CBUILDER7}
  {$ELSE}
    {$DEFINE DELPHI7}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
 {$define win32_or_win64}
  {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCLLikeOrKylix}
  {$define WidgetVCL}
  {$define VCL60plus}
{$ENDIF}

//Delphi 8
{$IFDEF VER160}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL80}
  {$DEFINE DELPHI8}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
  //Widget defines are omitted since D8 only supports NET
{$ENDIF}

//Delphi 9 - 2005
{$IFDEF VER170}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL90}
  {$DEFINE DELPHI9}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
   {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
   {$define win32_or_win64}
  {$ifndef CIL}
    {$define WidgetVCLLike} // LCL included.
    {$define WidgetVCLLikeOrKylix}
    {$define WidgetVCL}
    {$define VCL60plus}
  {$endif}
{$ENDIF}

//Delphi 10 - Delphi 2006, Delphi 2007
{$IFDEF VER180}
  {$DEFINE USEINLINE}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL10}
  {$DEFINE DELPHI10}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
   {$define win32_or_win64}
     {$define Wi dgetVCLLike} // LCL included.
    {$define WidgetVCL}
    {$define WidgetVCLLikeOrKylix}
    {$define VCL60plus}
{$ENDIF}

//Delphi 11 - 2007
{$IFDEF VER185}

  {$DEFINE USEINLINE}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL11ORABOVE}
  {$UNDEF DELPHI10}
  {$UNDEF VCL10}
  {$DEFINE VCL11}
  {$DEFINE DELPHI11}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
  {$DEFINE TFormatSettings}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
   {$define win32_or_win64}
  {$ifndef CIL}
    {$define WidgetVCLLike} // LCL included.
    {$define WidgetVCLLikeOrKylix}
    {$define WidgetVCL}
    {$define VCL60plus}
  {$endif}
{$ENDIF}

{$IFDEF CIL}
  {$define WidgetWinForms}
{$ENDIF}

//Delphi.NET
// Covers D8+
{$IFDEF CIL}
  {$define i386}
  {$define ENDIAN_LITTLE}
  {$define CPU32}
  {$define WidgetWinForms}
  // Platform specific conditional. Used for platform specific code.
  {$DEFINE DotNet}
  //differences in DotNET Framework versions.
  {$IFDEF VCL11ORABOVE}
     {$DEFINE DotNet2}
  {$ELSE}
     {$DEFINE DotNet1}
  {$ENDIF}
  // Extra include used in D7 for testing. Remove later when all comps are
  // ported. Used to selectively exclude non ported parts. Allowed in places
  // IFDEFs are otherwise not permitted.
  {$DEFINE DotNetExclude}
{$ENDIF}

// FPC (2+)

{$IFDEF FPC}
  {$MODE Delphi}
  {$define WidgetVCLLike} // LCL included.
  {$define WidgetVCLLikeOrKylix}
  {$define UseTBitBtn} //use Bit Buttons instead of Buttons
  {$define WidgetLCL}
  //note that we may need further defines for widget types depending on
  //what we do and what platforms we support in FPC.
  //I'll let Marco think about that one.
  {$IFDEF UNIX}
     {$IFDEF LINUX}
     //In Linux, you can either use USELIBC or USEBASEUNIX.
     //If you choose USELIBC, you need to modify the Makefile.fpc in
     //in the System folder and generate the Makefile (preferably with the
     //complete source tree.
        {.$DEFINE USELIBC}
        {$DEFINE USEBASEUNIX}
     {$ELSE}
        {$DEFINE USEBASEUNIX}
     {$ENDIF}
  {$ENDIF}
  {$IF defined(win32) or defined(win64)}
    {$define win32_or_win64}
  {$ifend}
  //so we can use IdWinsock2 in WinCE, maybe in other places in Indy as well -CYA
  {$IF defined(wince)} 
    {$DEFINE UNICODE} //CE is UNICODE ONLY
    {$define win32_or_win64_or_winCE}
  {$IFEND}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL70}
  {$DEFINE DELPHI7}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
  {$DEFINE NO_TMultiReadExclusiveWriteSynchronizer}
   {$DEFINE FPC_REINTRODUCE_BUG}
   {$DEFINE FPC_CircularBug}
   {$DEFINE NoRedeclare}
   {$DEFINE ByteCompareSets}
{$ENDIF}

// Kylix
//
//Important:  Don't use CompilerVersion here as
//$IF's are evaluated before $IFDEF's
//and Kylix 1 does not have CompilerVersion defined at all.
{$IFDEF LINUX}
  {$IFDEF CONDITIONALEXPRESSIONS}
    {$IF RTLVersion = 14.0}
      {$DEFINE KYLIX1}
      {$DEFINE KYLIX1ORABOVE}
    {$IFEND}
    {$IF RTLVersion = 14.2}
      {$DEFINE KYLIX2}
      {$DEFINE USEZLIBUNIT}
      {$DEFINE KYLIX1ORABOVE}
      {$DEFINE KYLIX2ORABOVE}
    {$IFEND}
    {$IF RTLVersion = 14.5}
      {$DEFINE KYLIX3}
      {$DEFINE USEZLIBUNIT}
      {$DEFINE KYLIX1ORABOVE}
      {$DEFINE KYLIX2ORABOVE}
      {$DEFINE KYLIX3ORABOVE}
    {$IFEND}
  {$ENDIF}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL60}
  {$define WidgetKylix}
  {$define WidgetVCLLikeOrKylix}  
{$ENDIF}

{$ifdef win32_or_win64}
   {$define win32_or_win64_or_winCE}
{$endif}
