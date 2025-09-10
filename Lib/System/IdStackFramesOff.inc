{$IFOPT W+} // detect stack frames
  {$I IdCompilerOptionsPush.inc}
  {$W-} // turn off stack frames
  {$DEFINE _WPlusWasEnabled}
{$ENDIF}
