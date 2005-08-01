unit IdTestTrivialFTP;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdGlobal,
  IdTrivialFTP,
  IdTrivialFTPServer;

type

  TIdTestTrivialFTP = class(TIdTest)
  private
    procedure CallbackReadFile(Sender: TObject; var FileName: String; const PeerInfo: TPeerInfo;
    var GrantAccess: Boolean; var AStream: TIdStream; var FreeStreamOnComplete: Boolean);
  published
    procedure TestBasic;
  end;

implementation

const
  cFile='file.txt';
  cContent='12345';

procedure TIdTestTrivialFTP.CallbackReadFile(Sender: TObject;
  var FileName: String; const PeerInfo: TPeerInfo;
  var GrantAccess: Boolean; var AStream: TIdStream;
  var FreeStreamOnComplete: Boolean);
begin
  if FileName=cFile then
    begin
    AStream:=TIdStringStream.Create(cContent);
    end;
end;

procedure TIdTestTrivialFTP.TestBasic;
var
  c:TIdTrivialFTP;
  s:TIdTrivialFTPServer;
  aStream:TIdMemoryStream;
  aContent:string;
begin
  c:=TIdTrivialFTP.Create;
  s:=TIdTrivialFTPServer.Create;
  aStream:=TIdMemoryStream.Create;
  try
  s.OnReadFile:=Self.CallbackReadFile;
  //set ThreadedEvent, else theres a deadlock because we do a blocking read soon
  s.ThreadedEvent:=True;
  s.Active:=True;

  c.ReceiveTimeout:=1000;
  c.Get(cFile,aStream);
  aStream.Position:=0;
  aContent:=ReadStringFromStream(aStream);
  Assert(aContent=cContent);

  finally
    sys.FreeAndNil(aStream);
    Sys.FreeAndNil(c);
    Sys.FreeAndNil(s);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestTrivialFTP);

end.
