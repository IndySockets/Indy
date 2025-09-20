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
   Rev 1.0    11/13/2002 08:04:28 AM  JPMugaas
}
{
  This component holds a username/password combination.
  It is used by SASL or other components in order to
  simplify application programming - the programmer will only have to
  set the username/password once if a user enters it, instead of for
  all components that instead now link to an instance of this class.
}
unit IdUserPassProvider;

interface

{$i IdCompilerDefines.inc}

uses
  IdBaseComponent;

type
  TIdUserPassProvider = class(TIdBaseComponent)
  protected
    FUsername: string;
    FPassword: string;
  published
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;
  end;

implementation

end.

