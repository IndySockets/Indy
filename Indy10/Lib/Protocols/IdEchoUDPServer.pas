{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13820: IdEchoUDPServer.pas 
{
{   Rev 1.4    2004.02.03 5:45:08 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/22/2004 7:10:04 AM  JPMugaas
{ Tried to fix AnsiSameText depreciation.
}
{
{   Rev 1.2    1/21/2004 3:27:52 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.1    10/23/2003 03:50:52 AM  JPMugaas
{ TIdEchoUDP Ported.
}
{
{   Rev 1.0    11/14/2002 02:19:38 PM  JPMugaas
}
unit IdEchoUDPServer;

interface

uses
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type

   TIdEchoUDPServer = class(TIdUDPServer)
   protected
      procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
     procedure InitComponent; override;
   published
     property DefaultPort default IdPORT_ECHO;
   end;

implementation

{ TIdEchoUDPServer }

procedure TIdEchoUDPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_ECHO;
end;

procedure TIdEchoUDPServer.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  inherited DoUDPRead(AData, ABinding);
  with ABinding do
  begin
    SendTo(PeerIP, PeerPort, AData);
  end;
end;

end.

 

