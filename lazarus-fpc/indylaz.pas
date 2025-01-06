{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit indylaz;

{$warn 5023 off : no warning about unused units}
interface

uses
  IdDsnBaseCmpEdt, IdDsnCoreResourceStrings, IdDsnPropEdBinding, 
  IdDsnPropEdBindingVCL, IdCoreDsnRegister, IdAboutVCL, IdDsnRegister, 
  IdDsnResourceStrings, IdDsnSASLListEditor, IdDsnSASLListEditorForm, 
  IdDsnSASLListEditorFormVCL, IdAbout, IdRegisterCore, IdRegister, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('IdCoreDsnRegister' , @IdCoreDsnRegister.Register);
  RegisterUnit('IdDsnRegister' , @IdDsnRegister.Register);
  RegisterUnit('IdRegisterCore' , @IdRegisterCore.Register);
  RegisterUnit('IdRegister' , @IdRegister.Register);
end;

initialization
  RegisterPackage('indylaz' , @Register);
end.
