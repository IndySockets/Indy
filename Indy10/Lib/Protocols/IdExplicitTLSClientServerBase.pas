{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17190: IdExplicitTLSClientServerBase.pas 
{
{   Rev 1.14    10/26/2004 9:09:36 PM  JPMugaas
{ Updated references.
}
{
{   Rev 1.13    2004.02.03 5:45:36 PM  czhower
{ Name changes
}
{
{   Rev 1.12    1/25/2004 3:52:28 PM  JPMugaas
{ Fixes for abstract SSL interface to work in NET.
}
{
{   Rev 1.11    1/21/2004 1:23:38 PM  JPMugaas
{ InitComponent.
}
{
{   Rev 1.10    5/25/2003 12:06:16 AM  JPMugaas
{ TLS checking code moved into a protected method for reuse in TIdDirectSMTP. 
{ Note that TLS support is different in that component because of the way it
{ works.
}
{
    Rev 1.9    5/21/2003 3:36:42 PM  BGooijen
  Fixed design time bug regarding the Active property
}
{
{   Rev 1.8    5/8/2003 11:27:38 AM  JPMugaas
{ Moved feature negoation properties down to the ExplicitTLSClient level as
{ feature negotiation goes hand in hand with explicit TLS support.
}
{
{   Rev 1.7    4/13/2003 05:38:02 PM  JPMugaas
{ Fix for SetTLS exception problem with IdMessage.SaveToFile.
}
{
{   Rev 1.6    4/5/2003 02:06:48 PM  JPMugaas
{ TLS handshake itself can now be handled.
}
{
{   Rev 1.5    3/27/2003 05:46:22 AM  JPMugaas
{ Updated framework with an event if the TLS negotiation command fails.
{ Cleaned up some duplicate code in the clients.
}
{
{   Rev 1.4    3/26/2003 04:19:18 PM  JPMugaas
{ Cleaned-up some code and illiminated some duplicate things.
}
{
    Rev 1.3    3/23/2003 11:45:02 PM  BGooijen
  classes -> Classes
}
{
{   Rev 1.2    3/18/2003 04:36:52 PM  JPMugaas
}
{
{   Rev 1.1    3/16/2003 06:08:34 PM  JPMugaas
{ Fixed a bug where the wrong port number was being set.  I also expanded a few
{ things for the server.
}
{
{   Rev 1.0    3/16/2003 02:38:08 PM  JPMugaas
{ Base class for some clients that use both implicit and explicit TLS.
}
unit IdExplicitTLSClientServerBase;

interface

uses
  Classes, IdGlobal, IdCmdTCPServer,
    IdException, IdIOHandler, IdServerIOHandler,
    IdTCPClient, IdTStrings;

type
  TIdUseTLS = (
    utNoTLSSupport,
    utUseImplicitTLS, // ssl iohandler req, allways tls
    utUseRequireTLS, // ssl iohandler req, user command only accepted when in tls
    utUseExplicitTLS // < user can choose to use tls
    );
const
  ExplicitTLSVals = [utUseRequireTLS,utUseExplicitTLS];
const
  DEF_USETLS = utNoTLSSupport; //we can't assume the user wants to use a SSL IOHandler
type
  TIdOnTLSNegotiationFailure = procedure(Asender : TObject; var VContinue : Boolean) of object;
type
  TIdExplicitTLSServer = class(TIdCmdTCPServer)
  protected
    FRegularProtPort : Integer;
    FImplicitTLSProtPort : Integer;
    FUseTLS : TIdUseTLS;
    procedure Loaded; override;
    procedure SetIOHandler(const AValue: TIdServerIOHandler); override;
    procedure SetUseTLS(AValue : TIdUseTLS); virtual;
    property UseTLS : TIdUseTLS read FUseTLS write SetUseTLS default  DEF_USETLS;
    procedure InitComponent; override;
  public
  end;
  TIdExplicitTLSClient = class(TIdTCPClientCustom)
  protected
    FRegularProtPort : Integer;
    FImplicitTLSProtPort : Integer;
    FUseTLS : TIdUseTLS;
    FOnTLSNotAvailable : TIdOnTLSNegotiationFailure;
    FOnTLSNegCmdFailed : TIdOnTLSNegotiationFailure;
    FOnTLSHandShakeFailed : TIdOnTLSNegotiationFailure;

    //feature negotiation stuff
    FCapabilities : TIdStrings;
    function GetSupportsTLS : boolean; virtual; 
    procedure CheckIfCanUseTLS; virtual;
    procedure Loaded; override;
    procedure TLSNotAvailable;
    procedure DoOnTLSNotAvailable;
    procedure ProcessTLSNotAvail;

    procedure TLSNegCmdFailed;
    procedure DoOnTLSNegCmdFailed;
    procedure ProcessTLSNegCmdFailed;

    procedure TLSHandShakeFailed;
    procedure DoOnTLSHandShakeFailed;
    procedure ProcessTLSHandShakeFailed;

    procedure SetIOHandler(AValue: TIdIOHandler); override;
    procedure SetUseTLS(AValue : TIdUseTLS); virtual;
    //Note TLSHandshake should be the ONLY method to do the actual TLS
    //or SSL handshake for explicit TLS clients.
    procedure TLSHandshake; virtual;
    procedure InitComponent; override;
    property UseTLS : TIdUseTLS read FUseTLS write SetUseTLS default DEF_USETLS;
  public
    destructor Destroy; override;
    procedure Connect; override;
    property SupportsTLS: boolean read GetSupportsTLS;
    property Capabilities : TIdStrings read FCapabilities;
    property OnTLSHandShakeFailed : TIdOnTLSNegotiationFailure read FOnTLSHandShakeFailed write FOnTLSHandShakeFailed;
    property OnTLSNotAvailable : TIdOnTLSNegotiationFailure read FOnTLSNotAvailable write FOnTLSNotAvailable;
    property OnTLSNegCmdFailed : TIdOnTLSNegotiationFailure read FOnTLSNegCmdFailed write FOnTLSNegCmdFailed;
  end;

type
  EIdTLSClientException = class(EIdException);
  EIdTLSClientSSLIOHandlerRequred = class(EIdTLSClientException);
  EIdTLSClientCanNotSetWhileConnected = class(EIdTLSClientException);
  EIdTLSClientTLSNotAvailable = class(EIdTLSClientException);
  EIdTLSClientTLSNegCmdFailed = class(EIdTLSClientException);
  EIdTLSClientTLSHandShakeFailed = class(EIdTLSClientException);
  EIdTLSServerException = class(EIdException);
  EIdTLSServerSSLIOHandlerRequired = class(EIdTLSServerException);
  EIdTLSClientCanNotSetWhileActive = class(EIdTLSClientException);

implementation

uses
  IdResourceStringsProtocols, IdSSL, SysUtils;

{ TIdExplicitTLSServer }

procedure TIdExplicitTLSServer.InitComponent;
begin
  inherited;
  FUseTLS := DEF_USETLS;
end;

procedure TIdExplicitTLSServer.Loaded;
begin
  inherited;
  if ((IOHandler is TIdServerIOHandler)=False) then
  begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSServer.SetIOHandler(
  const AValue: TIdServerIOHandler);
begin
  inherited;
  if ((IOHandler is TIdServerIOHandlerSSLBase)=False) then
  begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSServer.SetUseTLS(AValue: TIdUseTLS);
begin
  if not Active or ( csDesigning in ComponentState) then
  begin
    if csLoading in ComponentState then
    begin
      FUseTLS := AValue;
      exit;
    end;
    if ((IOHandler is TIdServerIOHandlerSSLBase)=False) and (AValue<>utNoTLSSupport) then
    begin
      raise EIdTLSServerSSLIOHandlerRequired.Create(RSTLSSSLIOHandlerRequired);
    end;
    if FUseTLS <> AValue then
    begin
      if AValue=utUseImplicitTLS then
      begin
        if DefaultPort = FRegularProtPort then
        begin
          DefaultPort := FImplicitTLSProtPort;
        end;
      end
      else
      begin
        if DefaultPort = FImplicitTLSProtPort then
        begin
          DefaultPort := FRegularProtPort;
        end;
      end;
      FUseTLS := AValue;
    end;
  end
  else
  begin
    raise EIdTLSClientCanNotSetWhileActive.Create(RSTLSSLCanNotSetWhileConnected);
  end;
end;

{ TIdExplicitTLSClient }

procedure TIdExplicitTLSClient.CheckIfCanUseTLS;
begin
  if ((IOHandler is TIdSSLIOHandlerSocketBase)=False) then
  begin
    raise EIdTLSClientSSLIOHandlerRequred.Create(RSTLSSSLIOHandlerRequired);
  end;
end;

procedure TIdExplicitTLSClient.Connect;
begin
  if UseTLS in ExplicitTLSVals then
  begin
    // TLS only enabled later in this case!
    (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := true;
  end;
  if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
      case FUseTLS of
       utNoTLSSupport :
       begin
        (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := true;
       end;
       utUseImplicitTLS :
       begin
         (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
       end
       else
        if FUseTLS<>utUseImplicitTLS then begin
         (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := true;
        end;
      end;
  end;
  inherited;

end;

procedure TIdExplicitTLSClient.InitComponent; 
begin
  inherited;
  FCapabilities := TIdStringList.Create;
  FUseTLS := DEF_USETLS;
end;

destructor TIdExplicitTLSClient.Destroy;
begin
  FreeAndNil(FCapabilities);
  inherited;
end;

procedure TIdExplicitTLSClient.DoOnTLSHandShakeFailed;
//OnTLSHandShakeFailed
var LContinue : Boolean;
begin
  LContinue := False;
  if Assigned(OnTLSHandShakeFailed ) then
  begin
    FOnTLSHandShakeFailed(Self,LContinue);
  end;
  if LContinue = False then
  begin
    TLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.DoOnTLSNegCmdFailed;
var LContinue : Boolean;
begin
  LContinue := False;
  if Assigned(OnTLSNegCmdFailed ) then
  begin
    FOnTLSNegCmdFailed(Self,LContinue);
  end;
  if LContinue = False then
  begin
    TLSNotAvailable;
  end;
end;



procedure TIdExplicitTLSClient.DoOnTLSNotAvailable;
var LContinue : Boolean;
begin
  if Assigned(FOnTLSNotAvailable) then
  begin
    LContinue := True;
    FOnTLSNotAvailable(Self,LContinue);
    if LContinue = False then
    begin
      TLSNotAvailable;
    end;
  end;
end;

procedure TIdExplicitTLSClient.Loaded;
begin
  inherited;
  if ((IOHandler is TIdSSLIOHandlerSocketBase)=False) then
  begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSHandShakeFailed;

begin
  if FUseTLS = utUseRequireTLS then
  begin
    TLSHandShakeFailed;
  end
  else
  begin
    DoOnTLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSNegCmdFailed;
begin
  if FUseTLS = utUseRequireTLS then
  begin
    TLSNegCmdFailed;
  end
  else
  begin
    DoOnTLSNegCmdFailed;
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSNotAvail;
begin
  if FUseTLS = utUseRequireTLS then
  begin
    TLSNotAvailable;
  end
  else
  begin
    DoOnTLSNotAvailable;
  end;
end;

procedure TIdExplicitTLSClient.SetIOHandler(AValue: TIdIOHandler);
begin
  inherited;
  if ((IOHandler is TIdSSLIOHandlerSocketBase)=False) then
  begin
    if FUseTLS <> utNoTLSSupport then
    begin
      SetUseTLS(utNoTLSSupport);
    end;
  end;
end;

procedure TIdExplicitTLSClient.SetUseTLS(AValue: TIdUseTLS);
begin
  if not Connected then
  begin
    if csLoading in ComponentState then
    begin
      FUseTLS := AValue;
      exit;
    end;
    if (AValue<>utNoTLSSupport) then
    begin
      CheckIfCanUseTLS;
    end;
    if FUseTLS <> AValue then
    begin
      if AValue=utUseImplicitTLS then
      begin
        if Port = FRegularProtPort then
        begin
          Port := FImplicitTLSProtPort;
        end;
      end
      else
      begin
        if Port = FImplicitTLSProtPort then
        begin
          Port := FRegularProtPort;
        end;
      end;
      FUseTLS := AValue;
    end;
  end
  else
  begin
    raise EIdTLSClientCanNotSetWhileConnected.Create(RSTLSSLCanNotSetWhileConnected);
  end;
end;

procedure TIdExplicitTLSClient.TLSHandshake;
begin
  try
    if (IOHandler is TIdSSLIOHandlerSocketBase) then
    begin
      (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
    end;
  except
    Self.ProcessTLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.TLSHandShakeFailed;
begin
  if Connected then
  begin
    Disconnect;
  end;
  raise EIdTLSClientTLSHandShakeFailed.Create( RSTLSSLSSLNotAvailable);
end;

procedure TIdExplicitTLSClient.TLSNegCmdFailed;
begin
  if Connected then
  begin
    Disconnect;
  end;
  raise  EIdTLSClientTLSNotAvailable.Create( RSTLSSLSSLNotAvailable);
end;

procedure TIdExplicitTLSClient.TLSNotAvailable;
begin
  if Connected then
  begin
    Disconnect;
  end;
  raise  EIdTLSClientTLSNotAvailable.Create( RSTLSSLSSLCmdFailed);
end;

function TIdExplicitTLSClient.GetSupportsTLS: boolean;
begin
  //this is a dummy for descendants to override.  NET doesn't support
  //abstract methods.
  Result := False;
end;

end.
