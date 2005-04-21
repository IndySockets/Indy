{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11635: IdIPMCastBase.pas 
{
{   Rev 1.4    2004.02.03 5:43:52 PM  czhower
{ Name changes
}
{
{   Rev 1.3    1/21/2004 3:11:06 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    10/26/2003 09:11:50 AM  JPMugaas
{ Should now work in NET.
}
{
{   Rev 1.1    2003.10.12 4:03:56 PM  czhower
{ compile todos
}
{
{   Rev 1.0    11/13/2002 07:55:16 AM  JPMugaas
}
unit IdIPMCastBase;

interface

uses
  Classes,
  IdComponent, IdException, IdGlobal, IdSocketHandle,
  IdStack {$IFDEF LINUX} ,Libc {$ENDIF}, IdStackBSDBase, IdSys;

const
  IPMCastLo = 224;
  IPMCastHi = 239;

type
  TMultiCast = record
    IMRMultiAddr : TIdIn4Addr;   // IP multicast address of group */
    IMRInterface : TIdIn4Addr;   // local IP address of interface */
  end;

  TIdIPMCastBase = class(TIdComponent)
  protected
    FDsgnActive: Boolean;
    FMulticastGroup: String;
    FPort: Integer;
    //
    procedure CloseBinding; virtual; abstract;
    function GetActive: Boolean; virtual;
    function GetBinding: TIdSocketHandle; virtual; abstract;
    procedure Loaded; override;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetMulticastGroup(const Value: string); virtual;
    procedure SetPort(const Value: integer); virtual;
    //
    property Active: Boolean read GetActive write SetActive Default False;
    property MulticastGroup: string read FMulticastGroup write SetMulticastGroup;
    property Port: Integer read FPort write SetPort;
    procedure InitComponent; override;
  public
    function IsValidMulticastGroup(Value: string): Boolean;
  published
  end;

  EIdMCastException = Class(EIdException);
  EIdMCastNoBindings = class(EIdMCastException);
  EIdMCastNotValidAddress = class(EIdMCastException);
  EIdMCastReceiveErrorZeroBytes = class(EIdMCastException);

implementation

uses
  IdAssignedNumbers,
  IdResourceStringsProtocols, IdStackConsts;

{ TIdIPMCastBase }

procedure TIdIPMCastBase.InitComponent;
begin
  inherited;
  FMultiCastGroup := Id_IPMC_All_Systems;
end;

function TIdIPMCastBase.GetActive: Boolean;
begin
  Result := FDsgnActive;
end;

function TIdIPMCastBase.IsValidMulticastGroup(Value: string): Boolean;
var
  ThisIP: string;
  s1: string;
  ip1: integer;
begin
  Result := false;

  if not GStack.IsIP(Value) then
    Exit;

  ThisIP := Value;
  s1 := Fetch(ThisIP, '.');    {Do not Localize}
  ip1 := Sys.StrToInt(s1);

  if ((ip1 < IPMCastLo) or (ip1 > IPMCastHi)) then
    Exit;

  Result := true;
end;

procedure TIdIPMCastBase.Loaded;
var
  b: Boolean;
begin
  inherited Loaded;
  b := FDsgnActive;
  FDsgnActive := False;
  Active := b;
end;

procedure TIdIPMCastBase.SetActive(const Value: Boolean);
begin
  if Active <> Value then begin
    if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then begin
      if Value then begin
        GetBinding;
      end
      else begin
        CloseBinding;
      end;
    end
    else begin  // don't activate at designtime (or during loading of properties)    {Do not Localize}
      FDsgnActive := Value;
    end;
  end;
end;

procedure TIdIPMCastBase.SetMulticastGroup(const Value: string);
begin
  if (FMulticastGroup <> Value) then begin
    if IsValidMulticastGroup(Value) then
    begin
      Active := False;
      FMulticastGroup := Value;
    end
    else
    begin
      Raise EIdMCastNotValidAddress.Create(RSIPMCastInvalidMulticastAddress);
    end;
  end;
end;

procedure TIdIPMCastBase.SetPort(const Value: integer);
begin
  if FPort <> Value then begin
    Active := False;
    FPort := Value;
  end;
end;

end.
