unit fmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  IdHL7, IdTCPConnection,idGlobal,idSync;

type

  { TForm1 }




    { TLog }

    TLog = class(TIdNotify)
    protected
      FMsg: string;
      procedure DoNotify; override;
    public
      class procedure LogMsg(const AMsg :string);
    end;

  TForm1 = class(TForm)
    btnStart: TButton;
    btnListen: TButton;
    edtServerPort: TEdit;
    edtServer: TEdit;
    edtPort: TEdit;
    idHl7Client: TIdHL7;
    idHl7Server: TIdHL7;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    memClient: TMemo;
    memClientReplyText: TMemo;
    memGeneral: TMemo;
    memServerReply: TMemo;
    memServer: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    procedure btnListenClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure idHl7ClientConnCountChange(ASender: TIdHL7; AConnCount: integer);
    procedure idHl7ClientConnect(Sender: TObject);
    procedure idHl7ClientDisconnect(Sender: TObject);
    procedure idHl7ClientReceiveError(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; AException: Exception; var VReply: string; var VDropConnection: boolean);
    procedure idHl7ServerConnCountChange(ASender: TIdHL7; AConnCount: integer);
    procedure idHl7ServerConnect(Sender: TObject);
    procedure idHl7ServerDisconnect(Sender: TObject);
    procedure idHl7ServerReceiveError(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; AException: Exception; var VReply: string; var VDropConnection: boolean);
    procedure Panel3Click(Sender: TObject);
  protected
    procedure hl7ServerReceive(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; var VHandled: boolean; var VReply: string);
    procedure hl7ServerMsgArrive(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string);
    procedure hl7clientReceive(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; var VHandled: boolean; var VReply: string);
    procedure logGeneral(sText  : String);


  private
    procedure clientSend();
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TLog }

procedure TLog.DoNotify;
begin
      Form1.memGeneral.Lines.Add(Fmsg);
end;

class procedure TLog.LogMsg(const AMsg :string);
begin
   with TLog.Create do
  try
    FMsg := AMsg;
    Notify;
  except
    Free;
    raise;
  end;
end;

{ TForm1 }

procedure TForm1.btnStartClick(Sender: TObject);
begin
    if idHl7Client.Connected then begin
    idHl7Client.Stop;
  end;

    idHl7Client.Port := StrToInt(edtPort.Text);
    idHl7Client.Address := edtServer.Text;
    clientSend;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if idHl7Client.Status = isConnected then begin
    idHl7Client.Stop;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  idHl7Server.OnReceiveMessage := @hl7ServerReceive;
  idHl7Server.OnMessageArrive := @hl7ServerMsgArrive;
  idHl7Client.OnReceiveMessage:= @hl7clientReceive;

end;

procedure TForm1.idHl7ClientConnCountChange(ASender: TIdHL7; AConnCount: integer);
begin
  logGeneral('clientcon_count change : ');
end;

procedure TForm1.idHl7ClientConnect(Sender: TObject);
begin
  logGeneral('clientconnect : ');
end;

procedure TForm1.idHl7ClientDisconnect(Sender: TObject);
begin
  logGeneral('clientdisconnect : ');
end;

procedure TForm1.idHl7ClientReceiveError(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; AException: Exception; var VReply: string; var VDropConnection: boolean);
begin
  logGeneral('clientrcverr : ' + AException.Message);
  VDropConnection := True;
end;

procedure TForm1.idHl7ServerConnCountChange(ASender: TIdHL7; AConnCount: integer);
begin
  //Currently if evcents log to memo even in critical section it breaks the whole thread schedule system
  logGeneral('servercon_count change : ');
end;

procedure TForm1.idHl7ServerConnect(Sender: TObject);
begin
  logGeneral('serverconnect : ');
end;

procedure TForm1.idHl7ServerDisconnect(Sender: TObject);
begin
  //Currently if evcents log to memo even in critical section it breaks the whole thread schedule system
  logGeneral('serverdisconnect : ');
end;

procedure TForm1.idHl7ServerReceiveError(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; AException: Exception; var VReply: string; var VDropConnection: boolean);
begin
  logGeneral('servrcverr : ' + AException.Message);
  VDropConnection := True;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin

end;


procedure TForm1.hl7ServerReceive(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string; var VHandled: boolean; var VReply: string);
begin
  vReply := memServerReply.Lines.Text;
  memServer.lines.text := Amsg;
  vhandled := True;
  logGeneral('servreceived '+AMsg+
                      '- reply provided '+vReply);

end;

procedure TForm1.hl7ServerMsgArrive(ASender: TObject; AConnection: TIdTCPConnection; AMsg: string);
begin
  logGeneral('servmsgarrive : ' + AMsg);
  memServer.lines.add(amsg);

  idHl7Server.AsynchronousSend(memServerReply.Lines.text,AConnection);
end;

procedure TForm1.hl7clientReceive(ASender: TObject;
  AConnection: TIdTCPConnection; AMsg: string; var VHandled: boolean;
  var VReply: string);
begin
  memClientReplyText.lines.text := Amsg;
  vhandled := True;
  logGeneral('clreceived '+AMsg);

end;

procedure TForm1.logGeneral(sText: String);
begin
  TLog.LogMsg(sText);

end;

procedure TForm1.clientSend;
var
  iX: integer;
  sAnt: string;
//  vR : TSendResponse;
  vMsg : IInterface;
begin
  if idHl7Client.Status <> isConnected then begin
    idHl7Client.Start;
    idHl7Client.WaitForConnection(10000);
  end;
  idHl7Client.SendMessage(memClient.Lines.Text);
  iX := 0;
  while (iX < 10)  do begin
    Inc(iX);
    sleep(10);
    Application.ProcessMessages;
    (*vR*)vMsg := idHl7Client.GetMessage(sAnt);
    if vMsg <> nil (*vR = srOK*) then begin
      memClientReplyText.Lines.text := 'success : '+sAnt;
      break
(*  end else if vR = srError then begin
      memClientReplyText.Lines.text := 'error : '+sAnt;
      break;
    end else if vR = srTimeout then begin
      memClientReplyText.Lines.text := 'timeout waiting for reply ';
      break;*)
    end;
  end;
//  memClientReplyText.Lines.Text := sAnt;

end;

procedure TForm1.btnListenClick(Sender: TObject);
begin
  if btnListen.Tag = 0 then begin
    idHl7Server.Port := StrToInt(edtServerPort.Text);
    idHl7Server.Start;
    btnListen.Tag := 1;
    btnListen.Caption := 'Stop';
  end else begin
    idHl7Server.Stop;
    btnListen.Caption := 'Start';
    btnListen.Tag := 0;
  end;
end;

end.
