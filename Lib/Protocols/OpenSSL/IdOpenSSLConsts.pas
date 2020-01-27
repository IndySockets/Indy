unit IdOpenSSLConsts;

interface

{$i IdCompilerDefines.inc}

const
  CLibCrypto =
    {$IFDEF CPU32}'libcrypto-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}'libcrypto-1_1-x64.dll'{$ENDIF}
    ;
  CLibSSL =
    {$IFDEF CPU32}'libssl-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}'libssl-1_1-x64.dll'{$ENDIF}
    ;

implementation

end.
