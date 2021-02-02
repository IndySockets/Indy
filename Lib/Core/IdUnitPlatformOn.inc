// TODO: for FreePascal, use {$PUSH} in IdUnitPlatformOff.inc and {$POP} here
{$IFDEF HAS_UNIT_PLATFORM}
  {$IFDEF HAS_DIRECTIVE_WARN_DEFAULT}
    {$WARN UNIT_PLATFORM DEFAULT}
  {$ELSE}
    {$WARN UNIT_PLATFORM ON}
  {$ENDIF}
{$ENDIF}

