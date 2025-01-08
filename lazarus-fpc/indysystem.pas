{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit indysystem;

{$warn 5023 off : no warning about unused units}
interface

uses
  IdBaseComponent, IdComponent, IdCTypes, IdException, IdGlobal, IdIDN, 
  IdResourceStrings, IdResourceStringsIconv, IdResourceStringsKylixCompat, 
  IdResourceStringsTextEncoding, IdResourceStringsUnix, IdStack, 
  IdStackBSDBase, IdStackConsts, IdStream, IdStruct, IdTransactedFileStream, 
  IdWinsock2, IdWship6, IdAntiFreezeBase, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('indysystem', @Register);
end.
