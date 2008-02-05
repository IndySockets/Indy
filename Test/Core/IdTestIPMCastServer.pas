unit IdTestIPMCastServer;

//http://www.rfc-editor.org/rfc/rfc1112.txt
//http://www.rfc-editor.org/rfc/rfc1458.txt

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdThreadSafe,
  IdSocketHandle,
  IdGlobal,
  IdIPMCastClient,
  IdIPMCastServer;

type

  TIdTestIPMCastServer = class(TIdTest)
	private
    FClientRead:TIdThreadSafeString;
    procedure CallbackClientRead(Sender: TObject; const AData: TIdBytes; ABinding: TIdSocketHandle);
  published
    procedure TestBasic;
  end;

implementation

procedure TIdTestIPMCastServer.CallbackClientRead(Sender: TObject;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s:string;
begin
  s:=BytesToString(AData);
  FClientRead.Append(s);
end;

procedure TIdTestIPMCastServer.TestBasic;
var
  s:TIdIPMCastServer;
  c1:TIdIPMCastClient;
const
  cTest='123';
  cMulticastPort=22299;
  cMulticastGroup='224.0.0.10';
begin
  s:=TIdIPMCastServer.Create;
  c1:=TIdIPMCastClient.Create;
  FClientRead:=TIdThreadSafeString.Create;
  try
    s.Loopback:=False;
    s.Port:=cMulticastPort;
    s.TimeToLive:=10;
    s.MulticastGroup:=cMulticastGroup;
    s.Active:=True;

    c1.ThreadedEvent:=True;
    c1.DefaultPort:=cMulticastPort;
    c1.MulticastGroup:=cMulticastGroup;
    c1.OnIPMCastRead:=CallbackClientRead;
    c1.Active:=True;

    s.Send(cTest);

    Sleep(500);

    Assert(FClientRead.Value=cTest);

  finally
    Sys.FreeAndNil(c1);
    Sys.FreeAndNil(s);
    Sys.FreeAndNil(FClientRead);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestIPMCastServer);

end.
