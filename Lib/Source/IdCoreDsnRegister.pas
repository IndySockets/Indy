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
  Rev 1.4    12/10/2004 15:36:40  HHariri
  Fix so it works with D8 too

  Rev 1.3    9/5/2004 2:08:14 PM  JPMugaas
  Should work in D9 NET.

  Rev 1.2    2/3/2004 11:42:52 AM  JPMugaas
  Fixed for new design.

  Rev 1.1    2/1/2004 2:44:20 AM  JPMugaas
  Bindings editor should be fully functional including IPv6 support.

  Rev 1.0    11/13/2002 08:41:18 AM  JPMugaas
}

unit IdCoreDsnRegister;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF FPC}
  PropEdits,
  ComponentEditors
  {$ELSE}
  DesignIntf,
  DesignEditors
  {$ENDIF}
  ;

type
  TIdBaseComponentEditor = class({$IFDEF FPC}TDefaultComponentEditor{$ELSE}TDefaultEditor{$ENDIF})
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TIdPropEdBinding = class({$IFDEF FPC}TPropertyEditor{$ELSE}TClassProperty{$ENDIF})
  {$IFDEF FPC}
  protected
    FValue : String;
    property Value : String read FValue write FValue;
    {$ENDIF}
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

// Procs
procedure Register;

implementation

uses
  Classes,
  IdDsnPropEdBindingVCL,
  IdAboutVCL,
  {$IFDEF DCC}
  ToolsAPI,
  SysUtils,
  {$IFEND}
  IdDsnCoreResourceStrings,
  IdBaseComponent,
  IdComponent,
  IdGlobal,
  IdStack,
  IdSocketHandle;

type
  TIdPropEdBindingEntry = TIdDsnPropEdBindingVCL;

procedure TIdPropEdBinding.Edit;
var
  pSockets: TIdSocketHandles;
  pEntry: TIdPropEdBindingEntry;
begin
  inherited Edit;

  pSockets := TIdSocketHandles({$IFDEF CPU64}GetInt64Value{$ELSE}GetOrdValue{$ENDIF});

  pEntry := TIdPropEdBindingEntry.Create;
  try
    pEntry.Caption := TComponent(GetComponent(0)).Name;
    pEntry.DefaultPort := pSockets.DefaultPort;
    Value := GetListValues(pSockets);
    pEntry.SetList(Value);
    if pEntry.Execute then
    begin
      Value := pEntry.GetList;
      FillHandleList(Value, pSockets);
    end;
  finally
    pEntry.Free;
  end;
end;

function TIdPropEdBinding.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

function TIdPropEdBinding.GetValue: string;
var
  pSockets: TIdSocketHandles;
begin
  pSockets := TIdSocketHandles({$IFDEF CPU64}GetInt64Value{$ELSE}GetOrdValue{$ENDIF});
  Result := GetListValues(pSockets);
end;

procedure TIdPropEdBinding.SetValue(const Value: string);
var
  pSockets: TIdSocketHandles;
begin
  inherited SetValue(Value);
  pSockets := TIdSocketHandles({$IFDEF CPU64}GetInt64Value{$ELSE}GetOrdValue{$ENDIF});
  pSockets.BeginUpdate;
  try
    FillHandleList(Value, pSockets);
  finally
    pSockets.EndUpdate;
  end;
end;

{ TIdBaseComponentEditor }

procedure TIdBaseComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 : TfrmAbout.ShowDlg;
  end;
end;

function TIdBaseComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := IndyFormat(RSAAboutMenuItemName, [gsIdVersion]);
  end;
end;

function TIdBaseComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TIdSocketHandles), nil, '', TIdPropEdBinding);    {Do not Localize}
  RegisterComponentEditor(TIdBaseComponent, TIdBaseComponentEditor);
end;

{$IFDEF DCC}
var
  AboutBoxServices: IOTAAboutBoxServices = nil;
  AboutBoxIndex: Integer = -1;

procedure RegisterAboutBox;
begin
  if Supports(BorlandIDEServices, IOTAAboutBoxServices, AboutBoxServices) then
  begin
    AboutBoxIndex := AboutBoxServices.AddPluginInfo(
      RSAAboutBoxCompName + ' ' + gsIdVersion,
      RSAAboutBoxDescription + sLineBreak + sLineBreak
        + RSAAboutBoxCopyright + sLineBreak + sLineBreak
        + RSAAboutBoxPleaseVisit + sLineBreak + RSAAboutBoxIndyWebsite,
      0,
      False,
      RSAAboutBoxLicences,
      '');
  end;
end;

procedure UnregisterAboutBox;
begin
  if (AboutBoxIndex <> -1) and (AboutBoxServices <> nil) then
  begin
    AboutBoxServices.RemovePluginInfo(AboutBoxIndex);
  end;
end;

initialization
  RegisterAboutBox;
finalization
  UnregisterAboutBox;

{$ENDIF}

end.
