// TODO: for FreePascal, use {$PUSH} here and {$POP} in IdOverflowCheckingOn.inc
{$IFOPT Q+} // detect overflow checking
  {$Q-}
  {$DEFINE _QPlusWasEnabled}
{$ENDIF}
