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
  Rev 1.7    2004.02.03 5:44:16 PM  czhower
  Name changes

  Rev 1.6    2004.01.22 6:09:04 PM  czhower
  IdCriticalSection

  Rev 1.5    1/21/2004 3:27:18 PM  JPMugaas
  InitComponent

  Rev 1.4    4/4/2003 8:03:40 PM  BGooijen
  fixed

  Rev 1.3    2/24/2003 09:32:56 PM  JPMugaas

  Rev 1.2    1/31/2003 02:32:04 PM  JPMugaas
  Should now compile.

  Rev 1.1    12/6/2002 05:30:32 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 07:59:26 AM  JPMugaas

  -2001.02.15 - J. Peter Mugaas
  Started this unit with code originally in TIdRexec
}

unit IdRemoteCMDClient;

{
  Indy Rexec Client TIdRexec
  Copyright (C) 2001 Indy Pit Crew
  Author J. Peter Mugaas
  Based partly on code authored by Laurence LIew
  2001-February-15
}              

interface
{$i IdCompilerDefines.inc}

uses
  IdException,  IdTCPClient;

const
  IDRemoteUseStdErr = True;
  {for IdRSH, we set this to.  IdRexec will override this}
  IDRemoteFixPort = True;

type
  EIdCanNotBindRang = class(EIdException);

  TIdRemoteCMDClient = class(TIdTCPClientCustom)
  protected
    FUseReservedPorts: Boolean;
    FUseStdError : Boolean;
    FErrorMessage : String;
    FErrorReply : Boolean;
    //
    function InternalExec(AParam1, AParam2, ACommand : String) : String; virtual;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    Function Execute(ACommand: String): String; virtual;
    property ErrorReply : Boolean read FErrorReply;
    property ErrorMessage : String read FErrorMessage;
  published
    property UseStdError : Boolean read FUseStdError write FUseStdError default IDRemoteUseStdErr;
  end;

implementation

uses
  IdComponent, IdGlobal, IdIOHandlerStack, IdIOHandlerSocket,IdSimpleServer, IdTCPConnection, IdThread, SysUtils;

type
  TIdStdErrThread = class(TIdThread)
   protected
     FStdErr : TIdSimpleServer;
     FOutput : String;
   public
     Constructor Create(AStdErr : TIdSimpleServer; ALock : TIdCriticalSection); reintroduce;
     Procedure Run; override;
     property Output : String read FOutput;
   end;

{ TIdRemoteCMDClient }

procedure TIdRemoteCMDClient.InitComponent;
begin
  inherited;
  FUseReservedPorts := IDRemoteFixPort;
  FUseStdError := IDRemoteUseStdErr;
end;

destructor TIdRemoteCMDClient.Destroy;
begin
  inherited;
end;

function TIdRemoteCMDClient.Execute(ACommand: String): String;
begin
  Result := '';    {Do not Localize}
end;

function TIdRemoteCMDClient.InternalExec(AParam1, AParam2, ACommand: String) : String;
var
  stdErr : TIdSimpleServer;
  thr : TIdStdErrThread;

  procedure SendAuthentication(APort : TIdPort);
  begin
    // Send authentication and commands
    IOHandler.Write(IntToStr(APort)+#0);  //stdErr Port Number - none for this session
    IOHandler.Write(AParam1 + #0);
    IOHandler.Write(AParam2 + #0);
    IOHandler.Write(ACommand + #0);
  end;

begin
  Result := '';    {Do not Localize}
  if FUseReservedPorts then begin
    BoundPortMin := 512;
    BoundPortMax := 1023;
  end else begin
    BoundPortMin := 0;
    BoundPortMax := 0;
  end;
  if Socket = nil then begin
    IOHandler := TIdIOHandlerStack.Create(Self);
  end;
  {For RSH, we have to set the port the client to connect.  I don't
   think it is required to this in Rexec.}
  Connect;
  try
    if FUseStdError then begin
      StdErr := TIdSimpleServer.Create(nil);
      try
        StdErr.BoundIP := Socket.Binding.IP;
        StdErr.BoundPortMin := BoundPortMin;
        StdErr.BoundPortMax := BoundPortMax;
        StdErr.BeginListen;
        thr := TIdStdErrThread.Create(StdErr, nil{, FLock});
        try
          SendAuthentication(StdErr.Binding.Port);
          Thr.Start;
          try
            FErrorReply := (IOHandler.ReadString(1) <> #0);
            {Receive answers}
            BeginWork(wmRead);
            try
              Result := IOHandler.AllData;
            finally
              EndWork(wmRead);
              FErrorMessage := thr.Output;
            end;
          finally
            StdErr.Abort;
            thr.Terminate;
            thr.WaitFor;
          end;
        finally
          FreeAndNil(thr);
        end;
      finally
        FreeAndNil(StdErr);
      end;
    end else
    begin
      SendAuthentication(0);
      FErrorReply := (IOHandler.ReadString(1) <> #0);
      {Receive answers}
      BeginWork(wmRead);
      try
        if FErrorReply then begin
          FErrorMessage := IOHandler.AllData;
        end else begin
          Result := IOHandler.AllData;
        end;
      finally
        EndWork(wmRead);
      end;
    end;
  finally
    Disconnect;
  end;
end;

{ TIdStdErrThread }

constructor TIdStdErrThread.Create(AStdErr: TIdSimpleServer;
  ALock: TIdCriticalSection);
begin
  inherited Create(True);
  FStdErr := AStdErr;
  StopMode := smTerminate;
  FStdErr.BeginListen;
end;

procedure TIdStdErrThread.Run;
begin
  FStdErr.Listen;
  FOutput := FStdErr.IOHandler.AllData;
end;

end.
