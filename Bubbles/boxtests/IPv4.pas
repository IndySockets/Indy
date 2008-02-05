{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14144: IPv4.pas 
{
{   Rev 1.0    12-7-2002 12:42:52  BGooijen
{ Tests to check if IPv4 and IPv6 works.
{ This is done by connection a TCPClient to a TCPServer.
{ NOTE: the IPv6 test fails when there is no IPv6 support in the OS.
}
unit IPv4;

interface

uses
  IndyBox;

type
  TIPv4Box = class(TIndyBox)
  public
    procedure Test; override;
  end;



implementation

uses
  IdTCPServer, IdTCPClient, IdException, IdServerIOHandlerStack, IdIOHandlerStack, IdCoreGlobal,
  SysUtils;

{ TCommandHandlerProc }

procedure TIPv4Box.Test;
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

  try
    LServer:= TIdTCPServer.Create(nil);
    LServerIO:= TIdServerIOHandlerStack.Create(nil);
    LServer.IOHandler:= LServerIO;
    with LServer.Bindings.Add do begin
      IP:='0.0.0.0';
      Port:=12987;
      IPVersion:=Id_IPv4;
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
    LClientIO.Host:='127.0.0.1';
    LClientIO.Port:=12987;
    LClientIO.IPVersion:=Id_IPv4;
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

initialization
  TIndyBox.RegisterBox(TIPv4Box, 'IPv4 Support', 'Misc');
end.
