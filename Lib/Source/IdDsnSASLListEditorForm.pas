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


  Rev 1.7    9/8/2004 10:10:40 PM  JPMugaas
  Now should work properly in DotNET versions of Delphi.

  Rev 1.6    9/5/2004 3:16:58 PM  JPMugaas
  Should work in D9 DotNET.

  Rev 1.5    2/26/2004 8:53:22 AM  JPMugaas
  Hack to restore the property editor for SASL mechanisms.

  Rev 1.4    1/25/2004 3:11:10 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.3    10/19/2003 6:05:38 PM  DSiders
  Added localization comments.

  Rev 1.2    10/12/2003 1:49:30 PM  BGooijen
  Changed comment of last checkin

  Rev 1.1    10/12/2003 1:43:30 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.0    11/14/2002 02:19:14 PM  JPMugaas

  2002-08 Johannes Berg
  Form for the SASL List Editor. It doesn't use a DFM/XFM to be
  more portable between Delphi/Kylix versions, and to make less
  trouble maintaining it.
}

unit IdDsnSASLListEditorForm;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF WIDGET_WINFORMS}
  Classes,
  IdDsnSASLListEditorFormNET;
  {$R 'IdDsnSASLListEditorFormNET.TfrmSASLListEditor.resources' 'IdDsnSASLListEditorFormNET.resx'}
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  IdDsnSASLListEditorFormVCL;
  {$ENDIF}

type
  {$IFDEF WIDGET_WINFORMS}
  //we make a create here because I'm not sure how the Visual Designer for WinForms
  //we behave in a package.  I know it can act weird if something is renamed
  TfrmSASLListEditor = class(IdDsnSASLListEditorFormNET.TfrmSASLListEditor)
  public
    constructor Create(AOwner : TComponent);
  end;
  {$ENDIF}
  {$IFDEF WIDGET_VCL_LIKE_OR_KYLIX}
  TfrmSASLListEditor = class(TfrmSASLListEditorVCL);
  {$ENDIF}

implementation

{$IFDEF WIDGET_WINFORMS}
constructor TfrmSASLListEditor.Create(AOwner : TComponent);
begin
  inherited Create;
end;
{$ENDIF}
end.
