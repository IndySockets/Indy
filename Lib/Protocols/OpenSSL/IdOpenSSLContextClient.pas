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
  Classes,
  IdCTypes,
  IdOpenSSLContext,
  IdOpenSSLOptions,
  IdOpenSSLOptionsClient,
  IdOpenSSLSocket;

type
  TIdOpenSSLContextClient = class(TIdOpenSSLContext)
  private
  protected
    FSessionList: TList;
    function GetVerifyMode(const AOptions: TIdOpenSSLOptionsBase): TIdC_INT; override;
  public
    constructor Create;
    destructor Destroy; override;

    function Init(const AOptions: TIdOpenSSLOptionsClient): Boolean;
    function CreateSocket: TIdOpenSSLSocket; override;
  end;

implementation

uses
  IdOpenSSLHeaders_ssl,
  IdOpenSSLSocketClient,
  IdOpenSSLHeaders_ossl_typ,
  Types;

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
  LContext := TIdOpenSSLContextClient(SSL_ctx_get_ex_data(LCtx, CExDataIndexSelf));
  if not Assigned(LContext) then
    Exit;
  LContext.FSessionList.Add(session);
  Result := 1;
end;

// Is automatically called whenever a session is removed by the SSL engine,
// because it is considered faulty or the session has become obsolete because of
// exceeding the timeout value
procedure remove_session_cb(ctx: PSSL_CTX; session: PSSL_SESSION); cdecl;
var
  LContext: TIdOpenSSLContextClient;
  LSession: Pointer;
begin
  LContext := TIdOpenSSLContextClient(SSL_ctx_get_ex_data(ctx, CExDataIndexSelf));
  if not Assigned(LContext) then
    Exit;
  LSession := LContext.FSessionList.Extract(session);
  if Assigned(LSession) then
    SSL_SESSION_free(LSession);
end;

{ TIdOpenSSLContextClient }

constructor TIdOpenSSLContextClient.Create;
begin
  inherited Create();
  FSessionList := TList.Create();
end;

function TIdOpenSSLContextClient.CreateSocket: TIdOpenSSLSocket;
begin
  Result := TIdOpenSSLSocketClient.Create(OpenSSLContext);
  if FSessionList.Count > 0 then
    TIdOpenSSLSocketClient(Result).SetSession(FSessionList.Last());
end;

destructor TIdOpenSSLContextClient.Destroy;
var
  i: Integer;
begin
  SSL_CTX_sess_set_remove_cb(OpenSSLContext, nil);
  SSL_CTX_sess_set_new_cb(OpenSSLContext, nil);
  for i := FSessionList.Count-1 downto 0 do
    SSL_SESSION_free(FSessionList[i]);
  FSessionList.Free();
  inherited;
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
