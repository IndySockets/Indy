{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLIOHandlerClient;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal,
  IdOpenSSLContext,
  IdOpenSSLIOHandlerClientBase,
  IdOpenSSLOptionsClient,
  IdOpenSSLSocketClient,
  IdSSL;

type
  TIdOpenSSLIOHandlerClient = class(TIdOpenSSLIOHandlerClientBase)
  private
    FOpenSSLLoaded: Boolean;
    function GetTargetHost: string;
    function GetClientSocket: TIdOpenSSLSocketClient; {$IFDEF USE_INLINE}inline;{$ENDIF}
    procedure EnsureOpenSSLLoaded;
  protected
    FOptions: TIdOpenSSLOptionsClient;
    function GetOptionClass: TIdOpenSSLOptionsClientClass; virtual;
    procedure InitComponent; override;
    procedure EnsureContext; override;

    procedure BeforeInitContext(const AContext: TIdOpenSSLContext); virtual;
    procedure AfterInitContext(const AContext: TIdOpenSSLContext); virtual;
  public
    destructor Destroy; override;
    procedure StartSSL; override;

    function Clone: TIdSSLIOHandlerSocketBase; override;
  published
    property Options: TIdOpenSSLOptionsClient read FOptions;
  end;

implementation

uses
  Classes,
  IdCustomTransparentProxy,
  IdOpenSSLContextClient,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_ssl,
  IdOpenSSLLoader,
  IdURI,
  SysUtils;

type
  TIdOpenSSLContextClientAccessor = class(TIdOpenSSLContextClient);

{ TIdOpenSSLIOHandlerClient }

procedure TIdOpenSSLIOHandlerClient.EnsureContext;
begin
  if not Assigned(FContext) then
    FContext := TIdOpenSSLContextClient.Create();

  EnsureOpenSSLLoaded();
  try
    BeforeInitContext(FContext);
    TIdOpenSSLContextClient(FContext).Init(FOptions);
    AfterInitContext(FContext);
  except
    on E: EExternalException do
    begin
      try
        FreeAndNil(FContext);
      except
        on E: EExternalException do ; // Nothing
      end;
      raise EIdOpenSSLLoadError.Create('Failed to load OpenSSL');
    end;
  end;
end;

procedure TIdOpenSSLIOHandlerClient.EnsureOpenSSLLoaded;
var
  LLoader: IOpenSSLLoader;
begin
  if not FOpenSSLLoaded then
  begin
    LLoader := GetOpenSSLLoader();
    if Assigned(LLoader) and not LLoader.Load() then
      raise EIdOpenSSLLoadError.Create('Failed to load OpenSSL');
    FOpenSSLLoaded := True;
  end;
end;

procedure TIdOpenSSLIOHandlerClient.AfterInitContext(
  const AContext: TIdOpenSSLContext);
begin
end;

procedure TIdOpenSSLIOHandlerClient.BeforeInitContext(
  const AContext: TIdOpenSSLContext);
begin
end;

function TIdOpenSSLIOHandlerClient.Clone: TIdSSLIOHandlerSocketBase;
var
  LSessionCopies: TList;
  i: Integer;
begin
  Result := inherited Clone();
  Options.AssignTo(TIdOpenSSLIOHandlerClient(Result).Options);
  TIdOpenSSLIOHandlerClient(Result).EnsureContext();
  LSessionCopies := TIdOpenSSLContextClientAccessor(TIdOpenSSLIOHandlerClient(Result).FContext).FSessionList;
  LSessionCopies.Assign(TIdOpenSSLContextClientAccessor(TIdOpenSSLIOHandlerClient(Self).FContext).FSessionList);
  for i := 0 to LSessionCopies.Count-1 do
    SSL_SESSION_up_ref(LSessionCopies[i]);
end;

destructor TIdOpenSSLIOHandlerClient.Destroy;
begin
  FOptions.Free();
  inherited;
  // Destroy tls socket before context
  FContext.Free();
end;

function TIdOpenSSLIOHandlerClient.GetClientSocket: TIdOpenSSLSocketClient;
begin
  Result := FTLSSocket as TIdOpenSSLSocketClient;
end;

function TIdOpenSSLIOHandlerClient.GetOptionClass: TIdOpenSSLOptionsClientClass;
begin
  Result := TIdOpenSSLOptionsClient;
end;

function TIdOpenSSLIOHandlerClient.GetTargetHost: string;

  function GetHostToCheck(const AUriToCheck: string): string;
  var
    LURI: TIdURI;
  begin
    Result := '';
    if AUriToCheck = '' then
      Exit;
    LURI := TIdURI.Create(URIToCheck);
    try
      Result := LURI.Host;
    finally
      LURI.Free();
    end;
  end;

  function GetProxyTargetHost(const ATransparentProxy: TIdCustomTransparentProxy): string;
  var
    LProxy: TIdCustomTransparentProxy;
  begin
    Result := '';
    LProxy := ATransparentProxy;
    while Assigned(LProxy) and LProxy.Enabled do
    begin
      Result := LProxy.Host;
      LProxy := LProxy.ChainedProxy;
    end;
  end;

begin
  Result := GetHostToCheck(URIToCheck);
  if Result = '' then
    // RLebeau: not reading from the property as it will create a
    // default Proxy object if one is not already assigned...
    Result := GetProxyTargetHost(FTransparentProxy);
end;

procedure TIdOpenSSLIOHandlerClient.InitComponent;
begin
  inherited;
  FOptions := GetOptionClass().Create();
end;

procedure TIdOpenSSLIOHandlerClient.StartSSL;
begin
  inherited;
  if PassThrough then
    Exit;
  GetClientSocket().Connect(Binding.Handle, GetTargetHost());
end;

end.
