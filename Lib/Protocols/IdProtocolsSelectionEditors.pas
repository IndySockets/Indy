unit IdProtocolsSelectionEditors;

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
  TIdGlobalSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TIdWebDAVSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TIdWhoIsServerSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

implementation

{$IFDEF HAS_TSelectionEditor}

procedure TIdGlobalSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdGlobal');
end;

procedure TIdWebDAVSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdAuthentication');
  Proc('IdHeaderList');
end;

procedure TIdWhoIsServerSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdContext');
  Proc('IdSocketHandle');
  Proc('IdThread');
end;

{$ENDIF}

end.
