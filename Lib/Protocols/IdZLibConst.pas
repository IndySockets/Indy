
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1997-1999 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit IdZLibConst;

interface

{$I IdCompilerDefines.inc}

{$UNDEF STATICLOAD_ZLIB}
{
TODO:  Wait for Emb to decide how to approach ZLib for their 64-bit support
before we proceed at our end.
}
{$IFDEF DCC}
  {$IFDEF WIN32}
    {$IFNDEF BCB5_DUMMY_BUILD}
      {$DEFINE STATICLOAD_ZLIB}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFNDEF STATICLOAD_ZLIB}
uses
  IdException;
{$ENDIF}

resourcestring
  sTargetBufferTooSmall = 'ZLib error: target buffer may be too small';
  sInvalidStreamOp = 'Invalid stream operation';

  sZLibError = 'ZLib Error (%d)';

  {$IFNDEF STATICLOAD_ZLIB}
  RSZLibCallError = 'Error on call to ZLib library function %s';
  {$ENDIF}

implementation

end.
 
