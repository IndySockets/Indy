// TODO: for FreePascal, use {$PUSH} in IdIOChecksOff.inc and {$POP} here
{$IFDEF _IPlusWasEnabled} // detect previous setting
  {$UNDEF _IPlusWasEnabled}
  {$I+}
{$ENDIF}
