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
  Classes,
  IdAssignedNumbers, IdUDPBase, IdUDPClient;

type
  TIdQOTDUDP = class(TIdUDPClient)
  protected
    Function GetQuote : String;
  public
    constructor Create(AOwner: TComponent); override;
    { This is the quote from the server }
    Property Quote: String read GetQuote;
  published
    Property Port default IdPORT_QOTD;
  end;

implementation

uses
  IdGlobal;

{ TIdQOTDUDP }

constructor TIdQOTDUDP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Port := IdPORT_QOTD;
end;

function TIdQOTDUDP.GetQuote: String;
begin
  //The string can be anything - The RFC says the server should discard packets
  Send(' ');    {Do not Localize}
  Result := ReceiveString(IdTimeoutDefault, IndyTextEncoding_8Bit);
end;

end.
