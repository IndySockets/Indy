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
  Rev 1.1    1/21/2004 3:27:14 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 07:58:46 AM  JPMugaas
}

unit IdQOTDUDP;

interface

{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdUDPBase, IdUDPClient;

type
  TIdQOTDUDP = class(TIdUDPClient)
  protected
    Function GetQuote : String;
    procedure InitComponent; override;
  public
    { This is the quote from the server }
    Property Quote: String read GetQuote;
  published
    Property Port default IdPORT_QOTD;
  end;

implementation

uses
  IdGlobal;

{ TIdQOTDUDP }

procedure TIdQOTDUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_QOTD;
end;

function TIdQOTDUDP.GetQuote: String;
var
  LEncoding: IIdTextEncoding;
begin
  //The string can be anything - The RFC says the server should discard packets
  Send(' ');    {Do not Localize}
  LEncoding := IndyTextEncoding_8Bit;
  Result := ReceiveString(IdTimeoutDefault, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
end;

end.
