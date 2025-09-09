{$IFOPT R+} // detect range checking
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$PUSH}
  {$ENDIF}
  {$R-}
  {$DEFINE _RPlusWasEnabled}
{$ENDIF}
