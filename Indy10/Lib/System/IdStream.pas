unit IdStream;

interface

{$I IdCompilerDefines.inc}

uses
{$IFDEF DotNet}
  IdStreamNET
{$ELSE}
  IdStreamVCL
{$ENDIF};

type
{$IFDEF DotNet}
  TIdStreamHelper = TIdStreamHelperNET;
{$ELSE}
  TIdStreamHelper = TIdStreamHelperVCL;
{$ENDIF}

implementation

end.

