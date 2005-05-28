{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11639: IdIPMCastServer.pas 
{
{   Rev 1.7    14/06/2004 21:38:42  CCostelloe
{ Converted StringToTIn4Addr call
}
{
{   Rev 1.6    09/06/2004 10:00:50  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.5    2004.02.03 5:43:52 PM  czhower
{ Name changes
}
{
{   Rev 1.4    1/21/2004 3:11:10 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.3    10/26/2003 09:11:54 AM  JPMugaas
{ Should now work in NET.
}
{
{   Rev 1.2    2003.10.24 10:38:28 AM  czhower
{ UDP Server todos
}
{
{   Rev 1.1    2003.10.12 4:03:58 PM  czhower
{ compile todos
}
{
{   Rev 1.0    11/13/2002 07:55:26 AM  JPMugaas
}
unit IdIPMCastServer;

{

  History:

  Date         By         Description
  ----------  ----------  --------------------------------------------------
  2001-10-16  DSiders     Modified TIdIPMCastServer.MulticastBuffer to
                          validate the AHost argument to the method instead
                          of the MulticastGroup property.

  ???   Dr. Harley J. Mackenzie    Initial revision.

}

interface

uses
  IdComponent,
  IdGlobal,
  IdIPMCastBase,
  IdSocketHandle;

const
  DEF_IMP_LOOPBACK = True;
  DEF_IMP_TTL = 1;

type
  TIdIPMCastServer = class(TIdIPMCastBase)
  protected
    FBinding: TIdSocketHandle;
    FLoopback: Boolean;
    FTimeToLive: Byte;
    //
    procedure CloseBinding; override;
    function GetActive: Boolean; override;
    function GetBinding: TIdSocketHandle; override;
    procedure Loaded; override;
    procedure MulticastBuffer(const AHost: string; const APort: Integer; const ABuffer : TIdBytes);
    procedure SetLoopback(const AValue: Boolean); virtual;
    procedure SetTTL(const AValue: Byte); virtual;
    procedure SetTTLOption(AInBinding: TIdSocketHandle; const AValue: Byte); virtual;
    procedure InitComponent; override;
  public
    procedure Send(const AData: string); overload;
    procedure Send(const ABuffer : TIdBytes); overload;
    destructor Destroy; override;
    //
    property Binding: TIdSocketHandle read GetBinding;
  published
    property Active;
    property Loopback: Boolean read FLoopback write SetLoopback default DEF_IMP_LOOPBACK;
    property MulticastGroup;
    property Port;
    property TimeToLive: Byte read FTimeToLive write SetTTL default DEF_IMP_TTL;
  end;

implementation

{ TIdIPMCastServer }

uses
  IdResourceStringsCore,
  IdStack,
  IdStackConsts,
  IdSys;

procedure TIdIPMCastServer.InitComponent;
begin
  inherited;
  FLoopback := DEF_IMP_LOOPBACK;
  FTimeToLive := DEF_IMP_TTL;
end;

procedure TIdIPMCastServer.CloseBinding;
begin
  //Multicast.IMRMultiAddr := GBSDStack.StringToTIn4Addr(FMulticastGroup);
  //Hope the following is correct for StringToTIn4Addr(), should be checked...
  GStack.DropMulticastMembership(FBinding.Handle,FMulticastGroup,Binding.IP);

  Sys.FreeAndNil(FBinding);
end;

function TIdIPMCastServer.GetActive: Boolean;
begin
  Result := inherited GetActive or (Assigned(FBinding) and FBinding.HandleAllocated);
end;

function TIdIPMCastServer.GetBinding: TIdSocketHandle;

begin
  if not Assigned(FBinding) then begin
    FBinding := TIdSocketHandle.Create(nil);
  end;
  if not FBinding.HandleAllocated then begin
{$IFDEF LINUX}
    FBinding.AllocateSocket(Integer(Id_SOCK_DGRAM));
{$ELSE}
    FBinding.AllocateSocket(Id_SOCK_DGRAM);
{$ENDIF}
    FBinding.Bind;
    //Multicast.IMRMultiAddr :=  GBSDStack.StringToTIn4Addr(FMulticastGroup);
    //Hope the following is correct for StringToTIn4Addr(), should be checked...
     GStack.AddMulticastMembership(FBinding.Handle,FMulticastGroup,Binding.IP);
    SetTTLOption(FBinding, FTimeToLive);
    Loopback := True;
  end;
  Result := FBinding;
end;

procedure TIdIPMCastServer.Loaded;
var
  b: Boolean;
begin
  inherited Loaded;
  b := FDsgnActive;
  FDsgnActive := False;
  Active := b;
end;

procedure TIdIPMCastServer.MulticastBuffer(const AHost: string; const APort: Integer; const ABuffer : TIdBytes);
begin
  // DS - if not IsValidMulticastGroup(FMulticastGroup) then
  EIdMCastNotValidAddress.IfFalse(IsValidMulticastGroup(AHost), RSIPMCastInvalidMulticastAddress);

  Binding.SendTo(AHost, APort, ABuffer);
end;

procedure TIdIPMCastServer.Send(const AData: string);
begin
  MulticastBuffer(FMulticastGroup, FPort, ToBytes(AData));
end;

procedure TIdIPMCastServer.Send(const ABuffer : TIdBytes);
begin
  MulticastBuffer(FMulticastGroup, FPort, ABuffer);
end;

procedure TIdIPMCastServer.SetLoopback(const AValue: Boolean);
begin
  if FLoopback <> AValue then begin
    if FDsgnActive or (Assigned(Binding) and Binding.HandleAllocated) then begin
      GStack.SetLoopBack(Binding.Handle,AValue);
    end;
    FLoopback := AValue;
  end;
end;

procedure TIdIPMCastServer.SetTTL(const AValue: Byte);
begin
  if (FTimeToLive <> AValue) then begin
    GStack.SetMulticastTTL(FBinding.Handle,AValue);
    FTimeToLive := AValue;
  end;
end;

procedure TIdIPMCastServer.SetTTLOption(AInBinding: TIdSocketHandle; const AValue: Byte);
begin
  if (FDsgnActive or (Assigned(AInBinding) and AInBinding.HandleAllocated)) then begin
    GStack.SetMulticastTTL(AInBinding.Handle,AValue);
  end;
end;

destructor TIdIPMCastServer.Destroy;
begin
	Active := False;
  inherited Destroy;
end;

end.

