{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11707: IdQOTDUDP.pas 
{
{   Rev 1.1    1/21/2004 3:27:14 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 07:58:46 AM  JPMugaas
}
unit IdQOTDUDP;

interface
uses Classes, IdAssignedNumbers, IdUDPBase, IdUDPClient;
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

{ TIdQOTDUDP }

procedure TIdQOTDUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_QOTD;
end;

function TIdQOTDUDP.GetQuote: String;
begin
  //The string can be anything - The RFC says the server should discard packets
  Send(' ');    {Do not Localize}
  Result := ReceiveString;
end;

end.
