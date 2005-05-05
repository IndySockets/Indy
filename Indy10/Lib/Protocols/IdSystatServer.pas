{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11775: IdSystatServer.pas 
{
{   Rev 1.7    12/2/2004 4:23:58 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.6    10/26/2004 10:49:20 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.5    2004.02.03 5:44:30 PM  czhower
{ Name changes
}
{
{   Rev 1.4    1/21/2004 4:04:04 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.3    2/24/2003 10:29:50 PM  JPMugaas
}
{
{   Rev 1.2    1/17/2003 07:10:58 PM  JPMugaas
{ Now compiles under new framework.
}
{
{   Rev 1.1    1/8/2003 05:53:54 PM  JPMugaas
{ Switched stuff to IdContext.
}
{
{   Rev 1.0    11/13/2002 08:02:28 AM  JPMugaas
}
unit IdSystatServer;
{*******************************************************}
{                                                       }
{       Indy Systat Client TIdSystatServer              }
{                                                       }
{       Copyright (C) 2002 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2002-August-13                                  }
{       Based on RFC 866                                }
{                                                       }
{*******************************************************}
{Note that this protocol is officially called Active User}
{2002-Aug-13  J. Peter Mugaas
  -Original version}
interface
uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer,
  IdTStrings;

type
  TIdSystatEvent = procedure (AThread: TIdContext; AResults : TIdStrings) of object;

Type
  TIdSystatServer = class(TIdCustomTCPServer)
  protected
    FOnSystat : TIdSystatEvent;
    //
    function DoExecute(AThread: TIdContext): boolean; override;

    procedure InitComponent; override;
  published
    property OnSystat : TIdSystatEvent read FOnSystat write FOnSystat;
    property DefaultPort default IdPORT_SYSTAT;
  end;

{
Note that no result parsing is done because RFC 866 does not specify a syntax for
a user list.

Quoted from RFC 866:

   There is no specific syntax for the user list.  It is recommended
   that it be limited to the ASCII printing characters, space, carriage
   return, and line feed.  Each user should be listed on a separate
   line.
}

implementation

uses
  IdGlobal, IdSys;

{ TIdSystatServer }

procedure TIdSystatServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_SYSTAT;
end;

function TIdSystatServer.DoExecute(AThread: TIdContext): boolean;
var s : TIdStrings;
begin
  Result := True;
  if Assigned(FOnSystat) then
  begin
    s := TIdStringList.Create;
    try
      FOnSystat(AThread,s);
      AThread.Connection.IOHandler.Write(s.Text);
    finally
      Sys.FreeAndNil(s);
    end;
    AThread.Connection.Disconnect;
  end;
end;

end.
