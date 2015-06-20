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
  Rev 1.15    2/13/05 7:21:30 PM  RLebeau
  Updated TIdTelnetReadThread.Run() to use a timeout when calling the
  IOHandler's CheckForDataOnSource() method.

  Rev 1.14    10/07/2004 10:00:28  ANeillans
  Fixed compile bug

  Rev 1.13    7/8/04 4:12:06 PM  RLebeau
  Updated calls to Write() to use the IOHandler

  Rev 1.12    7/4/04 1:38:36 PM  RLebeau
  Updated Negotiate() to trigger the OnDataAvailable event only when data is
  actually available.

  Rev 1.11    5/16/04 3:14:06 PM  RLebeau
  Added destructor to terminate the reading thread

  Rev 1.10    3/29/04 11:47:00 AM  RLebeau
  Updated to support new ThreadedEvent property

  Rev 1.9    2004.03.06 1:31:56 PM  czhower
  To match Disconnect changes to core.

  Rev 1.8    2004.02.03 5:44:32 PM  czhower
  Name changes

  Rev 1.7    1/21/2004 4:20:48 PM  JPMugaas
  InitComponent

  Rev 1.6    2003.11.29 10:20:16 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.5    3/6/2003 5:08:50 PM  SGrobety
  Updated the read buffer methodes to fit the new core (InputBuffer ->
  InputBufferAsString + call to CheckForDataOnSource)

  Rev 1.4    2/24/2003 10:32:46 PM  JPMugaas

  Rev 1.3    12/8/2002 07:26:10 PM  JPMugaas
  Added published host and port properties.

  Rev 1.2    12/7/2002 06:43:30 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.1    12/6/2002 05:30:40 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 08:02:50 AM  JPMugaas

  03-01-2002 Andrew P.Rybin  Renamings and standardization

  26-05-2000 SG: Converted to Indy, no other change

  07-Mar-2000 Mark   Added a bunch of stuff... it's very much a work in progress

  05-Mar-2000 Mark   Added constants for telnet implememtation.

  13-JAN-2000 MTL: Moved to new Palette Scheme (Winshoes Servers)
}

unit IdTelnet;

{
  Author: Mark Holmes
  This is the telnet client component. I'm still testing
  There is no real terminal emulation other than dumb terminal
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers,
  IdGlobal,
  IdException,
  IdStack,
  IdTCPClient, IdThread;

const
  { These are the telnet command constansts from RFC 854 }
  TNC_EOR                = $EF;   // End of Record RFC 885
  TNC_SE                 = $F0;   // End of subnegotiation parameters.
  TNC_NOP                = $F1;   // No operation.
  TNC_DATA_MARK          = $F2;   // The data stream portion of a Synch.
                                  // This should always be accompanied
                                  // by a TCP Urgent notification.
  TNC_BREAK              = $F3;   // NVT character BRK.
  TNC_IP                 = $F4;   // The function IP.
  TNC_AO                 = $F5;   // The function ABORT OUTPUT.
  TNC_AYT                = $F6;   // The function ARE YOU THERE.
  TNC_EC                 = $F7;   // The function ERASE CHARACTER.
  TNC_EL                 = $F8;   // The function ERASE LINE.
  TNC_GA                 = $F9;   // The GO AHEAD signal.
  TNC_SB                 = $FA;   // Indicates that what follows is
                                  // subnegotiation of the indicated
                                  // option.
  TNC_WILL               = $FB;   // Indicates the desire to begin
                                  // performing, or confirmation that
                                  // you are now performing, the
                                  // indicated option.
  TNC_WONT               = $FC;   // Indicates the refusal to perform,
                                  // or continue performing, the
                                  // indicated option.
  TNC_DO                 = $FD;   // Indicates the request that the
                                  // other party perform, or
                                  // confirmation that you are expecting
                                  // the other party to perform, the
                                  // indicated option.
  TNC_DONT               = $FE;   // Indicates the demand that the
                                  // other party stop performing,
                                  // or confirmation that you are no
                                  // longer expecting the other party
                                  // to perform, the indicated option.
  TNC_IAC                = $FF;   // Data Byte 255.

  { Telnet options registered with IANA }
  TNO_BINARY             = $00;        // Binary Transmission
  TNO_ECHO               = $01;        // Echo
  TNO_RECONNECT          = $02;        // Reconnection
  TNO_SGA                = $03;        // Suppress Go Ahead
  TNO_AMSN               = $04;        // Approx Message Size Negotiation
  TNO_STATUS             = $05;        // Status
  TNO_TIMING_MARK        = $06;        // Timing Mark
  TNO_RCTE               = $07;        // Remote Controlled Trans and Echo -BELL
  TNO_OLW                = $08;        // Output Line Width
  TNO_OPS                = $09;        // Output Page Size
  TNO_OCRD               = $0A;       // Output Carriage-Return Disposition
  TNO_OHTS               = $0B;       // Output Horizontal Tab Stops
  TNO_OHTD               = $0C;       // Output Horizontal Tab Disposition
  TNO_OFD                = $0D;       // Output Formfeed Disposition
  TNO_OVT                = $0E;       // Output Vertical Tabstops
  TNO_OVTD               = $0F;       // Output Vertical Tab Disposition
  TNO_OLD                = $10;       // Output Linefeed Disposition
  TNO_EA                 = $11;       // Extended ASCII
  TNO_LOGOUT             = $12;       // Logout
  TNO_BYTE_MACRO         = $13;       // Byte Macro
  TNO_DET                = $14;       // Data Entry Terminal
  TNO_SUPDUP             = $15;       // SUPDUP
  TNO_SUPDUP_OUTPUT      = $16;       // SUPDUP Output
  TNO_SL                 = $17;       // Send Location
  TNO_TERMTYPE           = $18;       // Terminal Type
  TNO_EOR                = $19;       // End of Record
  TNO_TACACS_ID          = $1A;       // TACACS User Identification
  TNO_OM                 = $1B;       // Output Marking
  TNO_TLN                = $1C;       // Terminal Location Number
  TNO_3270REGIME         = $1D;       // 3270 regime
  TNO_X3PAD              = $1E;       // X.3 PAD
  TNO_NAWS               = $1F;       // Window size
  TNO_TERM_SPEED         = $20;       // Terminal speed
  TNO_RFLOW              = $21;       // Remote flow control
  TNO_LINEMODE           = $22;       // Linemode option
  TNO_XDISPLOC           = $23;       // X Display Location
  TNO_ENV                = $24;       // Environment
  TNO_AUTH               = $25;       // Authenticate
  TNO_ENCRYPT            = $26;       // Encryption option
  TNO_NEWENV             = $27;
  TNO_TN3270E            = $28;
  TNO_XAUTH              = $29;
  TNO_CHARSET            = $2A;
  TNO_RSP                = $2B;
  TNO_COMPORT            = $2C;
  TNO_SUPLOCALECHO       = $2D;
  TNO_STARTTLS           = $2E;
  TNO_KERMIT             = $2F;
  TNO_SEND_URL           = $30;
  TNO_FORWARD_X          = $31;
  // 50-137 = Unassigned
  TNO_PRAGMA_LOGON       = $8A;
  TNO_SSPI_LOGON         = $8B;
  TNO_PRAGMA_HEARTBEAT   = $8C;
  TNO_EOL                = $FF;       // Extended-Options-List

  // Sub options
  TNOS_TERM_IS           = $00;
  TNOS_TERMTYPE_SEND     = $01;       // Sub option
  TNOS_REPLY             = $02;
  TNOS_NAME              = $03;

  //Auth commands
  TNOAUTH_IS             = $00;
  TNOAUTH_SEND           = $01;
  TNOAUTH_REPLY          = $02;
  TNOAUTH_NAME           = $03;

  // Auth options  $25
  TNOAUTH_NULL           = $00;
  TNOAUTH_KERBEROS_V4    = $01;
  TNOAUTH_KERBEROS_V5    = $02;
  TNOAUTH_SPX            = $03;
  TNOAUTH_MINK           = $04;
  TNOAUTH_SRP            = $05;
  TNOAUTH_RSA            = $06;
  TNOAUTH_SSL            = $07;
  TNOAUTH_LOKI           = $0A;
  TNOAUTH_SSA            = $0B;
  TNOAUTH_KEA_SJ         = $0C;
  TNOAUTH_KEA_SJ_INTEG   = $0D;
  TNOAUTH_DSS            = $0E;
  TNOAUTH_NTLM           = $0F;

  //Kerberos4 Telnet Authentication suboption commands
  TNOAUTH_KRB4_AUTH      = $00;
  TNOAUTH_KRB4_REJECT    = $01;
  TNOAUTH_KRB4_ACCEPT    = $02;
  TNOAUTH_KRB4_CHALLENGE = $03;
  TNOAUTH_KRB4_RESPONSE  = $04;
  TNOAUTH_KRB4_FORWARD   = $05;
  TNOAUTH_KRB4_FORWARD_ACCEPT = $06;
  TNOAUTH_KRB4_FORWARD_REJECT = $07;
  TNOAUTH_KRB4_EXP       = $08;
  TNOAUTH_KRB4_PARAMS    = $09;

  //Kerberos5 Telnet Authentication suboption commands
  TNOAUTH_KRB5_AUTH      = $00;
  TNOAUTH_KRB5_REJECT    = $01;
  TNOAUTH_KRB5_ACCEPT    = $02;
  TNOAUTH_KRB5_RESPONSE  = $03;
  TNOAUTH_KRB5_FORWARD   = $04;
  TNOAUTH_KRB5_FORWARD_ACCEPT = $05;
  TNOAUTH_KRB5_FORWARD_REJECT = $06;

  //DSS Telnet Authentication suboption commands
  TNOAUTH_DSS_INITIALIZE = $01;
  TNOAUTH_DSS_TOKENBA    = $02;
  TNOAUTH_DSS_CERTA_TOKENAB = $03;
  TNOAUTH_DSS_CERTB_TOKENBA2 = $04;

  //SRP Telnet Authentication suboption commands
  TNOAUTH_SRP_AUTH       = $00;
  TNOAUTH_SRP_REJECT     = $01;
  TNOAUTH_SRP_ACCEPT     = $02;
  TNOAUTH_SRP_CHALLENGE  = $03;
  TNOAUTH_SRP_RESPONSE   = $04;
  TNOAUTH_SRP_EXP        = $08;
  TNOAUTH_SRP_PARAMS     = $09;

  // KEA_SJ and KEA_SJ_INTEG Telnet Authenticatio suboption commands
  TNOAUTH_KEA_CERTA_RA   = $01;
  TNOAUTH_KEA_CERTB_RB_IVB_NONCEB  = $02;
  TNOAUTH_KEA_IVA_RESPONSEB_NONCEA = $03;
  TNOAUTH_KEA_RESPONSEA  = $04;

  //Telnet Encryption Types (Option 38)
  //  commands
  TNOENC_IS              = $00;
  TNOENC_SUPPORT         = $01;
  TNOENC_REPLY           = $02;
  TNOENC_START           = $03;
  TNOENC_END             = $04;
  TNOENC_REQUEST_START   = $05;
  TNOENC_REQUEST_END     = $06;
  TNOENC_ENC_KEYID       = $07;
  TNOENC_DEC_KEYID       = $08;
  //  types
  TNOENC_NULL            = $00;
  TNOENC_DES_CFB64       = $01;
  TNOENC_DES_OFB64       = $02;
  TNOENC_DES3_CFB64      = $03;
  TNOENC_DES3_OFB64      = $04;
  TNOENC_CAST5_40_CFB64  = $08;
  TNOENC_CAST5_40_OFB64  = $09;
  TNOENC_CAST128_CFB64   = $0A;
  TNOENC_CAST128_OFB64   = $0B;
  TNOENC_AES_CCM         = $0C;

  //DES3_CFB64 Telnet Encryption type suboption commands
  TNOENC_CFB64_IV        = $01;
  TNOENC_CFB64_IV_OK     = $02;
  TNOENC_CFB64_IV_BAD    = $03;

  //CAST5_40_OFB64 and CAST128_OFB64 Telnet Encryption types suboption commands
  TNOENC_OFB64_IV        = $01;
  TNOENC_OFB64_IV_OK     = $02;
  TNOENC_OFB64_IV_BAD    = $03;

  //CAST5_40_CFB64 and CAST128_CFB64 Telnet Encryption types suboption commands
  //same as DES3_CFB64 Telnet Encryption type suboption commands

  //DES_CFB64 Telnet Encryption type
  //same as DES3_CFB64 Telnet Encryption type suboption commands

  //DES_OFB64 Telnet Encryption type
  //same as CAST5_40_OFB64 and CAST128_OFB64 Telnet Encryption types suboption commands


type
  TIdTelnet = class;

  {Commands to telnet client from server}
  TIdTelnetCommand = (tncNoLocalEcho, tncLocalEcho, tncEcho);

  TIdTelnetDataAvailEvent = procedure (Sender: TIdTelnet; const Buffer: TIdBytes) of object;

  TIdTelnetCommandEvent = procedure(Sender: TIdTelnet; Status: TIdTelnetCommand) of object;

  {This object is for the thread that listens for the telnet server responses
  to key input and initial protocol negotiations }

  TIdTelnetReadThread = class(TIdThread)
  protected
    FClient: TIdTelnet;
    //
    procedure Run; override;
  public
    constructor Create(AClient: TIdTelnet); reintroduce;
    property Client: TIdTelnet read FClient;
  end; //TIdTelnetReadThread

  TIdTelnet = class(TIdTCPClientCustom)
  protected
    fTerminal : String;
    fThreadedEvent: Boolean;
    FOnDataAvailable: TIdTelnetDataAvailEvent;
    fIamTelnet: Boolean;
    FOnTelnetCommand: TIdTelnetCommandEvent;
    FTelnetThread: TIdTelnetReadThread;
    //
    procedure DoOnDataAvailable(const Buf: TIdBytes);
    // Are we connected to a telnet server or some other server?
    property IamTelnet: Boolean read fIamTelnet write fIamTelnet;
    // Protocol negotiation begins here
    procedure Negotiate;
    // Handle the termtype request
    procedure Handle_SB(const SbType: Byte; const SbData: TIdBytes);
    // Send the protocol resp to the server based on what's in Reply    {Do not Localize}
    procedure SendNegotiationResp(const Response: Byte; const ResponseData: Byte);
    procedure SendSubNegotiationResp(const SbType: Byte; const ResponseData: TIdBytes);
    // Update the telnet status
    procedure DoTelnetCommand(Status: TIdTelnetCommand);
    procedure InitComponent; override;
  public
    //
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;
    procedure Connect; override;
    procedure Disconnect(ANotifyPeer: Boolean); override;
    procedure SendCh(Ch: Char);
    procedure SendString(const S: String);

    property TelnetThread: TIdTelnetReadThread read FTelnetThread;
  published
    property Host;
    property Port default IdPORT_TELNET;
    property OnTelnetCommand: TIdTelnetCommandEvent read FOnTelnetCommand write FOnTelnetCommand;
    property OnDataAvailable: TIdTelnetDataAvailEvent read FOnDataAvailable write FOnDataAvailable;
    property Terminal: string read fTerminal write fTerminal;
    property ThreadedEvent: Boolean read fThreadedEvent write fThreadedEvent default False;
  end;

  EIdTelnetError = class(EIdException);
  EIdTelnetClientConnectError = class(EIdTelnetError);
  EIdTelnetServerOnDataAvailableIsNil = class(EIdTelnetError);

implementation

uses
  IdResourceStringsCore,
  IdResourceStringsProtocols,
  SysUtils;

constructor TIdTelnetReadThread.Create(AClient: TIdTelnet);
begin
  FClient := AClient;
  inherited Create(False);
end;

procedure TIdTelnetReadThread.Run;
begin
  // if we have data run it through the negotiation routine. If we aren't
  // connected to a telnet server then the data just passes through the
  // negotiate routine unchanged.

  // RLebeau 3/29/04 - made Negotiate() get called by Synchronize() to
  // ensure that the OnTelnetCommand event handler is synchronized when
  // ThreadedEvent is false

  if FClient.IOHandler.InputBufferIsEmpty then begin
    FClient.IOHandler.CheckForDataOnSource(IdTimeoutInfinite);
  end;
  if not FClient.IOHandler.InputBufferIsEmpty then begin
    if FClient.ThreadedEvent then begin
      FClient.Negotiate;
    end else begin
      Synchronize(FClient.Negotiate);
    end;
  end;
  FClient.IOHandler.CheckForDisconnect;
end;

{ TIdTelnet }

procedure TIdTelnet.SendCh(Ch : Char);
begin
  // this  code is necessary to allow the client to receive data properly
  // from a non-telnet server
  if Connected then begin
    if (Ch <> CR) or IamTelnet then begin
      IOHandler.Write(Ch);
    end else begin
      IOHandler.Write(EOL);
    end;
  end;
end;

procedure TIdTelnet.SendString(const S : String);
var
  I: Integer;
  Ch: Char;
begin
  // this  code is necessary to allow the client to receive data properly
  // from a non-telnet server
  for I := 1 to Length(S) do begin
    try
      Ch := S[I];
      if (Ch <> CR) or IamTelnet then begin
        IOHandler.Write(Ch);
      end else begin
        IOHandler.Write(EOL);
      end;
    except
    end;
  end;
end;

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdTelnet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdTelnet.InitComponent;
begin
  inherited InitComponent;
  Terminal := 'dumb';    {Do not Localize}
  ThreadedEvent := False;
  IamTelnet := False;
  Port := IdPORT_TELNET;
end;

destructor TIdTelnet.Destroy;
begin
  Disconnect;
  inherited Destroy;
end;

procedure TIdTelnet.Disconnect(ANotifyPeer: Boolean);
begin
  if Assigned(FTelnetThread) then begin
    FTelnetThread.Terminate;
  end;
  try
    inherited Disconnect(ANotifyPeer);
  finally
    if Assigned(FTelnetThread) and (not IsCurrentThread(FTelnetThread)) then begin
      FTelnetThread.WaitFor;
      FreeAndNil(FTelnetThread);
    end;
  end;
end;

procedure TIdTelnet.DoOnDataAvailable(const Buf: TIdBytes);
begin
  if Assigned(FOnDataAvailable) then begin
    OnDataAvailable(Self, Buf);
  end else begin
    raise EIdTelnetServerOnDataAvailableIsNil.Create(RSTELNETSRVOnDataAvailableIsNil);
  end;
end;

procedure TIdTelnet.Connect;
begin
  inherited Connect;
  try
    // create the reading thread and assign the current Telnet object to it
    IAmTelnet := False;
    FTelnetThread := TIdTelnetReadThread.Create(Self);
  except
    Disconnect(True);
    IndyRaiseOuterException(EIdTelnetClientConnectError.Create(RSNoCreateListeningThread));  // translate
  end;
end;

procedure TIdTelnet.SendNegotiationResp(const Response: Byte; const ResponseData: Byte);
var
  Resp: TIdBytes;
begin
  SetLength(Resp, 3);
  Resp[0] := TNC_IAC;
  Resp[1] := Response;
  Resp[2] := ResponseData;
  IOHandler.Write(Resp);
end;

procedure TIdTelnet.SendSubNegotiationResp(const SbType: Byte; const ResponseData: TIdBytes);
var
  Resp: TIdBytes;
begin
  SetLength(Resp, 3 + Length(ResponseData) + 2);
  Resp[0] := TNC_IAC;
  Resp[1] := TNC_SB;
  Resp[2] := SbType;
  CopyTIdBytes(ResponseData, 0, Resp, 3, Length(ResponseData));
  Resp[Length(Resp)-2] := TNC_IAC;
  Resp[Length(Resp)-1] := TNC_SE;
  IOHandler.Write(Resp);
end;

procedure TIdTelnet.Handle_SB(const SbType: Byte; const SbData: TIdBytes);
var
  Resp: TIdBytes;
  LTerminal: String;
begin
  Resp := nil;
  case SbType of
    TNO_TERMTYPE:
      if (Length(SbData) > 0) and (SbData[0] = TNOS_TERMTYPE_SEND) then
      begin
        // if someone inadvertantly sets Terminal to null
        // You can set terminal to anything you want I suppose but be
        // prepared to handle the data emulation yourself
        LTerminal := Terminal;
        if LTerminal = '' then begin
          Terminal := 'UNKNOWN';    {Do not Localize}
        end;
        SetLength(Resp, 1);
        Resp[0] := TNOS_TERM_IS;
        AppendString(Resp, LTerminal);
        SendSubNegotiationResp(TNO_TERMTYPE, Resp);
      end;
  end;
  // add authentication code here
end;

procedure TIdTelnet.Negotiate;
var
  b         : Byte;
  nBuf      : TIdBytes;
  sbBuf     : TIdBytes;
  CurrentSb : Byte;
  Reply     : Byte;
begin
  nBuf := nil;
  sbBuf := nil;

  repeat
    b := IOHandler.ReadByte;
    if b <> TNC_IAC then
    begin
      AppendByte(nBuf, b);
      Continue;
    end;

    { start of command sequence }
    IamTelnet := True;

    b := IOHandler.ReadByte;
    if b = TNC_IAC then
    begin
      AppendByte(nBuf, TNC_IAC);
      Continue;
    end;

    case b of
      TNC_WILL:
        begin
          b := IOHandler.ReadByte;
          case b of
            TNO_ECHO:
              begin
                Reply := TNC_DO;
                DoTelnetCommand(tncNoLocalEcho);
                //doStatus('NOLOCALECHO');    {Do not Localize}
              end;

            TNO_EOR:
              Reply := TNC_DO;

            else
              Reply := TNC_DONT;
          end;
          SendNegotiationResp(Reply, b);
        end;

      TNC_WONT:
        begin
          b := IOHandler.ReadByte;
          case b of
            TNO_ECHO:
              begin
                Reply := TNC_DONT;
                DoTelnetCommand(tncLocalEcho);
                //Dostatus('LOCALECHO');    {Do not Localize}
              end;

            else
              Reply := TNC_DONT;
          end;
          SendNegotiationResp(Reply, b);
        end;

      TNC_DONT:
        begin
          b := IOHandler.ReadByte;
          case b of
            TNO_ECHO:
              begin
                DoTelnetCommand(tncEcho);
                //DoStatus('ECHO');    {Do not Localize}
                Reply := TNC_WONT;
              end;
            else
              Reply := TNC_WONT;
          end;
          SendNegotiationResp(Reply, b);
        end;

      TNC_DO:
        begin
          b := IOHandler.ReadByte;
          case b of
            TNO_ECHO:
              begin
                Reply := TNC_WILL;
                DoTelnetCommand(tncLocalEcho);
              end;

            TNO_TERMTYPE:
              Reply := TNC_WILL;

            //TNO_NAWS:
            TNO_AUTH:
              begin
                {
                if (Authentication) then begin
                  Reply := TNC_WILL;
                end else
                }
                begin
                  Reply := TNC_WONT;
                end;
              end;

            else
              Reply := TNC_WONT;
          end;
          SendNegotiationResp(Reply, b);
        end;

      TNC_EOR:
        begin
          // send any current data to the app
          if Length(nBuf) > 0 then
          begin
            DoOnDataAvailable(nBuf);
            SetLength(nBuf, 0);
          end;
        end;

      TNC_SB:
        begin
          SetLength(sbBuf, 0);

          // send any current data to the app, as the sub-negotiation
          // may affect how subsequent data needs to be processed...
          if Length(nBuf) > 0 then
          begin
             DoOnDataAvailable(nBuf);
            SetLength(nBuf, 0);
          end;

          CurrentSB := IOHandler.ReadByte;
          repeat
            b := IOHandler.ReadByte;
            if b = TNC_IAC then
            begin
              b := IOHandler.ReadByte;
              case b of
                TNC_IAC:
                  begin
                    AppendByte(sbBuf, TNC_IAC);
                  end;

                TNC_SE:
                  begin
                    Handle_Sb(CurrentSB, sbBuf);
                    SetLength(sbBuf, 0);
                    Break;
                  end;

                TNC_SB:
                  begin
                    Handle_Sb(CurrentSB, sbBuf);
                    SetLength(sbBuf, 0);
                    CurrentSB := IOHandler.ReadByte;
                  end;
              end;
            end else begin
              AppendByte(sbBuf, b);
            end;
          until False;
        end;
    end;
  until IOHandler.InputBufferIsEmpty;

  // if any data remains then send this data to the app
  if Length(nBuf) > 0 then begin
    DoOnDataAvailable(nBuf);
  end;
end;

procedure TIdTelnet.DoTelnetCommand(Status: TIdTelnetCommand);
begin
  if Assigned(FOnTelnetCommand) then
    FOnTelnetCommand(Self, Status);
end;

END.
