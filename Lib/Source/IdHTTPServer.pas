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
  Rev 1.0    11/13/2002 07:54:30 AM  JPMugaas

  Aug-26-2001:
  - New event (TOnCreateSession) - The user program can use it create objects from its own
  descendant class of TIdHTTPSession. Thi s descendant class can be used to hold additional,
  spcific to the user program data.
}

unit IdHTTPServer;

{
  Implementation of the HTTP server based on RFC 2616
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

  Author: Stephane Grobety (grobety@fulgan.com)
  Additional chages and bug fixes - Doychin Bondzhev (doychin@dsoft-bg.com)
}

interface
{$i IdCompilerDefines.inc}

uses
  IdCustomHTTPServer;

type
  TIdHTTPServer = class(TIdCustomHTTPServer)
  published
    property OnCreatePostStream;
    property OnDoneWithPostStream;
    property OnCommandGet;
  end;

implementation

end.
