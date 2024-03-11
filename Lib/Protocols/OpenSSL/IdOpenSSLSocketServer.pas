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

unit IdOpenSSLSocketServer;

interface

{$i IdCompilerDefines.inc}

uses
  IdOpenSSLSocket,
  IdStackConsts;

type
  TIdOpenSSLSocketServer = class(TIdOpenSSLSocket)
  public
    function Accept(
      const AHandle: TIdStackSocketHandle): Boolean;
  end;

implementation

uses
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLExceptions,
  IdOpenSSLHeaders_ssl,
  IdCTypes;

{ TIdOpenSSLSocketServer }

function TIdOpenSSLSocketServer.Accept(
  const AHandle: TIdStackSocketHandle): Boolean;
var
  LReturnCode: TIdC_INT;
  LShouldRetry: Boolean;
begin
  FSSL := StartSSL(FContext);
  SSL_set_fd(FSSL, AHandle);

  repeat
    LReturnCode := SSL_accept(FSSL);
    Result := LReturnCode = 1;

    LShouldRetry := ShouldRetry(FSSL, LReturnCode);
    if not LShouldRetry and (LReturnCode < 0) then
      raise EIdOpenSSLAcceptError.Create(FSSL, LReturnCode, '');
  until not LShouldRetry;
end;

end.
