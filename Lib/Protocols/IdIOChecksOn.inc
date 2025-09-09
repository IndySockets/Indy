{$IFDEF _IPlusWasEnabled} // detect previous setting
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$POP}
  {$ELSE}
    {$I+}
  {$ENDIF}
  {$UNDEF _IPlusWasEnabled}
{$ENDIF}
