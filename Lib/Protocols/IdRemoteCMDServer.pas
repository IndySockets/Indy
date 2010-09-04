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
  Rev 1.5    12/2/2004 4:23:58 PM  JPMugaas
  Adjusted for changes in Core.

  Rev 1.4    2004.02.03 5:44:16 PM  czhower
  Name changes

  Rev 1.3    4/4/2003 8:03:40 PM  BGooijen
  fixed

  Rev 1.2    2/24/2003 09:33:00 PM  JPMugaas

  Rev 1.1    1/31/2003 02:32:08 PM  JPMugaas
  Should now compile.

  Rev 1.0    11/13/2002 07:59:32 AM  JPMugaas

  2001, Feb 17
  started this unit with code from TIdRexecServer
}

unit IdRemoteCMDServer;

interface

{$i IdCompilerDefines.inc}

uses
  IdAssignedNumbers, IdContext,IdTCPClient, IdCustomTCPServer;

type
  TIdRemoteCMDServer = class(TIdCustomTCPServer)
  protected
    FForcePortsInRange : Boolean;
    FStdErrorPortsInRange : Boolean;
    function DoExecute(AThread: TIdContext): boolean; override;
    procedure DoCMD(AThread: TIdContext; AStdError : TIdTCPClient;
        AParam1, AParam2, ACommand : String); virtual; abstract;
  public
    procedure SendError(AThread : TIdContext;AStdErr : TIdTCPClient; AMsg : String);
    procedure SendResults(AThread : TIdContext; AStdErr : TIdTCPClient; AMsg : String);
  end;

implementation

uses
  IdSocketHandle, IdException, IdGlobal, IdIOHandlerStack, IdIOHandlerSocket, IdStack, SysUtils;

{ TIdRemoteCMDServer }

function TIdRemoteCMDServer.DoExecute(AThread: TIdContext): boolean;
var
  StdError : TIdTCPClient;
  ErrorPort : TIdPort;
  Param1, Param2, Command : String;

  procedure ExecuteCMD;
  begin
    try
     Result := True;
     StdError := nil;
     ErrorPort := IndyStrToInt(AThread.Connection.IOHandler.ReadLn(#0), 0);

     if ErrorPort <> 0 then
     begin
       StdError := TIdTCPClient.Create(nil);
       if FStdErrorPortsInRange then
       begin
         StdError.BoundPortMin := 512;
         StdError.BoundPortMax := 1023;
       end;
       StdError.BoundIP := AThread.Connection.Socket.Binding.IP;
       StdError.Host := AThread.Connection.Socket.Binding.PeerIP;
       StdError.Port := ErrorPort;

       repeat
         try
           StdError.Connect;
           Break;
         except
           on E: EIdSocketError do begin
             // This will be uncommented after we have the fix into TIdTCPClient.Connect method
             // There is one extra line that has to be added in order to run this code
             //
             // except
             //   // This will free IOHandler
             //   BoundPort := TIdIOHandlerSocket(IOHandler).Binding.Port;    // The extra line
             //   DisconnectSocket;
             //   raise;
             // end;
             //
             // After we have this code we will know the exact Port on wich the exception has occured

             {if E.LastError = 10048 then begin
               StdError.BoundPortMax := StdError.BoundPort - 1;
               StdError.BoundPort := 0;
               StdError.Disconnect;
             end
             else}
               raise;
           end;
         end;
       until False;
     end;

     Param1 := AThread.Connection.IOHandler.ReadLn(#0);
     Param2 := AThread.Connection.IOHandler.ReadLn(#0);
     Command  := AThread.Connection.IOHandler.ReadLn(#0);

     DoCMD(AThread, StdError, Param1, Param2, Command);
     if Assigned(StdError) then
     begin
       StdError.Disconnect;
     end;
    finally
      FreeAndNil(StdError);
    end;
  end;
begin
  if FForcePortsInRange then begin
    if ((AThread.Connection.IOHandler as TIdIOHandlerSocket).Binding.Port >= 512) or
       ((AThread.Connection.IOHandler as TIdIOHandlerSocket).Binding.Port <= 1023) then
    begin
      ExecuteCMD;
    end;
  end
  else begin
    ExecuteCMD;
  end;
  AThread.Connection.Disconnect;
  Result := False;// DoExecute does not have to be called again
end;

procedure TIdRemoteCMDServer.SendError(AThread: TIdContext;
  AStdErr: TIdTCPClient; AMsg: String);
begin
  AThread.Connection.IOHandler.Write(#1);
  if Assigned(AStdErr) then begin
    AStdErr.IOHandler.Write(AMsg);
  end else begin
    AThread.Connection.IOHandler.Write(AMsg);
  end;
end;

procedure TIdRemoteCMDServer.SendResults(AThread: TIdContext;
  AStdErr: TIdTCPClient; AMsg: String);
begin
  AThread.Connection.IOHandler.Write(#0 + AMsg)
end;

end.
