{$IFDEF _RPlusWasEnabled}
  {$IFDEF CAN_PUSHPOP_OPTIONS}
    {$I IdCompilerOptionsPop.inc}
  {$ELSE}
    {$R+}
  {$ENDIF}
  {$UNDEF _RPlusWasEnabled}
{$ENDIF}
