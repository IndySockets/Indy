{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11281: UDPBox.pas 
{
{   Rev 1.0    11/12/2002 09:21:16 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit UDPBox;

interface

uses
  IndyBox,
  Classes,
  IdSocketHandle;

type
  TUDPBox = class(TIndyBox)
  protected
    procedure ServerRead(ASender: TObject; AData: TStream; ABinding: TIdSocketHandle);
  public
    procedure Test; override;
  end;

implementation

uses
  IdUDPServer, IdUDPClient,
  SysUtils;

{ TUDPBox }

procedure TUDPBox.ServerRead(ASender: TObject; AData: TStream; ABinding: TIdSocketHandle);
var
  i: integer;
begin
  AData.ReadBuffer(i, SizeOf(i));
  Assert(i = 1);
  i := i + 1;
  TIdUDPServer(ASender).SendBuffer(ABinding.PeerIP, ABinding.PeerPort, i, SizeOf(i));
end;

procedure TUDPBox.Test;
var
  i: integer;
  LServer: TIdUDPServer;
begin
  LServer := TIdUDPServer.Create(nil); try
    with LServer do begin
      DefaultPort := 6000;
      OnUDPRead := ServerRead;
      ThreadedEvent := True;
      Active := True;
    end;
    with TIdUDPClient.Create(nil) do try
      Host := '127.0.0.1';
      Port := 6000;
      i := 1;
      SendBuffer(i, SizeOf(i));
      ReceiveBuffer(i, SizeOf(i));
      Check(i = 2, 'UDP Data failed.');
    finally Free; end;
  finally FreeAndNil(LServer); end;
end;

initialization
  TIndyBox.RegisterBox(TUDPBox, 'UDP', 'Misc');
end.
