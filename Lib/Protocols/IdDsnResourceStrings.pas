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
  Rev 1.0    11/14/2002 02:19:02 PM  JPMugaas
}

unit IdDsnResourceStrings;

{ This is only for resource strings that appear in the design-time editors in the main Indy package }

interface
//Here just so we can IFDEF some things for a Lazarus Workaround
//This should make things a little easier for GNU Make.
{$I IdCompilerDefines.inc}

resourcestring
  {Binding Editor stuff}

  {
  Note to translators - Please Read!!!

   & symbol before a letter or number.  This is rendered as that chractor being
  underlined.  In addition, the charactor after the & symbol along with the ALT
  key enables a user to move to that control.  Since these are on one form, be
  careful to ensure that the same letter or number does not have a & before it
  in more than one string, otherwise an ALT key sequence will be broken.
  }

  {Design time SASLList Hints}
  RSADlgSLMoveUp = 'Move Up';
  RSADlgSLMoveDown = 'Move Down';
  RSADlgSLAdd = 'Add';
  RSADlgSLRemove = 'Remove';
  //Caption that uses format with component name
  RSADlgSLCaption = 'Editing SASL List for %s';
  RSADlgSLAvailable = '&Available';
  RSADlgSLAssigned = 'A&ssigned (tried in order listed)';
  {Note that the Ampersand indicates an ALT keyboard sequence}
  RSADlgSLEditList = 'Edit &List';
{$IFDEF FPC}
  //This is part of a workaround for the Lazarus IDE Toolbar being
  //unable to scroll.
  RSProt = ' Protocols';
  RSProtam = ' Protocols (am)';
  RSProtnz = ' Protocols (nz)';
  RSMappedPort = ' Mapped Port';
  RSEncoder = ' Encoder';
  RSDecoder = ' Decoder';
{$ENDIF}

implementation

end.
