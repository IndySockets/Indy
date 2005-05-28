{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11665: IdMappedPortUDP.pas 
{
{   Rev 1.6    7/21/04 3:14:04 PM  RLebeau
{ Removed local Buffer variable from TIdMappedPortUDP.DoUDPRead(), not needed
}
{
{   Rev 1.5    2004.02.03 5:44:00 PM  czhower
{ Name changes
}
{
{   Rev 1.4    2/2/2004 4:20:30 PM  JPMugaas
{ Removed warning from Delphi 8.  It now should compile in DotNET.
}
{
{   Rev 1.3    1/21/2004 3:11:34 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    10/25/2003 06:52:14 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.  
}
{
{   Rev 1.1    2003.10.24 10:38:28 AM  czhower
{ UDP Server todos
}
{
{   Rev 1.0    11/13/2002 07:56:46 AM  JPMugaas
}
unit IdMappedPortUDP;

interface

{
  - Syncronized with Indy standards by Gregor Ibic
  - Original DNS mapped port by Gregor Ibic
}

uses
  IdSys,
  IdGlobal,
  IdUDPServer,
  IdSocketHandle,
  IdObjs,
  IdGlobalProtocols;

type
  TIdMappedPortUDP = class(TIdUDPServer)
  protected
    FMappedPort: Integer;
    FMappedHost: String;
    FOnRequest: TIdNotifyEvent;
    //
    procedure DoRequestNotify; virtual;
    procedure InitComponent; override;
    procedure DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle); override;
  published
    property MappedHost: string read FMappedHost write FMappedHost;
    property MappedPort: Integer read FMappedPort write FMappedPort;
    property OnRequest: TIdNotifyEvent read fOnRequest write fOnRequest;
  end;

implementation

uses
  IdAssignedNumbers,
  IdUDPClient;

procedure TIdMappedPortUDP.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_DOMAIN;
end;

procedure TIdMappedPortUDP.DoRequestNotify;
begin
  if Assigned(OnRequest) then begin
    OnRequest(Self);
  end;
end;

procedure TIdMappedPortUDP.DoUDPRead(AData: TIdBytes; ABinding: TIdSocketHandle);
var
  OutboundClient: TIdUDPClient;
  rcvData: String;
begin
  inherited;
  DoRequestNotify;
  OutboundClient := TIdUDPClient.Create(nil); try
    OutboundClient.Host := FMappedHost;
    OutboundClient.Port := FMappedPort;
    OutboundClient.Send(BytesToString(AData));
    rcvData := OutboundClient.ReceiveString;
    if rcvData <> '' then begin    {Do not Localize}
      Send (ABinding.PeerIP, ABinding.PeerPort, rcvData);
    end;
  finally Sys.FreeAndNil(OutboundClient); end;
end;

end.
