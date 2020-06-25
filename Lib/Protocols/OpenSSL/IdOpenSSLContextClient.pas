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

unit IdOpenSSLContextClient;

interface

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdOpenSSLContext,
  IdOpenSSLOptions,
  IdOpenSSLOptionsClient,
  IdOpenSSLSocket;

type
  TIdOpenSSLContextClient = class(TIdOpenSSLContext)
  private
  protected
    FSession: Pointer;
    function GetVerifyMode(const AOptions: TIdOpenSSLOptionsBase): TIdC_INT; override;
  public
    function Init(const AOptions: TIdOpenSSLOptionsClient): Boolean;
    function CreateSocket: TIdOpenSSLSocket; override;
  end;

implementation

uses
  IdOpenSSLHeaders_ssl,
  IdOpenSSLSocketClient,
  IdOpenSSLHeaders_ossl_typ;

// Is automatically called whenever a new session was negotiated
function new_session_cb(ssl: PSSL; session: PSSL_SESSION): TIdC_INT; cdecl;
var
  LCtx: PSSL_CTX;
  LContext: TIdOpenSSLContextClient;
begin
  Result := 0;
  LCtx := SSL_get_SSL_CTX(ssl);
  if not Assigned(LCtx) then
    Exit;
  LContext := TIdOpenSSLContextClient(SSL_ctx_get_ex_data(LCtx, TIdOpenSSLContext.CExDataIndexSelf));
  if not Assigned(LContext) then
    Exit;
  LContext.FSession := session;
  Result := 1;
end;

// Is automatically called whenever a session is removed by the SSL engine,
// because it is considered faulty or the session has become obsolete because of
// exceeding the timeout value
procedure remove_session_cb(ctx: PSSL_CTX; session: PSSL_SESSION); cdecl;
var
  LContext: TIdOpenSSLContextClient;
begin
  LContext := TIdOpenSSLContextClient(SSL_ctx_get_ex_data(ctx, TIdOpenSSLContext.CExDataIndexSelf));
  if not Assigned(LContext) then
    Exit;
  if LContext.FSession = session then
    LContext.FSession := nil;
end;

{ TIdOpenSSLContextClient }

function TIdOpenSSLContextClient.CreateSocket: TIdOpenSSLSocket;
begin
  Result := TIdOpenSSLSocketClient.Create(OpenSSLContext);
  TIdOpenSSLSocketClient(Result).SetSession(FSession);
end;

function TIdOpenSSLContextClient.GetVerifyMode(
  const AOptions: TIdOpenSSLOptionsBase): TIdC_INT;
begin
  Result := SSL_VERIFY_NONE;
  if TIdOpenSSLOptionsClient(AOptions).VerifyServerCertificate then
    Result := SSL_VERIFY_PEER;
end;

function TIdOpenSSLContextClient.Init(
  const AOptions: TIdOpenSSLOptionsClient): Boolean;
begin
  Result := inherited Init(AOptions);
  SSL_CTX_sess_set_new_cb(OpenSSLContext, new_session_cb);
  SSL_CTX_sess_set_remove_cb(OpenSSLContext, remove_session_cb);
end;

end.
