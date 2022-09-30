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
  Rev 1.13    12/2/2004 4:24:00 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.12    2004.02.03 5:44:32 PM  czhower
  Name changes

  Rev 1.11    2004.01.22 2:33:58 PM  czhower
  Matched visibility of DoConnect

  Rev 1.10    1/21/2004 4:20:52 PM  JPMugaas
  InitComponent

  Rev 1.9    2003.10.21 9:13:16 PM  czhower
  Now compiles.

  Rev 1.8    9/19/2003 04:27:02 PM  JPMugaas
  Removed IdFTPServer so Indy can compile with Kudzu's new changes.

  Rev 1.7    7/6/2003 7:55:36 PM  BGooijen
  Removed unused units from the uses

  Rev 1.6    2/24/2003 10:32:50 PM  JPMugaas

  Rev 1.5    1/17/2003 07:11:04 PM  JPMugaas
  Now compiles under new framework.

  Rev 1.4    1/17/2003 04:05:40 PM  JPMugaas
  Now compiles under new design.

  Rev 1.3    1/9/2003 06:09:42 AM  JPMugaas
  Updated for IdContext API change.

  Rev 1.2    1/8/2003 05:53:58 PM  JPMugaas
  Switched stuff to IdContext.

  Rev 1.1    12/7/2002 06:43:36 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 08:02:56 AM  JPMugaas
}

unit IdTelnetServer;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdBaseComponent,
  IdAssignedNumbers, IdContext,
  IdCustomTCPServer,
  IdTCPConnection, IdYarn;

const
  GLoginAttempts = 3;

type

  // SG 16/02/2001: Moved the TTelnetData object from TIdPeerThread to custom TIdPeerThread descendant

  TTelnetData = class(TObject)
  public
    Username, Password: String;
    HUserToken: UInt32;
  end;

  // Custom Peer thread class
  TIdTelnetServerContext = class(TIdServerContext)
  private
    FTelnetData: TTelnetData;
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TIdContextThreadList = nil
      ); override;
    destructor Destroy; override;
    Property TelnetData: TTelnetData read FTelnetData;
  end; //class


  TIdTelnetNegotiateEvent = procedure(AContext: TIdContext) of object;
  TAuthenticationEvent = procedure(AContext: TIdContext;
   const AUsername, APassword: string; var AAuthenticated: Boolean) of object;

  TIdTelnetServer = class(TIdCustomTCPServer)
  protected
    FLoginAttempts: Integer;
    FOnAuthentication: TAuthenticationEvent;
    FLoginMessage: string;
    FOnNegotiate: TIdTelnetNegotiateEvent;
    //
    procedure DoConnect(AContext: TIdContext); override;
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    function DoAuthenticate(AContext: TIdContext; const AUsername, APassword: string)
     : boolean; virtual;
    procedure DoNegotiate(AContext: TIdContext); virtual;
  published
    property DefaultPort default IdPORT_TELNET;
    property LoginAttempts: Integer read FLoginAttempts write FLoginAttempts Default GLoginAttempts;
    property LoginMessage: String read FLoginMessage write FLoginMessage;
    property OnAuthentication: TAuthenticationEvent read FOnAuthentication write FOnAuthentication;
    property OnNegotiate: TIdTelnetNegotiateEvent read FOnNegotiate write FOnNegotiate;
    property OnExecute;
  end;

implementation

uses
  IdException, IdResourceStringsProtocols, SysUtils;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdTelnetServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdTelnetServer.InitComponent;
begin
  inherited InitComponent;
  LoginAttempts := GLoginAttempts;
  LoginMessage := RSTELNETSRVWelcomeString;
  DefaultPort := IdPORT_TELNET;
  FContextClass := TIdTelnetServerContext;
end;

function TIdTelnetServer.DoAuthenticate;
begin
  if not Assigned(OnAuthentication) then begin
    raise EIdException.Create(RSTELNETSRVNoAuthHandler); // TODO: create a new Exception class for this
  end;
  Result := False;
  OnAuthentication(AContext, AUsername, APassword, result);
end;

procedure TIdTelnetServer.DoConnect(AContext: TIdContext);
Var
  Data: TTelnetData;
  i: integer;
begin
  try
    inherited;
    Data := (AContext as TIdTelnetServerContext).TelnetData;
    // do protocol negotiation first
    DoNegotiate(AContext);
    // Welcome the user
    if Length(LoginMessage) > 0 then
    begin
      AContext.Connection.IOHandler.WriteLn(LoginMessage);
      AContext.Connection.IOHandler.WriteLn;    {Do not Localize}
    end;
    // Only prompt for creditentials if there is an authentication handler
    if Assigned(OnAuthentication) then
    begin
      // ask for username/password.
      for i := 1 to LoginAttempts do
      begin
        // UserName
        AContext.Connection.IOHandler.Write(RSTELNETSRVUsernamePrompt);
        Data.Username := AContext.Connection.IOHandler.InputLn;
        // Password
        AContext.Connection.IOHandler.Write(RSTELNETSRVPasswordPrompt);
        Data.Password := AContext.Connection.IOHandler.InputLn('*');    {Do not Localize}
        AContext.Connection.IOHandler.WriteLn;
        // Check authentication
        if DoAuthenticate(AContext, Data.Username, Data.Password) then begin
          Break; // exit the loop
        end;
        AContext.Connection.IOHandler.WriteLn(RSTELNETSRVInvalidLogin);
        if i = FLoginAttempts then begin
          raise EIdException.Create(RSTELNETSRVMaxloginAttempt); // TODO: create a new Exception class for this
        end;
      end;
    end;
  except
    on E: Exception do begin
      AContext.Connection.IOHandler.WriteLn(E.Message);
      AContext.Connection.Disconnect;
    end;
  end;
end;

procedure TIdTelnetServer.DoNegotiate(AContext: TIdContext);
begin
  if Assigned(FOnNegotiate) then begin
    FOnNegotiate(AContext);
  end;
end;

{ TIdTelnetServerContext }

constructor TIdTelnetServerContext.Create(AConnection: TIdTCPConnection;
  AYarn: TIdYarn; AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FTelnetData := TTelnetData.Create;
end;

destructor TIdTelnetServerContext.Destroy;
begin
  FreeAndNil(FTelnetData);
  inherited Destroy;
end;

end.
