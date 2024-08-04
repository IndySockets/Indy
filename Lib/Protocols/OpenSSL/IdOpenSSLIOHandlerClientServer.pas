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
  IdOpenSSLExceptions,
  IdOpenSSLSocketServer,
  SysUtils;

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
  try
    (FTLSSocket as TIdOpenSSLSocketServer).Accept(Binding.Handle);
  except
    on E: EIdOpenSSLAcceptError do
    begin
      if Binding.PeerIP <> '' then
        E.Message := Format('%s [%s]:[%d]', [E.Message, Binding.PeerIP, Binding.PeerPort]);
      raise;
    end;
  end;
end;

end.
