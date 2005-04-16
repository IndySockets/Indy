{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11954: IdRawBase.pas 
{
{   Rev 1.15    7/9/04 4:26:28 PM  RLebeau
{ Removed TIdBytes local variable from Send()
}
{
{   Rev 1.14    09/06/2004 00:28:00  CCostelloe
{ Kylix 3 patch
}
{
{   Rev 1.13    4/25/2004 7:54:26 AM  JPMugaas
{ Fix for AV.
}
{
{   Rev 1.12    2/8/2004 12:58:42 PM  JPMugaas
{ Should now compile in DotNET.
}
{
{   Rev 1.11    2004.02.03 4:16:48 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.10    2/1/2004 6:10:14 PM  JPMugaas
{ Should compile better.
}
{
{   Rev 1.9    2/1/2004 4:52:34 PM  JPMugaas
{ Removed the rest of the Todo; items.
}
{
{   Rev 1.8    2004.01.20 10:03:30 PM  czhower
{ InitComponent
}
{
{   Rev 1.7    2004.01.02 9:38:46 PM  czhower
{ Removed warning
}
{
{   Rev 1.6    2003.10.24 10:09:54 AM  czhower
{ Compiles
}
{
{   Rev 1.5    2003.10.20 12:03:08 PM  czhower
{ Added IdStackBSDBase to make it compile again.
}
{
{   Rev 1.4    10/19/2003 10:41:12 PM  BGooijen
{ Compiles in DotNet and D7 again
}
{
{   Rev 1.3    10/19/2003 9:34:28 PM  BGooijen
{ SetSocketOption
}
{
{   Rev 1.2    2003.10.11 5:48:58 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.1    2003.09.30 1:23:00 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.0    11/13/2002 08:45:24 AM  JPMugaas
}
unit IdRawBase;

interface
{We need to selectively disable some functionality in DotNET with buffers as
we don't want to impact anything else such as TIdICMPClient.
}
{$I IdCompilerDefines.inc}
uses
  Classes,
  IdComponent, IdGlobal, IdSocketHandle,
  IdStackConsts;

const
  Id_TIdRawBase_Port = 0;
  Id_TIdRawBase_BufferSize = 8192;
  GReceiveTimeout = 0;
  GFTTL = 128;
  
type
  TIdRawBase = class(TIdComponent)
  protected
    FBinding: TIdSocketHandle;
    FBuffer: TMemoryStream;
    FHost: string;
    FPort: integer;
    FReceiveTimeout: integer;
    FProtocol: TIdSocketProtocol;
    FTTL: Integer;
    //
    function GetBinding: TIdSocketHandle;
    function GetBufferSize: Integer;
    procedure InitComponent; override;
    procedure SetBufferSize(const AValue: Integer);
    procedure SetTTL(const Value: Integer);
  public
    destructor Destroy; override;
    // TODO: figure out which ReceiveXXX functions we want
     {$IFNDEF DotNetExclude}
    function ReceiveBuffer(var ABuffer; const AByteCount: Integer; ATimeOut: integer = -1): integer;
    {$ENDIF}
    procedure Send(AData: string); overload;
    procedure Send(AHost: string; const APort: Integer; AData: string); overload;
     {$IFNDEF DotNetExclude}
    procedure Send(AHost: string; const APort: integer; var ABuffer; const ABufferSize: integer); overload;
    {$ENDIF}
    //
    property TTL: Integer read FTTL write SetTTL default GFTTL;
    property Binding: TIdSocketHandle read GetBinding;
    property ReceiveTimeout: integer read FReceiveTimeout write FReceiveTimeout Default GReceiveTimeout;
  published
    property BufferSize: Integer read GetBufferSize write SetBufferSize default Id_TIdRawBase_BufferSize;
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort default Id_TIdRawBase_Port;
    property Protocol: TIdSocketProtocol read FProtocol write FProtocol default Id_IPPROTO_RAW;
  end;

implementation

uses
  IdStack,

  SysUtils;

{ TIdRawBase }

destructor TIdRawBase.Destroy;
begin
  FreeAndNil(FBinding);
  FreeAndNil(FBuffer);
  inherited;
end;

function TIdRawBase.GetBinding: TIdSocketHandle;
begin
  if not FBinding.HandleAllocated then begin
{$IFDEF LINUX}
    FBinding.AllocateSocket(Integer(Id_SOCK_RAW), FProtocol);
{$ELSE}
    FBinding.AllocateSocket(Id_SOCK_RAW, FProtocol);
{$ENDIF}
  end;
  GStack.SetSocketOption(FBinding.Handle, Id_SOL_IP, Id_IP_TTL, FTTL);
  Result := FBinding;
end;

function TIdRawBase.GetBufferSize: Integer;
begin
  Result := FBuffer.Size;
end;

procedure TIdRawBase.SetBufferSize(const AValue: Integer);
begin
  if (FBuffer = nil) then
    FBuffer := TMemoryStream.Create;
  FBuffer.Size := AValue;
end;

 {$IFNDEF DotNetExclude}
function TIdRawBase.ReceiveBuffer(var ABuffer; const AByteCount: Integer; ATimeOut: integer = -1): integer;
var LBuf : TIdBytes;
begin
  if (AByteCount > 0) and (@ABuffer <> nil) then begin
    // TODO: pass flags to recv()
    if ATimeOut < 0 then
    begin
      ATimeOut := FReceiveTimeout;
    end;
    SetLength(LBuf,AByteCount);
    if Binding.Readable(ATimeOut) then begin
      Result := Binding.Receive( LBuf);
      Move(LBuf[0],ABuffer,AByteCount);
    end else begin
      Result := 0;
    end;
  end else begin
    Result := 0;
  end;
end;
{$ENDIF}

procedure TIdRawBase.Send(AHost: string; const APort: Integer; AData: string);
begin
  AHost := GStack.ResolveHost(AHost);
  Binding.SendTo(AHost, APort, ToBytes(AData));
end;

procedure TIdRawBase.Send(AData: string);
begin
  Send(Host, Port, AData);
end;

 {$IFNDEF DotNetExclude}
procedure TIdRawBase.Send(AHost: string; const APort: integer; var ABuffer; const ABufferSize: integer);
var LBuf : TIdBytes;
begin
  AHost := GStack.ResolveHost(AHost);
    SetLength(LBuf,ABufferSize);
  Move(ABuffer,LBuf[0],ABufferSize);
  Binding.SendTo(AHost, APort, LBuf);
end;
{$ENDIF}

procedure TIdRawBase.SetTTL(const Value: Integer);
begin
  FTTL := Value;
   GStack.SetSocketOption(Binding.Handle,Id_SOL_IP,Id_IP_TTL, FTTL);
end;

procedure TIdRawBase.InitComponent;
begin
  inherited;
  FBinding := TIdSocketHandle.Create(nil);
  BufferSize := Id_TIdRawBase_BufferSize;
  ReceiveTimeout := GReceiveTimeout;
  FPort := Id_TIdRawBase_Port;
  FProtocol := Id_IPPROTO_RAW;
  FTTL := GFTTL;
end;

end.
