{$IFDEF _QPlusWasEnabled}
  {$IFDEF CAN_PUSHPOP_OPTIONS}
    {$I IdCompilerOptionsPop.inc}
  {$ELSE}
    {$Q+}
  {$ENDIF}
  {$UNDEF _QPlusWasEnabled}
{$ENDIF}
