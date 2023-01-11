// {$LIBSUFFIX} was added in Delphi/C++Builder 6, the same version
// that CONDITIONALEXPRESSIONS and {$IF} were added...

// TODO:
{.$SONAME '?.so.?'}
{.$LIBPREFIX ''}
{.$LIBVERSION '?'}

{$IFDEF CONDITIONALEXPRESSIONS}

  // Must be at the top...
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON}
  {$IFEND}

  // NOTE: {$LIBSUFFIX AUTO} was added in 10.4, but it is not supported by the IDE yet!
  // Update: IDE support for AUTO was added in 10.4.1...

  //Delphi & CBuilder 10.4 Sydney (Denali) and later
  {$IF CompilerVersion >= 34}
    {$LIBSUFFIX AUTO} //{$LIBSUFFIX '270'}

  //Delphi & CBuilder 10.3 Rio (Carnival)
  {$ELSEIF CompilerVersion >= 33}
    {$LIBSUFFIX '260'}

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

  {$ELSE}
    {$MESSAGE ERROR 'Unsupported compiler version detected!'}

  {$IFEND}

{$ELSE}
  {$MESSAGE ERROR 'Unsupported compiler version detected!'}
{$ENDIF}
