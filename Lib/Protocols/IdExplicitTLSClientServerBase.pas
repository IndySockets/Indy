{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.14    10/26/2004 9:09:36 PM  JPMugaas
  Updated references.

  Rev 1.13    2004.02.03 5:45:36 PM  czhower
  Name changes

  Rev 1.12    1/25/2004 3:52:28 PM  JPMugaas
  Fixes for abstract SSL interface to work in NET.

  Rev 1.11    1/21/2004 1:23:38 PM  JPMugaas
  InitComponent.

  Rev 1.10    5/25/2003 12:06:16 AM  JPMugaas
  TLS checking code moved into a protected method for reuse in TIdDirectSMTP.
  Note that TLS support is different in that component because of the way it
  works.

    Rev 1.9    5/21/2003 3:36:42 PM  BGooijen
  Fixed design time bug regarding the Active property

  Rev 1.8    5/8/2003 11:27:38 AM  JPMugaas
  Moved feature negoation properties down to the ExplicitTLSClient level as
  feature negotiation goes hand in hand with explicit TLS support.

  Rev 1.7    4/13/2003 05:38:02 PM  JPMugaas
  Fix for SetTLS exception problem with IdMessage.SaveToFile.

  Rev 1.6    4/5/2003 02:06:48 PM  JPMugaas
  TLS handshake itself can now be handled.

  Rev 1.5    3/27/2003 05:46:22 AM  JPMugaas
  Updated framework with an event if the TLS negotiation command fails.
  Cleaned up some duplicate code in the clients.

  Rev 1.4    3/26/2003 04:19:18 PM  JPMugaas
  Cleaned-up some code and illiminated some duplicate things.

    Rev 1.3    3/23/2003 11:45:02 PM  BGooijen
  classes -> Classes

  Rev 1.2    3/18/2003 04:36:52 PM  JPMugaas

  Rev 1.1    3/16/2003 06:08:34 PM  JPMugaas
  Fixed a bug where the wrong port number was being set.  I also expanded a few
  things for the server.

  Rev 1.0    3/16/2003 02:38:08 PM  JPMugaas
  Base class for some clients that use both implicit and explicit TLS.
}

unit IdExplicitTLSClientServerBase;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCmdTCPServer,
  IdException,
  IdGlobal,
  IdIOHandler,
  IdServerIOHandler,
  IdTCPClient;

type
  TIdUseTLS = (
    utNoTLSSupport,
    utUseImplicitTLS, // ssl iohandler req, allways tls
    utUseRequireTLS, // ssl iohandler req, user command only accepted when in tls
    utUseExplicitTLS // < user can choose to use tls
    );

const
  ExplicitTLSVals = [utUseRequireTLS,utUseExplicitTLS];
  DEF_USETLS = utNoTLSSupport; //we can't assume the user wants to use a SSL IOHandler

type
  TIdOnTLSNegotiationFailure = procedure(Asender : TObject; var VContinue : Boolean) of object;

  TIdExplicitTLSServer = class(TIdCmdTCPServer)
  protected
    FRegularProtPort : TIdPort;
    FImplicitTLSProtPort : TIdPort;
    FExplicitTLSProtPort : TIdPort;
    FUseTLS : TIdUseTLS;
    procedure Loaded; override;
    procedure SetIOHandler(const AValue: TIdServerIOHandler); override;
    procedure SetUseTLS(AValue : TIdUseTLS); virtual;
    property UseTLS : TIdUseTLS read FUseTLS write SetUseTLS default  DEF_USETLS;
    procedure InitComponent; override;
  end;

  TIdExplicitTLSClient = class(TIdTCPClientCustom)
  protected
    FRegularProtPort : TIdPort;
    FImplicitTLSProtPort : TIdPort;
    FExplicitTLSProtPort : TIdPort;
    FUseTLS : TIdUseTLS;
    FOnTLSNotAvailable : TIdOnTLSNegotiationFailure;
    FOnTLSNegCmdFailed : TIdOnTLSNegotiationFailure;
    FOnTLSHandShakeFailed : TIdOnTLSNegotiationFailure;

    //feature negotiation stuff
    FCapabilities : TStrings;
    function GetSupportsTLS : Boolean; virtual; 
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
    property Capabilities : TStrings read FCapabilities;
    property OnTLSHandShakeFailed : TIdOnTLSNegotiationFailure read FOnTLSHandShakeFailed write FOnTLSHandShakeFailed;
    property OnTLSNotAvailable : TIdOnTLSNegotiationFailure read FOnTLSNotAvailable write FOnTLSNotAvailable;
    property OnTLSNegCmdFailed : TIdOnTLSNegotiationFailure read FOnTLSNegCmdFailed write FOnTLSNegCmdFailed;
  end;

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
  IdResourceStringsProtocols, IdSSL, IdBaseComponent, SysUtils;

{ TIdExplicitTLSServer }

procedure TIdExplicitTLSServer.InitComponent;
begin
  inherited InitComponent;
  FUseTLS := DEF_USETLS;
end;

procedure TIdExplicitTLSServer.Loaded;
begin
  inherited Loaded;
  if not (IOHandler is TIdServerIOHandler) then begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSServer.SetIOHandler(const AValue: TIdServerIOHandler);
begin
  inherited SetIOHandler(AValue);
  if not (IOHandler is TIdServerIOHandlerSSLBase) then begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSServer.SetUseTLS(AValue: TIdUseTLS);
begin
  if Active and (not IsDesignTime) then begin
    raise EIdTLSClientCanNotSetWhileActive.Create(RSTLSSLCanNotSetWhileConnected);
  end;
  if IsLoading then begin
    FUseTLS := AValue;
    Exit;
  end;
  if FUseTLS <> AValue then
  begin
    if AValue <> utNoTLSSupport then
    begin
      if not (IOHandler is TIdServerIOHandlerSSLBase) then begin
        raise EIdTLSServerSSLIOHandlerRequired.Create(RSTLSSSLIOHandlerRequired);
      end;
    end;
    case AValue of
      utUseImplicitTLS: begin
        if (DefaultPort = FRegularProtPort) or (DefaultPort = FExplicitTLSProtPort) then begin
          DefaultPort := FImplicitTLSProtPort;
        end;
      end;
      utUseExplicitTLS: begin
        if (DefaultPort = FRegularProtPort) or (DefaultPort = FImplicitTLSProtPort) then begin
          DefaultPort := iif(FExplicitTLSProtPort <> 0, FExplicitTLSProtPort, FRegularProtPort);
        end;
      end;
    else
      if (DefaultPort = FImplicitTLSProtPort) or (DefaultPort = FExplicitTLSProtPort) then begin
        DefaultPort := FRegularProtPort;
      end;
    end;
    FUseTLS := AValue;
  end;
end;

{ TIdExplicitTLSClient }

procedure TIdExplicitTLSClient.CheckIfCanUseTLS;
begin
  if not (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    raise EIdTLSClientSSLIOHandlerRequred.Create(RSTLSSSLIOHandlerRequired);
  end;
end;

procedure TIdExplicitTLSClient.Connect;
begin
  if UseTLS in ExplicitTLSVals then begin
    // TLS only enabled later in this case!
    (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := True;
  end;
  if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    case FUseTLS of
      utNoTLSSupport :
        begin
          (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := True;
        end;
      utUseImplicitTLS :
        begin
          (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
        end;
      else
        begin
          if FUseTLS <> utUseImplicitTLS then begin
            (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := True;
          end;
        end;
    end;
  end;
  inherited Connect;
end;

procedure TIdExplicitTLSClient.InitComponent; 
begin
  inherited InitComponent;
  FCapabilities := TStringList.Create;
  FUseTLS := DEF_USETLS;
end;

destructor TIdExplicitTLSClient.Destroy;
begin
  FreeAndNil(FCapabilities);
  inherited Destroy;
end;

//OnTLSHandShakeFailed
procedure TIdExplicitTLSClient.DoOnTLSHandShakeFailed;
var
  LContinue : Boolean;
begin
  LContinue := False;
  if Assigned(OnTLSHandShakeFailed) then begin
    FOnTLSHandShakeFailed(Self, LContinue);
  end;
  if not LContinue then begin
    TLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.DoOnTLSNegCmdFailed;
var
  LContinue : Boolean;
begin
  LContinue := False;
  if Assigned(OnTLSNegCmdFailed) then begin
    FOnTLSNegCmdFailed(Self, LContinue);
  end;
  if not LContinue then begin
    TLSNegCmdFailed;
  end;
end;

procedure TIdExplicitTLSClient.DoOnTLSNotAvailable;
var
  LContinue : Boolean;
begin
  LContinue := True;
  if Assigned(FOnTLSNotAvailable) then begin
    FOnTLSNotAvailable(Self, LContinue);
  end;
  if not LContinue then begin
    TLSNotAvailable;
  end;
end;

procedure TIdExplicitTLSClient.Loaded;
begin
  inherited Loaded;
  if not (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    SetUseTLS(utNoTLSSupport);
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSHandShakeFailed;
begin
  if FUseTLS = utUseRequireTLS then begin
    TLSHandShakeFailed;
  end else begin
    DoOnTLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSNegCmdFailed;
begin
  if FUseTLS = utUseRequireTLS then begin
    TLSNegCmdFailed;
  end else begin
    DoOnTLSNegCmdFailed;
  end;
end;

procedure TIdExplicitTLSClient.ProcessTLSNotAvail;
begin
  if FUseTLS = utUseRequireTLS then begin
    TLSNotAvailable;
  end else begin
    DoOnTLSNotAvailable;
  end;
end;

procedure TIdExplicitTLSClient.SetIOHandler(AValue: TIdIOHandler);
begin
  inherited SetIOHandler(AValue);
  if not (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    if FUseTLS <> utNoTLSSupport then begin
      SetUseTLS(utNoTLSSupport);
    end;
  end;
end;

procedure TIdExplicitTLSClient.SetUseTLS(AValue: TIdUseTLS);
begin
  if Connected then begin
    raise EIdTLSClientCanNotSetWhileConnected.Create(RSTLSSLCanNotSetWhileConnected);
  end;
  if IsLoading then begin
    FUseTLS := AValue;
    Exit;
  end;
  if FUseTLS <> AValue then
  begin
    if AValue <> utNoTLSSupport then begin
      CheckIfCanUseTLS;
    end;
    case AValue of
      utUseImplicitTLS: begin
        if (Port = FRegularProtPort) or (Port = FExplicitTLSProtPort) then begin
          Port := FImplicitTLSProtPort;
        end;
      end;
      utUseExplicitTLS: begin
        if (Port = FRegularProtPort) or (Port = FImplicitTLSProtPort) then begin
          Port := iif(FExplicitTLSProtPort <> 0, FExplicitTLSProtPort, FRegularProtPort);
        end;
      end;
    else
      if (Port = FImplicitTLSProtPort) or (Port = FExplicitTLSProtPort) then begin
        Port := FRegularProtPort;
      end;
    end;
    FUseTLS := AValue;
  end;
end;

procedure TIdExplicitTLSClient.TLSHandshake;
begin
  try
    if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
      (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
    end;
  except
    ProcessTLSHandShakeFailed;
  end;
end;

procedure TIdExplicitTLSClient.TLSHandShakeFailed;
begin
  if Connected then begin
    // RLebeau 9/19/2013: do not send a goodbye command to the peer.
    // The socket data may be in a bad state at this point!
    Disconnect(False);
  end;
  // This method should always be called in the context of an active 'except'
  // block, so use IndyRaiseOuterException() to capture the inner exception
  // (if possible) when raising this outer exception...
  IndyRaiseOuterException(EIdTLSClientTLSHandShakeFailed.Create(RSTLSSLSSLHandshakeFailed));
end;

procedure TIdExplicitTLSClient.TLSNegCmdFailed;
begin
  if Connected then begin
    Disconnect;
  end;
  // This method should never be called in the context of an active 'except'
  // block, so do not use IndyRaiseOuterException() to capture an inner exception
  // when raising this exception...
  raise EIdTLSClientTLSNegCmdFailed.Create(RSTLSSLSSLCmdFailed);
end;

procedure TIdExplicitTLSClient.TLSNotAvailable;
begin
  if Connected then begin
    Disconnect;
  end;
  // This method should never be called in the context of an active 'except'
  // block, so do not use IndyRaiseOuterException() to capture an inner exception
  // when raising this exception...
  raise EIdTLSClientTLSNotAvailable.Create(RSTLSSLSSLNotAvailable);
end;

function TIdExplicitTLSClient.GetSupportsTLS: boolean;
begin
  //this is a dummy for descendants to override.  NET doesn't support
  //abstract methods.
  Result := False;
end;

end.
