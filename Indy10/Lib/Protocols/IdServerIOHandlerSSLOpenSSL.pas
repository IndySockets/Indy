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
{   Rev 1.1    2/6/2004 3:37:06 PM  JPMugaas
{ Fixed a refernce that was outdated.
}
{
{   Rev 1.0    11/13/2002 08:00:44 AM  JPMugaas
}
unit IdServerIOHandlerSSLOpenSSL;

interface
uses
  Classes,
  IdServerIOHandler,
  IdSSLOpenSSL,
  IdX509,
  IdSocketHandle,
  IdThread,
  IdIOHandler;

type
  TIdServerIOHandlerSSLOpenSSL = class(TIdServerIOHandler)
  protected
    fSSLContext: TIdSSLContext;
    fxSSLOptions: TIdSSLOptions;
//    fPeerCert: TIdX509;
//    function GetPeerCert: TIdX509;
    fIsInitialized: Boolean;
    fOnStatusInfo: TCallbackEvent;
    fOnGetPassword: TPasswordEvent;
    fOnVerifyPeer: TVerifyPeerEvent;
    //procedure CreateSSLContext(axMode: TIdSSLMode);
    //procedure CreateSSLContext;

  public
    procedure Init; override;
    function Accept(ASocket: TIdSocketHandle; AThread: TIdThread = nil): TIdIOHandler; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoGetPassword(var Password: String); virtual;
    procedure DoStatusInfo(Msg: String); virtual;
    function DoVerifyPeer(Certificate: TIdX509): Boolean; virtual;
  published
    property SSLOptions: TIdSSLOptions read fxSSLOptions write fxSSLOptions;
    property OnStatusInfo: TCallbackEvent read fOnStatusInfo write fOnStatusInfo;
    property OnGetPassword: TPasswordEvent read fOnGetPassword write fOnGetPassword;
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer write fOnVerifyPeer;
  end;

implementation
uses
  IdGlobal, IdIOHandlerSSLOpenSSL, SysUtils;
  
///////////////////////////////////////////////////////
//   TIdServerIOHandlerSSLOpenSSL
///////////////////////////////////////////////////////

{ TIdServerIOHandlerSSLOpenSSL }

constructor TIdServerIOHandlerSSLOpenSSL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fIsInitialized := False;
  fxSSLOptions := TIdSSLOptions.Create;
end;

destructor TIdServerIOHandlerSSLOpenSSL.Destroy;
begin
  if fSSLContext <> nil then begin
    FreeAndNil(fSSLContext);
  end;

  fxSSLOptions.Destroy;
  inherited Destroy;
end;

procedure TIdServerIOHandlerSSLOpenSSL.Init;
begin
  // CreateSSLContext(SSLOptions.fMode);
  // CreateSSLContext;
  fSSLContext := TIdSSLContext.Create;
  with fSSLContext do begin
    Parent := self;
    RootCertFile := SSLOptions.RootCertFile;
    CertFile := SSLOptions.CertFile;
    KeyFile := SSLOptions.KeyFile;

    VerifyDepth := SSLOptions.VerifyDepth;
    VerifyMode := SSLOptions.VerifyMode;
    // fVerifyFile := SSLOptions.fVerifyFile;
    VerifyDirs := SSLOptions.VerifyDirs;
    CipherList := SSLOptions.CipherList;

    if Assigned(fOnVerifyPeer) then begin
      VerifyOn := True;
    end
    else begin
      VerifyOn := False;
    end;

    if Assigned(fOnStatusInfo) then begin
      StatusInfoOn := True;
    end
    else begin
      StatusInfoOn := False;
    end;

    {if Assigned(fOnGetPassword) then begin
      PasswordRoutineOn := True;
    end
    else begin
      PasswordRoutineOn := False;
    end;}

    Method :=  SSLOptions.Method;
    Mode := SSLOptions.Mode;
    fSSLContext.InitContext(sslCtxServer);
  end;

  fIsInitialized := True;
end;

function TIdServerIOHandlerSSLOpenSSL.Accept(ASocket: TIdSocketHandle; AThread: TIdThread = nil): TIdIOHandler;
var
  tmpIdCIOpenSSL: TIdIOHandlerSSLOpenSSL;
begin
  if not fIsInitialized then begin
    Init;
  end;

  tmpIdCIOpenSSL := TIdIOHandlerSSLOpenSSL.Create(self);
  tmpIdCIOpenSSL.IsPeer := True;
  tmpIdCIOpenSSL.Open;
  if tmpIdCIOpenSSL.Binding.Accept(ASocket.Handle) then begin
    tmpIdCIOpenSSL.xSSLOptions := fxSSLOptions;
    tmpIdCIOpenSSL.SSLSocket := TIdSSLSocket.Create(self);
    tmpIdCIOpenSSL.SSLContext := fSSLContext;
    result := tmpIdCIOpenSSL;
  end
  else begin
    result := nil;
    FreeAndNil(tmpIdCIOpenSSL);
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoStatusInfo(Msg: String);
begin
  if Assigned(fOnStatusInfo) then
    fOnStatusInfo(Msg);
end;

procedure TIdServerIOHandlerSSLOpenSSL.DoGetPassword(var Password: String);
begin
  if Assigned(fOnGetPassword) then
    fOnGetPassword(Password);
end;

function TIdServerIOHandlerSSLOpenSSL.DoVerifyPeer(Certificate: TIdX509): Boolean;
begin
  Result := True;
  if Assigned(fOnVerifyPeer) then
    Result := fOnVerifyPeer(Certificate);
end;

end.
