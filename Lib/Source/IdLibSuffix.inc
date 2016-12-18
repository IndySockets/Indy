// {$LIBSUFFIX} was added in Delphi/C++Builder 6, the same version
// that CONDITIONALEXPRESSIONS and {$IF} were added...

{$IFDEF CONDITIONALEXPRESSIONS}

  // Must be at the top...
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON}
  {$IFEND}

  {$IF CompilerVersion >= 33}
    {$MESSAGE WARN 'Unsupported compiler version detected!'}

  //Delphi & CBuilder 10.2 Tokyo (Godzilla)
  {$ELSEIF CompilerVersion >= 32}
    {$LIBSUFFIX '250'}

  //Delphi & CBuilder 10.1 Berlin (BigBen)
  {$ELSEIF CompilerVersion >= 31}
    {$LIBSUFFIX '240'}

  //Delphi & CBuilder 10.0 Seattle (Aitana)
  {$ELSEIF CompilerVersion >= 30}
    {$LIBSUFFIX '230'}

  //Delphi & CBuilder XE8 (Elbrus)
  {$ELSEIF CompilerVersion >= 29}
    {$LIBSUFFIX '220'}

  //Delphi & CBuilder XE7 (Carpathia)
  {$ELSEIF CompilerVersion >= 28}
    {$LIBSUFFIX '210'}

  //Delphi & CBuilder XE6 (Proteus)
  {$ELSEIF CompilerVersion >= 27}
    {$LIBSUFFIX '200'}

  //Delphi & CBuilder XE5 (Zephyr)
  //Delphi & C++Builder AppMethod is XE5 for mobile only, VCL is removed
  {$ELSEIF CompilerVersion >= 26}
    {$LIBSUFFIX '190'}

  //Delphi & CBuilder XE4 (Quintessence)
  {$ELSEIF CompilerVersion >= 25}
    {$LIBSUFFIX '180'}

  //Delphi & CBuilder XE3 (Waterdragon)
  //Delphi & CBuilder XE3.5 (Quintessence - early betas only)
  {$ELSEIF CompilerVersion >= 24}
    {$LIBSUFFIX '170'}

  //Delphi & CBuilder XE2 (Pulsar)
  {$ELSEIF CompilerVersion >= 23}
    {$LIBSUFFIX '160'}

  //Delphi & C++Builder XE (Fulcrum)
  {$ELSEIF CompilerVersion >= 22}
    {$LIBSUFFIX '150'}

  //Delphi & C++Builder 2010 (Weaver)
  {$ELSEIF CompilerVersion >= 21}
    {$LIBSUFFIX '140'}

  // LIBSUFFIX 130 was skipped between 2009 and 2010

  //Delphi & C++Builder 2009 (Tiburon)
  {$ELSEIF CompilerVersion >= 20}
    {$LIBSUFFIX '120'}

  // BDS 2007 NET personality uses VER190 instead of 185.
  // Delphi .NET 2007
  {$ELSEIF CompilerVersion >= 19}
    {$IFDEF CIL}
      //Delphi 2007
      {$LIBSUFFIX '110'}
    {$ENDIF}

  // NOTE: CodeGear decided to make Highlander be a non-breaking release
  // (no interface changes, thus fully backwards compatible without any
  // end user code changes), so VER180 applies to both BDS 2006 and
  // Highlander prior to the release of RAD Studio 2007.  Use VER185 to
  // identify Highlanger specifically.

  //Delphi & C++Builder 2007 (Highlander)
  {$ELSEIF CompilerVersion >= 18.5}
    {$LIBSUFFIX '110'}

  //Delphi & C++Builder 2006
  {$ELSEIF CompilerVersion >= 18}
    {$LIBSUFFIX '100'}

  //Delphi 2005
  {$ELSEIF CompilerVersion >= 17}
    {$LIBSUFFIX '90'}

  //Delphi 8
  {$ELSEIF CompilerVersion >= 16}
    {$LIBSUFFIX '80'}

  //Delphi 7
  {$ELSEIF CompilerVersion >= 15}
    {$LIBSUFFIX '70'}

  //Delphi & C++Builder 6, Kylix 1-3
  {$ELSEIF CompilerVersion >= 14}
    {$IFDEF LINUX}
      {$IF CompilerVersion = 14.5}
        {$LIBSUFFIX 'K3'}
      {$ELSEIF CompilerVersion >= 14.2}
        {$LIBSUFFIX 'K2'}
      {$ELSE}
        {$LIBSUFFIX 'K1'}
      {$IFEND}
    {$ELSE}
      {$LIBSUFFIX '60'}
    {$ENDIF}
  {$ENDIF}

  {$ELSE}
    {$MESSAGE WARN 'Unsupported compiler version detected!'}

  {$IFEND}

{$ENDIF}
