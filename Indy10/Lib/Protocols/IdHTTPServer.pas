{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11619: IdHTTPServer.pas 
{
{   Rev 1.0    11/13/2002 07:54:30 AM  JPMugaas
}
{
  Implementation of the HTTP server based on RFC 2616

  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

  Author: Stephane Grobety (grobety@fulgan.com)

  Additional chages and bug fixes - Doychin Bondzhev (doychin@dsoft-bg.com)

  Aug-26-2001:
    - New event (TOnCreateSession) - The user program can use it create objects from its own
    descendant class of TIdHTTPSession. Thi s descendant class can be used to hold additional,
    spcific to the user program data.
}

unit IdHTTPServer;

interface

uses
  IdCustomHTTPServer;

type
  TIdHTTPServer = class(TIdCustomHTTPServer)
  published
    property OnCreatePostStream;
    property OnCommandGet;
  end;

implementation

end.
