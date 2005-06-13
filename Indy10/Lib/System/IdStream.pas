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

unit IdStream;

interface

{$I IdCompilerDefines.inc}

uses
{$IFDEF DotNet}
  IdStreamNET
{$ELSE}
  IdStreamVCL
{$ENDIF};

type
{$IFDEF DotNet}
  TIdStreamHelper = TIdStreamHelperNET;
{$ELSE}
  TIdStreamHelper = TIdStreamHelperVCL;
{$ENDIF}

implementation

end.

