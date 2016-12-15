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
  Rev 1.3    10/26/2004 11:08:04 PM  JPMugaas
  Updated refs.

  Rev 1.2    2004.02.03 5:44:22 PM  czhower
  Name changes

  Rev 1.1    1/21/2004 4:03:36 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:01:02 AM  JPMugaas
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
|   Remy Lebeau (remy@lebeausoftware.org)      Added support for Unicode and   |
|                                              Generics                        |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================|
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  {$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
  {$ENDIF}
  IdASN1Util,
  IdException,
  IdGlobal,
  IdUDPBase,
  IdUDPClient,
  IdSocketHandle;

const
  //PDU type
  PDUGetRequest     = $a0;
  PDUGetNextRequest = $a1;
  PDUGetResponse    = $a2;
  PDUSetRequest     = $a3;
  PDUTrap           = $a4;

  //errors
  ENoError    = 0;
  ETooBig     = 1;
  ENoSuchName = 2;
  EBadValue   = 3;
  EReadOnly   = 4;
  EGenErr     = 5;

type
  TIdSNMP = class;

  // TODO: create TIdMIBValueList for non-Generics compilers...
  {$IFDEF HAS_GENERICS_TList}
  TIdMIBValue = record
    OID: String;
    Value: String;
    ValueType: Integer;
    constructor Create(const AOID, AValue: String; const AValueType: Integer);
  end;
  TIdMIBValueList = TList<TIdMIBValue>;
  {$ENDIF}

  TSNMPInfo = class(TObject)
  private
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} fOwner : TIdSNMP;
    fCommunity: string;
    function GetValue (idx : Integer) : string;
    function GetValueCount: Integer;
    function GetValueType (idx : Integer) : Integer;
    function GetValueOID(idx: Integer): string;
    procedure SetCommunity(const Value: string);
  protected
    Buffer: string;
    {$IFNDEF HAS_GENERICS_TList}
    procedure SyncMIB;
    {$ENDIF}
  public
    Host : string;
    Port : TIdPort;
    Enterprise: string;
    GenTrap: integer;
    SpecTrap: integer;
    Version : integer;
    PDUType : integer;
    TimeTicks : integer;
    ID : integer;
    ErrorStatus : integer;
    ErrorIndex : integer;
    {$IFDEF HAS_GENERICS_TList}
    MIBValues : TIdMIBValueList;
    {$ELSE}
    MIBOID : TStrings;
    MIBValue : TStrings;
    {$ENDIF}

    constructor Create (AOwner : TIdSNMP);
    destructor  Destroy; override;
    function    EncodeTrap: Boolean;
    function    DecodeTrap: Boolean;
    procedure   DecodeBuf(Buffer: string);
    function    EncodeBuf: string;
    procedure   Clear;
    procedure   MIBAdd(MIB, Value: string; ValueType: Integer = ASN1_OCTSTR);
    procedure   MIBDelete(Index: integer);
    function    MIBGet(MIB: string): string;

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
    fTrapPort: TIdPort;
    fTrapRecvBinding: TIdSocketHandle;
    procedure SetCommunity(const Value: string);
    procedure SetTrapPort(const AValue: TIdPort);
    procedure InitComponent; override;
    function GetBinding: TIdSocketHandle; override;
    procedure CloseBinding; override;
  public
    Query : TSNMPInfo;
    Reply : TSNMPInfo;
    Trap  : TSNMPInfo;
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;
    function SendQuery : Boolean;
    function QuickSend(const Mib, DestCommunity, DestHost: string; var Value: string):Boolean;
    function QuickSendTrap(const DestHost, Enterprise, DestCommunity: string;
                      DestPort: TIdPort; Generic, Specific: integer;
                      {$IFDEF HAS_GENERICS_TList}
                      MIBValues: TIdMIBValueList
                      {$ELSE}
                      MIBName, MIBValue: TStrings
                      {$ENDIF}
                      ): Boolean;
    function QuickReceiveTrap(var SrcHost, Enterprise, SrcCommunity: string;
                      var SrcPort: TIdPort; var Generic, Specific, Seconds: integer;
                      {$IFDEF HAS_GENERICS_TList}
                      MIBValues: TIdMIBValueList
                      {$ELSE}
                      MIBName, MIBValue: TStrings
                      {$ENDIF}
                      ): Boolean;
    function SendTrap: Boolean;
    function ReceiveTrap: Boolean;
  published
    property Port default 161;
    property TrapPort : TIdPort read fTrapPort write SetTrapPort default 162;
    property Community : string read fCommunity write SetCommunity;
  end;

implementation

uses
  IdStack, IdStackConsts, SysUtils;

//Hernan Sanchez
function IPToID(Host: string): string;
var
  s, t: string;
  i, x: integer;
begin
  Result := '';    {Do not Localize}
  for x := 1 to 3 do
  begin
    t := '';    {Do not Localize}
    s := Copy(Host, IndyPos('.', Host), Length(Host));    {Do not Localize}
    t := Copy(Host, 1, (Length(Host) - Length(s)));
    Delete(Host, 1, (Length(Host) - Length(s) + 1));
    i := IndyStrToInt(t, 0);
    Result := Result + Chr(i);
  end;
  i := IndyStrToInt(Host, 0);
  Result := Result + Chr(i);
end;

function MibIntToASNObject(const OID: String; const Value: Integer; const ObjType: Integer = ASN1_INT): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(OID), ASN1_OBJID) + ASNObject(ASNEncInt(Value), ObjType);
end;

function MibUIntToASNObject(const OID: String; const Value, ObjType: Integer): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(OID), ASN1_OBJID) + ASNObject(ASNEncUInt(Value), ObjType);
end;

function MibObjIDToASNObject(const ObjID, Value: String): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(ObjID), ASN1_OBJID) + ASNObject(MibToID(Value), ASN1_OBJID);
end;

function MibIPAddrToASNObject(const OID, Value: String): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(OID), ASN1_OBJID) + ASNObject(IPToID(Value), ASN1_IPADDR);
end;

function MibNullToASNObject(const OID: String): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(OID), ASN1_OBJID) + ASNObject('', ASN1_NULL); {Do not Localize}
end;

function MibStrToASNObject(const OID, Value: String; const ObjType: Integer = ASN1_OCTSTR): String;
  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := ASNObject(MibToID(OID), ASN1_OBJID) + ASNObject(Value, ObjType);
end;

{========================== SNMP INFO OBJECT ==================================}

{$IFDEF HAS_GENERICS_TList}
constructor TIdMIBValue.Create(const AOID, AValue: String; const AValueType: Integer);
begin
  OID := AOID;
  Value := AValue;
  ValueType := AValueType;
end;
{$ENDIF}

{ TSNMPInfo }

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
  {$IFDEF HAS_GENERICS_TList}
  MIBValues := TIdMIBValueList.Create;
  {$ELSE}
  MIBOID := TStringList.Create;
  MIBValue := TStringList.Create;
  {$ENDIF}
  if fOwner <> nil then begin
    fCommunity := fOwner.Community;
    Port := fOwner.Port;
  end;
end;

(*----------------------------------------------------------------------------*
 | destructor TSNMPInfo.Destroy                                               |
 |                                                                            |
 | Destructor for TSNMPInfo                                                   |
 *----------------------------------------------------------------------------*)
destructor TSNMPInfo.Destroy;
begin
  {$IFDEF HAS_GENERICS_TList}
  FreeAndNil(MIBValues);
  {$ELSE}
  FreeAndNil(MIBValue);
  FreeAndNil(MIBOID);
  {$ENDIF}
  inherited Destroy;
end;

{$IFNDEF HAS_GENERICS_TList}
(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.SyncMIB                                                |
 |                                                                            |
 | Ensure that there are as many 'values' as 'oids'                           |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.SyncMIB;
var
  n,x: integer;
begin
  x := MIBValue.Count;
  for n := x to MIBOID.Count-1 do begin
    MIBValue.Add('');
  end;
end;
{$ENDIF}

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.DecodeBuf                                              |
 |                                                                            |
 | Decode an ASN buffer into version, community, MIB OID/Value pairs, etc.    |
 |                                                                            |
 | Parameters:                                                                |
 |   Buffer:string             The ASN buffer to decode                       |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.DecodeBuf(Buffer: string);
var
  Pos: integer;
  endpos,vt: integer;
  sm,sv: string;
begin
  Pos := 2;
  Endpos := ASNDecLen(Pos, Buffer);
  Version := IndyStrToInt(ASNItem(Pos,Buffer,vt),0);
  Community := ASNItem(Pos,buffer,vt);
  PDUType := IndyStrToInt(ASNItem(Pos,Buffer,vt),0);
  ID := IndyStrToInt(ASNItem(Pos,Buffer,vt),0);
  ErrorStatus := IndyStrToInt(ASNItem(Pos,Buffer,vt),0);
  ErrorIndex := IndyStrToInt(ASNItem(Pos,Buffer,vt),0);
  ASNItem(Pos, Buffer, vt);
  while Pos < Endpos do           // Decode MIB/Value pairs
  begin
    ASNItem(Pos, Buffer, vt);
    Sm := ASNItem(Pos, Buffer, vt);
    Sv := ASNItem(Pos, Buffer, vt);
    MIBAdd(sm, sv, vt);
  end;
end;

(*----------------------------------------------------------------------------*
 | function TSNMPInfo.EncodeBuf                                               |
 |                                                                            |
 | Encode the details into an ASN string                                      |
 |                                                                            |
 | The function returns the encoded ASN string                                |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.EncodeBuf: string;
var
  data,s: string;
  n: integer;
  objType: Integer;
begin
  data := '';    {Do not Localize}
  {$IFNDEF HAS_GENERICS_TList}
  SyncMIB;
  {$ENDIF}
  for n := 0 to {$IFDEF HAS_GENERICS_TList}MIBValues{$ELSE}MIBOID{$ENDIF}.Count-1 do
  begin
    objType := GetValueType(n);
    case objType of
      ASN1_INT:
        s := MibIntToASNObject(GetValueOID(n), IndyStrToInt(GetValue(n), 0));
      ASN1_COUNTER, ASN1_GAUGE, ASN1_TIMETICKS:
        s := MibUIntToASNObject(GetValueOID(n), IndyStrToInt(GetValue(n), 0), objType);
      ASN1_OBJID:
        s := MibObjIDToASNObject(GetValueOID(n), GetValue(n));
      ASN1_IPADDR:
        s := MibIPAddrToASNObject(GetValueOID(n), GetValue(n));
      ASN1_NULL:
        s := MibNullToASNObject(GetValueOID(n));
      else
        s := MibStrToASNObject(GetValueOID(n), GetValue(n), objType);
    end;
    data := data + ASNObject(s, ASN1_SEQ);
  end;
  data := ASNObject(ASNEncInt(ID), ASN1_INT)
         + ASNObject(ASNEncInt(ErrorStatus), ASN1_INT)
         + ASNObject(ASNEncInt(ErrorIndex), ASN1_INT)
         + ASNObject(data, ASN1_SEQ);
  data := ASNObject(ASNEncInt(Version), ASN1_INT)
         + ASNObject(Community, ASN1_OCTSTR)
         + ASNObject(data, PDUType);
  data := ASNObject(data, ASN1_SEQ);
  Result := data;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.Clear                                                  |
 |                                                                            |
 | Clear the header info and  MIBOID/Value lists.                             |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.Clear;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LOwner: TIdSNMP;
begin
  LOwner := fOwner;
  Version := 0;
  if LOwner <> nil then begin
    fCommunity := LOwner.Community;
    if Self = LOwner.Trap then begin
      Port := LOwner.TrapPort
    end else begin
      Port := LOwner.Port;
    end;
    Host := LOwner.Host;
  end else begin
    fCommunity := '';
    Port := 0;
    Host := '';
  end;
  PDUType := 0;
  ID := 0;
  ErrorStatus := 0;
  ErrorIndex := 0;
  {$IFDEF HAS_GENERICS_TList}
  MIBValues.Clear;
  {$ELSE}
  MIBOID.Clear;
  MIBValue.Clear;
  {$ENDIF}
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
procedure TSNMPInfo.MIBAdd(MIB, Value: string; ValueType: Integer);
{$IFNDEF HAS_GENERICS_TList}
var
  x: integer;
{$ENDIF}
begin
  {$IFDEF HAS_GENERICS_TList}
  MIBValues.Add(TIdMIBValue.Create(MIB, Value, ValueType));
  {$ELSE}
  SyncMIB;
  MIBOID.Add(MIB);
  x := MIBOID.Count;
  if MIBValue.Count > x then
  begin
    MIBValue[x-1] := Value;
    MIBValue.Objects[x-1] := TObject(ValueType);
  end else
  begin
    MIBValue.AddObject(Value, TObject(ValueType));
  end;
  {$ENDIF}
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.MIBDelete                                              |
 |                                                                            |
 | Delete a MIBOID/Value pair                                                 |
 |                                                                            |
 | Parameters:                                                                |
 |   Index:integer                      The index of the pair to delete       |
 *----------------------------------------------------------------------------*)
procedure TSNMPInfo.MIBDelete(Index: integer);
begin
  {$IFDEF HAS_GENERICS_TList}
  MIBValues.Delete(Index);
  {$ELSE}
  SyncMIB;
  MIBOID.Delete(Index);
  if (MIBValue.Count-1) >= Index then begin
    MIBValue.Delete(Index);
  end;
  {$ENDIF}
end;

(*----------------------------------------------------------------------------*
 | function TSNMPInfo.MIBGet                                                  |
 |                                                                            |
 | Get a string representation of the value of the specified MIBOID           |
 |                                                                            |
 | Parameters:                                                                |
 |   MIB:string                         The MIBOID to query                   |
 |                                                                            |
 | The function returns the string representation of the value.               |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.MIBGet(MIB: string): string;
var
  x: integer;
begin
  {$IFDEF HAS_GENERICS_TList}
  Result := '';    {Do not Localize}
  for x := 0 to MIBValues.Count-1 do begin
    if TextIsSame(MIBValues[x].OID, MIB) then begin
      Result := MIBValues[x].Value;
      Exit;
    end;
  end;
  {$ELSE}
  SyncMIB;
  x := MIBOID.IndexOf(MIB);
  if x < 0 then begin
    Result := '';    {Do not Localize}
  end else begin
    Result := MIBValue[x];
  end;
  {$ENDIF}
end;

{======================= TRAPS =====================================}

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.EncodeTrap                                             |
 |                                                                            |
 | Encode the trap details into an ASN string - the 'Buffer' member           |
 |                                                                            |
 | The function returns 1 for historical reasons!                             |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.EncodeTrap: Boolean;
var
  s: string;
  n: integer;
  objType: Integer;
begin
  Buffer := '';    {Do not Localize}
  for n := 0 to {$IFDEF HAS_GENERICS_TList}MIBValues{$ELSE}MIBOID{$ENDIF}.Count-1 do
  begin
    objType := GetValueType(n);
    case objType of
      ASN1_INT:
        s := MibIntToASNObject(GetValueOID(n), IndyStrToInt(GetValue(n), 0));
      ASN1_COUNTER, ASN1_GAUGE, ASN1_TIMETICKS:
        s := MibUIntToASNObject(GetValueOID(n), IndyStrToInt(GetValue(n), 0), objType);
      ASN1_OBJID:
        s := MibObjIDToASNObject(GetValueOID(n), GetValue(n));
      ASN1_IPADDR:
        s := MibIPAddrToASNObject(GetValueOID(n), GetValue(n));
      ASN1_NULL:
        s := MibNullToASNObject(GetValueOID(n));
      else
        s := MibStrToASNObject(GetValueOID(n), GetValue(n), objType);
    end;
    Buffer := Buffer + ASNObject(s, ASN1_SEQ);
  end;
  Buffer := ASNObject(MibToID(Enterprise), ASN1_OBJID)
    + ASNObject(IPToID(Host), ASN1_IPADDR)
    + ASNObject(ASNEncInt(GenTrap), ASN1_INT)
    + ASNObject(ASNEncInt(SpecTrap), ASN1_INT)
    + ASNObject(ASNEncInt(TimeTicks), ASN1_TIMETICKS)
    + ASNObject(Buffer, ASN1_SEQ);
  Buffer := ASNObject(ASNEncInt(Version), ASN1_INT)
    + ASNObject(Community, ASN1_OCTSTR)
    + ASNObject(Buffer, PDUType);
  Buffer := ASNObject(Buffer, ASN1_SEQ);
  Result := True;
end;

(*----------------------------------------------------------------------------*
 | procedure TSNMPInfo.DecodeTrap                                             |
 |                                                                            |
 | Decode the 'Buffer' trap string to fil in our member variables.            |    {Do not Localize}
 |                                                                            |
 | The function returns 1.                                                    |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.DecodeTrap: Boolean;
var
  Pos, EndPos, vt: integer;
  Sm, Sv: string;
begin
  Pos := 2;
  EndPos := ASNDecLen(Pos, Buffer);
  Version := IndyStrToInt(ASNItem(Pos, Buffer, vt), 0);
  Community := ASNItem(Pos, Buffer, vt);
  PDUType := IndyStrToInt(ASNItem(Pos, Buffer, vt), PDUTRAP);
  Enterprise := ASNItem(Pos, Buffer, vt);
  Host := ASNItem(Pos, Buffer, vt);
  GenTrap := IndyStrToInt(ASNItem(Pos, Buffer, vt), 0);
  Spectrap := IndyStrToInt(ASNItem(Pos, Buffer, vt), 0);
  TimeTicks := IndyStrToInt(ASNItem(Pos, Buffer, vt), 0);
  ASNItem(Pos, Buffer, vt);
  while Pos < EndPos do
  begin
    ASNItem(Pos, Buffer, vt);
    Sm := ASNItem(Pos, Buffer, vt);
    Sv := ASNItem(Pos, Buffer, vt);
    MIBAdd(Sm, Sv, vt);
  end;
  Result := True;
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
  if fCommunity <> Value then
  begin
    Clear;
    fCommunity := Value;
  end;
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
{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdSNMP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdSNMP.InitComponent;
begin
  inherited InitComponent;
  Port := 161;
  fTrapPort := 162;
  fCommunity := 'public';    {Do not Localize}
  Query := TSNMPInfo.Create(Self);
  Reply := TSNMPInfo.Create(Self);
  Trap  := TSNMPInfo.Create(Self);
  Query.Clear;
  Reply.Clear;
  Trap.Clear;
  FReceiveTimeout := 5000;
end;

(*----------------------------------------------------------------------------*
 |  destructor TIdSNMP.Destroy                                                |
 |                                                                            |
 |  Destructor for TIdSNMP component                                          |
 *----------------------------------------------------------------------------*)
destructor TIdSNMP.Destroy;
begin
  FreeAndNil(Reply);
  FreeAndNil(Query);
  FreeAndNil(Trap);
  inherited Destroy;
end;

(*----------------------------------------------------------------------------*
 | function TIdSNMP.GetBinding                                                |
 |                                                                            |
 | Prepare socket handles for use.                                            |
 *----------------------------------------------------------------------------*)
function TIdSNMP.GetBinding: TIdSocketHandle;
begin
  Result := inherited GetBinding;
  if fTrapRecvBinding = nil then begin
    fTrapRecvBinding := TIdSocketHandle.Create(nil);
  end;
  if (not fTrapRecvBinding.HandleAllocated) and (fTrapPort <> 0) then begin
    fTrapRecvBinding.IPVersion := Result.IPVersion;
    fTrapRecvBinding.AllocateSocket(Id_SOCK_DGRAM);
    fTrapRecvBinding.IP := Result.IP;
    fTrapRecvBinding.Port := fTrapPort;
    fTrapRecvBinding.Bind;
  end;
end;

(*----------------------------------------------------------------------------*
 | procedure TIdSNMP.CloseBinding                                             |
 |                                                                            |
 | Clean up socket handles.                                                   |
 *----------------------------------------------------------------------------*)
procedure TIdSNMP.CloseBinding;
begin
  FreeAndNil(fTrapRecvBinding);
  inherited CloseBinding;
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
function TIdSNMP.SendQuery: Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Reply.Clear;
  Query.Buffer := Query.EncodeBuf;
  LEncoding := IndyTextEncoding_8Bit;
  Send(Query.Host, Query.Port, Query.Buffer, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  try
    Reply.Buffer := ReceiveString(Reply.Host, Reply.Port, FReceiveTimeout, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  except
    on e : EIdSocketError do
    begin
      if e.LastError = 10054 then begin
        Reply.Buffer := '';    {Do not Localize}
      end else begin
        raise;
      end;
    end;
  end;

  if Reply.Buffer <> '' then begin
    Reply.DecodeBuf(Reply.Buffer);    {Do not Localize}
  end;
  Result := (Reply.Buffer <> '') and (Reply.ErrorStatus = 0);    {Do not Localize}
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
function TIdSNMP.QuickSend (const Mib, DestCommunity, DestHost: string; var Value: string): Boolean;
begin
  Community := DestCommunity;
  Host := DestHost;
  Query.Clear;
  Query.PDUType := PDUGetRequest;
  Query.MIBAdd(MIB, '');    {Do not Localize}
  Result := SendQuery;
  if Result then begin
    Value := Reply.MIBGet(MIB);
  end;
end;

(*----------------------------------------------------------------------------*
 | TIdSNMP.SendTrap                                                           |
 |                                                                            |
 | Send an SNMP trap.                                                         |
 |                                                                            |
 | The function returns 1                                                     |
 *----------------------------------------------------------------------------*)
function TIdSNMP.SendTrap: Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Trap.PDUType := PDUTrap;
  Trap.EncodeTrap;
  LEncoding := IndyTextEncoding_8Bit;
  Send(Trap.Host, Trap.Port, Trap.Buffer, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  Result := True;
end;

function TIdSNMP.ReceiveTrap: Boolean;
var
  i, LMSec: Integer;
  LBuffer : TIdBytes;
  LIPVersion: TIdIPVersion;
begin
  Result := False;

  Trap.Clear;
  Trap.PDUType := PDUTrap;

  LMSec := ReceiveTimeOut;
  if (LMSec = IdTimeoutDefault) or (LMSec = 0) then begin
    LMSec := IdTimeoutInfinite;
  end;

  GetBinding; // make sure fTrapBinding is allocated
  SetLength(LBuffer, BufferSize);

  if not fTrapRecvBinding.Readable(LMSec) then begin
    Trap.Host := '';    {Do not Localize}
    Trap.Port := 0;
    Exit;
  end;

  i := fTrapRecvBinding.RecvFrom(LBuffer, Trap.Host, Trap.Port, LIPVersion);
  Trap.Buffer := BytesToString(LBuffer, 0, i, IndyTextEncoding_8Bit);
  if Trap.Buffer <> '' then begin    {Do not Localize}
    Trap.DecodeTrap;
    Result := True;
  end;
end;

function TIdSNMP.QuickSendTrap(const DestHost, Enterprise, DestCommunity: string;
  DestPort: TIdPort; Generic, Specific: integer;
  {$IFDEF HAS_GENERICS_TList}
  MIBValues: TIdMIBValueList
  {$ELSE}
  MIBName, MIBValue: TStrings
  {$ENDIF}
  ): Boolean;
var
  i: integer;
begin
  Trap.Clear;
  Trap.Host := DestHost;
  Trap.Port := DestPort;
  Trap.Community := DestCommunity;
  Trap.Enterprise := Enterprise;
  Trap.GenTrap := Generic;
  Trap.SpecTrap := Specific;
  for i := 0 to {$IFDEF HAS_GENERICS_TList}MIBValues{$ELSE}MIBName{$ENDIF}.Count-1 do begin
    Trap.MIBAdd(
      {$IFDEF HAS_GENERICS_TList}
      MIBValues[i].OID, MIBValues[i].Value, MIBValues[i].ValueType
      {$ELSE}
      MIBName[i], MIBValue[i], PtrInt(MIBValue.Objects[i])
      {$ENDIF}
    );
  end;
  Result := SendTrap;
end;

function TIdSNMP.QuickReceiveTrap(var SrcHost, Enterprise, SrcCommunity: string;
  var SrcPort: TIdPort; var Generic, Specific, Seconds: integer;
  {$IFDEF HAS_GENERICS_TList}
  MIBValues: TIdMIBValueList
  {$ELSE}
  MIBName, MIBValue: TStrings
  {$ENDIF}
  ): Boolean;
var
  i: integer;
begin
  Result := ReceiveTrap;
  if Result then
  begin
    SrcHost := Trap.Host;
    SrcPort := Trap.Port;
    Enterprise := Trap.Enterprise;
    SrcCommunity := Trap.Community;
    Generic := Trap.GenTrap;
    Specific := Trap.SpecTrap;
    Seconds := Trap.TimeTicks;
    {$IFDEF HAS_GENERICS_TList}
    MIBValues.Clear;
    {$ELSE}
    MIBName.Clear;
    MIBValue.Clear;
    {$ENDIF}
    for i := 0 to Trap.{$IFDEF HAS_GENERICS_TList}MIBValues{$ELSE}MIBOID{$ENDIF}.Count-1 do
    begin
      {$IFDEF HAS_GENERICS_TList}
      MIBValues.Add(TIdMIBValue.Create(Trap.ValueOID[i], Trap.Value[i], Trap.ValueType[i]));
      {$ELSE}
      MIBName.Add(Trap.ValueOID[i]);
      MIBValue.AddObject(Trap.Value[i], TObject(Trap.ValueType[i]));
      {$ENDIF}
    end;
  end;
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValue                                                         |
 |                                                                            |
 | Return string representation of value 'idx'                                |
 |                                                                            |
 | Parameters:                                                                |
 |   idx : Integer              The value to get                              |
 |                                                                            |
 | The function returns the string representation of the value.               |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValue (idx : Integer) : string;
begin
  {$IFDEF HAS_GENERICS_TList}
  Result := MIBValues[idx].Value;
  {$ELSE}
  Result := MIBValue[idx];
  {$ENDIF}
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
  {$IFDEF HAS_GENERICS_TList}
  Result := MIBValues.Count;
  {$ELSE}
  Result := MIBValue.Count;
  {$ENDIF}
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValueType                                                     |
 |                                                                            |
 | Return the 'type' of value 'idx'                                           |
 |                                                                            |
 | Parameters:                                                                |
 |   idx : Integer              The value type to get                         |
 |                                                                            |
 | The function returns the value type.                                       |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValueType (idx : Integer): Integer;
begin
  {$IFDEF HAS_GENERICS_TList}
  Result := MIBValues[idx].ValueType;
  {$ELSE}
  Result := Integer(MIBValue.Objects[idx]);
  {$ENDIF}
  if Result = 0 then begin
    Result := ASN1_OCTSTR;
  end;
end;

(*----------------------------------------------------------------------------*
 | TSNMPInfo.GetValueOID                                                      |
 |                                                                            |
 | Get the MIB OID for value 'idx'                                            |
 |                                                                            |
 | Parameters:                                                                |
 |   idx: Integer               The MIB OID to gey                            |
 |                                                                            |
 | The function returns the specified MIB OID                                 |
 *----------------------------------------------------------------------------*)
function TSNMPInfo.GetValueOID(idx: Integer): string;
begin
  {$IFDEF HAS_GENERICS_TList}
  Result := MIBValues[idx].OID;
  {$ELSE}
  Result := MIBOID[idx];
  {$ENDIF}
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

(*----------------------------------------------------------------------------*
 | TIdSNMP.SetTrapPort                                                        |
 |                                                                            |
 | Setter for the TrapPort property.                                          |
 |                                                                            |
 | Parameters:                                                                |
 |   const Value: TIdPort       The new port value                            |
 *----------------------------------------------------------------------------*)
procedure TIdSNMP.SetTrapPort(const AValue: TIdPort);
begin
  if fTrapPort <> AValue then begin
    if Assigned(fTrapRecvBinding) then begin
      fTrapRecvBinding.CloseSocket;
    end;
    fTrapPort := AValue;
  end;
end;

end.
