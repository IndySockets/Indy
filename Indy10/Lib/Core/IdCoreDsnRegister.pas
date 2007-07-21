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
  IdIPMCastClient,
  IdStack,
  IdSocketHandle,

  IdTCPServer,
  IdUDPServer;

procedure TIdPropEdBinding.Edit;
begin
  inherited Edit;
  with TIdPropEdBindingEntry.Create do
  try
    if PropCount > 0 then
    begin
      Caption := TComponent(GetComponent(0)).Name;
      if (GetComponent(0) is TIdTCPServer) then
      begin
        DefaultPort := TIdTCPServer(GetComponent(0)).DefaultPort;
        Value := GetListValues( TIdTCPServer(GetComponent(0)).Bindings);
      end;
      if (GetComponent(0) is TIdUDPServer) then
      begin
        DefaultPort := TIdUDPServer(GetComponent(0)).DefaultPort;
        Value := GetListValues( TIdUDPServer(GetComponent(0)).Bindings);
      end;
      if (GetComponent(0) is TIdIPMCastClient) then
      begin
        DefaultPort := TIdIPMCastClient(GetComponent(0)).DefaultPort;
        Value := GetListValues( TIdIPMCastClient(GetComponent(0)).Bindings);
      end;
    end;
    SetList(Value);
    if Execute then
    begin
      Value := GetList;
      if PropCount > 0 then
      begin
        if (GetComponent(0) is TIdTCPServer) then
        begin
          FillHandleList(Value,TIdTCPServer(GetComponent(0)).Bindings);
        end;
        if (GetComponent(0) is TIdUDPServer) then
        begin
          FillHandleList(Value,TIdUDPServer(GetComponent(0)).Bindings);
        end;
        if (GetComponent(0) is TIdIPMCastClient) then
        begin
          FillHandleList(Value,TIdIPMCastClient(GetComponent(0)).Bindings);
        end;
      end;
    end;
  finally
    Free;
  end;
end;

function TIdPropEdBinding.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog];
end;

function TIdPropEdBinding.GetValue: string;
begin
  {$IFNDEF DOTNET}
  Result := GetListValues(TIdSocketHandles(GetOrdValue));
  {$ELSE}
  Result := GetListValues(GetObjValue as TIdSocketHandles);
  {$ENDIF}
end;

procedure TIdPropEdBinding.SetValue(const Value: string);
var
  IdSockets: TIdSocketHandles;
begin
  inherited SetValue(Value);
  {$IFNDEF DOTNET}
  IdSockets := TIdSocketHandles(GetOrdValue);
  {$ELSE}
  IdSockets := GetObjValue as TIdSocketHandles;
  {$ENDIF}
  IdSockets.BeginUpdate;
  try
    FillHandleList(Value, IdSockets);
  finally
    IdSockets.EndUpdate;
  end;
end;

procedure Register;
begin

  RegisterPropertyEditor(TypeInfo(TIdSocketHandles), TIdTCPServer, '', TIdPropEdBinding);    {Do not Localize}
   RegisterPropertyEditor(TypeInfo(TIdSocketHandles), TIdUDPServer, '', TIdPropEdBinding);    {Do not Localize}
   RegisterPropertyEditor(TypeInfo(TIdSocketHandles),TIdIPMCastClient,'',TIdPropEdBinding);  {Do not localize}
  RegisterComponentEditor(TIdBaseComponent, TIdBaseComponentEditor);
end;

end.
