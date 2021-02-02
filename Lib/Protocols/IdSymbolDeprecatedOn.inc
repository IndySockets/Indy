// TODO: for FreePascal, use {$PUSH} in IdSymbolDeprecatedOff.inc and {$POP} here
{$IFDEF HAS_DEPRECATED}
  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN SYMBOL_DEPRECATED DEFAULT}
  {$ELSE}
    {$WARN SYMBOL_DEPRECATED ON}
  {$ENDIF}
{$ENDIF}

