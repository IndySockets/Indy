{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13796: IdDiscardUDPServer.pas 
{
{   Rev 1.1    1/21/2004 2:12:48 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/14/2002 02:18:14 PM  JPMugaas
}
unit IdDiscardUDPServer;

interface

uses
  Classes,
  IdAssignedNumbers, IdSocketHandle, IdUDPBase, IdUDPServer;

type
   TIdDiscardUDPServer = class(TIdUDPServer)
   protected
     procedure InitComponent; override;
   published
     property DefaultPort default IdPORT_DISCARD;
   end;

implementation

{ TIdDiscardUDPServer }

procedure TIdDiscardUDPServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_DISCARD;
end;

end.
 
