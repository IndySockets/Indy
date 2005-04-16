{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11757: IdSocksServer.pas
{
{   Rev 1.15    12/2/2004 4:23:58 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
    Rev 1.14    5/30/2004 7:50:44 PM  DSiders
  Corrected case in ancestor for TIdCustomSocksServer.
}
{
{   Rev 1.13    2004.03.03 10:28:48 AM  czhower
{ Removed warnings.
}
{
{   Rev 1.12    2004.02.03 5:44:24 PM  czhower
{ Name changes
}
{
{   Rev 1.11    1/21/2004 4:03:44 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.10    2003.10.21 9:13:14 PM  czhower
{ Now compiles.
}
{
{   Rev 1.9    2003.10.12 7:23:52 PM  czhower
{ Compile todos
}
{
{   Rev 1.8    9/19/2003 04:27:04 PM  JPMugaas
{ Removed IdFTPServer so Indy can compile with Kudzu's new changes.
}
{
{   Rev 1.7    9/16/2003 11:59:16 PM  JPMugaas
{ Should compile.
}
{
    Rev 1.6    1/20/2003 1:15:38 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes
}
{
{   Rev 1.5    1/17/2003 07:10:54 PM  JPMugaas
{ Now compiles under new framework.
}
{
{   Rev 1.4    1/9/2003 06:09:36 AM  JPMugaas
{ Updated for IdContext API change.
}
{
{   Rev 1.3    1/8/2003 05:53:50 PM  JPMugaas
{ Switched stuff to IdContext.
}
{
{   Rev 1.2    12-8-2002 18:08:56  BGooijen
{ Changed to use TIdIOHandlerStack for the .IPVersion
}
{
{   Rev 1.1    12/7/2002 06:43:26 PM  JPMugaas
{ These should now compile except for Socks server.  IPVersion has to be a
{ property someplace for that.
}
{
{   Rev 1.0    11/13/2002 08:01:18 AM  JPMugaas
}
{*****************************************************************************}
{*                              IdSocksServer.pas                            *}
{*****************************************************************************}

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen (bas_gooijen@yahoo.com)                          *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*  Indy SOCKS 4/5 Server                                                    *}
{*                                                                           *}
{* QUICK NOTES:                                                              *}
{*   Socks5 GSSAPI-authentication is NOT supported.                          *}
{*   UDP ASSOCIATE is NOT supported                                          *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 19/05/2002    1.0   Bas Gooijen  Initial start                            *}
{* 24/05/2002    1.0   Bas Gooijen  Added socks 5 authentication             *}
{* 08/06/2002    1.0   Bas Gooijen  Revised code                             *}
{* 08/09/2002    1.0   Bas Gooijen  Added Socks 5 IPv6 Support               *}
{*****************************************************************************}

unit IdSocksServer;

interface

uses
  Classes,
  IdAssignedNumbers, IdYarn, IdContext,
  IdException,
  IdGlobal,
  IdTCPConnection,
  IdCustomTCPServer;

const
  IdSocksAuthNoAuthenticationRequired = 0;
  IdSocksAuthGSSApi = 1;
  IdSocksAuthUsernamePassword = 2;
  IdSocksAuthNoAcceptableMethods = $FF;

  IdSocksLoginSuccess = 0;
  IdSocksLoginFailure = 1; // any value except 0

type
  EIdSocksSvrException = class(EIdException);
  EIdSocksSvrNotSupported = class(EIdSocksSvrException);
  EIdSocksSvrInvalidLogin = class(EIdSocksSvrException);
  EIdSocksSvrSocks5WrongATYP = class(EIdSocksSvrException);
  EIdSocksSvrWrongSocksVer = class(EIdSocksSvrException);
  EIdSocksSvrWrongSocksCmd = class(EIdSocksSvrException);
  EIdSocksSvrAccessDenied = class(EIdSocksSvrException);
  EIdSocksSvrUnexpectedClose = class(EIdSocksSvrException);

  TIdSocksServerContext = class( TIdContext )
  protected
    // what needs to be stored...
    fUser: string;
    fPassword: string;
    FSocksVersion: byte; // either 4 or 5, or 0 when version not known yet
  public
    constructor Create(
      AConnection: TIdTCPConnection;
      AYarn: TIdYarn;
      AList: TThreadList = nil
      ); override;
    destructor Destroy; override;
    property Username: string read fUser write fUser;
    property Password: string read fPassword write fPassword;
    property SocksVersion: byte read FSocksVersion write FSocksVersion;
  end;

  TIdOnAuthenticate = procedure( AThread: TIdSocksServerContext; const AUsername, APassword: string; var AAuthenticated: boolean ) of object;
  TIdOnBeforeConnect = procedure( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) of object;
  TIdOnBeforeBind = procedure( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) of object;

  TIdCustomSocksServer = class( TIdCustomTCPServer )
  private
  protected
    fSocks5NeedsAuthentication: boolean;
    fAllowSocks4: boolean;
    fAllowSocks5: boolean;
    fOnAuthenticate: TIdOnAuthenticate;
    fOnBeforeConnect: TIdOnBeforeConnect;
    fOnBeforeBind: TIdOnBeforeBind;

    function DoExecute( AThread: TIdContext ) : boolean; override;

    procedure CommandConnect( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; virtual; abstract; //
    procedure CommandBind( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; virtual; abstract; //

    procedure DoAuthenticate( AThread: TIdSocksServerContext; const AUsername, APassword: string; var AAuthenticated: boolean ) ; virtual;
    procedure DoBeforeConnectUser( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) ; virtual;
    procedure DoBeforeBind( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) ; virtual;
    procedure HandleConnectV4( AThread: TIdSocksServerContext; var ACommand: byte; var AUserId, AHost: string; var Aport: integer ) ; virtual;
    procedure HandleConnectV5( AThread: TIdSocksServerContext; var ACommand: byte; var AUserId, AHost: string; var Aport: integer ) ; virtual;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
  published
    property DefaultPort default IdPORT_SOCKS;
    property Socks5NeedsAuthentication: boolean read fSocks5NeedsAuthentication write fSocks5NeedsAuthentication;
    property AllowSocks4: boolean read fAllowSocks4 write fAllowSocks4;
    property AllowSocks5: boolean read fAllowSocks5 write fAllowSocks5;

    property OnAuthenticate: TIdOnAuthenticate read fOnAuthenticate write fOnAuthenticate;
    property OnBeforeConnect: TIdOnBeforeConnect read fOnBeforeConnect write fOnBeforeConnect;
    property OnBeforeBind: TIdOnBeforeBind read fOnBeforeBind write fOnBeforeBind;
  end;

  TIdSocksServer = class( TIdCustomSocksServer )
  protected
    procedure CommandConnect( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; override; //
    procedure CommandBind( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; override; //
  public
  published
  end;

  TIdOnCommandConnect = procedure( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) of object;
  TIdOnCommandBind = procedure( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) of object;

  TIdEventSocksServer = class( TIdCustomSocksServer )
  private
  protected
    fOnCommandConnect: TIdOnCommandConnect;
    fOnCommandBind: TIdOnCommandBind;
    procedure CommandConnect( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; override; //
    procedure CommandBind( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ; override; //
  public
  published
    property OnCommandConnect: TIdOnCommandConnect read fOnCommandConnect write fOnCommandConnect;
    property OnCommandBind: TIdOnCommandBind read fOnCommandBind write fOnCommandBind;
  end;

implementation

uses
  IdResourceStringsProtocols,
  IdTcpClient,
  IdSimpleServer,
  IdIOHandlerStack,
  IdStack,
  IdGlobalProtocols,
  SysUtils;

function ReadBufferEx( AFrom: TIdTCPConnection; var ABuffer; const AMaxSize: Integer; const ATimeOut: integer = 25 ) : integer;
begin
  if ( AMaxSize > 0 ) and ( @ABuffer <> nil ) then begin

todo;
//    if AFrom.IOHandler.Buffer.Size { from.CurrentReadBufferSize} < AMaxSize then
//    begin
      AFrom.IOHandler.CheckForDataOnSource(ATimeOut ) ;
//    end;

todo;
//    if AFrom.IOHandler.Buffer.Size { from.CurrentReadBufferSize} > AMaxSize then
//    begin
//      result := AMaxSize;
//    end
//    else
//    begin
//      result := AFrom.IOHandler.Buffer.Size {from.CurrentReadBufferSize};
//    end;
//    AFrom.IOHandler.ReadBuffer( ABuffer, result ) ;
//  end
//  else
//  begin
   // result := 0;
  end;
Result := 0;
end;

function GetBufferSize( AFrom: TIdTCPConnection; const ATimeOut: integer = 25 ) : integer;
begin
  AFrom.IOHandler.CheckForDataOnSource(ATimeOut ) ;
todo;
//  result := AFrom.IOHandler.Buffer.Size {from.CurrentReadBufferSize};
Result := 0;
end;

procedure TransferData( const FromConn, ToConn: TIdTCPConnection ) ;
var
  buff: array[0..4095] of char;
  amount: integer;
begin
  while FromConn.Connected and ToConn.Connected do
  begin
    amount := ReadBufferEx( FromConn, buff, sizeof( buff ) ) ;
    if amount > 0 then
    begin
todo;
//      ToConn.IOHandler.WriteBuffer( buff, amount ) ;
    end;
    amount := ReadBufferEx( ToConn, buff, sizeof( buff ) ) ;
    if amount > 0 then
    begin
todo;
//      FromConn.IOHandler.WriteBuffer( buff, amount ) ;
    end;
  end;
end;

procedure TIdCustomSocksServer.DoAuthenticate( AThread: TIdSocksServerContext; const AUsername, APassword: string; var AAuthenticated: boolean ) ;
begin
  if assigned( OnAuthenticate ) then
  begin
    OnAuthenticate( AThread, AUsername, APassword, AAuthenticated ) ;
  end;
end;

procedure TIdCustomSocksServer.DoBeforeConnectUser( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) ;
begin
  if assigned( OnBeforeConnect ) then
  begin
    OnBeforeConnect( AThread, AUserId, AHost, APort, AAllowed ) ;
  end;
end;

procedure TIdCustomSocksServer.DoBeforeBind( AThread: TIdSocksServerContext; const AUserId: string; var AHost: string; var APort: integer; var AAllowed: boolean ) ;
begin
  if assigned( OnBeforeBind ) then
  begin
    OnBeforeBind( AThread, AUserId, AHost, APort, AAllowed ) ;
  end;
end;

procedure SendV5Response( AThread: TIdSocksServerContext; const AResponse: byte ) ;
begin
  AThread.Connection.IOHandler.Write( #5 + chr( AResponse ) ) ;
end;

procedure TIdCustomSocksServer.HandleConnectV5( AThread: TIdSocksServerContext; var ACommand: byte; var AUserId, AHost: string; var Aport: integer ) ;
var
  LLine: string;

  LTyp: byte;
  LSupportsAuth: boolean;

  Lusername, Lpassword: string;
  LValidLogin: boolean;

  a: integer;
begin
  LSupportsAuth := false;
  for a := 1 to byte( AThread.Connection.IOHandler.ReadChar ) do
  begin
    if byte( AThread.Connection.IOHandler.ReadChar ) = IdSocksAuthUsernamePassword then
    begin
      LSupportsAuth := true;
    end;
  end;
  if not Socks5NeedsAuthentication then
  begin
    SendV5Response( AThread, IdSocksAuthNoAuthenticationRequired )
  end
  else
  begin
    if not LSupportsAuth then
    begin
      SendV5Response( AThread, IdSocksAuthNoAcceptableMethods ) ;
      AThread.Connection.disconnect; // not sure the server has to disconnect
      raise EIdSocksSvrNotSupported.create(RSSocksSvrNotSupported);
//      exit; //exception
    end
    else
    begin
      SendV5Response( AThread, IdSocksAuthUsernamePassword ) ;
      AThread.Connection.IOHandler.ReadChar; //subversion, we don't need it.
      LUsername := AThread.Connection.IOHandler.ReadString( byte( AThread.Connection.IOHandler.readchar ) ) ;
      LPassword := AThread.Connection.IOHandler.ReadString( byte( AThread.Connection.IOHandler.readchar ) ) ;
      LValidLogin := false;
      DoAuthenticate( TIdSocksServerContext( AThread ) , LUsername, LPassword, LValidLogin ) ;
      if LValidLogin then
      begin
        AThread.Connection.IOHandler.Write(#1+chr(IdSocksLoginSuccess) );
      end
      else
      begin
        AThread.Connection.IOHandler.Write(#1+chr(IdSocksLoginFailure )) ;
        AThread.Connection.disconnect;
        raise EIdSocksSvrNotSupported.create(RSSocksSvrInvalidLogin);
        //exit; //exception
      end;
    end;
  end;
  AThread.Connection.IOHandler.ReadChar; // socks version, should be 5

  Acommand := byte( AThread.Connection.IOHandler.ReadChar ) ;

  AThread.Connection.IOHandler.ReadChar; //reserved, should be 0

  LTyp := byte( AThread.Connection.IOHandler.ReadChar ) ;

  case LTyp of
    1:
      begin
        Lline := AThread.Connection.IOHandler.ReadString( 6 ) ;
        Ahost := inttostr( ord( Lline[1] ) ) + '.' + inttostr( ord( Lline[2] ) ) + '.' + inttostr( ord( Lline[3] ) ) + '.' + inttostr( ord( Lline[4] ) ) ;
        Aport := ord( Lline[5] ) * 256 + ord( Lline[6] ) ;
      end;
    3:
      begin
        Ahost := AThread.Connection.IOHandler.ReadString( byte( AThread.Connection.IOHandler.readchar ) ) ;
        Lline := AThread.Connection.IOHandler.ReadString( 2 ) ;
        Aport := ord( Lline[1] ) * 256 + ord( Lline[2] ) ;
      end;
    4:  // ip v6
      begin
        AThread.Connection.IOHandler.Readchar;// should be 18 (16 for host, and 2 for port)
        Lline := AThread.Connection.IOHandler.ReadString( 18 ) ;
todo;
//        Ahost:=GStack.TInAddrToString(lline[1],id_ipv6);
        Aport := ord( Lline[17] ) * 256 + ord( Lline[18] ) ;
      end;
  else
    raise EIdSocksSvrSocks5WrongATYP.Create( RSSocksSvrWrongATYP ) ;
  end;
end;

procedure TIdCustomSocksServer.HandleConnectV4( AThread: TIdSocksServerContext; var ACommand: byte; var AUserId, AHost: string; var Aport: integer ) ;
var
  Lline: string;
begin
  Acommand := byte( AThread.Connection.IOHandler.ReadChar ) ;
  Lline := AThread.Connection.IOHandler.ReadString( 2 ) ;
  Aport := ord( Lline[1] ) * 256 + ord( Lline[2] ) ;
  Lline := AThread.Connection.IOHandler.ReadString( 5 ) ;
  Ahost := inttostr( ord( Lline[1] ) ) + '.' + inttostr( ord( Lline[2] ) ) + '.' + inttostr( ord( Lline[3] ) ) + '.' + inttostr( ord( Lline[4] ) ) ;
end;

function TIdCustomSocksServer.DoExecute( AThread: TIdContext ) : boolean;
var
  LVersion: byte;
  LCommand: byte;
  LUserId: string;
  LHost: string;
  Lport: integer;
  LSocksServerThread: TIdSocksServerContext absolute AThread;
begin
  //just to keep the compiler happy
  Result := True;

  LVersion := byte( AThread.Connection.IOHandler.ReadChar ) ;
  TIdSocksServerContext( AThread ) .SocksVersion := LVersion;

  if not ( ( ( LVersion = 4 ) and AllowSocks4 ) or ( ( LVersion = 5 ) and AllowSocks5 ) ) then
    raise EIdSocksSvrWrongSocksVer.Create( RSSocksSvrWrongSocksVersion ) ;

  case LVersion of
    4: HandleConnectV4( TIdSocksServerContext( AThread ) , LCommand, LUserId, LHost, Lport ) ;
    5: HandleConnectV5( TIdSocksServerContext( AThread ) , LCommand, LUserId, LHost, Lport ) ;
  end;

  case LCommand of
    1: CommandConnect( TIdSocksServerContext( AThread ) , LUserId, LHost, LPort ) ;
    2: CommandBind( TIdSocksServerContext( AThread ) , LUserId, LHost, LPort ) ;
    //3: //udp bind
  else
    raise EIdSocksSvrWrongSocksCmd.Create( RSSocksSvrWrongSocksCommand ) ;
  end;
end;

procedure TIdSocksServer.CommandConnect( AThread: TIdSocksServerContext; AUserId, AHost: string; APort: integer ) ;
var
  LIdtcpclient: tidtcpclient;
  LAlowed: boolean;
begin
  LAlowed := true;
  DoBeforeConnectUser( AThread, AUserId, AHost, Aport, LAlowed ) ;
  if not LAlowed then
  begin
    if AThread.SocksVersion = 4 then
    begin
      AThread.Connection.IOHandler.write( #0#2#0#1 + #0#0#0#0#0#0 )
    end
    else
    begin
      AThread.Connection.IOHandler.write( chr( AThread.SocksVersion ) + #2#0#1 + #0#0#0#0#0#0 ) ;
    end;
    raise EIdSocksSvrAccessDenied.Create( RSSocksSvrAccessDenied ) ;
  end;

  LIdtcpclient := nil;
  try

    LIdtcpclient := tidtcpclient.create( nil ) ;
    LIdtcpclient.IOHandler:=TIdIOHandlerStack.Create(nil);
    LIdtcpclient.port := Aport;
    LIdtcpclient.host := Ahost;
    try
      if Length(MakeCanonicalIPv6Address(Ahost))>0 then
      begin
todo;
//        (LIdtcpclient.IOHandler as TIdIOHandlerStack).IPVersion:=Id_IPv6;
      end;
      LIdtcpclient.Connect;
      if AThread.SocksVersion = 4 then
      begin
        AThread.Connection.IOHandler.write( #4#90 + #0#0#0#0#0#0 )
      end
      else
      begin
        AThread.Connection.IOHandler.write( chr( AThread.SocksVersion ) + #0#0#1 + #0#0#0#0#0#0 )
      end;
    except
      if AThread.SocksVersion = 4 then
      begin
        AThread.Connection.IOHandler.write( #4#91#0#1 + #0#0#0#0#0#0 )
      end
      else
      begin
        AThread.Connection.IOHandler.write( chr( AThread.SocksVersion ) + #4#0#1 + #0#0#0#0#0#0 ) ;
        raise;
      end;
    end;
    TransferData( AThread.Connection, LIdtcpclient ) ;
    LIdtcpclient.Disconnect;
    AThread.Connection.Disconnect;
  finally
    if assigned(LIdtcpclient.IOHandler) then begin
    	LIdtcpclient.IOHandler.free;
    	LIdtcpclient.IOHandler:=nil;
    end;
    LIdtcpclient.free;
  end;
end;

function ipStrToStr( ip: string ) : string;
var
  a: integer;
begin
  setlength( result, 4 ) ;

  a := pos( '.', ip ) ;
  result[1] := chr( strtoint( copy( ip, 1, a - 1 ) ) ) ;
  ip := copy( ip, a + 1, maxint ) ;

  a := pos( '.', ip ) ;
  result[2] := chr( strtoint( copy( ip, 1, a - 1 ) ) ) ;
  ip := copy( ip, a + 1, maxint ) ;

  a := pos( '.', ip ) ;
  result[3] := chr( strtoint( copy( ip, 1, a - 1 ) ) ) ;
  ip := copy( ip, a + 1, maxint ) ;

  result[4] := chr( strtoint( ip ) ) ;
end;

function PortToStr( const port: word ) : string;
begin
  result := chr( Port div 256 ) + chr( Port mod 256 )
end;

procedure TIdSocksServer.CommandBind( AThread: TIdSocksServerContext; AUserId, AHost: string; APort: integer ) ;
var
  LIdSimpleServer: TIdSimpleServer;
  LAlowed: boolean;
begin
  LAlowed := true;
  DoBeforeBind( AThread, AUserId, AHost, Aport, LAlowed ) ;
  if not LAlowed then
  begin
    if AThread.SocksVersion = 4 then
    begin
      AThread.Connection.IOHandler.write( #0#2#0#1 + #0#0#0#0#0#0 )
    end
    else
    begin
      AThread.Connection.IOHandler.write( #5#2#0#1 + #0#0#0#0#0#0 ) ;
    end;
    raise EIdSocksSvrAccessDenied.Create( RSSocksSvrAccessDenied ) ;
  end;

  LIdSimpleServer := nil;
  try
    LIdSimpleServer := TIdSimpleServer.create( nil ) ;

    LIdSimpleServer.BeginListen;

    if AThread.SocksVersion = 4 then
    begin
      AThread.Connection.IOHandler.write( #0 + #90 + PortToStr( LIdSimpleServer.Binding.Port ) + ipstrtostr( LIdSimpleServer.Binding.IP ) )
    end
    else
    begin
      AThread.Connection.IOHandler.write( chr( AThread.SocksVersion ) + #0#0#1 + ipstrtostr( LIdSimpleServer.Binding.IP ) + chr( LIdSimpleServer.Binding.Port div 256 ) + chr( LIdSimpleServer.Binding.Port mod 256 ) ) ;
    end;

    //  while AThread.Connection.Connected do
    //    LIdSimpleServer.Listen(30000); // wait 30 secs
    LIdSimpleServer.Listen;

//    assert( LIdSimpleServer.binding.PeerIP = AHost ) ;

    if not AThread.Connection.Connected then
    begin
      raise EIdSocksSvrUnexpectedClose.create( RSSocksSvrUnexpectedClose ) ;
    end;
    TransferData( AThread.Connection, LIdSimpleServer ) ;

    LIdSimpleServer.Disconnect;
    AThread.Connection.Disconnect;
  finally
    LIdSimpleServer.free;
  end;
end;

procedure TIdEventSocksServer.CommandConnect( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ;
begin
  if assigned( foncommandconnect ) then
  begin
    foncommandconnect( AThread, AUserId, AHost, Aport ) ;
  end;
end;

procedure TIdEventSocksServer.CommandBind( AThread: TIdSocksServerContext; AUserId, AHost: string; Aport: integer ) ;
begin
  if assigned( foncommandbind ) then
  begin
    foncommandbind( AThread, AUserId, AHost, Aport ) ;
  end;
end;

{ Constructor / Destructors }

procedure TIdCustomSocksServer.InitComponent;
begin
  inherited;
  FContextClass := TIdSocksServerContext;
  DefaultPort := IdPORT_SOCKS;
  AllowSocks4 := true;
  AllowSocks5 := true;
  Socks5NeedsAuthentication := false;
end;

destructor TIdCustomSocksServer.Destroy;
begin
  inherited;
end;

{ TIdSocksServerContext }

constructor TIdSocksServerContext.Create;
begin
  inherited;
  FUser := '';
  FPassword := '';
  FSocksVersion := 0;
end;

destructor TIdSocksServerContext.Destroy;
begin
  inherited;
end;

end.

