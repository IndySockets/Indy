{$IFOPT Q+} // detect overflow checking
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$PUSH}
  {$ENDIF}
  {$Q-}
  {$DEFINE _QPlusWasEnabled}
{$ENDIF}
