{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
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
  public
    constructor Create; override;
    procedure Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags); override;
  end;

implementation

uses
  SysUtils, DModule;

{ TFTPParsers }

constructor TFTPParsers.Create;
begin
  inherited;
  FOutputSubDir := 'Lib\Protocols';
end;

procedure TFTPParsers.Generate(ACompiler: TCompiler; const AFlags: TGenerateFlags);
var
  i: Integer;
begin
  //We don't call many of the inherited Protected methods because
  //those are for Packages while I'm making a unit.
  //inherited;

  FName := 'IdAllFTPListParsers';
  FExt := '.pas';

  FCompiler := ACompiler;
  FCode.Clear;
  FDesignTime := False;

  Code('unit IdAllFTPListParsers;');
  Code('');
  Code('interface');
  Code('');
  Code('{$I IdCompilerDefines.inc}');
  Code('');
  Code('{');
  Code('Note that is unit is simply for listing ALL FTP List parsers in Indy.');
  Code('The user could then add this unit to a uses clause in their program and');
  Code('have all FTP list parsers linked into their program.');
  Code('');
  Code('ABSOLELY NO CODE is permitted in this unit.');
  Code('');
  Code('}');
  Code('');
  Code('// RLebeau 4/17/10: this forces C++Builder to link to this unit so');
  Code('// the units can register themselves correctly at program startup...');
  Code('');
  Code('{$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}');
  Code('  {$HPPEMIT LINKUNIT}');
  Code('{$ELSE}');
  Code('  {$HPPEMIT ''#pragma link "IdAllFTPListParsers"''}');
  Code('{$ENDIF}');
  //Now add our units
  Code('');
  Code('implementation');
  Code('');
  Code('uses');
  for i := 0 to FUnits.Count - 1 do begin
    Code('  ' + ChangeFileExt(FUnits[i], '') + iif(i < FUnits.Count - 1, ',', ';'));
  end;
  //
  Code('');
  Code('{dee-duh-de-duh, that''s all folks.}');
  Code('');
  Code('end.');

  WriteFile;
end;

end.

