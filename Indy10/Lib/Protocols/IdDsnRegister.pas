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
// Procs

procedure Register;

implementation

uses
  IdDsnSASLListEditor,
  {Since we are removing New Design-Time part, we remove the "New Message Part Editor"}
  {IdDsnNewMessagePart, }
  IdSASLCollection;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries), nil, '', TIdPropEdSASL);
end;

end.
