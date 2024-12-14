// In FreePascal, if the -CR compiler option (Verify object method call validity) is enabled,
// the compiler emits code to make class methods raise an error if their Self pointer is nil
// (this is documented behavior), BUT the compiler will ALSO silently change object hard-casts
// into the 'as' operator (this is undocumented behavior!).  This change breaks any place that
// Indy uses Accessor Classes to reach protected class members across unit boundaries. This is
// usually not a problem when Indy is compiled into its own package, but if Indy's source is
// compiled directly into a project that happens to be using -CR, this becomes a big problem.
// So, we have to turn off that compiler option everywhere that Accessor Classes are being used...
{$IFDEF FPC}
  {$PUSH}
  {$OBJECTCHECKS OFF}
{$ENDIF}
