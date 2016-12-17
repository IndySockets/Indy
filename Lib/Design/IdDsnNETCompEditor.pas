unit IdDsnNETCompEditor;

interface
uses
  System.ComponentModel,
  System.ComponentModel.Design;

type
  TIdNetComponentEditor = class(System.ComponentModel.Design.ComponentDesigner)
  protected
    procedure OnVerItemSelected(sender : System.Object; args : System.EventArgs);

  public
    function get_Verbs : DesignerVerbCollection; override;
  end;

implementation
uses
  IdAbout,
  IdGlobal,
  IdDsnCoreResourceStrings,
  IdSys;

{ TIdNetComponentEditor }

function TIdNetComponentEditor.get_Verbs: DesignerVerbCollection;
var LV : DesignerVerb;
begin
  Result := inherited get_Verbs;
  if not Assigned(Result) then
  begin
    Result := DesignerVerbCollection.Create;
  end;
  LV := DesignerVerb.Create(Sys.Format(RSAAboutMenuItemName, [gsIdVersion]),OnVerItemSelected);
  LV.Enabled := True;
  LV.Visible := True;
  Result.Add(LV);
end;

procedure TIdNetComponentEditor.OnVerItemSelected(sender: TObject;
  args: System.EventArgs);
begin
  ShowAboutBox(RSAAboutBoxCompName, gsIdVersion)
end;

end.
