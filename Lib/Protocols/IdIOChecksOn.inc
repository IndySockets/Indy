{$IFDEF _IPlusWasEnabled} // detect previous setting
  {$IFDEF CAN_PUSHPOP_OPTIONS}
    {$I IdCompilerOptionsPop.inc}
  {$ELSE}
    {$I+}
  {$ENDIF}
  {$UNDEF _IPlusWasEnabled}
{$ENDIF}
