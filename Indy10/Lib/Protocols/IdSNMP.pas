{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11751: IdSNMP.pas 
{
{   Rev 1.3    10/26/2004 11:08:04 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.2    2004.02.03 5:44:22 PM  czhower
{ Name changes
}
{
{   Rev 1.1    1/21/2004 4:03:36 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 08:01:02 AM  JPMugaas
}
unit IdSNMP;

{
-2001.02.13 - Kudzu - Misc "Indy" Changes.
-Contributions also by: Hernan Sanchez (hernan.sanchez@iname.com)
-Original Author: Lukas Gebauer

The Synapse SNMP component was converted for use in INDY.

| The Original Code is Synapse Delphi Library.                                 |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c)2000.                     |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|   Hernan Sanchez (hernan.sanchez@iname.com)  Original author                 |
|   Colin Wilson (colin@wilsonc.demon.co.uk)   Fixed some bugs & added support |
|                                              for Value types                 |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================}

interface

uses
  Classes,
    IdASN1Util,
    IdObjs,
  IdException,
  IdUDPBase,
  IdUDPClient;

const
  //PDU type
  PDUGetRequest=$a0;
  PDUGetNextRequest=$a1;
  PDUGetResponse=$a2;
  PDUSetRequest=$a3;
  PDUTrap=$a4;

  //errors
  ENoError=0;
  ETooBig=1;
  ENoSuchName=2;
  EBadValue=3;
  EReadOnly=4;
  EGenErr=5;

type
  TIdSNMP = class;
  TSNMPInfo=class(TObject)
  private
    fOwner : TIdSNMP;
    fCommunity: string;
    function GetValue (idx : Integer) : string;
    function GetValueCount: Integer;
    function GetValueType (idx : Integer) : Integer;
    function GetValueOID(idx: Integer): string;
    procedure SetCommunity(const Value: string);
  protected
    Buffer: string;
    procedure SyncMIB;
  public
    Host : string;
    Port : integer;
    Enterprise: string;
    GenTrap: integer;
    SpecTrap: integer;
    Version : integer;
    PDUType : integer;
    TimeTicks : integer;
    ID : integer;
    ErrorStatus : integer;
    ErrorIndex : integer;
    MIBOID : TIdStringList;
    MIBValue : TIdStringList;

    constructor Create (AOwner : TIdSNMP);
    destructor  Destroy; override;
    function    EncodeTrap: integer;
    function    DecodeTrap: integer;
    procedure   DecodeBuf(Buffer:string);
    function    EncodeBuf:string;
    procedure   Clear;
    procedure   MIBAdd(MIB,Value:string; valueType : Integer = ASN1_OCTSTR);
    procedure   MIBDelete(Index:integer);
    function    MIBGet(MIB:string):string;

    property    Owner : TIdSNMP read fOwner;
    property    Community : string read fCommunity write SetCommunity;
    property    ValueCount : Integer read GetValueCount;
    property    Value [idx : Integer] : string read GetValue;
    property    ValueOID [idx : Integer] : string read GetValueOID;
    property    ValueType [idx : Integer] : Integer read GetValueType;
  end;

  TIdSNMP = class(TIdUDPClient)
  protected
    fCommunity: string;
    fTrapPort: Integer;
    procedure SetCommunity(const Value: string);
    procedure InitComponent; override;
  public
    Query : TSNMPInfo;
    Reply : TSNMPInfo;
    Trap  : TSNMPInfo;
    destructor Destroy; override;
    function SendQuery : boolean;
    function QuickSend(const Mib, Community, Host:string; var Value:string):Boolean;
    function QuickSendTrap(const Dest, Enterprise, Community: string;
                      Port, Generic, Specific: integer; MIBName, MIBValue: TIdStringList): integer;
    function QuickReceiveTrap(var Source, Enterprise, Community: string;
                      var Port, Generic, Specific, Seconds: integer; var MIBName, MIBValue: TIdStringList): integer;
    function SendTrap: integer;
    function ReceiveTrap: integer;
  published
    property Port default 161;
    property TrapPort : Integer read fTrapPort Write fTrapPort default 162;
    property Community : string read fCommunity write SetCommunity;
  end;

implementation

uses
  IdGlobal,
  IdSys,
  IdStack;

//Hernan Sanchez
function IPToID(Host: string): string;
var
  s, t: string;
  i, x: integer;
begin
  Result := '';    {Do not Localize}
  for x:= 1 to 3 do
    begin
      t := '';    {Do not Localize}
      s := Copy(Host,IndyPos(Host, '.'),Length(Host));    {Do not Localize}
      t := Copy(Host, 1, (Length(Host) - Length(s)));
      Delete(Host, 1, (Length(Host) - Length(s) + 1));
      i := Sys.StrToint(t, 0);
      Result := Result + Chr(i);
    end;
  i := Sys.StrToint(Host, 0);
  Result := Result + Chr(i);
end;

{========================== SNMP INFO OBJECT ==================================}

{ TIdSNMPInfo }

(*----------------------------------------------------------------------------*
 | constructor TSNMPInfo.Create ()                                            |
 |                                                                            |
 | Constructor for TSNMPInfo                                                  |
 |                                                                            |
 | Parameters:                                                                |
 |   AOwner : TIdSNMP       The owning IdSNMP Component                       |
 |                                                                            |
 *----------------------------------------------------------------------------*)
constructor TSNMPInfo.Create(AOwner : TIdSNMP);
begin
  inherited Create;
  fOwner := AOwner;
  MIBOID:=TIdStringList.create;
  MIBValue:=TIdStringList.create;
  fCommunity := AOwner.Community;
  Port := AOwner.Port;
end;

(*----------------------------------------------------------------------------*
 | destructor TSNMPInfo.Destroy                                               |
 |                                                                            |
 | Destructor for TSNMPInfo                                                   |
 *----------------------------------------------------------------------------*)
destructor TSNMPInfo.Destroy;
begin
  MIBValue.Free;
  MIBOID.Free;
  inherited destroy;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.SyncMIB                                                |
 |                                                                            |
 | Ensure that there are as many 'values' as 'oids'                           |    {Do not Localize}
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.SyncMIB;
var
  n,x:integer;
begin
  x:=MIBValue.Count;
  for n:=x to MIBOID.Count-1 do
    MIBValue.Add('');    {Do not Localize}
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.DecodeBuf                                              |
 |                                                                            |
 | Decode an ASN buffer into version, community, MIB OID/Value pairs, etc.    |
 |                                                                            |
 | Parameters:                                                                |
 |   Buffer:string             The ASN buffer to decode                       |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.DecodeBuf(Buffer:string);
var
  Pos:integer;
  endpos,vt:integer;
  sm,sv:string;
begin
  Pos:=2;
  Endpos:=ASNDecLen(Pos,buffer);
  Self.version:=Sys.StrToInt(ASNItem(Pos,buffer,vt),0);
  Self.community:=ASNItem(Pos,buffer,vt);
  Self.PDUType:=Sys.StrToInt(ASNItem(Pos,buffer,vt),0);
  Self.ID:=Sys.StrToInt(ASNItem(Pos,buffer,vt),0);
  Self.ErrorStatus:=Sys.StrToInt(ASNItem(Pos,buffer,vt),0);
  Self.ErrorIndex:=Sys.StrToInt(ASNItem(Pos,buffer,vt),0);
  ASNItem(Pos,buffer,vt);
  while Pos<Endpos do           // Decode MIB/Value pairs
    begin
      ASNItem(Pos,buffer,vt);
      Sm:=ASNItem(Pos,buffer,vt);
      Sv:=ASNItem(Pos,buffer,vt);

      MIBadd(sm,sv, vt);
    end;
end;

(*----------------------------------------------------------------------------*
 | function TSNMPInfo.EncodeBuf                                               |
 |                                                                            |
 | Encode the details into an ASN string                                      |
 |                                                                            |
 | The function returns the encoded ASN string                                |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.EncodeBuf:string;
var
  data,s:string;
  n:integer;
  objType:Integer;
begin
  data:='';    {Do not Localize}
  SyncMIB;
  for n:=0 to Self.MIBOID.Count-1 do
    begin
      objType := Integer (Self.MIBValue.Objects[n]);
      if objType = 0 then
        objType := ASN1_OCTSTR;

      case objType of
        ASN1_INT:
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject(ASNEncInt(Sys.StrToInt(Self.MIBValue[n], 0)), objType);
        ASN1_COUNTER, ASN1_GAUGE, ASN1_TIMETICKS:
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject(ASNEncUInt(Sys.StrToInt(Self.MIBValue[n], 0)), objType);
        ASN1_OBJID:
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject(MibToID(Self.MIBValue[n]), objType);
        ASN1_IPADDR:
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject(IPToID(Self.MIBValue[n]), objType);
        ASN1_NULL:
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject('', ASN1_NULL);    {Do not Localize}
        else
          s := ASNObject(MibToID(Self.MIBOID[n]), ASN1_OBJID) +
            ASNObject(Self.MIBValue[n], objType);
      end;
      data:=data+ASNObject(s,$30);
    end;
  data:=ASNObject(data,$30);
  data:=ASNObject(char(Self.ID),2)+ASNObject(char(Self.ErrorStatus),2)
         +ASNObject(char(Self.ErrorIndex),2)+data;
  data:=ASNObject(char(Self.Version),2)+ASNObject(Self.community,4)+ASNObject(data,Self.PDUType);
  data:=ASNObject(data,$30);
  Result:=data;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.Clear                                                  |
 |                                                                            |
 | Clear the header info and  MIBOID/Value lists.                             |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.Clear;
begin
  version:=0;
  fCommunity:=Owner.Community;
  if Self = fOwner.Trap then
    Port := Owner.TrapPort
  else
    Port := Owner.Port;
  Host := Owner.Host;
  PDUType:=0;
  ID:=0;
  ErrorStatus:=0;
  ErrorIndex:=0;
  MIBOID.Clear;
  MIBValue.Clear;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.MIBAdd                                                 |
 |                                                                            |
 | Add a MIBOID/Value pair                                                    |
 |                                                                            |
 | Parameters:                                                                |
 |  MIB  : string               The MIBOID to add                             |
 |  Value : string              The Value                                     |
 |  valueType : Integer         The Value's type.  Optional - defaults to     |    {Do not Localize}
 |                              ASN1_OCTSTR                                   |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.MIBAdd(MIB,Value:string; valueType : Integer);
var
  x:integer;
begin
  SyncMIB;
  MIBOID.Add (MIB);
  x:=MIBOID.Count;
  if MIBValue.Count>x then
  begin
    MIBvalue[x-1]:=Value;
    MibValue.Objects [x-1] := TObject (valueType)
  end
  else MIBValue.AddObject(Value, TObject (valueType));
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.MIBDelete                                              |
 |                                                                            |
 | Delete a MIBOID/Value pair                                                 |
 |                                                                            |
 | Parameters:                                                                |
 |   Index:integer                      The index of the pair to delete       |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.MIBDelete(Index:integer);
begin
  SyncMIB;
  MIBOID.Delete(Index);
  if (MIBValue.Count-1)>= Index then MIBValue.Delete(Index);
end;

(*----------------------------------------------------------------------------*
 | function TSNMPInfo.MIBGet                                                  |
 |                                                                            |
 | Get a string representation of tha value of the specified MIBOID           |
 |                                                                            |
 | Parameters:                                                                |
 |   MIB:string                         The MIBOID to query                   |
 |                                                                            |
 | The function returns the string representation of the value.               |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.MIBGet(MIB:string):string;
var
  x:integer;
begin
  SyncMIB;
  x:=MIBOID.IndexOf(MIB);
  if x<0 then Result:=''    {Do not Localize}
    else Result:=MIBValue[x];
end;

{======================= TRAPS =====================================}

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.EncodeTrap                                             |
 |                                                                            |
 | Encode the trap details into an ASN string - the 'Buffer' member           |    {Do not Localize}
 |                                                                            |
 | The function returns 1 for historical reasons!                             |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.EncodeTrap: integer;
var
  s: string;
  n: integer;
begin
  Buffer := '';    {Do not Localize}
  for n:=0 to MIBOID.Count-1 do
    begin
      s := ASNObject(MibToID(MIBOID[n]), ASN1_OBJID)
        + ASNObject(MIBValue[n], ASN1_OCTSTR);
      Buffer := Buffer + ASNObject(s, ASN1_SEQ);
    end;
  Buffer := ASNObject(Buffer, ASN1_SEQ);
  Buffer := ASNObject(ASNEncInt(GenTrap), ASN1_INT)
    + ASNObject(ASNEncInt(SpecTrap), ASN1_INT)
    + ASNObject(ASNEncInt(TimeTicks), ASN1_TIMETICKS) + Buffer;
  Buffer := ASNObject(MibToID(Enterprise), ASN1_OBJID)
    + ASNObject(IPToID(Host), ASN1_IPADDR) + Buffer;
  Buffer := ASNObject(Char(Version), ASN1_INT)
    + ASNObject(Community, ASN1_OCTSTR) + ASNObject(Buffer, Self.PDUType);
  Buffer := ASNObject(Buffer, ASN1_SEQ);
  Result := 1;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.DecodeTrap                                             |
 |                                                                            |
 | Decode the 'Buffer' trap string to fil in our member variables.            |    {Do not Localize}
 |                                                                            |
 | The function returns 1.                                                    |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.DecodeTrap: integer;
var
  Pos, EndPos, vt: integer;
  Sm, Sv: string;
begin
  Pos := 2;
  EndPos := ASNDecLen(Pos, Buffer);
  Version := Sys.StrToInt(ASNItem(Pos, Buffer,vt), 0);
  Community := ASNItem(Pos, Buffer,vt);
  PDUType := Sys.StrToInt(ASNItem(Pos, Buffer,vt), PDUTRAP);
  Enterprise := IdToMIB(ASNItem(Pos, Buffer,vt));
  Host := ASNItem(Pos, Buffer,vt);
  GenTrap := Sys.StrToInt(ASNItem(Pos, Buffer,vt), 0);
  Spectrap := Sys.StrToInt(ASNItem(Pos, Buffer,vt), 0);
  TimeTicks := Sys.StrToInt(ASNItem(Pos, Buffer,vt), 0);
  ASNItem(Pos, Buffer,vt);
  while (Pos < EndPos) do
    begin
      ASNItem(Pos, Buffer,vt);
      Sm := ASNItem(Pos, Buffer,vt);
      Sv := ASNItem(Pos, Buffer,vt);
      MIBAdd(Sm, Sv, vt);
    end;
  Result := 1;
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.SetCommunity                                                     |
 |                                                                            |
 | Set the community.                                                         |
 |                                                                            |
 | Parameters:                                                                |
 |   const Value: string        The new community value                       |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.SetCommunity(const Value: string);
begin
  if Community <> Value then
  begin
    Clear;
    fCommunity := Value
  end
end;

{ TIdSNMP }

{==============================  IdSNMP OBJECT ================================}


(*----------------------------------------------------------------------------*
 | constructor TIdSNMP.Create                                                 |
 |                                                                            |
 | Contructor for TIdSNMP component                                           |
 |                                                                            |
 | Parameters:                                                                |
 |   aOwner : TComponent                                                      |
 *----------------------------------------------------------------------------*)
procedure TIdSNMP.InitComponent;
begin
  inherited;
  Port := 161;
  fTrapPort := 162;
  fCommunity := 'public';    {Do not Localize}
  Query:=TSNMPInfo.Create (Self);
  Reply:=TSNMPInfo.Create (Self);
  Trap :=TSNMPInfo.Create (Self);
  Query.Clear;
  Reply.Clear;
  Trap.Clear;
  FReceiveTimeout:=5000;
end;

(*----------------------------------------------------------------------------*
 |  destructor TIdSNMP.Destroy                                                |
 |                                                                            |
 |  Destructor for TIdSNMP component                                          |
 *----------------------------------------------------------------------------*)
destructor TIdSNMP.Destroy;
begin
  Reply.Free;
  Query.Free;
  Trap.Free;
  inherited destroy;
end;

(*----------------------------------------------------------------------------*
 | function TIdSNMP.SendQuery                                                 |
 |                                                                            |
 | Send an SNMP query and receive a reply.                                    |
 |                                                                            |
 | nb.  Before calling this, ensure that the following members are set:       |
 |                                                                            |
 |        Community         The SNMP community being queried - eg. 'public'   |    {Do not Localize}
 |        Host              The IP address being queried.  127.0.0.1 for the  |
 |                          local machine.                                    |
 |                                                                            |
 |      The call Query.Clear, then set:                                       |
 |                                                                            |
 |        Query.PDUType     PDUGetRequest to get a single set of MIBOID       |
 |                          value(s) or PDUGetNextRequest to start walking    |
 |                          the MIB                                           |
 |                                                                            |
 |      Next call Query.Clear, call MIBAdd to add the MIBOID(s) you require.  |
 |                                                                            |
 | The function returns True if a response was received.  IF a response was   |
 | received, it will be decoded into Reply.Value                              |
 *----------------------------------------------------------------------------*)
function TIdSNMP.SendQuery:boolean;
begin
  reply.clear;
  Query.Buffer:=Query.Encodebuf;
  Send(Query.host, Query.port, Query.buffer);
  try
    reply.Buffer := ReceiveString(Query.host, Query.port, FReceiveTimeout);
  except
    on e : EIdSocketError do
      if e.LastError <> 10054 then
        raise
      else
        reply.buffer := '';    {Do not Localize}
  end;

  if reply.Buffer<>'' then reply.DecodeBuf(reply.Buffer);    {Do not Localize}
  Result := (reply.Buffer <> '') and (reply.ErrorStatus = 0)    {Do not Localize}
end;

(*----------------------------------------------------------------------------*
 | TIdSNMP.QuickSend                                                          |
 |                                                                            |
 | Query a single MIBOID value.                                               |
 |                                                                            |
 | Parameters:                                                                |
 |   Mib : string               The MIBOID to query                           |
 |   Community : string         The SNMP comunity                             |
 |   Host : string              The SNMP host                                 |
 |   var value : string         String representation of the returned value.  |
 |                                                                            |
 | The function returns true if a value was returned for the MIB OID          |
 *----------------------------------------------------------------------------*)
function TIdSNMP.QuickSend (const Mib, Community,Host:string; var Value:string):Boolean;
begin
  self.Community := Community;
  self.Host := Host;
  Query.Clear;
  Query.PDUType:=PDUGetRequest;

  Query.MIBAdd(MIB,'');    {Do not Localize}
  Result:=SendQuery;
  if Result then Value:=Reply.MIBGet(MIB);
end;

(*----------------------------------------------------------------------------*
 | TIdSNMP.SendTrap                                                           |
 |                                                                            |
 | Send an SNMP trap.                                                         |
 |                                                                            |
 | The function returns 1                                                     |
 *----------------------------------------------------------------------------*)
function TIdSNMP.SendTrap: integer;
begin
  Trap.PDUType := PDUTrap;
  Trap.EncodeTrap;
  Send(Trap.Host, Trap.Port, Trap.Buffer);
  Result := 1;
end;

function TIdSNMP.ReceiveTrap: integer;
begin
  Trap.PDUType := PDUTrap;
  Result := 0;
  Trap.Buffer := ReceiveString(trap.host, trap.port, FReceiveTimeout);
  if Trap.Buffer <> '' then begin    {Do not Localize}
     Trap.DecodeTrap;
     Result := 1;
  end;
end;

function TIdSNMP.QuickSendTrap(const Dest, Enterprise, Community: string;
  Port, Generic, Specific: integer; MIBName, MIBValue: TIdStringList): integer;
var
  i: integer;
begin
    Trap.Host := Dest;
    Trap.Enterprise := Enterprise;
    Trap.GenTrap := Generic;
    Trap.SpecTrap := Specific;
    for i:=0 to (MIBName.Count - 1) do
      Trap.MIBAdd(MIBName[i], MIBValue[i], Integer (MibValue.Objects [i]));
    Result := SendTrap;
end;

function TIdSNMP.QuickReceiveTrap(var Source, Enterprise, Community: string;
  var Port, Generic, Specific, Seconds: integer; var MIBName, MIBValue: TIdStringList): integer;
var
  i: integer;
begin
    Result := ReceiveTrap;
    if (Result <> 0) then
    begin
      Source := Trap.Host;
      Port := Trap.Port;
      Enterprise := Trap.Enterprise;
      Community := Trap.Community;
      Generic := Trap.GenTrap;
      Specific := Trap.SpecTrap;
      Seconds := Trap.TimeTicks;
      MIBName.Clear;
      MIBValue.Clear;
      for i:=0 to (Trap.MIBOID.Count - 1) do
        begin
          MIBName.Add(Trap.MIBOID[i]);
          MIBValue.Add(Trap.MIBValue[i]);
        end;
    end;
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValue                                                         |
 |                                                                            |
 | Return string representation of value 'idx'                                |    {Do not Localize}
 |                                                                            |
 | Parameters:                                                                |
 |   idx : Integer              The value to get                              |
 |                                                                            |
 | The function returns the string representation of the value.               |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValue (idx : Integer) : string;
begin
  Result := MIBValue [idx]
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValueCount                                                    |
 |                                                                            |
 | Get the number of values.                                                  |
 |                                                                            |
 | The function returns the number of values.                                 |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValueCount: Integer;
begin
  Result := MIBValue.Count
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValueType                                                     |
 |                                                                            |
 | Return the 'type' of value 'idx'                                           |    {Do not Localize}
 |                                                                            |
 | Parameters:                                                                |
 |   idx : Integer              The value type to get                         |
 |                                                                            |
 | The function returns the value type.                                       |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValueType (idx : Integer): Integer;
begin
  Result := Integer (MIBValue.Objects [idx]);
  if Result = 0 then
    Result := ASN1_OCTSTR
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValueOID                                                      |
 |                                                                            |
 | Get the MIB OID for value 'idx'                                            |    {Do not Localize}
 |                                                                            |
 | Parameters:                                                                |
 |   idx: Integer               The MIB OID to gey                            |
 |                                                                            |
 | The function returns the specified MIB OID                                 |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValueOID(idx: Integer): string;
begin
  Result := MIBOID [idx];
end;

(*----------------------------------------------------------------------------*
 | TIdSNMP.SetCommunity                                                       |
 |                                                                            |
 | Setter for the Community property.                                         |
 |                                                                            |
 | Parameters:                                                                |
 |   const Value: string        The new community value                       |
 *----------------------------------------------------------------------------*)
procedure TIdSNMP.SetCommunity(const Value: string);
begin
  if fCommunity <> Value then
  begin
    fCommunity := Value;
    Query.Community := Value;
    Reply.Community := Value;
    Trap.Community := Value
  end
end;

end.
