
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1997-1999 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit IdZLibConst;

interface

{$i IdCompilerDefines.inc}

{$IFNDEF FPC}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  {$DEFINE STATICLOAD}
  {$ENDIF}
{$ENDIF}
{$IFNDEF STATICLOAD}
uses
  IdException;
{$ENDIF}

resourcestring
 sTargetBufferTooSmall = 'ZLib error: target buffer may be too small';
 sInvalidStreamOp = 'Invalid stream operation';

{$IFNDEF STATICLOAD} 
RSZLibCallError = 'Error on call to ZLib library function %s';
{$ENDIF}

implementation

end.
 
