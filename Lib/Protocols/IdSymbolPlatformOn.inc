// TODO: for FreePascal, use {$PUSH} in IdSymbolPlatformOff.inc and {$POP} here
{$IFDEF HAS_SYMBOL_PLATFORM}
  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN SYMBOL_PLATFORM DEFAULT}
  {$ELSE}
    {$WARN SYMBOL_PLATFORM ON}
  {$ENDIF}
{$ENDIF}

