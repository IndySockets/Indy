{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  93683: PackageFTPParsers.pas 
{
{   Rev 1.4    04/09/2004 12:45:16  ANeillans
{ Moved the databasename and output paths into a globally accessible variable
{ -- makes it a lot easier to override if you need to (as I did for my local
{ file structure).
}
{
{   Rev 1.3    2004.06.13 8:42:42 PM  czhower
{ Added name.
}
{
{   Rev 1.2    2004.06.13 8:06:14 PM  czhower
{ Update for D8
}
{
{   Rev 1.1    6/8/2004 3:52:52 PM  JPMugaas
{ FTP List generation should work.
}
{
{   Rev 1.0    6/8/2004 2:15:50 PM  JPMugaas
{ FTP Listing unit generation.
}
unit PackageFTPParsers;

interface
uses
  Package;

type
  TFTPParsers = class(TPackage)
  protected
    function ExtractNoExt(const AFileName : String) : String;
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler); override;
  end;

implementation
uses
  IdGlobal,
  SysUtils, DModule;

{ TFTPParsers }

constructor TFTPParsers.Create;
begin
  inherited;
  FName := 'IdAllFTPListParsers';
  FExt := '.pas';
end;

function TFTPParsers.ExtractNoExt(const AFileName: String): String;
begin
  Result := AFileName;
  Result := Fetch(Result,'.',False);
end;

procedure TFTPParsers.Generate(ACompiler: TCompiler);
var
    i: Integer;
begin
  inherited;
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.
  Code('unit IdAllFTPListParsers;');
  Code('');
  Code('interface');
  Code('{');
  Code('Note that is unit is simply for listing ALL FTP List parsers in Indy.');
  Code('The user could then add this unit to a uses clause in their program and');
  Code('have all FTP list parsers linked into their program.');
  Code('');
  Code('ABSOLELY NO CODE is permitted in this unit.');
  Code('');
  Code('}');
  //Now add our units
   Code('');
  Code('implementation');
  Code('uses');
  for i := 0 to FUnits.Count - 1 do begin
    Code('  ' + ExtractNoExt( FUnits[i]) + iif(i < FUnits.Count - 1, ',', ';'));
  end;
//
  Code('');
  Code('{dee-duh-de-duh, that''s all folks.}');
  WriteFile(DM.OutputPath + '\Lib\Protocols\');
end;

end.

