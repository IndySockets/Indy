{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11233: CommandHandler.pas 
{
{   Rev 1.4    2003.08.20 2:03:32 PM  czhower
{ Removed dependency on protocol unit
}
{
{   Rev 1.3    2003.07.11 3:56:26 PM  czhower
{ Fixed to match changes in Indy.
}
{
    Rev 1.2    6/5/2003 10:51:04 PM  BGooijen
  Commandhandlers can't be created without a server any more
}
{
    Rev 1.1    4/4/2003 7:43:44 PM  BGooijen
  compile again
}
{
{   Rev 1.0    11/12/2002 09:15:02 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit CommandHandler;

interface

{
2001-Nov-24 Peter Mee
 - Created.
}

uses
  IndyBox;

type
  TCommandHandlerProc = class(TIndyBox)
  public
    procedure Test; override;
  end;



implementation

uses
  IdCmdTCPServer, IdCommandHandlers,
  SysUtils;

{ TCommandHandlerProc }

procedure TCommandHandlerProc.Test;
var
  LServer:TIdCmdTCPServer;
  LCH : TIdCommandHandler;
begin
  // The parse parameters default must be true
  Check(IdParseParamsDefault = true,  'CommandHandler''s IdParseParamsDefault is false');

  LServer := TIdCmdTCPServer.Create(Nil);
  LCH := TIdCommandHandler.Create(LServer.CommandHandlers);
  try
    
  finally
    FreeAndNil(LCH);
    FreeAndNil(LServer);
  end;
end;

initialization
  TIndyBox.RegisterBox(TCommandHandlerProc, 'CommandHandler', 'Misc');
end.
