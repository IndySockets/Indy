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

uses
  IdAssignedNumbers,
  IdGlobal,
  IdException,
  IdObjs,
  IdStack,
  IdSys,
  IdTCPClient, IdThread;

const
  { These are the telnet command constansts from RFC 854 }
  TNC_EOR                = #239;    // End of Record RFC 885
  TNC_SE                 = #240;    // End of subnegotiation parameters.
  TNC_NOP                = #241;    // No operation.
  TNC_DATA_MARK          = #242;    // The data stream portion of a Synch.
                                    // This should always be accompanied
                                    // by a TCP Urgent notification.
  TNC_BREAK              = #243;    // NVT character BRK.
  TNC_IP                 = #244;    // The function IP.
  TNC_AO                 = #245;    // The function ABORT OUTPUT.
  TNC_AYT                = #246;    // The function ARE YOU THERE.
  TNC_EC                 = #247;    // The function ERASE CHARACTER.
  TNC_EL                 = #248;    // The function ERASE LINE.
  TNC_GA                 = #249;    // The GO AHEAD signal.
  TNC_SB                 = #250;    // Indicates that what follows is
                                    // subnegotiation of the indicated
                                    // option.
  TNC_WILL               = #251;    // Indicates the desire to begin
                                    // performing, or confirmation that
                                    // you are now performing, the
                                    // indicated option.
  TNC_WONT               = #252;    // Indicates the refusal to perform,
                                    // or continue performing, the
                                    // indicated option.
  TNC_DO                 = #253;    // Indicates the request that the
                                    // other party perform, or
                                    // confirmation that you are expecting
                                    // the other party to perform, the
                                    // indicated option.
  TNC_DONT               = #254;    // Indicates the demand that the
                                    // other party stop performing,
                                    // or confirmation that you are no
                                    // longer expecting the other party
                                    // to perform, the indicated option.
  TNC_IAC                = #255;    // Data Byte 255.

  { Telnet options from RFC 1010 }
  TNO_BINARY             = #0;      // Binary Transmission
  TNO_ECHO               = #1;      // Echo
  TNO_RECONNECT          = #2;      // Reconnection
  TNO_SGA                = #3;      // Suppress Go Ahead
  TNO_AMSN               = #4;      // Approx Message Size Negotiation
  TNO_STATUS             = #5;      // Status
  TNO_TIMING_MARK        = #6;      // Timing Mark
  TNO_RCTE               = #7;      // Remote Controlled Trans and Echo -BELL
  TNO_OLW                = #8;      // Output Line Width
  TNO_OPS                = #9;      // Output Page Size
  TNO_OCRD               = #10;     // Output Carriage-Return Disposition
  TNO_OHTS               = #11;     // Output Horizontal Tab Stops
  TNO_OHTD               = #12;     // Output Horizontal Tab Disposition
  TNO_OFD                = #13;     // Output Formfeed Disposition
  TNO_OVT                = #14;     // Output Vertical Tabstops
  TNO_OVTD               = #15;     // Output Vertical Tab Disposition
  TNO_OLD                = #16;     // Output Linefeed Disposition
  TNO_EA                 = #17;     // Extended ASCII
  TNO_LOGOUT             = #18;     // Logout
  TNO_BYTE_MACRO         = #19;     // Byte Macro
  TNO_DET                = #20;     // Data Entry Terminal
  TNO_SUPDUP             = #21;     // SUPDUP
  TNO_SUPDUP_OUTPUT      = #22;     // SUPDUP Output
  TNO_SL                 = #23;     // Send Location
  TNO_TERMTYPE           = #24;     // Terminal Type
  TNO_EOR                = #25;     // End of Record
  TNO_TACACS_ID          = #26;     // TACACS User Identification
  TNO_OM                 = #27;     // Output Marking
  TNO_TLN                = #28;     // Terminal Location Number
  TNO_3270REGIME         = #29;     // 3270 regime
  TNO_X3PAD	         = #30;     // X.3 PAD
  TNO_NAWS      	 = #31;     // Window size
  TNO_TERM_SPEED         = #32;     // Terminal speed
  TNO_RFLOW              = #33;     // Remote flow control
  TNO_LINEMODE           = #34;     // Linemode option
  TNO_XDISPLOC	         = #35;     // X Display Location
  TNO_AUTH               = #37;     // Authenticate
  TNO_ENCRYPT            = #38;     // Encryption option

  TNO_EOL                = #255;    // Extended-Options-List                               [84,JBP]

  // Sub options
  TNOS_TERM_IS           = #0;
  TNOS_TERMTYPE_SEND     = #1;      // Sub option
  TNOS_REPLY             = #2;
  TNOS_NAME              = #3;
type
  TIdTelnet = class;

  {Various states for telnet }
  TIdTelnetState =(tnsDATA, tnsIAC, tnsIAC_SB, tnsIAC_WILL, tnsIAC_DO, tnsIAC_WONT,
     tnsIAC_DONT, tnsIAC_SBIAC, tnsIAC_SBDATA, tnsSBDATA_IAC);

  {Commands to telnet client from server}
  TIdTelnetCommand = (tncNoLocalEcho, tncLocalEcho, tncEcho);

  TIdTelnetDataAvailEvent = procedure (Sender: TIdTelnet; const Buffer: String) of object;
  TIdTelnetCommandEvent = procedure(Sender: TIdTelnet; Status: TIdTelnetCommand) of object;

  {This object is for the thread that listens for the telnet server responses
  to key input and initial protocol negotiations }

  TIdTelnetReadThread = class(TIdThread)
  protected
    FClient: TIdTelnet;
    //
    procedure Run; override;
    procedure HandleIncomingData;
  public
    constructor Create(AClient: TIdTelnet); reintroduce;
    property  Client: TIdTelnet read FClient;
  End; //TIdTelnetReadThread

  TIdTelnet = class(TIdTCPClientCustom)
  protected
    fState: TIdTelnetState;
    fReply: Char;
    fSentDoDont: String;
    fSentWillWont: String;
    fReceivedDoDont: String;
    fReceivedWillWont: String;
    fTerminal : String;
    fThreadedEvent: Boolean;
    FOnDataAvailable: TIdTelnetDataAvailEvent;
    fIamTelnet: Boolean;
    FOnDisconnect: TIdNotifyEvent;
    FOnTelnetCommand: TIdTelnetCommandEvent;
    FTelnetThread: TIdTelnetReadThread;
    //
    procedure DoOnDataAvailable(const Buf: String);
    // what is our current state ?
    property State : TIdTelnetState read fState write fState;
    // what we send to the telnet server in response to protocol negotiations
    property Reply : Char read fReply write fReply;
    // did we send a DO DONT command?
    property SentDoDont : String read fSentDoDont write fSentDoDont;
    // did we send a WILL WONT command?
    property SentWillWont: String read fSentWillWont write fSentWillWont;
    // did we receive a DO DONT request from the server?
    property ReceivedDoDont: String read fReceivedDoDont write fReceivedDoDont;
    // did we receive a WILL WONT answer from the server?
    property ReceivedWillWont: String read fReceivedWillWont write fReceivedWillWont;
    // Are we connected to a telnet server or some other server?
    property IamTelnet: Boolean read fIamTelnet write fIamTelnet;
    // Protocol negotiation begins here
    procedure Negotiate(const Buf: String);
    // Handle the termtype request
    procedure Handle_SB(CurrentSb: Byte; sbData: String; sbCount: Integer);
    // Send the protocol resp to the server based on what's in Reply    {Do not Localize}
    procedure SendNegotiationResp(var Resp: String);
    // Update the telnet status
    procedure DoTelnetCommand(Status: TIdTelnetCommand);
    procedure InitComponent; override;
  public
    //
    destructor Destroy; override;
    procedure Connect; override;
    procedure Disconnect(ANotifyPeer: Boolean); override;
    procedure SendCh(Ch: Char);

    property TelnetThread: TIdTelnetReadThread read FTelnetThread;
  published
    property Host;
    property Port default IdPORT_TELNET;
    property OnTelnetCommand: TIdTelnetCommandEvent read FOnTelnetCommand write FOnTelnetCommand;
    property OnDataAvailable: TIdTelnetDataAvailEvent read FOnDataAvailable write FOnDataAvailable;
    property Terminal: string read fTerminal write fTerminal;
    property ThreadedEvent: Boolean read fThreadedEvent write fThreadedEvent default False;
    property OnDisconnect: TIdNotifyEvent read FOnDisconnect write FOnDisconnect;
  end;

  EIdTelnetError = class(EIdException);
  EIdTelnetClientConnectError = class(EIdTelnetError);
  EIdTelnetServerOnDataAvailableIsNil = class(EIdTelnetError);

implementation

uses
  IdResourceStringsCore,
  IdResourceStringsProtocols;

constructor TIdTelnetReadThread.Create(AClient: TIdTelnet);
begin
  inherited Create(False);
  FClient := AClient;
  FreeOnTerminate := FALSE; //other way TRUE
end;

procedure TIdTelnetReadThread.Run;
begin
  // if we have data run it through the negotiation routine. If we aren't
  // connected to a telnet server then the data just passes through the
  // negotiate routine unchanged.

  // RLebeau 3/29/04 - made Negotiate() get called by Synchronize() to
  // ensure that the OnTelnetCommand event handler is synchronized when
  // ThreadedEvent is false

  FClient.IOHandler.CheckForDataOnSource(50);
  if not FClient.IOHandler.InputBufferIsEmpty then begin
    if FClient.ThreadedEvent then begin
      HandleIncomingData;
    end else begin
      Synchronize(HandleIncomingData);
    end;
  end;
  FClient.IOHandler.CheckForDisconnect;
end;

procedure TIdTelnetReadThread.HandleIncomingData;
begin
  FClient.Negotiate(FClient.IOHandler.InputBufferAsString);
end;

{ TIdTelnet }

procedure TIdTelnet.SendCh(Ch : Char);
begin
  // this  code is necessary to allow the client to receive data properly
  // from a non-telnet server
  if Connected then begin
    if Ch <> CR then begin
      IOHandler.Write(Ch)
    end else if (Ch = CR) and (IamTelnet = True) then begin
      IOHandler.Write(Ch)
    end else begin
      IOHandler.Write(EOL);
    end;
  end;
end;

procedure TIdTelnet.InitComponent;
begin
  inherited;
  Port := 23;
  State := tnsData;
  SentDoDont := #0;
  SentWillWont := #0;
  ReceivedDoDont := #0;
  ReceivedWillWont := #0;
  Terminal := 'dumb';    {Do not Localize}
  ThreadedEvent := False;
  IamTelnet := False;
  Port := IdPORT_TELNET;
end;

destructor TIdTelnet.Destroy;
begin
  Disconnect(True);
  inherited Destroy;
end;

procedure TIdTelnet.Disconnect(ANotifyPeer: Boolean);
begin
  if Assigned(FTelnetThread) then begin
    FTelnetThread.Terminate;
  end;
  IAmTelnet := False;
  inherited Disconnect(ANotifyPeer);
  if Assigned(FOnDisconnect) then begin
    FOnDisconnect(Self);
  end;
  if Assigned(FTelnetThread) then begin
    FTelnetThread.WaitFor;
  end;
  Sys.FreeAndNil(FTelnetThread);
End;//Disconnect

procedure TIdTelnet.DoOnDataAvailable(const Buf: String);
begin
  if Assigned(FOnDataAvailable) then begin
    OnDataAvailable(SELF, Buf);
  end else begin
    raise EIdTelnetServerOnDataAvailableIsNil.Create(RSTELNETSRVOnDataAvailableIsNil);
  end;
end;

procedure TIdTelnet.Connect;
begin
  inherited Connect;
  try
    // create the reading thread and assign the current Telnet object to it
    FTelnetThread := TIdTelnetReadThread.Create(SELF);
  except
    Disconnect(True);
    raise EIdTelnetClientConnectError.Create(RSNoCreateListeningThread);  // translate
  end;
end;

procedure TIdTelnet.SendNegotiationResp(var Resp: String);
begin
  if Connected then begin
    IOHandler.Write(Resp);
  end;
  Resp := '';    {Do not Localize}
end;

procedure TIdTelnet.Handle_SB(CurrentSB: Byte; sbData: String; sbCount: Integer);
var
  Resp : String;
begin
  if (sbcount > 0) and (sbdata = TNOS_TERMTYPE_SEND) then
  begin
    // if someone inadvertantly sets Termnal to null
    // You can set termial to anything you want i supose but be prepared to handle
    // the data emulation yourself
    if Terminal = '' then    {Do not Localize}
      Terminal := 'dumb';    {Do not Localize}
    Resp := TNC_IAC + TNC_SB + TNO_TERMTYPE + TNOS_TERM_IS + Terminal + TNC_IAC + TNC_SE;
    SendNegotiationResp(Resp);
  end;
  // add authentication code here
end;

procedure TIdTelnet.Negotiate(const Buf: String);
var
  LCount: Integer;
  bOffset   : Integer;
  B         : Char;
  nBuf      : String;
  sbBuf     : String;
  sbCount   : Integer;
  CurrentSb : Integer;
  SendBuf   : String;
begin
  bOffset := 1;
  sbCount := 1;
  CurrentSB := 1;
  nbuf := '';    {Do not Localize}
  LCount := Length(Buf);
  while bOffset <= LCount do
  begin
    b := Buf[bOffset];
    case State of
      tnsData: { start of command sequence }
        if b = TNC_IAC then
        begin
          IamTelnet := True;
          State := tnsIAC;
        end
        else
          nbuf := nbuf + b;

      tnsIAC: { a Do request }
        case b of
          TNC_IAC:
            begin
              State := tnsData;
              nbuf := nbuf + b;
            end;
          TNC_WILL:
            State := tnsIAC_WILL;
          TNC_WONT:
            State := tnsIAC_WONT;
          TNC_DONT:
            State := tnsIAC_DONT;
          TNC_DO:
            State := tnsIAC_DO;
          TNC_EOR:
            State := tnsDATA;
          TNC_SB:
            begin
              State := tnsIAC_SB;
              sbCount := 0;
            end;
        else
          State := tnsData; // the default setting
        end; //end case b

      tnsIAC_WILL:
        begin
          case b of
            TNO_ECHO:
              begin
                Reply := TNC_DO;
                DoTelnetCommand(tncNoLocalEcho);
//                doStatus('NOLOCALECHO');    {Do not Localize}
              end;
            TNO_EOR:
              Reply := TNC_DO;
          else
            Reply := TNC_DONT;
          end; // end case b

        //  if (Reply <> SentDoDont) or (TNC_WILL <> ReceivedWillWont) then
          begin
            SendBuf := TNC_IAC + Reply + b;
            SendNegotiationResp(SendBuf);
            SentDoDont := Reply;
            ReceivedWillWont := TNC_WILL;
          end;
          State := tnsData;
        end; // end of tnsIAC_WILL

      tnsIAC_WONT:
        begin
          case b of
            TNO_ECHO:
              begin
                DoTelnetCommand(tncLocalEcho);
//                Dostatus('LOCALECHO');    {Do not Localize}
                Reply := TNC_DONT;
              end;
            TNO_EOR:
              Reply := TNC_DONT;
          else
            Reply := TNC_DONT;
          end; // end case b

        //  if (Reply <> SentDoDont) or (ReceivedWillWont <> TNC_WONT) then
          begin
            SendBuf := TNC_IAC + Reply + b;
            SendNegotiationResp(SendBuf);
            SentDoDont := Reply;
            ReceivedWillWont := TNC_WILL;
          end;
          State := tnsData;

        end; // end tnsIAC_WONT
      tnsIAC_DO:
      begin
        case b of
          TNO_ECHO:
            begin
              DoTelnetCommand(tncLocalEcho);
              Reply := TNC_WILL;
            end;
          TNO_TERMTYPE:
            Reply := TNC_WILL;
          //TNO_NAWS:
          TNO_AUTH:
          begin
//            if(Authentication) then
//            Reply := TNC_WILL
//            else
            Reply := TNC_WONT;
          end;
        else
          Reply := TNC_WONT;
        end; // end of case b
        //if (Reply <> SentWillWont) or (ReceivedDoDont <> TNC_DO) then
        begin
          SendBuf := TNC_IAC + Reply + b;
          SendNegotiationResp(SendBuf);
          SentWillWont := Reply;
          ReceivedDoDont := TNC_DO;
        end;
        State := tnsData;
      end;
      tnsIAC_DONT:
      begin
        case b of
          TNO_ECHO:
            begin
              DoTelnetCommand(tncEcho);
//              DoStatus('ECHO');    {Do not Localize}
              Reply := TNC_WONT;
            end;
          TNO_NAWS:
            Reply := TNC_WONT;
          TNO_AUTH:
            Reply := TNC_WONT
        else
          Reply := TNC_WONT;
        end; // end case b

      //  if (Reply <> SentWillwont) or (TNC_DONT <> ReceivedDoDont) then
        begin
          SendBuf := TNC_IAC + reply + b;
          SendNegotiationResp(SendBuf);
        end;
        State := tnsData;
      end;

      tnsIAC_SB:
        begin
          if b = TNC_IAC then
            State := tnsIAC_SBIAC
          else begin
            CurrentSb := Ord(b);
            sbCount := 0;
            State := tnsIAC_SBDATA;
          end;
        end;
      tnsIAC_SBDATA:
        begin
          if b = TNC_IAC then
            State := tnsSBDATA_IAC
          else begin
            inc(sbCount);
            sbBuf := b;
          end;
        end;
      tnsSBDATA_IAC:
        case b of
          TNC_IAC:
            begin
              State := tnsIAC_SBDATA;
              inc(sbCount);
              sbBuf[sbCount] := TNC_IAC;
            end;
          TNC_SE:
            begin
              handle_sb(CurrentSB,sbBuf,sbCount);
              CurrentSB	:= 0;
              State := tnsData;
            end;
          TNC_SB:
            begin
              handle_sb(CurrentSB,sbBuf,sbCount);
              CurrentSB	:= 0;
              State := tnsIAC_SB;
            end
         else
           State := tnsDATA;
         end;
      else
        State := tnsData;
    end; // end case State
    inc(boffset);
  end; // end while
  // if textual data is returned by the server then send this data to
  // the client app
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
