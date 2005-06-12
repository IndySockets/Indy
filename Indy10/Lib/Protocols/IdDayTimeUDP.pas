{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13786: IdDayTimeUDP.pas 
{
{   Rev 1.1    1/21/2004 2:12:42 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/14/2002 02:17:14 PM  JPMugaas
}
unit IdDayTimeUDP;

interface
uses IdAssignedNumbers, IdUDPBase, IdUDPClient;
type
  TIdDayTimeUDP = class(TIdUDPClient)
  protected
    Function GetDayTimeStr : String;
    procedure InitComponent; override;
  public
    Property DayTimeStr : String read GetDayTimeStr;
  published
    property Port default IdPORT_DAYTIME;
  end;

implementation

{ TIdDayTimeUDP }

procedure TIdDayTimeUDP.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_DAYTIME;
end;

function TIdDayTimeUDP.GetDayTimeStr: String;
begin
  //The string can be anything - The RFC says the server should discard packets
  Send(' ');    {Do not Localize}
  Result := ReceiveString;
end;

end.
