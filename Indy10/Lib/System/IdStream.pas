unit IdStream;

interface

uses
{$IFDEF DotNetDistro}
  IdStreamNET
{$ELSE}
  IdStreamVCL
{$ENDIF};

type
{$IFDEF DotNetDistro}
  TIdStreamHelper = TIdStreamHelperNET;
{$ELSE}
  TIdStreamHelper = TIdStreamHelperVCL;
{$ENDIF}

implementation

end.

