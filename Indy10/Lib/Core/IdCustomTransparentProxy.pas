{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13959: IdCustomTransparentProxy.pas
{
{   Rev 1.10    11/12/2004 11:30:16 AM  JPMugaas
{ Expansions for IPv6.
}
{
{   Rev 1.9    11/11/2004 10:25:22 PM  JPMugaas
{ Added OpenProxy and CloseProxy so you can do RecvFrom and SendTo functions
{ from the UDP client with SOCKS.  You must call OpenProxy  before using
{ RecvFrom or SendTo.  When you are finished, you must use CloseProxy to close
{ any connection to the Proxy.  Connect and disconnect also call OpenProxy and
{ CloseProxy.
}
{
{   Rev 1.8    11/11/2004 3:42:52 AM  JPMugaas
{ Moved strings into RS.  Socks will now raise an exception if you attempt to
{ use SOCKS4 and SOCKS4A with UDP.  Those protocol versions do not support UDP
{ at all.
}
{
{   Rev 1.7    11/9/2004 8:18:00 PM  JPMugaas
{ Attempt to add SOCKS support in UDP.
}
{
{   Rev 1.6    6/6/2004 11:51:56 AM  JPMugaas
{ Fixed TODO with an exception
}
{
{   Rev 1.5    2004.02.03 4:17:04 PM  czhower
{ For unit name changes.
}
{
    Rev 1.4    10/15/2003 10:59:06 PM  DSiders
  Corrected spelling error in resource string name.
  Added resource string for circular links exception in transparent proxy.
}
{
    Rev 1.3    10/15/2003 10:10:18 PM  DSiders
  Added localization comments.
}
{
    Rev 1.2    5/16/2003 9:22:38 AM  BGooijen
  Added Listen(...)
}
{
    Rev 1.1    5/14/2003 6:41:00 PM  BGooijen
  Added Bind(...)
}
{
{   Rev 1.0    12/2/2002 05:01:26 PM  JPMugaas
{ Rechecked in due to file corruption.
}
unit IdCustomTransparentProxy;

interface

uses
  IdComponent,
  IdException,
  IdGlobal,
  IdObjs,
  IdIOHandler,
  IdSocketHandle,
  IdSys, IdBaseComponent;

type
  EIdTransparentProxyCircularLink = class(EIdException);
  EIdTransparentProxyUDPNotSupported = class(EIdException);
  TIdCustomTransparentProxyClass = class of TIdCustomTransparentProxy;

  TIdCustomTransparentProxy = class(TIdComponent)
  protected
    FHost: String;
    FPassword: String;
    FPort: Integer;
    FIPVersion : TIdIPVersion;
    FUsername: String;
    FChainedProxy: TIdCustomTransparentProxy;
    //
    procedure AssignTo(ASource: TIdPersistent); override;
    function  GetEnabled: Boolean; virtual; abstract;
    procedure SetEnabled(AValue: Boolean); virtual;
    procedure MakeConnection(AIOHandler: TIdIOHandler; const AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    procedure Notification(AComponent: TIdNativeComponent; Operation: TIdOperation); override;
    procedure SetChainedProxy(const AValue: TIdCustomTransparentProxy);
  public
    procedure OpenUDP(AHandle : TIdSocketHandle; const AHost: string=''; const APort: Integer=0; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual;
    procedure CloseUDP(AHandle: TIdSocketHandle); virtual;
    function RecvFromUDP(AHandle: TIdSocketHandle;
      var ABuffer : TIdBytes;
      var VPeerIP: string; var VPeerPort: integer; const AIPVersion: TIdIPVersion;
       AMSec: Integer = IdTimeoutDefault): integer; virtual;
    procedure SendToUDP(AHandle: TIdSocketHandle;
      AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion; const ABuffer : TIdBytes); virtual;
    procedure Connect(AIOHandler: TIdIOHandler; const AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
    //
    procedure Bind(AIOHandler: TIdIOHandler; const AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);overload;virtual;
    procedure Bind(AIOHandler: TIdIOHandler; const APort: Integer);overload;
    function  Listen(AIOHandler: TIdIOHandler; const ATimeOut:integer):boolean;virtual;
    //
    property  Enabled: Boolean read GetEnabled write SetEnabled;
    property  Host: String read FHost write FHost;
    property  Password: String read FPassword write FPassword;
    property  Port: Integer read FPort write FPort;
    property  IPVersion : TIdIPVersion read FIPVersion write FIPVersion default ID_DEFAULT_IP_VERSION;
    property  Username: String read FUsername write FUsername;
    property  ChainedProxy: TIdCustomTransparentProxy read FChainedProxy write SetChainedProxy;
  End;//TIdCustomTransparentProxy

implementation

uses
  IdResourceStringsCore, IdExceptionCore;

{ TIdCustomTransparentProxy }

procedure TIdCustomTransparentProxy.AssignTo(ASource: TIdPersistent);
Begin
  if ASource is TIdCustomTransparentProxy then begin
    with TIdCustomTransparentProxy(ASource) do begin
      FHost := Self.FHost;
      FPassword := Self.FPassword;
      FPort := Self.FPort;
      FIPVersion := Self.FIPVersion;
      FUsername := Self.FUsername;
    end
  end else begin
    inherited AssignTo(ASource);
  end;
End;//

procedure TIdCustomTransparentProxy.Connect(AIOHandler: TIdIOHandler; const AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  if Assigned(FChainedProxy) and FChainedProxy.Enabled then begin
    MakeConnection(AIOHandler, FChainedProxy.Host, FChainedProxy.Port);
    FChainedProxy.Connect(AIOHandler, AHost, APort,AIPVersion);
  end else begin
    MakeConnection(AIOHandler, AHost, APort, AIPVersion);
  end;
end;

function TIdCustomTransparentProxy.Listen(AIOHandler: TIdIOHandler; const ATimeOut:integer):boolean;
begin
  raise EIdTransparentProxyCantBind.Create(RSTransparentProxyCannotBind);
end;

procedure TIdCustomTransparentProxy.Bind(AIOHandler: TIdIOHandler; const AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  raise EIdTransparentProxyCantBind.Create(RSTransparentProxyCannotBind);
end;

procedure TIdCustomTransparentProxy.Bind(AIOHandler: TIdIOHandler; const APort: Integer);
begin

  Bind(AIOHandler, '0.0.0.0', APort);   {do not localize}
end;

procedure TIdCustomTransparentProxy.SetEnabled(AValue: Boolean);
Begin
End;

procedure TIdCustomTransparentProxy.Notification(AComponent: TIdNativeComponent; Operation: TIdOperation);
begin
  if (Operation = opRemove) and (AComponent = FChainedProxy) then begin
    FChainedProxy := nil;
  end;
  inherited;
end;

procedure TIdCustomTransparentProxy.SetChainedProxy(const AValue: TIdCustomTransparentProxy);
var
  LNextValue: TIdCustomTransparentProxy;
begin
  LNextValue := AValue;
  while Assigned(LNextValue) do begin
    if LNextValue = SELF then begin
      raise EIdTransparentProxyCircularLink.Create(Sys.Format(RSInterceptCircularLink,[ClassName]));// -> One EIDCircularLink exception
    end;
    LNextValue := LNextValue.FChainedProxy;
  end;

  FChainedProxy := AValue;

  if Assigned(AValue) then begin
    AValue.FreeNotification(Self);
  end;
end;

procedure TIdCustomTransparentProxy.CloseUDP(AHandle: TIdSocketHandle);
begin
  raise EIdTransparentProxyUDPNotSupported.Create(RSTransparentProxyCanNotSupportUDP);
end;

procedure TIdCustomTransparentProxy.OpenUDP(AHandle: TIdSocketHandle;
  const AHost: string=''; const APort: Integer=0;const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  raise EIdTransparentProxyUDPNotSupported.Create( RSTransparentProxyCanNotSupportUDP );
end;

function TIdCustomTransparentProxy.RecvFromUDP(AHandle: TIdSocketHandle;
      var ABuffer : TIdBytes;
      var VPeerIP: string; var VPeerPort: integer; const AIPVersion: TIdIPVersion;
       AMSec: Integer = IdTimeoutDefault): integer;
begin
   raise EIdTransparentProxyUDPNotSupported.Create(RSTransparentProxyCanNotSupportUDP);
end;

procedure TIdCustomTransparentProxy.SendToUDP(AHandle: TIdSocketHandle;
      AHost: string; const APort: Integer; const AIPVersion: TIdIPVersion; const ABuffer : TIdBytes);
begin
   raise EIdTransparentProxyUDPNotSupported.Create(RSTransparentProxyCanNotSupportUDP);
end;

end.

