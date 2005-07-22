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
{   Rev 1.53    3/10/05 3:23:16 PM  RLebeau
{ Updated WriteDirect() to access the Intercept property directly.
}
{
{   Rev 1.52    11/12/2004 11:30:16 AM  JPMugaas
{ Expansions for IPv6.
}
{
{   Rev 1.51    11/11/04 12:03:46 PM  RLebeau
{ Updated DoConnectTimeout() to recognize IdTimeoutDefault
}
{
{   Rev 1.50    6/18/04 1:06:58 PM  RLebeau
{ Bug fix for ReadTimeout property
}
{
{   Rev 1.49    5/4/2004 9:57:34 AM  JPMugaas
{ Removed some old uncommented code and reenabled some TransparentProxy code
{ since it compile in DotNET.
}
{
{   Rev 1.48    2004.04.18 12:52:02 AM  czhower
{ Big bug fix with server disconnect and several other bug fixed that I found
{ along the way.
}
{
{   Rev 1.47    2004.04.08 3:56:34 PM  czhower
{ Fixed bug with Intercept byte count. Also removed Bytes from Buffer.
}
{
{   Rev 1.46    2004.03.12 8:01:00 PM  czhower
{ Exception update
}
{
{   Rev 1.45    2004.03.07 11:48:42 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.44    2004.03.01 5:12:32 PM  czhower
{ -Bug fix for shutdown of servers when connections still existed (AV)
{ -Implicit HELP support in CMDserver
{ -Several command handler bugs
{ -Additional command handler functionality.
}
{
{   Rev 1.43    2/21/04 9:25:50 PM  RLebeau
{ Fix for BBG #66
{ 
{ Added FLastSocketError member to TIdConnectThread
}
{
{   Rev 1.42    2004.02.03 4:16:48 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.41    12/31/2003 9:51:56 PM  BGooijen
{ Added IPv6 support
}
{
{   Rev 1.40    2003.12.28 1:05:58 PM  czhower
{ .Net changes.
}
{
{   Rev 1.39    11/21/2003 12:05:18 AM  BGooijen
{ Terminated isn't public in TThread any more, made it public here now
}
{
{   Rev 1.38    10/28/2003 9:15:44 PM  BGooijen
{ .net
}
{
{   Rev 1.37    10/18/2003 1:42:46 PM  BGooijen
{ Added include
}
{
{   Rev 1.36    2003.10.14 1:26:56 PM  czhower
{ Uupdates + Intercept support
}
{
{   Rev 1.35    2003.10.11 5:48:36 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.34    10/9/2003 8:09:10 PM  SPerry
{ bug fixes
}
{
{   Rev 1.33    10/5/2003 11:02:36 PM  BGooijen
{ Write buffering
}
{
{   Rev 1.32    05/10/2003 23:01:02  HHariri
{ Fix for connect problem when IP address specified as opposed to host
}
{
{   Rev 1.31    2003.10.02 8:23:42 PM  czhower
{ DotNet Excludes
}
{
{   Rev 1.30    2003.10.02 10:16:28 AM  czhower
{ .Net
}
{
{   Rev 1.29    2003.10.01 9:11:18 PM  czhower
{ .Net
}
{
{   Rev 1.28    2003.10.01 5:05:14 PM  czhower
{ .Net
}
{
{   Rev 1.27    2003.10.01 2:46:38 PM  czhower
{ .Net
}
{
{   Rev 1.26    2003.10.01 2:30:38 PM  czhower
{ .Net
}
{
{   Rev 1.22    10/1/2003 12:14:14 AM  BGooijen
{ DotNet: removing CheckForSocketError
}
{
{   Rev 1.21    2003.10.01 1:37:34 AM  czhower
{ .Net
}
{
{   Rev 1.19    2003.09.30 1:22:58 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.18    2003.07.14 1:57:22 PM  czhower
{ -First set of IOCP fixes.
{ -Fixed a threadsafe problem with the stack class.
}
{
{   Rev 1.17    2003.07.14 12:54:32 AM  czhower
{ Fixed graceful close detection if it occurs after connect.
}
{
{   Rev 1.16    2003.07.10 4:34:58 PM  czhower
{ Fixed AV, added some new comments
}
{
{   Rev 1.15    7/4/2003 08:26:46 AM  JPMugaas
{ Optimizations.
}
{
{   Rev 1.14    7/1/2003 03:39:48 PM  JPMugaas
{ Started numeric IP function API calls for more efficiency.
}
{
    Rev 1.13    6/30/2003 10:25:18 AM  BGooijen
  removed unnecessary assignment to FRecvBuffer.Size
}
{
    Rev 1.12    6/29/2003 10:56:28 PM  BGooijen
  Removed .Memory from the buffer, and added some extra methods
}
{
{   Rev 1.11    2003.06.25 4:28:32 PM  czhower
{ Formatting and fixed a short circuit clause.
}
{
    Rev 1.10    6/3/2003 11:43:52 PM  BGooijen
  Elimintated some code
}
{
    Rev 1.9    4/16/2003 3:31:26 PM  BGooijen
  Removed InternalCheckForDisconnect, added .Connected
}
{
    Rev 1.8    4/14/2003 11:44:20 AM  BGooijen
  CheckForDisconnect calls ReadFromSource now
}
{
    Rev 1.7    4/2/2003 3:24:56 PM  BGooijen
  Moved transparantproxy from ..stack to ..socket
}
{
    Rev 1.6    3/5/2003 11:04:32 PM  BGooijen
  Fixed Intercept, but the part in WriteBuffer doesn't look really nice yet
}
{
    Rev 1.5    3/3/2003 11:31:58 PM  BGooijen
  fixed stack overflow in .CheckForDisconnect
}
{
    Rev 1.4    2/26/2003 1:15:40 PM  BGooijen
  FBinding is now freed in IdIOHandlerSocket, instead of in IdIOHandlerStack
}
{
{   Rev 1.3    2003.02.25 1:36:12 AM  czhower
}
{
{   Rev 1.2    2002.12.06 11:49:34 PM  czhower
}
{
{   Rev 1.1    12-6-2002 20:10:18  BGooijen
{ Added IPv6-support
}
{
{   Rev 1.0    11/13/2002 08:45:16 AM  JPMugaas
}
unit IdIOHandlerStack;

interface

uses
  IdGlobal, IdSocketHandle, IdIOHandlerSocket, IdExceptionCore, IdStack, IdSys,
  IdObjs;

type
  TIdIOHandlerStack = class(TIdIOHandlerSocket)
  protected
    procedure ConnectClient; override;
    function ReadFromSource(ARaiseExceptionIfDisconnected: Boolean = True;
     ATimeout: Integer = IdTimeoutDefault;
     ARaiseExceptionOnTimeout: Boolean = True): Integer; override;
  public
    procedure CheckForDataOnSource(ATimeout: Integer = 0); override;
    procedure CheckForDisconnect(ARaiseExceptionIfDisconnected: Boolean = True;
     AIgnoreBuffer: Boolean = False); override;
    function Connected: Boolean; override;
    function Readable(AMSec: Integer = IdTimeoutDefault): Boolean; override;
    // In TIdIOHandlerStack, WriteBytes must be the ONLY call to
    // WriteToDestination - all data goes thru this method
    procedure WriteDirect(
      var aBuffer: TIdBytes
      ); override;
  published
    property ReadTimeout default IdDefTimeout;
  end;

implementation

uses
  IdAntiFreezeBase, IdResourceStringsCore, IdResourceStrings, IdStackConsts, IdException,
  IdTCPConnection, IdComponent, IdIOHandler;

type
  TIdConnectThread = class(TIdNativeThread)
  protected
    FBinding: TIdSocketHandle;
    FLastSocketError: Integer;
    FExceptionMessage: string;
  public
    procedure Execute; override;
    property Terminated;
  end;

{ TIdIOHandlerStack }

function TIdIOHandlerStack.Connected: Boolean;
begin
  ReadFromSource(False, 0, False);
  Result := inherited Connected;
end;

procedure TIdIOHandlerStack.ConnectClient;

  procedure DoConnectTimeout(ATimeout: Integer);
  var
    LSleepTime: Integer;
    LInfinite: Boolean;
  begin
    if ATimeout = IdTimeoutDefault then begin
      ATimeout := IdTimeoutInfinite;
    end;
    LInfinite := ATimeout = IdTimeoutInfinite;
    with TIdConnectThread.Create(True) do try
      FBinding := Binding;
      Resume;
      // Sleep
      if TIdAntiFreezeBase.ShouldUse then begin
        LSleepTime := Min(GAntiFreeze.IdleTimeOut, 125);
      end else begin
        LSleepTime := 125;
      end;

      if LInfinite then begin
        ATimeout := LSleepTime + 1;
      end;

      while ATimeout > LSleepTime do begin
        IdGlobal.Sleep(LSleepTime);
        ATimeout := ATimeout - LSleepTime;

        if LInfinite then begin
          ATimeout := LSleepTime + 1;
        end;

        TIdAntiFreezeBase.DoProcess;
        if Terminated then begin
          ATimeout := 0;
          Break;
        end;
      end;
      IdGlobal.Sleep(ATimeout);
      //
      if Terminated then begin
        if FExceptionMessage <> '' then begin
          if FLastSocketError <> 0 then begin
            raise EIdSocketError.CreateError(FLastSocketError, FExceptionMessage);
          end;
          EIdConnectException.Toss(FExceptionMessage);
        end;
      end else begin
        Terminate;
        Close;
        WaitFor;
        EIdConnectTimeout.Toss(RSConnectTimeout);
      end;
    finally Free; end;
  end;

var
  LHost: String;
  LPort: Integer;
  LIP: string;
  LIPVersion : TIdIPVersion;
begin
  inherited ConnectClient;
  if Assigned(FTransparentProxy) then begin
    if FTransparentProxy.Enabled then begin
      LHost := FTransparentProxy.Host;
      LPort := FTransparentProxy.Port;
      LIPVersion := FTransparentProxy.IPVersion;
    end else begin
      LHost := Host;
      LPort := Port;
      LIPVersion := IPVersion;
    end;
  end else begin
    LHost := Host;
    LPort := Port;
    LIPVersion := IPVersion;
  end;
  if LIPVersion = Id_IPv4 then
  begin
    if not GStack.IsIP(LHost) then begin
      if Assigned(OnStatus) then begin
        DoStatus(hsResolving, [LHost]);
      end;
      LIP := GStack.ResolveHost(LHost, FIPVersion);
    end else begin
      LIP := LHost;
    end;
  end
  else
  begin  //IPv6
    LIP := MakeCanonicalIPv6Address(LHost);
    if LIP='' then begin  //if MakeCanonicalIPv6Address failed, we have a hostname
      if Assigned(OnStatus) then begin
        DoStatus(hsResolving, [LHost]);
      end;
      LIP := GStack.ResolveHost(LHost, LIPVersion);
    end else begin
      LIP := LHost;
    end;
  end;
  Binding.SetPeer(LIP, LPort, LIPVersion);
  // Connect
  //note for status events, we check specifically for them here
  //so we don't do a string conversion in Binding.PeerIP.
  if Assigned(OnStatus) then begin
    DoStatus(hsConnecting, [Binding.PeerIP]);
  end;

  if ConnectTimeout = 0 then begin
    if TIdAntiFreezeBase.ShouldUse then begin
      DoConnectTimeout(120000); // 2 Min
    end else begin
      Binding.Connect;
    end;
  end else begin
    DoConnectTimeout(ConnectTimeout);
  end;
  if Assigned(FTransparentProxy) then begin
    if FTransparentProxy.Enabled then begin
      FTransparentProxy.Connect(Self, Host, Port, IPVersion);
    end;
  end;
end;

function TIdIOHandlerStack.Readable(AMSec: integer): boolean;
begin
  Result := Binding.Readable(AMSec);
end;

procedure TIdIOHandlerStack.WriteDirect(
  var aBuffer: TIdBytes
  );
var
  LCount: Integer;
  LPos: Integer;
  LSize: Integer;
begin
  inherited WriteDirect(aBuffer);
  LSize := Length(ABuffer);
  LPos := 0;
  repeat
    LCount := Binding.Send(ABuffer, LPos, LSize - LPos);
    // TODO - Have a AntiFreeze param which allows the send to be split up so that process
    // can be called more. Maybe a prop of the connection, MaxSendSize?
    TIdAntiFreezeBase.DoProcess(False);
    FClosedGracefully := LCount = 0;

    // Check if other side disconnected
    CheckForDisconnect;
    DoWork(wmWrite, LCount);
    Inc(LPos, LCount);
  until LPos >= LSize;
end;

function TIdIOHandlerStack.ReadFromSource(
 ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
 ARaiseExceptionOnTimeout: Boolean): Integer;
// Reads any data in tcp/ip buffer and puts it into Indy buffer
// This must be the ONLY raw read from Winsock routine
// This must be the ONLY call to RECV - all data goes thru this method
var
  LByteCount: Integer;
  LBuffer: TIdBytes;
begin
  if ATimeout = IdTimeoutDefault then begin
    if (ReadTimeout = IdTimeoutDefault)
      or (ReadTimeout = 0) then begin // MtW: check for 0 too, for compatibility
      ATimeout := IdTimeoutInfinite;
    end else begin
      ATimeout := ReadTimeout;
    end;
  end;
  Result := 0;
  // Check here as this side may have closed the socket
  CheckForDisconnect(ARaiseExceptionIfDisconnected);
  if BindingAllocated then begin
    LByteCount := 0;
    repeat
      if Readable(ATimeout) then begin
        if Assigned(FRecvBuffer) then begin
          // No need to call AntiFreeze, the Readable does that.
          if BindingAllocated then begin
            // TODO: Whey are we reallocating LBuffer every time? This should
            // be a one time operation per connection.
            SetLength(LBuffer, RecvBufferSize); try
              LByteCount := Binding.Receive(LBuffer);
              SetLength(LBuffer, LByteCount);
              if LByteCount > 0 then begin
                if Intercept <> nil then begin
                  Intercept.Receive(LBuffer);
                  LByteCount := Length(LBuffer);
                end;
    //AsciiFilter - needs to go in TIdIOHandler base class
    //            if ASCIIFilter then begin
    //              for i := 1 to IOHandler.RecvBuffer.Size do begin
    //                PChar(IOHandler.RecvBuffer.Memory)[i] := Chr(Ord(PChar(IOHandler.RecvBuffer.Memory)[i]) and $7F);
    //              end;
    //            end;
                // Pass through LBuffer first so it can go through Intercept
                //TODO: If not intercept, we can skip this step
                InputBuffer.Write(LBuffer);
              end;
            finally LBuffer := nil; end;
          end else begin
            EIdClosedSocket.Toss(RSStatusDisconnected);
          end;
        end else begin
          LByteCount := 0;
          EIdException.IfTrue(ARaiseExceptionIfDisconnected, RSNotConnected);
        end;
        FClosedGracefully := LByteCount = 0;
        // Check here as other side may have closed connection
        CheckForDisconnect(ARaiseExceptionIfDisconnected);
        Result := LByteCount;
      end else begin
        // Timeout
        EIdReadTimeout.IfTrue(ARaiseExceptionOnTimeout, RSReadTimeout);
        Result := -1;
        Break;
      end;
    until (LByteCount <> 0) or (BindingAllocated = False);
  end else begin
    if ARaiseExceptionIfDisconnected then begin
      raise EIdException.Create(RSNotConnected);
    end;
  end;
end;

procedure TIdIOHandlerStack.CheckForDisconnect(
 ARaiseExceptionIfDisconnected: Boolean; AIgnoreBuffer: Boolean);
var
  LDisconnected: Boolean;
begin
  // ClosedGracefully // Server disconnected
  // IOHandler = nil // Client disconnected
  if ClosedGracefully then begin
    if BindingAllocated then begin
      Close;
      // Call event handlers to inform the user that we were disconnected
      DoStatus(hsDisconnected);
      //DoOnDisconnected;
    end;
    LDisconnected := True;
  end else begin
    LDisconnected := not BindingAllocated;
  end;
  // Do not raise unless all data has been read by the user
  if LDisconnected then begin
    if Assigned(FInputBuffer) then begin
      if ((FInputBuffer.Size = 0) or AIgnoreBuffer)
       and ARaiseExceptionIfDisconnected then begin
        RaiseConnClosedGracefully;
      end;
    end;
  end;
end;

procedure TIdIOHandlerStack.CheckForDataOnSource(ATimeout: Integer);
begin
  if Connected then begin
    ReadFromSource(False, ATimeout, False);
  end;
end;

{ TIdConnectThread }

procedure TIdConnectThread.Execute;
begin
  try
    try
      FBinding.Connect;
    except
      on E: EIdSocketError do begin
        if (E.LastError <> Id_WSAEBADF) and (E.LastError <> Id_WSAENOTSOCK) then begin
          raise;
        end;
      end;
    end;
  except
    on E: Exception do begin
      FExceptionMessage := E.Message;
      if E is EIdSocketError then begin
        FLastSocketError := EIdSocketError(E).LastError;
      end;
    end;
  end;
  // Necessary as caller checks this
  Terminate;
end;

initialization
  TIdIOHandlerStack.SetDefaultClass;
end.
