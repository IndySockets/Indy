{$IFDEF _RPlusWasEnabled}
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$POP}
  {$ELSE}
    {$R+}
  {$ENDIF}
  {$UNDEF _RPlusWasEnabled}
{$ENDIF}
