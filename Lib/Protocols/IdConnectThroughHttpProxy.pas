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
  Rev 1.6    11/12/2004 11:31:06 AM  JPMugaas
  IPv6 expansions.

  Rev 1.5    2004.02.03 5:45:00 PM  czhower
  Name changes

  Rev 1.4    10/19/2003 11:48:12 AM  DSiders
  Added localization comments.

  Rev 1.3    4/5/2003 7:27:48 PM  BGooijen
  Checks for errors, added authorisation

  Rev 1.2    4/1/2003 4:14:22 PM  BGooijen
  Fixed + cleaned up

  Rev 1.1    2/24/2003 08:20:46 PM  JPMugaas
  Now should compile with new code.

  Rev 1.0    11/14/2002 02:16:10 PM  JPMugaas
}

unit IdConnectThroughHttpProxy;

{
  implements:
  http://www.web-cache.com/Writings/Internet-Drafts/draft-luotonen-web-proxy-tunneling-01.txt
}

interface
{$i IdCompilerDefines.inc}

uses
  Classes, IdCustomTransparentProxy, IdGlobal, IdIOHandler;

type
  TIdConnectThroughHttpProxy = class(TIdCustomTransparentProxy)
  private
    FAuthorizationRequired: Boolean;
  protected
    FEnabled: Boolean;
    function  GetEnabled: Boolean; override;
    procedure SetEnabled(AValue: Boolean); override;
    procedure MakeConnection(AIOHandler: TIdIOHandler; const AHost: string; const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure DoMakeConnection(AIOHandler: TIdIOHandler; const AHost: string;
      const APort: TIdPort; const ALogin:boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);virtual;
  public
    procedure Assign(ASource: TPersistent); override;
  published
    property Enabled;
    property Host;
    property Port;
    property ChainedProxy;
    property Username;
    property Password;
  end;

implementation

uses
  IdCoderMIME, IdExceptionCore, IdHeaderList, IdGlobalProtocols, SysUtils;

{ TIdConnectThroughHttpProxy }

procedure TIdConnectThroughHttpProxy.Assign(ASource: TPersistent);
begin
  if ASource is TIdConnectThroughHttpProxy then begin
    FEnabled := TIdConnectThroughHttpProxy(ASource).Enabled;
  end;
  // always allow TIdCustomTransparentProxy to assign its properties as well
  inherited Assign(ASource);
end;

function TIdConnectThroughHttpProxy.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

procedure TIdConnectThroughHttpProxy.DoMakeConnection(AIOHandler: TIdIOHandler;
  const AHost: string; const APort: TIdPort; const ALogin: Boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LStatus: string;
  LResponseCode: Integer;
  LHeaders: TIdHeaderList;
  LContentLength: Int64;
  LEncoder: TIdEncoderMIME;
begin
  LHeaders := TIdHeaderList.Create(QuoteHTTP);
  try
    AIOHandler.WriteLn(IndyFormat('CONNECT %s:%d HTTP/1.0', [AHost,APort])); {do not localize}
    if ALogin then begin
      LEncoder := TIdEncoderMIME.Create;
      try
        AIOHandler.WriteLn('Proxy-Authorization: Basic ' + LEncoder.Encode(Username + ':' + Password));  {do not localize}
      finally
        LEncoder.Free;
      end;
    end;
    AIOHandler.WriteLn;
    LStatus := AIOHandler.ReadLn;
    if LStatus <> '' then begin // if empty response then we assume it succeeded
      AIOHandler.Capture(LHeaders, '', False);
      // TODO: support chunked replies...
      LContentLength := IndyStrToInt64(LHeaders.Values['Content-Length'], -1); {do not localize}
      if LContentLength > 0 then begin
        AIOHandler.Discard(LContentLength);
      end;
      Fetch(LStatus);// to remove the http/1.0 or http/1.1
      LResponseCode := IndyStrToInt(Fetch(LStatus, ' ', False), 200); // if invalid response then we assume it succeeded
      if (LResponseCode = 407) and (not ALogin) and ((Length(Username) > 0) or (Length(Password) > 0)) then begin // authorization required
        if TextIsSame(LHeaders.Values['Proxy-Connection'], 'close') or {do not localize}
           TextIsSame(LHeaders.Values['Connection'], 'close') then begin {do not localize}
          // need to reconnect before trying again with login
          AIOHandler.Close;
          FAuthorizationRequired := True;
          try
            AIOHandler.Open;
          finally
            FAuthorizationRequired := False;
          end;
        end else begin
          // still connected so try again with login
          DoMakeConnection(AIOHandler, AHost, APort, True);
        end;
      end
      else if not (LResponseCode in [200]) then begin // maybe more responsecodes to add
        raise EIdHttpProxyError.Create(LStatus);//BGO: TODO: maybe split into more exceptions?
      end;
    end;
  finally
    LHeaders.Free;
  end;
end;

procedure TIdConnectThroughHttpProxy.MakeConnection(AIOHandler: TIdIOHandler;
  const AHost: string; const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  DoMakeConnection(AIOHandler, AHost, APort, FAuthorizationRequired);
end;

procedure TIdConnectThroughHttpProxy.SetEnabled(AValue: Boolean);
begin
  FEnabled := AValue;
end;

end.
