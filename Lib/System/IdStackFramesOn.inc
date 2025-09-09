{$IFDEF _WPlusWasEnabled}
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$POP}
  {$ELSE}
    {$W+}
  {$ENDIF}
  {$UNDEF _WPlusWasEnabled}
{$ENDIF}
