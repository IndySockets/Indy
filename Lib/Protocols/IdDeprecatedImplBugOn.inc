{$IFDEF DEPRECATED_IMPL_BUG}
  // TODO: for FreePascal, use {$PUSH} in IdDeprecatedImplBugOff.inc and {$POP} here
  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN SYMBOL_DEPRECATED DEFAULT}
  {$ELSE}
    {$WARN SYMBOL_DEPRECATED ON}
  {$ENDIF}
{$ENDIF}

