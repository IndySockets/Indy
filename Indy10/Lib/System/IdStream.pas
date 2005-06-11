unit IdStream;

interface

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

