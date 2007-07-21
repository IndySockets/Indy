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
  Rev 1.38    11/10/2004 8:25:54 AM  JPMugaas
  Fix for AV caused by short-circut boolean evaluation.

  Rev 1.37    27.08.2004 21:58:20  Andreas Hausladen
  Speed optimization ("const" for string parameters)

  Rev 1.36    8/2/04 5:44:40 PM  RLebeau
  Moved ConnectTimeout over from TIdIOHandlerStack

  Rev 1.35    7/21/2004 12:22:32 PM  BGooijen
  Fix to .connected

  Rev 1.34    6/30/2004 12:31:34 PM  BGooijen
  Added OnSocketAllocated

  Rev 1.33    4/24/04 12:52:52 PM  RLebeau
  Added setter method to UseNagle property

  Rev 1.32    2004.04.18 12:52:02 AM  czhower
  Big bug fix with server disconnect and several other bug fixed that I found
  along the way.

  Rev 1.31    2004.02.03 4:16:46 PM  czhower
  For unit name changes.

  Rev 1.30    2/2/2004 11:46:46 AM  BGooijen
  Dotnet and TransparentProxy

  Rev 1.29    2/1/2004 9:44:00 PM  JPMugaas
  Start on reenabling Transparant proxy.

  Rev 1.28    2004.01.20 10:03:28 PM  czhower
  InitComponent

  Rev 1.27    1/2/2004 12:02:16 AM  BGooijen
  added OnBeforeBind/OnAfterBind

  Rev 1.26    12/31/2003 9:51:56 PM  BGooijen
  Added IPv6 support

  Rev 1.25    11/4/2003 10:37:40 PM  BGooijen
  JP's patch to fix the bound port

  Rev 1.24    10/19/2003 5:21:26 PM  BGooijen
  SetSocketOption

  Rev 1.23    10/18/2003 1:44:06 PM  BGooijen
  Added include

  Rev 1.22    2003.10.14 1:26:54 PM  czhower
  Uupdates + Intercept support

  Rev 1.21    10/9/2003 8:09:06 PM  SPerry
  bug fixes

  Rev 1.20    8/10/2003 2:05:50 PM  SGrobety
  Dotnet

  Rev 1.19    2003.10.07 10:18:26 PM  czhower
  Uncommneted todo code that is now non dotnet.

  Rev 1.18    2003.10.02 8:23:42 PM  czhower
  DotNet Excludes

  Rev 1.17    2003.10.01 9:11:18 PM  czhower
  .Net

  Rev 1.16    2003.10.01 5:05:12 PM  czhower
  .Net

  Rev 1.15    2003.10.01 2:46:38 PM  czhower
  .Net

  Rev 1.14    2003.10.01 11:16:32 AM  czhower
  .Net

  Rev 1.13    2003.09.30 1:22:58 PM  czhower
  Stack split for DotNet

  Rev 1.12    7/4/2003 08:26:44 AM  JPMugaas
  Optimizations.

  Rev 1.11    7/1/2003 03:39:44 PM  JPMugaas
  Started numeric IP function API calls for more efficiency.

  Rev 1.10    2003.06.30 5:41:56 PM  czhower
  -Fixed AV that occurred sometimes when sockets were closed with chains
  -Consolidated code that was marked by a todo for merging as it no longer
  needed to be separate
  -Removed some older code that was no longer necessary

  Passes bubble tests.

  Rev 1.9    6/3/2003 11:45:58 PM  BGooijen
  Added .Connected

  Rev 1.8    2003.04.22 7:45:34 PM  czhower

  Rev 1.7    4/2/2003 3:24:56 PM  BGooijen
  Moved transparantproxy from ..stack to ..socket

  Rev 1.6    2/28/2003 9:51:56 PM  BGooijen
  removed the field: FReadTimeout: Integer, it hided the one in TIdIOHandler

  Rev 1.5    2/26/2003 1:15:38 PM  BGooijen
  FBinding is now freed in IdIOHandlerSocket, instead of in IdIOHandlerStack

  Rev 1.4    2003.02.25 1:36:08 AM  czhower

  Rev 1.3    2002.12.07 12:26:26 AM  czhower

  Rev 1.2    12-6-2002 20:09:14  BGooijen
  Changed SetDestination to search for the last ':', instead of the first

  Rev 1.1    12-6-2002 18:54:14  BGooijen
  Added IPv6-support

  Rev 1.0    11/13/2002 08:45:08 AM  JPMugaas
}

unit IdIOHandlerSocket;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdCustomTransparentProxy,
  IdBaseComponent,
  IdGlobal,
  IdIOHandler,
  IdSocketHandle;

const
  IdDefTimeout = 0;
  IdBoundPortDefault = 0;

type
  {
  TIdIOHandlerSocket is the base class for socket IOHandlers that implement a
  binding.

  Descendants
    -TIdIOHandlerStack
    -TIdIOHandlerChain
  }
  TIdIOHandlerSocket = class(TIdIOHandler)
  protected
    FBinding: TIdSocketHandle;
    FBoundIP: string;
    FBoundPort: TIdPort;
    FBoundPortMax: TIdPort;
    FBoundPortMin: TIdPort;
    FDefaultPort: TIdPort;
    FOnBeforeBind: TNotifyEvent;
    FOnAfterBind: TNotifyEvent;
    FOnSocketAllocated: TNotifyEvent;
    FTransparentProxy: TIdCustomTransparentProxy;
    FUseNagle: Boolean;
    FReuseSocket: TIdReuseSocket;
    FIPVersion: TIdIPVersion;
    //
    procedure ConnectClient; virtual;
    procedure DoBeforeBind; virtual;
    procedure DoAfterBind; virtual;
    procedure DoSocketAllocated; virtual;
    procedure InitComponent; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDestination: string; override;
    procedure SetDestination(const AValue: string); override;
    function GetTransparentProxy: TIdCustomTransparentProxy; virtual;
    procedure SetTransparentProxy(AProxy: TIdCustomTransparentProxy); virtual;
    procedure SetUseNagle(AValue: Boolean);
    procedure SetNagleOpt(AEnabled: Boolean);
  public
    destructor Destroy; override;
    function BindingAllocated: Boolean;
    procedure Close; override;
    function Connected: Boolean; override;
    procedure Open; override;
    function WriteFile(
      const AFile: String;
      AEnableTransferFile: Boolean = False
      ): Int64;
      override;
    //
    property Binding: TIdSocketHandle read FBinding;
    property BoundPortMax: TIdPort read FBoundPortMax write FBoundPortMax;
    property BoundPortMin: TIdPort read FBoundPortMin write FBoundPortMin;
    // events
    property OnBeforeBind: TNotifyEvent read FOnBeforeBind write FOnBeforeBind;
    property OnAfterBind: TNotifyEvent read FOnAfterBind write FOnAfterBind;
    property OnSocketAllocated: TNotifyEvent read FOnSocketAllocated write FOnSocketAllocated;
  published
    property BoundIP: string read FBoundIP write FBoundIP;
    property BoundPort: TIdPort read FBoundPort write FBoundPort default 0;
    property DefaultPort: TIdPort read FDefaultPort write FDefaultPort;
    property IPVersion: TIdIPVersion read FIPVersion write FIPVersion default ID_DEFAULT_IP_VERSION;
    property ReuseSocket: TIdReuseSocket read FReuseSocket write FReuseSocket default rsOSDependent;
    property TransparentProxy: TIdCustomTransparentProxy
             read GetTransparentProxy write SetTransparentProxy;
    property UseNagle: boolean read FUseNagle write SetUseNagle default True;
  end;

implementation

uses
  SysUtils,
  IdStack,
  IdStackConsts,
  IdSocks;

{ TIdIOHandlerSocket }

procedure TIdIOHandlerSocket.Close;
begin
  if FBinding <> nil then begin
    FBinding.CloseSocket;
  end;
  inherited Close;
end;

procedure TIdIOHandlerSocket.ConnectClient;
begin
  with Binding do begin
    DoBeforeBind;
    // Allocate the socket
    IPVersion := Self.FIPVersion;
    AllocateSocket;
    DoSocketAllocated;
    // Bind the socket
    if BoundIP <> '' then begin
      IP := BoundIP;
    end;
    Port := BoundPort;
    ClientPortMin := BoundPortMin;
    ClientPortMax := BoundPortMax;
    // Turn on Reuse if specified
    if (FReuseSocket = rsTrue) or ((FReuseSocket = rsOSDependent) and (GOSType = otLinux)) then begin
      GStack.SetSocketOption(FBinding.Handle, Id_SOL_SOCKET, Id_SO_REUSEADDR, Id_SO_True);
    end;
    Bind;
    // Turn off Nagle if specified
    SetNagleOpt(UseNagle);
    DoAfterBind;
  end;
end;

function TIdIOHandlerSocket.Connected: Boolean;
begin
  Result := (BindingAllocated and inherited Connected) or not InputBufferIsEmpty;
end;

destructor TIdIOHandlerSocket.Destroy;
begin
  if Assigned(FTransparentProxy) then begin
    if FTransparentProxy.Owner = nil then begin
      FreeAndNil(FTransparentProxy);
    end;
  end;
  FreeAndNil(FBinding);
  inherited Destroy;
end;

procedure TIdIOHandlerSocket.DoBeforeBind;
begin
  if Assigned(FOnBeforeBind) then begin
    FOnBeforeBind(self);
  end;
end;

procedure TIdIOHandlerSocket.DoAfterBind;
begin
  if Assigned(FOnAfterBind) then begin
    FOnAfterBind(self);
  end;
end;

procedure TIdIOHandlerSocket.DoSocketAllocated;
begin
  if Assigned(FOnSocketAllocated) then begin
    FOnSocketAllocated(self);
  end;
end;

function TIdIOHandlerSocket.GetDestination: string;
begin
  Result := Host;
  if (Port <> DefaultPort) and (Port > 0) then begin
    Result := Host + ':' + IntToStr(Port);
  end;
end;

procedure TIdIOHandlerSocket.Open;
begin
  inherited Open;

  if not Assigned(FBinding) then begin
    FBinding := TIdSocketHandle.Create(nil);
  end else begin
    FBinding.Reset(True);
  end;
  FBinding.ClientPortMin := BoundPortMin;
  FBinding.ClientPortMax := BoundPortMax;

  //if the IOHandler is used to accept connections then port+host will be empty
  if (Host <> '') and (Port > 0) then begin
    ConnectClient;
  end;
end;

procedure TIdIOHandlerSocket.SetDestination(const AValue: string);
var LPortStart:integer;
begin
  // Bas Gooijen 06-Dec-2002: Changed to search the last ':', instead of the first:
  LPortStart := LastDelimiter(':', AValue);
  if LPortStart > 0 then begin
    Host := Copy(AValue,1,LPortStart-1);
    Port := IndyStrToInt(Copy(AValue, LPortStart + 1, $FF), DefaultPort);
  end;
end;

function TIdIOHandlerSocket.BindingAllocated: Boolean;
begin
  Result := FBinding <> nil;
  if Result then begin
    Result := FBinding.HandleAllocated;
  end;
end;

function TIdIOHandlerSocket.WriteFile(const AFile: String;
 AEnableTransferFile: Boolean): Int64;
var
  LProcessed: Boolean;
begin
  Result := 0;
  LProcessed := False;
//  if FileExists(AFile) then begin
  //TODO: Reenable this
//    if Assigned(GServeFileProc) and (WriteBufferingActive = False)
//     {and (Intercept = nil)} and AEnableTransferFile
//     then begin
//      Result := GServeFileProc(Binding.Handle, AFile);
//      LProcessed := True;
//    end;
//  end;
  if not LProcessed then begin
    Result := inherited WriteFile(AFile, AEnableTransferFile);
  end;
end;

procedure TIdIOHandlerSocket.SetTransparentProxy(AProxy : TIdCustomTransparentProxy);
var
  LClass: TIdCustomTransparentProxyClass;
begin
  // All this is to preserve the compatibility with old version
  // In the case when we have SocksInfo as object created in runtime without owner form it is treated as temporary object
  // In the case when the ASocks points to an object with owner it is treated as component on form.

  if Assigned(AProxy) then begin
    if not Assigned(AProxy.Owner) then begin
      if Assigned(FTransparentProxy) then begin
        if Assigned(FTransparentProxy.Owner) then begin
          FTransparentProxy := nil;
        end;
      end;
      LClass := TIdCustomTransparentProxyClass(AProxy.ClassType);
      if Assigned(FTransparentProxy) and (FTransparentProxy.ClassType <> LClass) then begin
        FreeAndNil(FTransparentProxy);
      end;
      if not Assigned(FTransparentProxy) then begin
        FTransparentProxy := LClass.Create(nil);
      end;
      FTransparentProxy.Assign(AProxy);
    end else begin
      if Assigned(FTransparentProxy) and not Assigned(FTransparentProxy.Owner) then begin
        FreeAndNil(FTransparentProxy);
      end;
      FTransparentProxy := AProxy;
      FTransparentProxy.FreeNotification(Self);
    end;
  end
  else begin
    if Assigned(FTransparentProxy) and not Assigned(FTransparentProxy.Owner) then begin
      FreeAndNil(FTransparentProxy);
    end else begin
      FTransparentProxy := nil; //remove link
    end;
  end;
end;

function TIdIOHandlerSocket.GetTransparentProxy: TIdCustomTransparentProxy;
begin
  // Necessary at design time for Borland SOAP support
  if FTransparentProxy = nil then begin
    FTransparentProxy := TIdSocksInfo.Create(nil); //default
  end;
  Result := FTransparentProxy;
end;

procedure TIdIOHandlerSocket.SetUseNagle(AValue: Boolean);
begin
  if FUseNagle <> AValue then begin
    FUseNagle := AValue;
    SetNagleOpt(FUseNagle);
  end;
end;

procedure TIdIOHandlerSocket.SetNagleOpt(AEnabled: Boolean);
begin
  if BindingAllocated then begin
    GStack.SetSocketOption(FBinding.Handle, Id_SOCKETOPTIONLEVEL_TCP, Id_TCP_NODELAY, Integer(not AEnabled));
  end;
end;

procedure TIdIOHandlerSocket.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FTransparentProxy) then begin
    FTransparentProxy := nil;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TIdIOHandlerSocket.InitComponent;
begin
  inherited InitComponent;
  FUseNagle := True;
  FIPVersion := ID_DEFAULT_IP_VERSION;
end;

end.
