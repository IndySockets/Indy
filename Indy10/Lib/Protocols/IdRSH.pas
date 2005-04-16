{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11725: IdRSH.pas 
{
{   Rev 1.3    2004.02.03 5:44:16 PM  czhower
{ Name changes
}
{
{   Rev 1.2    2004.01.22 5:58:54 PM  czhower
{ IdCriticalSection
}
{
{   Rev 1.1    1/21/2004 3:27:22 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 07:59:56 AM  JPMugaas
}
unit IdRSH;

(*******************************************************}
-2001.02.15 - J. Peter Mugaas
              Started this unit
{                                                       }
{       Indy Execute Client TIdRSH                      }
{                                                       }
{       Copyright (C) 2001 Indy Pit Crew                }
{       Original author J. Peter Mugaas                 }
{       2001-February-15                                }
{                                                       }
{*******************************************************)

interface

uses
  Classes,
  IdAssignedNumbers, IdGlobal, IdRemoteCMDClient, IdTCPClient;

type
  TIdRSH = class(TIdRemoteCMDClient)
  protected
    FClientUserName : String;
    FHostUserName : String;
    procedure InitComponent; override;
  public
    Function Execute(ACommand: String): String; override;
  published
    property ClientUserName : String read FClientUserName write FClientUserName;
    property HostUserName : String read FHostUserName write FHostUserName;
    property Port default IdPORT_cmd;
    property UseReservedPorts: Boolean read FUseReservedPorts write FUseReservedPorts
     default IDRemoteFixPort;
  end;

implementation

uses
  IdComponent,
  IdGlobalProtocols,
  IdSimpleServer,
  IdTCPConnection,
  IdThread,
  SysUtils;

{ TIdRSH }

procedure TIdRSH.InitComponent;
begin
  inherited;
  Port := IdPORT_cmd;
  FClientUserName := '';    {Do not Localize}
  FHostUserName := '';    {Do not Localize}
end;

function TIdRSH.Execute(ACommand: String): String;
begin
  Result := InternalExec(FClientUserName,FHostUserName,ACommand);
end;

end.
