{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11637: IdIPMCastClient.pas 
{
{   Rev 1.6    14/06/2004 21:38:28  CCostelloe
{ Converted StringToTIn4Addr call
}
{
{   Rev 1.5    09/06/2004 10:00:34  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.4    2004.02.03 5:43:52 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/21/2004 3:11:08 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    10/26/2003 09:11:52 AM  JPMugaas
{ Should now work in NET.
}
{
{   Rev 1.1    2003.10.12 4:03:56 PM  czhower
{ compile todos
}
{
{   Rev 1.0    11/13/2002 07:55:22 AM  JPMugaas
}
unit IdIPMCastClient;

interface

uses
  Classes,
  IdIPMCastBase, IdUDPBase, IdComponent, IdSocketHandle, IdThread, IdException;

const
  DEF_IMP_THREADEDEVENT = False;
type
	TIPMCastReadEvent = procedure(Sender: TObject; AData: TStream; ABinding: TIdSocketHandle) of object;

  TIdIPMCastClient = class;

  TIdIPMCastListenerThread = class(TIdThread)
  protected
    IncomingData: TIdSocketHandle;
    FAcceptWait: integer;
    FBuffer: TMemoryStream;
    FBufferSize: integer;
  public
    FServer: TIdIPMCastClient;
    //
    constructor Create(Owner: TIdIPMCastClient); reintroduce;
    destructor Destroy; override;
    procedure Run; override;
    procedure IPMCastRead;
    //
    property AcceptWait: integer read FAcceptWait write FAcceptWait;
  published
  end;

  TIdIPMCastClient = class(TIdIPMCastBase)
  protected
    FBindings: TIdSocketHandles;
    FBufferSize: Integer;
    FCurrentBinding: TIdSocketHandle;
    FListenerThread: TIdIPMCastListenerThread;
    FOnIPMCastRead: TIPMCastReadEvent;
    FThreadedEvent: boolean;
    //
    procedure CloseBinding; override;
    procedure DoIPMCastRead(AData: TStream; ABinding: TIdSocketHandle); virtual;
    function GetActive: Boolean; override;
    function GetBinding: TIdSocketHandle; override;
    function GetDefaultPort: integer;
    procedure PacketReceived(AData: TStream; ABinding: TIdSocketHandle);
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure SetDefaultPort(const AValue: integer);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    //
  published
    property Active;
    property Bindings: TIdSocketHandles read FBindings write SetBindings;
    property BufferSize: Integer read FBufferSize write FBufferSize default ID_UDP_BUFFERSIZE;
    property DefaultPort: integer read GetDefaultPort write SetDefaultPort;
    property MulticastGroup;
    property OnIPMCastRead: TIPMCastReadEvent read FOnIPMCastRead write FOnIPMCastRead;
    property ThreadedEvent: boolean read FThreadedEvent write FThreadedEvent default DEF_IMP_THREADEDEVENT;
  end;

implementation

uses
  IdResourceStringsCore,
  IdResourceStringsProtocols, IdStack, IdStackConsts, IdStackBSDBase, IdGlobal,
  IdSys;

{ TIdIPMCastClient }

procedure TIdIPMCastClient.InitComponent;
begin
  inherited;
  BufferSize := ID_UDP_BUFFERSIZE;
  FThreadedEvent := DEF_IMP_THREADEDEVENT;
  FBindings := TIdSocketHandles.Create(Self);
end;

procedure TIdIPMCastClient.CloseBinding;
var
  i: integer;
  Multicast  : TMultiCast;
begin
  if Assigned(FCurrentBinding) then begin
    // Necessary here - cancels the recvfrom in the listener thread
    FListenerThread.Stop;
    for i := 0 to Bindings.Count - 1 do begin
      //Multicast.IMRMultiAddr :=  GBSDStack.StringToTIn4Addr(FMulticastGroup);
      //Hope the following is correct for StringToTIn4Addr(), should be checked...
      GBSDStack.TranslateStringToTInAddr(FMulticastGroup, Multicast.IMRMultiAddr, Id_IPv4);
      Multicast.IMRInterface.S_addr :=  Id_INADDR_ANY;
      GBSDStack.SetSocketOption(Bindings[i].Handle,Id_IPPROTO_IP, Id_IP_DROP_MEMBERSHIP, pchar(@Multicast), SizeOf(Multicast));
      Bindings[i].CloseSocket;
    end;
    FListenerThread.WaitFor;
    Sys.FreeAndNil(FListenerThread);
    FCurrentBinding := nil;
  end;
end;

procedure TIdIPMCastClient.DoIPMCastRead(AData: TStream; ABinding: TIdSocketHandle);
begin
  if Assigned(OnIPMCastRead) then begin
    OnIPMCastRead(Self, AData, ABinding);
  end;
end;

function TIdIPMCastClient.GetActive: Boolean;
begin
  // inherited GetActive keeps track of design-time Active property
  Result := inherited GetActive or
            (Assigned(FCurrentBinding) and FCurrentBinding.HandleAllocated);
end;

function TIdIPMCastClient.GetBinding: TIdSocketHandle;
var
  i: integer;
  Multicast  : TMultiCast;
begin
  if not Assigned(FCurrentBinding) then
  begin
    if Bindings.Count < 1 then begin
      if DefaultPort > 0 then begin
        Bindings.Add;
      end else begin
        raise EIdMCastNoBindings.Create(RSNoBindingsSpecified);
      end;
    end;
    for i := 0 to Bindings.Count - 1 do begin
{$IFDEF LINUX}
      Bindings[i].AllocateSocket(Integer(Id_SOCK_DGRAM));
{$ELSE}
      Bindings[i].AllocateSocket(Id_SOCK_DGRAM);
{$ENDIF}
      Bindings[i].Bind;
      //Multicast.IMRMultiAddr :=  GBSDStack.StringToTIn4Addr(FMulticastGroup);
      //Hope the following is correct for StringToTIn4Addr(), should be checked...
      GBSDStack.TranslateStringToTInAddr(FMulticastGroup, Multicast.IMRMultiAddr, Id_IPv4);
      Multicast.IMRInterface.S_addr :=  Id_INADDR_ANY;
      GBSDStack.SetSocketOption(Bindings[i].Handle,Id_IPPROTO_IP, Id_IP_ADD_MEMBERSHIP, pchar(@Multicast), SizeOf(Multicast));
    end;
    FCurrentBinding := Bindings[0];
    FListenerThread := TIdIPMCastListenerThread.Create(Self);
    FListenerThread.Start;
  end;
  Result := FCurrentBinding;
end;

function TIdIPMCastClient.GetDefaultPort: integer;
begin
  result := FBindings.DefaultPort;
end;

procedure TIdIPMCastClient.PacketReceived(AData: TStream; ABinding: TIdSocketHandle);
begin
  FCurrentBinding := ABinding;
  DoIPMCastRead(AData, ABinding);
end;

procedure TIdIPMCastClient.SetBindings(const Value: TIdSocketHandles);
begin
  FBindings.Assign(Value);
end;

procedure TIdIPMCastClient.SetDefaultPort(const AValue: integer);
begin
  if (FBindings.DefaultPort <> AValue) then begin
    FBindings.DefaultPort := AValue;
    FPort := AValue;
  end;
end;

destructor TIdIPMCastClient.Destroy;
begin
  Active := False;
  Sys.FreeAndNil(FBindings);
  inherited Destroy;
end;

{ TIdIPMCastListenerThread }

constructor TIdIPMCastListenerThread.Create(Owner: TIdIPMCastClient);
begin
  inherited Create(True);
  FAcceptWait := 1000;
  FBuffer := TMemoryStream.Create;
  FBufferSize := Owner.BufferSize;
  FServer := Owner;
end;

destructor TIdIPMCastListenerThread.Destroy;
begin
  Sys.FreeAndNil(FBuffer);
  inherited Destroy;
end;

procedure TIdIPMCastListenerThread.Run;
var
  PeerIP: string;
  PeerPort: Integer;
  ByteCount: Integer;
  LReadList: TIdSocketList;
  i: Integer;

begin
  // create a socket list to select for read
  LReadList := TIdSocketList.CreateSocketList;

  try
    // fill list of socket handles for reading
    for i := 0 to FServer.Bindings.Count - 1 do
    begin
      LReadList.Add(FServer.Bindings[i].Handle);
    end;
    // select the handles for reading
    LReadList.SelectRead(AcceptWait);

    for i := 0 to LReadList.Count - 1 do
    begin
      // Doublecheck to see if we've been stopped
      // Depending on timing - may not reach here
      // if stopped the run method of the ancestor

      if not Stopped then
      begin
        IncomingData := FServer.Bindings.BindingByHandle(TIdStackSocketHandle(LReadList[i]));
        FBuffer.SetSize(FBufferSize);
        ByteCount := GBSDStack.RecvFrom(IncomingData.Handle,
          FBuffer.Memory^, FBufferSize, 0, PeerIP, PeerPort);
        GBSDStack.CheckForSocketError(ByteCount);

        if ByteCount = 0 then
        begin
          raise EIdUDPReceiveErrorZeroBytes.Create(RSIPMCastReceiveError0);
        end;
        FBuffer.SetSize(ByteCount);

        //Some streams alter their position on SetSize
        FBuffer.Position := 0;
        IncomingData.SetPeer(PeerIP, PeerPort);

        if FServer.ThreadedEvent then
        begin
          IPMCastRead;
        end

        else
        begin
          Synchronize(IPMCastRead);
        end;
      end;
    end;

  finally
    LReadList.Free;
  end;
end;

procedure TIdIPMCastListenerThread.IPMCastRead;
begin
  FServer.PacketReceived(FBuffer, IncomingData);
end;

end.
