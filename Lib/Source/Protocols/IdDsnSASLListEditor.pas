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


  $Log$


  Rev 1.6    9/5/2004 3:16:58 PM  JPMugaas
  Should work in D9 DotNET.

  Rev 1.5    3/8/2004 10:14:56 AM  JPMugaas
  Property editor for SASL mechanisms now supports TIdDICT.

  Rev 1.4    2/26/2004 8:53:16 AM  JPMugaas
  Hack to restore the property editor for SASL mechanisms.

  Rev 1.3    1/25/2004 3:11:08 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.2    10/12/2003 1:49:30 PM  BGooijen
  Changed comment of last checkin

  Rev 1.1    10/12/2003 1:43:30 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/14/2002 02:19:08 PM  JPMugaas
}

unit IdDsnSASLListEditor;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF DOTNET}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors
  {$ELSE}
    {$IFDEF FPC}
  PropEdits,
  ComponentEditors
    {$ELSE}
      {$IFDEF VCL_6_OR_ABOVE}
  DesignIntf,
  DesignEditors
      {$ELSE}
  Dsgnintf
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  ;

type
  TIdPropEdSASL = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

uses
  Classes,
  IdDsnResourceStrings, IdDsnSASLListEditorForm,
  IdSASL, IdSASLCollection,
  SysUtils, TypInfo;

{ TIdPropEdSASL }

procedure TIdPropEdSASL.Edit;
var
  LF: TfrmSASLListEditor;
  LComp: TPersistent;
  LList: TIdSASLEntries;
begin
  inherited Edit;

  LComp := GetComponent(0);
  //done this way to prevent invalid typecast error.
  LList := TIdSASLEntries(TObject(GetOrdProp(LComp, GetPropInfo)));

  LF := TfrmSASLListEditor.Create(nil);
  try
    if LComp is TComponent then begin
      LF.SetComponentName(TComponent(LComp).Name);
    end;
    LF.SetList(LList);
    if LF.Execute then begin
      LF.GetList(LList);
    end;
  finally
    FreeAndNil(LF);
  end;
end;

function TIdPropEdSASL.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

function TIdPropEdSASL.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TIdPropEdSASL.SetValue(const Value: string);
begin
  inherited SetValue(Value);
end;

end.
