unit IdCoreSelectionEditors;

interface

{$I IdCompilerDefines.inc}

uses
  Classes
  {$IFDEF HAS_TSelectionEditor}
    {$IFDEF FPC}
    ,PropEdits
    ,ComponentEditors
    {$ELSE}
    ,DesignIntf
    ,DesignEditors
    {$ENDIF}
  {$ENDIF}
  ;

{$IFDEF HAS_TSelectionEditor}
type
  TIdContextSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
  
  TIdSocketHandleSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

implementation

{$IFDEF HAS_TSelectionEditor}
procedure TIdContextSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdContext');
end;

procedure TIdSocketHandleSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdSocketHandle');
end;
{$ENDIF}

end.
