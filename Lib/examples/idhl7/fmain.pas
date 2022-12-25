unit fmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  IdHL7;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    cmbMode: TComboBox;
    edtServer: TEdit;
    edtPort: TEdit;
    idHl7Client: TIdHL7;
    idHl7Server: TIdHL7;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    procedure btnStartClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnStartClick(Sender: TObject);
begin

  if btnStart.tag = 0 then begin
    cmbMode.Enabled:=  false;
    btnStart.tag := 1;
  end else begin
    cmbMode.Enabled:=  true;
    btnStart.tag := 0;
  end;
end;

end.

