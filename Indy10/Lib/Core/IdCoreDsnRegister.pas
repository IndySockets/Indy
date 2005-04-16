{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11920: IdCoreDsnRegister.pas 
{
{   Rev 1.4    12/10/2004 15:36:40  HHariri
{ Fix so it works with D8 too
}
{
{   Rev 1.3    9/5/2004 2:08:14 PM  JPMugaas
{ Should work in D9 NET.
}
{
{   Rev 1.2    2/3/2004 11:42:52 AM  JPMugaas
{ Fixed for new design.
}
{
{   Rev 1.1    2/1/2004 2:44:20 AM  JPMugaas
{ Bindings editor should be fully functional including IPv6 support.
}
{
{   Rev 1.0    11/13/2002 08:41:18 AM  JPMugaas
}
unit IdCoreDsnRegister;

{$I IdCompilerDefines.inc}

interface

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
      DesignIntf, 
      DesignEditors;
    {$ELSE}
       Dsgnintf;
    {$ENDIF}
  {$ENDIF}

type
  TIdPropEdBinding = class(TClassProperty)
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
  IdSocketHandle,
  IdTCPServer,
  IdUDPServer,
    {$IFDEF Linux}
  QControls, QForms, QStdCtrls, QButtons, QExtCtrls, QActnList
  {$ELSE}
  Controls, Forms, StdCtrls, Buttons, ExtCtrls, ActnList
  {$ENDIF}
  ;

procedure TIdPropEdBinding.Edit;
begin
  inherited;
  with TIdPropEdBindingEntry.Create(nil) do
  try
    if PropCount > 0 then
    begin
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
    end;
    SetList(Value);
    if ShowModal = mrOk then
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
  inherited;
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
  RegisterComponentEditor(TIdBaseComponent, TIdBaseComponentEditor);
end;

end.
