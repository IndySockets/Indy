{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14146: IPv6.pas 
{
{   Rev 1.2    9/8/2003 02:54:54 PM  JPMugaas
{ IPv6Detection test should work.
}
{
    Rev 1.1    4/5/2003 3:39:56 PM  BGooijen
  now checks for IPv6 support first
}
{
{   Rev 1.0    12-7-2002 12:42:54  BGooijen
{ Tests to check if IPv4 and IPv6 works.
{ This is done by connection a TCPClient to a TCPServer.
{ NOTE: the IPv6 test fails when there is no IPv6 support in the OS.
}
unit IPv6;

interface

uses
  IndyBox;

type
  TIdv6Test = class(TIndyBox)
    procedure Test; override;
  end;
  TIPv6Box = class(TIndyBox)
  public
    procedure Test; override;
  end;



implementation

uses
  IdComponent, IdStack,
  IdTCPServer, IdTCPClient, IdException, IdServerIOHandlerStack, IdIOHandlerStack, IdCoreGlobal,IdWship6,
  SysUtils;

function IPv6Supported : Boolean;
var LCreated : Boolean;
begin
  LCreated := False;
  if Assigned(GStack)=False then
  begin
    GStack := TIdStack.CreateStack;
    LCreated := True;

  end;
  Result := GStack.SupportsIP6;
  if LCreated then
  begin
    FreeAndNil(GStack);
  end;
end;
{ TCommandHandlerProc }

procedure TIPv6Box.Test;
var
  LServer: TIdTCPServer;
  LServerIO:TIdServerIOHandlerStack;
  LClient: TIdTCPClient;
  LClientIO:TIdIOHandlerStack;
begin
  LServer:= nil;
  LServerIO:= nil;
  LClient:= nil;
  LClientIO:= nil;
  If IPv6Supported = False then
  begin
    Status('IPv6-support not detected, skipping test');
    exit;
  end;
  //if not IdIPv6Available then begin
  //  Status('IPv6-support not detected, skipping test');
  //  exit;
  //end;

  try
    LServer:= TIdTCPServer.Create(nil);
    LServerIO:= TIdServerIOHandlerStack.Create(nil);
    LServer.IOHandler:= LServerIO;
    with LServer.Bindings.Add do begin
      IP:='::0';
      Port:=12987;
      IPVersion:=Id_IPv6;
    end;

    try
      LServer.Active:=true;
    except on e: EIdException do
      Check(false,  'The TIdTCPServer failed to start: '+e.message);
    end;

    Check(LServer.Active,  'The TIdTCPServer doesn''t seem to be running, but no exception occured?'); // BGO: Just to be sure

    LClient:= TIdTCPClient.Create(nil);
    LClientIO:= TIdIOHandlerStack.Create(nil);
    LClient.IOHandler:=LClientIO;
    LClientIO.Host:='::1';
    LClientIO.Port:=12987;
    LClientIO.IPVersion:=Id_IPv6;
    try
      LClient.Connect;
    except on e: EIdException do
      Check(false,  'The TIdTCPClient failed to connect: '+e.message);
    end;

  finally
    FreeAndNil( LServer );
    FreeAndNil( LServerIO );
    FreeAndNil( LClient );
    FreeAndNil( LClientIO );
  end;

end;

{ TIdv6Test }

procedure TIdv6Test.Test;
begin
  If IPv6Supported then
  begin
   Status('IPv6-support detected');
  end
  else
  begin
    Status('IPv6-support not detected');
  end;
end;

initialization
  TIndyBox.RegisterBox(TIPv6Box, 'IPv6 Support', 'Misc');
  TIndyBox.RegisterBox(TIdv6Test,'IPv6 detection', 'Misc');
end.
