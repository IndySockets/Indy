{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11930: IdDsnBaseCmpEdt.pas 
{
{   Rev 1.2    9/5/2004 2:08:16 PM  JPMugaas
{ Should work in D9 NET.
}
{
{   Rev 1.1    2/3/2004 11:42:50 AM  JPMugaas
{ Fixed for new design.
}
{
{   Rev 1.0    11/13/2002 08:43:16 AM  JPMugaas
}
unit IdDsnBaseCmpEdt;

{$I IdCompilerDefines.inc}

interface

uses
  {$IFDEF VCL9ORABOVE}
     {$IFDEF DOTNET}
      Borland.Vcl.Design.DesignIntF,
      Borland.Vcl.Design.DesignEditors;
     {$ELSE}
      DesignIntf, 
      DesignEditors;
     {$ENDIF}
  {$ELSE}
    {$IFDEF VCL6ORABOVE}
      DesignIntf, 
      DesignEditors;
    {$ELSE}
       Dsgnintf;
    {$ENDIF}
  {$ENDIF}

type
  TIdBaseComponentEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  IdAbout,
  IdGlobal,
  IdDsnCoreResourceStrings,
  SysUtils;

{ TIdBaseComponentEditor }

procedure TIdBaseComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 : ShowAboutBox(RSAAboutBoxCompName, gsIdVersion);
  end;
end;

function TIdBaseComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := Format(RSAAboutMenuItemName, [gsIdVersion]);
  end;
end;

function TIdBaseComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
 
