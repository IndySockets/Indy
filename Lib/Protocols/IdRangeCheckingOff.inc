// TODO: for FreePascal, use {$PUSH} here and {$POP} in IdRangeCheckingOn.inc
{$IFOPT R+} // detect range checking
  {$R-}
  {$DEFINE _RPlusWasEnabled}
{$ENDIF}
