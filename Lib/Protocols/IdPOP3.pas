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
  Rev 1.39    1/7/05 3:29:12 PM  RLebeau
  Fix for AV in Notification()

  Rev 1.38    12/21/04 1:51:42 AM  RLebeau
  Bug fix for Capa() method.

  Rev 1.37    11/27/04 2:48:22 AM  RLebeau
  Fixed bug in ownership of SASLMechanisms property

  Rev 1.36    10/26/2004 10:35:42 PM  JPMugaas
  Updated ref.

  Rev 1.35    2004.04.18 1:39:26 PM  czhower
  Bug fix for .NET with attachments, and several other issues found along the
  way.

  Rev 1.34    2004.04.07 6:02:42 PM  czhower
  Implemented AutoLogin in a better manner.

  Rev 1.33    2004.04.07 5:53:56 PM  czhower
  .NET overload

  Rev 1.32    2004.03.06 1:31:48 PM  czhower
  To match Disconnect changes to core.

  Rev 1.31    2004.02.03 5:44:12 PM  czhower
  Name changes

  Rev 1.30    2004.02.03 2:12:18 PM  czhower
  $I path change

  Rev 1.29    1/25/2004 3:11:36 PM  JPMugaas
  SASL Interface reworked to make it easier for developers to use.
  SSL and SASL reenabled components.

  Rev 1.28    1/21/2004 3:27:06 PM  JPMugaas
  InitComponent

  Rev 1.27    1/12/04 12:22:40 PM  RLebeau
  Updated RetrieveMailboxSize() and RetrieveMsgSize() to support responses that
  contain additional data after the octet values.

  Rev 1.26    22/12/2003 00:45:12  CCostelloe
  .NET fixes

    Rev 1.25    10/19/2003 5:42:36 PM  DSiders
  Added localization comments.

  Rev 1.24    10/11/2003 7:14:34 PM  BGooijen
  Changed IdCompilerDefines.inc path

  Rev 1.23    10/10/2003 11:39:40 PM  BGooijen
  Compiles in DotNet now

  Rev 1.22    6/15/2003 01:17:10 PM  JPMugaas
  Intermediate class no longer used.  We use the SASL functionality right from
  the TIdSASLList.

  Rev 1.21    6/4/2003 04:10:36 PM  JPMugaas
  Removed hacked GetInternelResponse.

  Updated to use Kudzu's new string reply code.

  Rev 1.20    5/26/2003 04:28:16 PM  JPMugaas
  Removed GenerateReply and ParseResponse calls because those functions are
  being removed.

  Rev 1.19    5/26/2003 12:23:58 PM  JPMugaas

  Rev 1.18    5/25/2003 03:54:46 AM  JPMugaas

  Rev 1.17    5/25/2003 03:45:56 AM  JPMugaas

  Rev 1.16    5/22/2003 05:27:52 PM  JPMugaas

  Rev 1.16    5/20/2003 02:29:42 PM  JPMugaas
  Updated with POP3Reply object.

  Rev 1.15    5/10/2003 10:10:46 PM  JPMugaas
  Bug fixes.

  Rev 1.14    5/8/2003 08:44:16 PM  JPMugaas
  Moved some SASL authentication code down to an anscestor for reuse.  WIll
  clean up soon.

  Rev 1.13    5/8/2003 03:18:14 PM  JPMugaas
  Flattened ou the SASL authentication API, made a custom descendant of SASL
  enabled TIdMessageClient classes.

  Rev 1.12    5/8/2003 11:28:10 AM  JPMugaas
  Moved feature negoation properties down to the ExplicitTLSClient level as
  feature negotiation goes hand in hand with explicit TLS support.

  Rev 1.11    5/8/2003 03:03:00 AM  JPMugaas
  Fixed a problem with SASL.  It turns out that what was being processed with
  something from a previous command.  It also turned out that some charactors
  were being removed from the SASL processing when they shouldn't have been.

  Rev 1.10    5/8/2003 02:18:08 AM  JPMugaas
  Fixed an AV in IdPOP3 with SASL list on forms.  Made exceptions for SASL
  mechanisms missing more consistant, made IdPOP3 support feature feature
  negotiation, and consolidated some duplicate code.

  Rev 1.9    5/7/2003 04:58:34 AM  JPMugaas
  We now use the initial greeting message from the server when calculating the
  parameter for the APOP command.  Note that we were calling CAPA before APOP
  and that could throw things off.

  Rev 1.8    4/5/2003 02:06:24 PM  JPMugaas
  TLS handshake itself can now be handled.

  Rev 1.7    3/27/2003 05:46:40 AM  JPMugaas
  Updated framework with an event if the TLS negotiation command fails.
  Cleaned up some duplicate code in the clients.

  Rev 1.6    3/19/2003 08:53:40 PM  JPMugaas
  Now should work with new framework.

  Rev 1.5    3/17/2003 02:25:26 PM  JPMugaas
  Updated to use new TLS framework.  Now can require that users use TLS.  Note
  that this setting create an incompatiability with Norton AntiVirus because
  that does act as a "man in the middle" when intercepting E-Mail for virus
  scanning.

  Rev 1.4    3/13/2003 09:49:26 AM  JPMugaas
  Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
  can plug-in their products.

  Rev 1.3    2/24/2003 09:27:58 PM  JPMugaas

  Rev 1.2    12/15/2002 04:27:10 PM  JPMugaas
  POP3 now compiles and works in Indy 10.

  Rev 1.1    12-15-2002 12:57:40  BGooijen
  Added Top-command

  Rev 1.0    11/13/2002 07:58:22 AM  JPMugaas

  2002-08-18 - J. Berg
   - implement SASL, add CAPA and STLS

  02 August 2002 - A. Neillans
   - Bug fix:
     [ 574171 ] TIdMessage not cleared before a retreive

  11-10-2001 - J. Peter Mugaas
    Added suggested code from Andrew P.Rybin that does the following:
    -APOP Authentication Support
    -unrecognized text header now displayed in exception message
    -GetUIDL method

  2001-AUG-31 DSiders
    Changed TIdPOP3.Connect to use ATimeout when calling
    inherited Connect.

  2000-SEPT-28 SG
    Added GetUIDL as from code by

  2000-MAY-10 HH
    Added RetrieveMailBoxSize and renamed RetrieveSize to RetrieveMsgSize.
    Finished Connect.

  2000-MARCH-03 HH
    Converted to Indy
}

unit IdPOP3;

{ POP 3 (Post Office Protocol Version 3) }

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers,
  IdGlobal,
  IdException,
  IdExplicitTLSClientServerBase,
  IdGlobalProtocols,
  IdMessage,
  IdMessageClient,
  IdReply,
  IdSASL,
  IdSASLCollection,
  IdBaseComponent,
  IdUserPassProvider;

type
  TIdPOP3AuthenticationType = (patUserPass, patAPOP, patSASL);

const
  DEF_POP3USE_IMPLICIT_TLS = False;
  DEF_ATYPE = patUserPass;

type
  TIdPOP3 = class(TIdMessageClient)
  protected
    FAuthType : TIdPOP3AuthenticationType;
    FAutoLogin: Boolean;
    FAPOPToken : String; 
    FHasAPOP: Boolean;
    FHasCAPA: Boolean;
    FSASLMechanisms : TIdSASLEntries;
    //
    function GetReplyClass:TIdReplyClass; override;
    function GetSupportsTLS: Boolean; override;
    procedure SetSASLMechanisms(AValue: TIdSASLEntries);
    procedure InitComponent; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function CheckMessages: Integer;
    procedure Connect; override;
    procedure Login; virtual;
    destructor Destroy; override;
    function Delete(const MsgNum: Integer): Boolean;
    procedure DisconnectNotifyPeer; override;
    procedure KeepAlive;
    function List(const ADest: TStrings; const AMsgNum: Integer = -1): Boolean;
    procedure ParseLIST(ALine: String; var VMsgNum: Integer; var VMsgSize: Int64);
    procedure ParseUIDL(ALine: String; var VMsgNum: Integer; var VUidl: String);
    function Reset: Boolean;
    function Retrieve(const MsgNum: Integer; AMsg: TIdMessage): Boolean;
    function RetrieveHeader(const MsgNum: Integer; AMsg: TIdMessage): Boolean;
    function RetrieveMsgSize(const MsgNum: Integer): Int64;
    function RetrieveMailBoxSize: Int64;
    function RetrieveRaw(const aMsgNo: Integer; const aDest: TStrings): boolean; overload;
    function RetrieveRaw(const aMsgNo: Integer; const aDest: TStream): boolean; overload;
    function RetrieveStats(var VMsgCount: Integer; var VMailBoxSize: Int64): Boolean;
    function UIDL(const ADest: TStrings; const AMsgNum: Integer = -1): Boolean;
    function Top(const AMsgNum: Integer; const ADest: TStrings; const AMaxLines: Integer = 0): boolean;
    function CAPA: Boolean;
    property HasAPOP: boolean read FHasAPOP;
    property HasCAPA: boolean read FHasCAPA;
  published
    property AuthType : TIdPOP3AuthenticationType read FAuthType write FAuthType default DEF_ATYPE;
    property AutoLogin: Boolean read FAutoLogin write FAutoLogin default True;
    property Host;
    property Username;
    property UseTLS;
    property Password;
    property Port default IdPORT_POP3;
    property SASLMechanisms : TIdSASLEntries read FSASLMechanisms write SetSASLMechanisms;
  end;

type
  EIdPOP3Exception = class(EIdException);
  EIdDoesNotSupportAPOP = class(EIdPOP3Exception);
  EIdUnrecognizedReply = class(EIdPOP3Exception);

implementation

uses
  IdFIPS,
  IdHash,
  IdHashMessageDigest,
  IdTCPConnection,
  IdSSL,
  IdResourceStringsProtocols,
  IdReplyPOP3,
  IdCoderMIME,
  SysUtils;

{ TIdPOP3 }

function TIdPOP3.CheckMessages: Integer;
var
  LIgnore: Int64;
begin
  // RLebeau: for backwards compatibility, raise an exception if STAT fails
  if not RetrieveStats(Result, LIgnore) then begin
    RaiseExceptionForLastCmdResult;
  end;
  // Only gets here if exception is not raised
end;

procedure TIdPOP3.Login;
var
  S: String;
  LMD5: TIdHashMessageDigest5;
begin
  if UseTLS in ExplicitTLSVals then begin
    if SupportsTLS then begin
      if SendCmd('STLS','') = ST_OK then begin {Do not translate}
        TLSHandshake;
        //obtain capabilities again - RFC2595
        CAPA;
      end else begin
        ProcessTLSNegCmdFailed;
      end;
    end else begin
      ProcessTLSNotAvail;
    end;
  end;

  case FAuthType of
    patAPOP:  //APR
      begin
        if FHasAPOP then begin
          CheckMD5Permitted;
          LMD5 := TIdHashMessageDigest5.Create;
          try
            S := LowerCase(LMD5.HashStringAsHex(FAPOPToken+Password));
          finally
            LMD5.Free;
          end;//try
          SendCmd('APOP ' + Username + ' ' + S, ST_OK);    {Do not Localize}
        end else begin
          raise EIdDoesNotSupportAPOP.Create(RSPOP3ServerDoNotSupportAPOP);
        end;
      end;
    patUserPass:
      begin //classic method
        SendCmd('USER ' + Username, ST_OK);    {Do not Localize}
        SendCmd('PASS ' + Password, ST_OK);    {Do not Localize}
      end;//if APOP
    patSASL:
      begin
        // SASL in POP3 did not originally support Initial-Response. It was added
        // in RFC 2449 along with the CAPA command. If a server supports the CAPA
        // command then it *should* also support Initial-Response as well, however
        // many POP3 servers support CAPA but do not support Initial-Response
        // (which was formalized in RFC 5034). So, until we can handle that
        // descrepency better, we will simply disable Initial-Response for now.

        FSASLMechanisms.LoginSASL('AUTH', FHost, IdGSKSSN_pop, [ST_OK], [ST_SASLCONTINUE], Self, Capabilities, 'SASL'); {do not localize}
      end;
  end;
end;

procedure TIdPOP3.InitComponent;
begin
  inherited;
  FAutoLogin := True;
  FSASLMechanisms := TIdSASLEntries.Create(Self);
  FRegularProtPort := IdPORT_POP3;
  FImplicitTLSProtPort := IdPORT_POP3S;
  FExplicitTLSProtPort := IdPORT_POP3;
  Port := IdPORT_POP3;
  FAuthType := DEF_ATYPE;
end;

function TIdPOP3.Delete(const MsgNum: Integer): Boolean;
begin
  Result := (SendCmd('DELE ' + IntToStr(MsgNum), '') = ST_OK);   {do not localize}
end;

procedure TIdPOP3.DisconnectNotifyPeer;
begin
  inherited DisconnectNotifyPeer;
  SendCmd('QUIT', ST_OK);    {do not localize}
end;

function TIdPOP3.GetReplyClass:TIdReplyClass;
begin
  Result := TIdReplyPOP3;
end;

procedure TIdPOP3.KeepAlive;
begin
  SendCmd('NOOP', ST_OK);    {Do not Localize}
end;

function TIdPOP3.Reset: Boolean;
begin
  Result := (SendCmd('RSET', '') = ST_OK);    {Do not Localize}
end;

function TIdPOP3.RetrieveRaw(const aMsgNo: Integer; const aDest: TStrings): boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := (SendCmd('RETR ' + IntToStr(aMsgNo), '') = ST_OK);    {Do not Localize}
  if Result then begin
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(aDest, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdPOP3.RetrieveRaw(const aMsgNo: Integer; const aDest: TStream): boolean;
var
  LEncoding: IIdTextEncoding;
begin
  Result := (SendCmd('RETR ' + IntToStr(aMsgNo), '') = ST_OK);    {Do not Localize}
  if Result then begin
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(aDest, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

function TIdPOP3.Retrieve(const MsgNum: Integer; AMsg: TIdMessage): Boolean;
begin
  Result := (SendCmd('RETR ' + IntToStr(MsgNum), '') = ST_OK);   {Do not Localize}
  if Result then begin
    AMsg.Clear;
    // This is because of a bug in Exchange? with empty messages. See comment in ReceiveHeader
    if ReceiveHeader(AMsg) = '' then begin
      // Only retreive the body if we do not already have a full RFC
      ReceiveBody(AMsg);
    end;
  end;
end;

function TIdPOP3.RetrieveHeader(const MsgNum: Integer; AMsg: TIdMessage): Boolean;
begin
//  Result := False;
  AMsg.Clear;
  SendCmd('TOP ' + IntToStr(MsgNum) + ' 0', ST_OK);    {Do not Localize}
  // Only gets here if no exception is raised
  ReceiveHeader(AMsg,'.');
  Result := True;
end;

function TIdPOP3.RetrieveMailBoxSize: Int64;
var
  LIgnore: Integer;
begin
  // RLebeau: for backwards compatibility, return -1 if STAT fails
  try
    if not RetrieveStats(LIgnore, Result) then begin
      RaiseExceptionForLastCmdResult;
    end;
  except
    Result := -1;
  end;
end;

function TIdPOP3.RetrieveMsgSize(const MsgNum: Integer): Int64;
var
  s: string;
begin
  Result := -1;
  // Returns the size of the message. if an error ocurrs, returns -1.
  SendCmd('LIST ' + IntToStr(MsgNum), ST_OK);    {Do not Localize}
  s := LastCmdResult.Text[0];
  if Length(s) > 0 then begin
    // RL - ignore the message number, grab just the octets,
    // and ignore everything else that may be present
    Fetch(s);
    Result := IndyStrToInt64(Fetch(s), -1);
  end;
end;

function TIdPOP3.RetrieveStats(var VMsgCount: Integer; var VMailBoxSize: Int64): Boolean;
var
  s: string;
begin
  VMsgCount := 0;
  VMailBoxSize := 0;
  Result := (SendCmd('STAT', '') = ST_OK);    {Do not Localize}
  if Result then begin
    s := LastCmdResult.Text[0];
    if Length(s) > 0 then begin
      VMsgCount := IndyStrToInt(Fetch(s));
      VMailBoxSize := IndyStrToInt64(Fetch(s));
    end;
  end;
end;

function TIdPOP3.List(const ADest: TStrings; const AMsgNum: Integer = -1): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  if AMsgNum >= 0 then begin
    Result := (SendCmd('LIST ' + IntToStr(AMsgNum), '') = ST_OK);    {Do not Localize}
    if Result then begin
      ADest.Assign(LastCmdResult.Text);
    end;
  end
  else begin
    Result := (SendCmd('LIST', '') = ST_OK);    {Do not Localize}
    if Result then begin
      LEncoding := IndyTextEncoding_8Bit;
      IOHandler.Capture(ADest, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
    end;
  end;
end;

procedure TIdPOP3.ParseLIST(ALine: String; var VMsgNum: Integer; var VMsgSize: Int64);
begin
  VMsgNum := IndyStrToInt(Fetch(ALine), -1);
  VMsgSize := IndyStrToInt64(Fetch(ALine), -1);
end;

function TIdPOP3.UIDL(const ADest: TStrings; const AMsgNum: Integer = -1): Boolean;
var
  LEncoding: IIdTextEncoding;
begin
  if AMsgNum >= 0 then begin
    Result := (SendCmd('UIDL ' + IntToStr(AMsgNum), '') = ST_OK);    {Do not Localize}
    if Result then begin
      ADest.Assign(LastCmdResult.Text);
    end;
  end
  else begin
    Result := (SendCmd('UIDL', '') = ST_OK);    {Do not Localize}
    if Result then begin
      LEncoding := IndyTextEncoding_8Bit;
      IOHandler.Capture(ADest, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
    end;
  end;
end;

procedure TIdPOP3.ParseUIDL(ALine: String; var VMsgNum: Integer; var VUidl: String);
begin
  VMsgNum := IndyStrToInt(Fetch(ALine), -1);
  VUidl := Fetch(ALine);
end;

function TIdPOP3.Top(const AMsgNum: Integer; const ADest: TStrings; const AMaxLines: Integer = 0): boolean;
var
  Cmd: String;
  LEncoding: IIdTextEncoding;
begin
  Cmd := 'TOP ' + IntToStr(AMsgNum); {Do not Localize}
  if AMaxLines <> 0 then begin
    Cmd := Cmd + ' ' + IntToStr(AMaxLines); {Do not Localize}
  end;
  Result := (SendCmd(Cmd,'') = ST_OK);
  if Result then begin
    LEncoding := IndyTextEncoding_8Bit;
    IOHandler.Capture(ADest, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
  end;
end;

destructor TIdPOP3.Destroy;
begin
  FreeAndNil(FSASLMechanisms);
  inherited;
end;

function TIdPOP3.CAPA: Boolean;
begin
  FCapabilities.Clear;
  Result := (SendCmd('CAPA','') = ST_OK);    {Do not Localize}
  if Result then begin
    IOHandler.Capture(FCapabilities);
  end;
// RLebeau - do not delete here!  The +OK reply line is handled
// by SendCmd() above.  Deleting here is removing an actual capability entry.
{
  if FCapabilities.Count >0 then
  begin
    //dete the initial OK reply line
    FCapabilities.Delete(0);
  end;
  FHasCapa := Result;
}
  FHasCapa := (FCapabilities.Count > 0);
 // ParseCapaReply(FCapabilities,'SASL');
end;

procedure TIdPOP3.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (FSASLMechanisms <> nil) then begin
    FSASLMechanisms.RemoveByComp(AComponent);
  end;
  inherited Notification(AComponent,Operation);
end;

function TIdPOP3.GetSupportsTLS: Boolean;
begin
   Result := ( FCapabilities.IndexOf('STLS') > -1 ); //do not localize
end;

procedure TIdPOP3.SetSASLMechanisms(AValue: TIdSASLEntries);
begin
  FSASLMechanisms.Assign(AValue);
end;

procedure TIdPOP3.Connect;
var
  S: String;
  I: Integer;
begin
  FHasAPOP := False;
  FHasCAPA := False;
  FAPOPToken := '';

  if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
    (IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := (FUseTLS <> utUseImplicitTLS);
  end;

  inherited Connect;
  try
    GetResponse(ST_OK);

    // the initial greeting text is needed to determine APOP availability
    S := LastCmdResult.Text.Strings[0];  //read response
    I := Pos('<', S);    {Do not Localize}
    if i > 0 then begin
      S := Copy(S, I, MaxInt); //?: System.Delete(S,1,i-1);
      I := Pos('>', S);    {Do not Localize}
      if I > 0 then begin
        FAPOPToken := Copy(S, 1, I);
      end;
    end;
    FHasAPOP := (Length(FAPOPToken) > 0);
    CAPA;
    if FAutoLogin then begin
      Login;
    end;
  except
    Disconnect(False);
    raise;
  end;
end;

end.


