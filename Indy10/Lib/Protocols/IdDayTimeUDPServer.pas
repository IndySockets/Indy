{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13788: IdDayTimeUDPServer.pas 
{
{   Rev 1.4    2004.02.03 5:45:04 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/21/2004 2:12:44 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    10/24/2003 02:54:52 PM  JPMugaas
{ These should now work with the new code.
}
{
{   Rev 1.1    2003.10.24 10:38:24 AM  czhower
{ UDP Server todos
}
{
{   Rev 1.0    11/14/2002 02:17:18 PM  JPMugaas
}
unit IdDayTimeUDPServer;

interface

uses
  IdAssignedNumbers, IdGlobal, IdSocketHandle, IdUDPBase, IdUDPServer;

type
   TIdDayTimeUDPServer = class(TIdUDPServer)
   protected
     FTimeZone : String;
     procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
     procedure InitComponent; override;
   published
     property TimeZone: String read FTimeZone write FTimeZone;
     property DefaultPort default IdPORT_DAYTIME;
   end;

implementation
uses IdSys;

{ TIdDayTimeUDPServer }

procedure TIdDayTimeUDPServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DAYTIME;
  FTimeZone := 'EST';  {Do not Localize}
end;

procedure TIdDayTimeUDPServer.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
var s : String;
begin
  inherited DoUDPRead(AData, ABinding);
  s := Sys.FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss', Sys.Now) + ' -' + FTimeZone;  {Do not Localize}
  with ABinding do
  begin
    SendTo(PeerIP, PeerPort, ToBytes(s));
  end;
end;

end.

