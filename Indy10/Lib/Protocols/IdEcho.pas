{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13814: IdEcho.pas 
{
{   Rev 1.8    2004.02.03 5:45:06 PM  czhower
{ Name changes
}
{
{   Rev 1.7    1/21/2004 3:27:46 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.6    1/3/2004 12:59:52 PM  JPMugaas
{ These should now compile with Kudzu's change in IdCoreGlobal.
}
{
{   Rev 1.5    2003.11.29 10:18:52 AM  czhower
{ Updated for core change to InputBuffer.
}
{
{   Rev 1.4    3/6/2003 5:08:48 PM  SGrobety
{ Updated the read buffer methodes to fit the new core (InputBuffer ->
{ InputBufferAsString + call to CheckForDataOnSource)
}
{
{   Rev 1.3    2/24/2003 08:41:28 PM  JPMugaas
{ Should compile with new code.
}
{
{   Rev 1.2    12/8/2002 07:26:34 PM  JPMugaas
{ Added published host and port properties.
}
{
{   Rev 1.1    12/6/2002 05:29:32 PM  JPMugaas
{ Now decend from TIdTCPClientCustom instead of TIdTCPClient.
}
{
{   Rev 1.0    11/14/2002 02:19:24 PM  JPMugaas
}
unit IdEcho;
{*******************************************************}
{                                                       }
{       Indy Echo Client TIdEcho                        }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2000-April-24                                   }
{                                                       }
{*******************************************************}

interface

uses
  IdAssignedNumbers,
  IdTCPClient;

type
  TIdEcho = class(TIdTCPClientCustom)
  protected
    FEchoTime: Cardinal;
    procedure InitComponent; override;
  public
    {This sends Text to the peer and returns the reply from the peer}
    Function Echo(AText: String): String;
    {Time taken to send and receive data}
    Property EchoTime: Cardinal read FEchoTime;
  published
    property Port default IdPORT_ECHO;
    property Host;
  end;

implementation

uses
  IdComponent,
  IdGlobal,
  IdTCPConnection,
   IdIOHandler;

{ TIdEcho }

procedure TIdEcho.InitComponent;
begin
  inherited InitComponent;
  Port := IdPORT_ECHO;
end;

function TIdEcho.Echo(AText: String): String;
var
  StartTime: Cardinal;
begin
  {Send time monitoring}
  BeginWork(wmWrite, Length(AText)+2);
  try
    StartTime := IdGlobal.Ticks;
    IOHandler.Write(AText);
  finally
    EndWork(wmWrite);
  end;
  {Receive time monitoring}
  BeginWork(wmRead);
  try
    IOHandler.CheckForDataOnSource;
    Result := IOHandler.InputBufferAsString;
    //CurrentReadBuffer;
    {This is just in case the TickCount rolled back to zero}
    FEchoTime :=  GetTickDiff(StartTime,Ticks);

  finally
    EndWork(wmRead);
  end;
end;

end.
