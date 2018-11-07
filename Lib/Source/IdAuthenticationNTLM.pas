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
  Rev 1.3    2004.02.03 5:44:54 PM  czhower
  Name changes

  Rev 1.2    2/1/2004 3:33:48 AM  JPMugaas
  Reenabled.  Should work in DotNET.

  Rev 1.1    2003.10.12 3:36:26 PM  czhower
  todo item

  Rev 1.0    11/14/2002 02:13:44 PM  JPMugaas
}
{

  Implementation of the NTLM authentication as specified in
  http://www.innovation.ch/java/ntlm.html with some fixes

  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

  S.G. 12/7/2002: Moved the user query one step up: the domain name is required
                  to properly format the Type 1 message.
}


unit IdAuthenticationNTLM;

interface

{$i IdCompilerDefines.inc}

uses
  Classes, 
  IdAuthentication;

Type
  TIdNTLMAuthentication = class(TIdAuthentication)
  protected
    FNTLMInfo: String;
    FHost, FDomain, FUser: String;
    function DoNext: TIdAuthWhatsNext; override;
    function GetSteps: Integer; override;
    procedure SetUserName(const Value: String); override;
  public
    constructor Create; override;
    function Authentication: String; override;
    function KeepAlive: Boolean; override;
  end;

  // RLebeau 4/17/10: this forces C++Builder to link to this unit so
  // RegisterAuthenticationMethod can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdAuthenticationNTLM"'}
  {$ENDIF}

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  IdException,
  IdCoderMIME,
  IdResourceStringsOpenSSL,
  {.$IFDEF USE_OPENSSL}
  IdSSLOpenSSLHeaders,
  IdSSLOpenSSL,
  {.$ENDIF}
  IdNTLM,
  SysUtils;

{ TIdNTLMAuthentication }

constructor TIdNTLMAuthentication.Create;
begin
  inherited Create;
  {.$IFDEF USE_OPENSSL}
  if not LoadOpenSSLLibrary then begin
    raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
  end;
  {.$ENDIF}
  {TODO: add this?
  if not NTLMFunctionsLoaded then begin
    raise ...;
  end;
  }
end;

function TIdNTLMAuthentication.DoNext: TIdAuthWhatsNext;
begin
  Result := wnDoRequest;
  case FCurrentStep of
    0:
      begin
        if Length(UserName) > 0 then begin
          FCurrentStep := 1;
          Result := wnDoRequest;
        end else begin
          Result := wnAskTheProgram;
        end;
      end;
    1, 2:
      begin
        Inc(FCurrentStep);
        Result := wnDoRequest;
      end;
    3:
      begin
        Reset;
        Result := wnFail;
      end;
  end;
end;

function TIdNTLMAuthentication.Authentication: String;
var
  buf: TIdBytes;
  Type2: type_2_message_header;
  LDecoder: TIdDecoderMIME;
begin
  Result := '';    {do not localize}
  SetLength(buf, 0);

  case FCurrentStep of
    1:
      begin
        FHost := IndyComputerName;
        Result := 'NTLM ' + BuildType1Message(FDomain, FHost);    {do not localize}
      end;
    2:
      begin
        if Length(FNTLMInfo) = 0 then
        begin
          FNTLMInfo := ReadAuthInfo('NTLM');   {do not localize}
          Fetch(FNTLMInfo);
        end;

        if Length(FNTLMInfo) = 0 then
        begin
          Reset;
          Abort;
        end;

        LDecoder := TIdDecoderMIME.Create;
        try
          buf := LDecoder.DecodeBytes(FNTLMInfo);
        finally
          LDecoder.Free;
        end;
        BytesToRaw(buf, Type2, SizeOf(Type2));

        buf := RawToBytes(Type2.Nonce, SizeOf(Type2.Nonce));
        Result := 'NTLM ' + BuildType3Message(FDomain, FHost, FUser, Password, buf); {do not localize}

        FCurrentStep := 2;
      end;
  end;
end;

function TIdNTLMAuthentication.KeepAlive: Boolean;
begin
  Result := True;
end;

function TIdNTLMAuthentication.GetSteps: Integer;
begin
  Result := 3;
end;

procedure TIdNTLMAuthentication.SetUserName(const Value: String);
begin
  if Value <> Username then
  begin
    inherited SetUserName(Value);
    GetDomain(Username, FUser, FDomain);
  end;
end;

initialization
  RegisterAuthenticationMethod('NTLM', TIdNTLMAuthentication);    {do not localize}
finalization
  UnregisterAuthenticationMethod('NTLM');                         {do not localize}
end.
