// TODO: for FreePascal, use {$PUSH} here and {$POP} in IdIOChecksOn.inc
{$IFOPT I+} // detect IO checking
  {$DEFINE _IPlusWasEnabled}
  {$I-}
{$ENDIF}
