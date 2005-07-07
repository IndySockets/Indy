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
{   Rev 1.3    2004.02.03 5:44:54 PM  czhower
{ Name changes
}
{
{   Rev 1.2    2/1/2004 3:33:48 AM  JPMugaas
{ Reenabled.  SHould work in DotNET.
}
{
{   Rev 1.1    2003.10.12 3:36:26 PM  czhower
{ todo item
}
{
{   Rev 1.0    11/14/2002 02:13:44 PM  JPMugaas
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

Uses
  Classes, 
  IdAuthentication;

Type
  TIdNTLMAuthentication = class(TIdAuthentication)
  protected
    FNTLMInfo: String;
    LHost, LDomain, LUser: String;
    function DoNext: TIdAuthWhatsNext; override;
    function GetSteps: Integer; override;
    procedure SetUserName(const Value: String); override;
  public
    constructor Create; override;
    function Authentication: String; override;
    function KeepAlive: Boolean; override;
    procedure Reset; override;
  end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  IdException,
  IdCoderMIME,
  IdSSLOpenSSLHeaders,
  IdSys,
  IdNTLM;

{ TIdNTLMAuthentication }

constructor TIdNTLMAuthentication.Create;
begin
  inherited Create;
  // Load Open SSL Library
  if not IdSSLOpenSSLHeaders.Load then
  begin
    Unload;
    Sys.Abort;
  end;
end;

function TIdNTLMAuthentication.DoNext: TIdAuthWhatsNext;
begin
  result := wnDoRequest;
  case FCurrentStep of
    0:
      begin
        if (Length(UserName) > 0) then
        begin
          result := wnDoRequest;
        end
        else begin
          result := wnAskTheProgram;
        end;
        FCurrentStep := 1;
      end;
    1:
      begin
        FCurrentStep := 2;
        result := wnDoRequest;
      end;
    2:
      begin
        FCurrentStep := 3;
        result := wnDoRequest;
      end;
    3:
      begin
        Reset;
        result := wnFail;
      end;
  end;
end;

function TIdNTLMAuthentication.Authentication: String;
Var
  S: String;
  Type2: type_2_message_header;
begin
  result := '';    {do not localize}
  case FCurrentStep of
    1:
      begin
        LHost := IndyComputerName;
        result := 'NTLM ' + BuildType1Message(LDomain, LHost);    {do not localize}
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
          Sys.Abort;
        end;

        with TIdDecoderMIME.Create do try
          S := DecodeString(FNTLMInfo);
        finally Free; end;
        move(S[1], type2, sizeof(type2));
        Delete(S, 1, sizeof(type2));

        S := Type2.Nonce;

        S := BuildType3Message(LDomain, LHost, LUser, Password, Type2.Nonce);
        result := 'NTLM ' + S;    {do not localize}

        FCurrentStep := 2;
      end;
  end;
end;

procedure TIdNTLMAuthentication.Reset;
begin
  inherited Reset;
  FCurrentStep := 0;
end;

function TIdNTLMAuthentication.KeepAlive: Boolean;
begin
  result := true;
end;

function TIdNTLMAuthentication.GetSteps: Integer;
begin
  result := 3;
end;

procedure TIdNTLMAuthentication.SetUserName(const Value: String);
var
 i: integer;
begin
 if Value <> Username then
 begin
   inherited SetUserName(Value);
   i := Pos('\', Username);
   if i > -1 then
   begin
     LDomain := Copy(Username, 1, i - 1);
     LUser := Copy(Username, i + 1, Length(UserName));
   end
   else
   begin
     LDomain := ' ';         {do not localize}
     LUser := UserName;
   end;
 end;
end;

initialization
  RegisterAuthenticationMethod('NTLM', TIdNTLMAuthentication);    {do not localize}
finalization
  UnregisterAuthenticationMethod('NTLM');                         {do not localize}
end.

