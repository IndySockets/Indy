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
  Rev 1.7    9/5/2004 3:16:58 PM  JPMugaas
  Should work in D9 DotNET.

  Rev 1.6    3/8/2004 10:14:54 AM  JPMugaas
  Property editor for SASL mechanisms now supports TIdDICT.

  Rev 1.5    2/26/2004 8:53:14 AM  JPMugaas
  Hack to restore the property editor for SASL mechanisms.

  Rev 1.4    1/25/2004 4:28:42 PM  JPMugaas
  Removed a discontinued Unit.

  Rev 1.3    1/25/2004 3:11:06 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.2    10/12/2003 1:49:28 PM  BGooijen
  Changed comment of last checkin

  Rev 1.1    10/12/2003 1:43:28 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/14/2002 02:18:56 PM  JPMugaas
}

unit IdDsnRegister;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF FPC}
  PropEdits,
  ComponentEditors
  {$ELSE}
  DesignIntf,
  DesignEditors
  {$ENDIF}
  ;
// Procs

type
  TIdPropEdSASL = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  {$IFDEF HAS_TSelectionEditor}

  {$IFDEF USE_OPENSSL}
  TIdOpenSSLSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
  {$ENDIF}

  TIdFTPServerSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  {$ENDIF}

procedure Register;

implementation

uses
  IdDsnResourceStrings,
  IdDsnSASLListEditorFormVCL,
  {$IFDEF HAS_TSelectionEditor}
    {$IFDEF USE_OPENSSL}
  IdSSLOpenSSL,
    {$ENDIF}
  IdFTPServer,
  {$ENDIF}
  IdSASL, IdSASLCollection,
  SysUtils, TypInfo;
  {Since we are removing New Design-Time part, we remove the "New Message Part Editor"}
  {IdDsnNewMessagePart, }

type
  TfrmSASLListEditor = class(TfrmSASLListEditorVCL);

{ TfrmSASLListEditor }

{$IFDEF HAS_TSelectionEditor}

  {$IFDEF USE_OPENSSL}

{TIdOpenSSLSelectionEditor}

procedure TIdOpenSSLSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  //for new callback event
  Proc('IdCTypes');
  Proc('IdSSLOpenSSLHeaders');
end;

  {$ENDIF}

{TIdFTPServerSelectionEditor}

procedure TIdFTPServerSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('IdFTPListOutput');
  Proc('IdFTPList');
end;

{$ENDIF}

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
  LList := TIdSASLEntries(GetObjectProp(LComp, GetPropInfo, TIdSASLEntries));

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
    LF.Free;
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

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries), nil, '', TIdPropEdSASL);
  {$IFDEF HAS_TSelectionEditor}
    {$IFDEF USE_OPENSSL}
  RegisterSelectionEditor(TIdServerIOHandlerSSLOpenSSL, TIdOpenSSLSelectionEditor);
  RegisterSelectionEditor(TIdSSLIOHandlerSocketOpenSSL, TIdOpenSSLSelectionEditor);
    {$ENDIF}
  RegisterSelectionEditor(TIdFTPServer,TIdFTPServerSelectionEditor);
  {$ENDIF}
end;

end.
