{$IFDEF _WPlusWasEnabled}
  {$IFDEF CAN_PUSHPOP_OPTIONS}
    {$I IdCompilerOptionsPop.inc}
  {$ELSE}
    {$W+}
  {$ENDIF}
  {$UNDEF _WPlusWasEnabled}
{$ENDIF}
