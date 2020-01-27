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

unit IdOpenSSLIOHandlerClientServer;

interface

{$i IdCompilerDefines.inc}

uses
  IdOpenSSLIOHandlerClientBase,
  IdOpenSSLContextServer;

type
  TIdOpenSSLIOHandlerClientForServer = class(TIdOpenSSLIOHandlerClientBase)
  protected
    procedure EnsureContext; override;
  public
    procedure SetServerContext(const AContext: TIdOpenSSLContextServer);
    procedure StartSSL; override;
  end;

implementation

uses
  IdOpenSSLSocketServer;

{ TIdOpenSSLIOHandlerClientForServer }

procedure TIdOpenSSLIOHandlerClientForServer.EnsureContext;
begin
  inherited;
  Assert(Assigned(FContext));
end;

procedure TIdOpenSSLIOHandlerClientForServer.SetServerContext(
  const AContext: TIdOpenSSLContextServer);
begin
  FContext := AContext;
end;

procedure TIdOpenSSLIOHandlerClientForServer.StartSSL;
begin
  inherited;
  if PassThrough then
    Exit;
  (FTLSSocket as TIdOpenSSLSocketServer).Accept(Binding.Handle);
end;

end.
