{$IFOPT W+} // detect stack frames
  {$IFDEF HAS_DIRECTIVE_PUSHPOP}
    {$PUSH}
  {$ENDIF}
  {$W-} // turn off stack frames
  {$DEFINE _WPlusWasEnabled}
{$ENDIF}
