{$IFOPT I+} // detect IO checking
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$PUSH}
  {$ENDIF}
  {$I-}
  {$DEFINE _IPlusWasEnabled}
{$ENDIF}
