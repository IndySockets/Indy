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
  {$IFDEF VCL8ORABOVE}
     {$IFDEF DOTNET}
      Borland.Vcl.Design.DesignIntF,
      Borland.Vcl.Design.DesignEditors;
     {$ELSE}
      DesignIntf,
      DesignEditors;
     {$ENDIF}
  {$ELSE}
    {$IFDEF VCL6ORABOVE}
      {$IFDEF FPC}
      PropEdits,
      ComponentEditors;
      {$ELSE}
      DesignIntf, 
      DesignEditors;
      {$ENDIF}
    {$ELSE}
       Dsgnintf;
    {$ENDIF}
  {$ENDIF}

type
  {$IFDEF FPC}
  TIdPropEdBinding = class(TPropertyEditor)
  protected
    FValue : String;
    property Value : String read FValue write FValue;
  {$ELSE}
  TIdPropEdBinding = class(TClassProperty)
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
  IdDsnBaseCmpEdt,
  IdBaseComponent,
  IdComponent,
  IdGlobal,
  IdDsnPropEdBinding,
  IdStack,
  IdSocketHandle;

procedure TIdPropEdBinding.Edit;
var
  pSockets: TIdSocketHandles;
begin
  inherited Edit;
  if PropCount > 0 then
  begin
    with TIdPropEdBindingEntry.Create do
    try

      {$IFNDEF DOTNET}
      pSockets := TIdSocketHandles(GetOrdValue);
      {$ELSE}
      pSockets := GetObjValue as TIdSocketHandles;
      {$ENDIF}
      Caption := TComponent(GetComponent(0)).Name;
      DefaultPort := pSockets.DefaultPort;
      Value := GetListValues(pSockets);
      SetList(Value);
      if Execute then
      begin
        Value := GetList;
        if PropCount > 0 then begin
          FillHandleList(Value, pSockets);
      end;
    end;
    finally
      Free;
    end;
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
  {$IFNDEF DOTNET}
  pSockets := TIdSocketHandles(GetOrdValue);
  {$ELSE}
  pSockets := GetObjValue as TIdSocketHandles;
  {$ENDIF}
  Result := GetListValues(pSockets);
end;

procedure TIdPropEdBinding.SetValue(const Value: string);
var
  pSockets: TIdSocketHandles;
begin
  inherited SetValue(Value);
  {$IFNDEF DOTNET}
  pSockets := TIdSocketHandles(GetOrdValue);
  {$ELSE}
  pSockets := GetObjValue as TIdSocketHandles;
  {$ENDIF}
  pSockets.BeginUpdate;
  try
    FillHandleList(Value, pSockets);
  finally
    pSockets.EndUpdate;
  end;
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TIdSocketHandles), nil, '', TIdPropEdBinding);    {Do not Localize}
  RegisterComponentEditor(TIdBaseComponent, TIdBaseComponentEditor);
end;

end.
