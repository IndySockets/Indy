{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13818: IdEchoUDP.pas 
{
{   Rev 1.3    2004.02.03 5:45:06 PM  czhower
{ Name changes
}
{
{   Rev 1.2    1/21/2004 3:27:50 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.1    1/3/2004 12:59:52 PM  JPMugaas
{ These should now compile with Kudzu's change in IdCoreGlobal.
}
{
{   Rev 1.0    11/14/2002 02:19:34 PM  JPMugaas
}
unit IdEchoUDP;

interface
uses IdAssignedNumbers, IdUDPBase, IdUDPClient;
type
  TIdEchoUDP = class(TIdUDPClient)
  protected
    FEchoTime: Cardinal;
    procedure InitComponent; override;
  public
    {This sends Text to the peer and returns the reply from the peer}
    Function Echo(AText: String): String;
    {Time taken to send and receive data}
    Property EchoTime: Cardinal read FEchoTime;
  published
    property Port default IdPORT_ECHO;
  end;

implementation

uses
  IdGlobal;

{ TIdIdEchoUDP }

procedure TIdEchoUDP.InitComponent;
begin
  inherited;
  Port := IdPORT_ECHO;
end;

function TIdEchoUDP.Echo(AText: String): String;
var
  StartTime: Cardinal;
begin
  StartTime := Ticks;
  Send(AText);
  Result := ReceiveString;
  {This is just in case the TickCount rolled back to zero}
  FEchoTime :=  GetTickDiff(StartTime,Ticks);
end;

end.
