// TODO: for FreePascal, use {$PUSH} here and {$POP} in IdStackFramesOn.inc
{$IFOPT W+} // detect stack frames
  {$DEFINE _WPlusWasEnabled}
  {$W-} // turn off stack frames
{$ENDIF}
