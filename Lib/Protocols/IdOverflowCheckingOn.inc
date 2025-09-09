{$IFDEF _QPlusWasEnabled}
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$POP}
  {$ELSE}
    {$Q+}
  {$ENDIF}
  {$UNDEF _QPlusWasEnabled}
{$ENDIF}
