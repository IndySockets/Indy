{$IFNDEF DCC}

  // DCC is defined by the Delphi compiler in XE2 onwards, detect earlier versions

  {$IFDEF CONDITIONALEXPRESSIONS}

    {$IF CompilerVersion >= 24}
      {$LEGACYIFEND ON}
    {$IFEND}

    //Delphi & C++Builder 6 - XE
    {$IF CompilerVersion < 23}
      {$DEFINE DCC}
    {$IFEND}

  {$ENDIF}

{$ENDIF}