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

unit IdOpenSSLIOHandlerServer;

interface

{$i IdCompilerDefines.inc}

uses
  IdOpenSSLContextServer,
  IdOpenSSLOptionsServer,
  IdSSL,
  IdSocketHandle,
  IdThread,
  IdYarn,
  IdIOHandler;

type
  TIdOpenSSLIOHandlerServer = class(TIdServerIOHandlerSSLBase)
  private
    FOptions: TIdOpenSSLOptionsServer;
    FContext: TIdOpenSSLContextServer;
    FOpenSSLLoaded: Boolean;
  protected
    function GetOptionClass: TIdOpenSSLOptionsServerClass; virtual;
    procedure InitComponent; override;
  public
    destructor Destroy; override;

    procedure Init; override;
    procedure Shutdown; override;
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread;
      AYarn: TIdYarn): TIdIOHandler; override;

    // Abstract functions from TIdServerIOHandlerSSLBase
    function MakeClientIOHandler: TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPort: TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase; override;
  published
    property Options: TIdOpenSSLOptionsServer read FOptions;
  end;

implementation

uses
  IdOpenSSLExceptions,
  IdOpenSSLIOHandlerClientServer,
  IdOpenSSLLoader,
  SysUtils;

{ TIdOpenSSLIOHandlerServer }

function TIdOpenSSLIOHandlerServer.Accept(ASocket: TIdSocketHandle;
  AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler;
var
  LIOHandler: TIdOpenSSLIOHandlerClientForServer;
begin
  LIOHandler := MakeClientIOHandler() as TIdOpenSSLIOHandlerClientForServer;
  try
    LIOHandler.PassThrough := True;
    LIOHandler.Open;
    if not LIOHandler.Binding.Accept(ASocket.Handle) then
      FreeAndNil(LIOHandler);
  except
    FreeAndNil(LIOHandler);
    raise;
  end;
  Result := LIOHandler;
end;

destructor TIdOpenSSLIOHandlerServer.Destroy;
begin
  FOptions.Free();
  inherited;
end;

function TIdOpenSSLIOHandlerServer.GetOptionClass: TIdOpenSSLOptionsServerClass;
begin
  Result := TIdOpenSSLOptionsServer;
end;

procedure TIdOpenSSLIOHandlerServer.Init;
var
  LLoader: IOpenSSLLoader;
begin
  inherited;

  LLoader := GetOpenSSLLoader();
  if not FOpenSSLLoaded and Assigned(LLoader) and not LLoader.Load() then
    raise EIdOpenSSLLoadError.Create('Failed to load OpenSSL');
  FOpenSSLLoaded := True;

  FContext := TIdOpenSSLContextServer.Create();
  try
    FContext.Init(FOptions);
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

procedure TIdOpenSSLIOHandlerServer.InitComponent;
begin
  inherited;
  FOptions := GetOptionClass().Create();
end;

function TIdOpenSSLIOHandlerServer.MakeClientIOHandler: TIdSSLIOHandlerSocketBase;
var
  LHandler: TIdOpenSSLIOHandlerClientForServer;
begin
  LHandler := TIdOpenSSLIOHandlerClientForServer.Create(nil);
  LHandler.SetServerContext(FContext);

  Result := LHandler;
end;

function TIdOpenSSLIOHandlerServer.MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase;
begin
  Result := MakeClientIOHandler();
end;

function TIdOpenSSLIOHandlerServer.MakeFTPSvrPort: TIdSSLIOHandlerSocketBase;
begin
  Result := MakeClientIOHandler();
end;

procedure TIdOpenSSLIOHandlerServer.Shutdown;
begin
  inherited;
  FContext.Free();
end;

end.
