unit IdTestIMAP4;

interface

uses
  IdTest,
  IdIMAP4,
  IdObjs,
  IdGlobal,
  IdSys;

type

  TIdTestIMAP4 = class(TIdTest)
  published
    procedure TestStripCRLFs;
  end;

  TIdIMAP4Access = class(TIdIMAP4);

implementation

procedure TIdTestIMAP4.TestStripCRLFs;
var
  aImap:TIdIMAP4Access;
  aSource,aDest:TIdMemoryStream;
  aStr:string;
const
  cIn='1'#10'2'#13'3';
  cOut='123';
begin
  aImap:=TIdIMAP4Access.Create;
  aSource:=TIdMemoryStream.Create;
  aDest:=TIdMemoryStream.Create;
  try
    WriteStringToStream(aSource,cIn);
    aSource.Position:=0;
    aImap.StripCRLFs(aSource,aDest);
    aDest.Position:=0;
    aStr:=ReadStringFromStream(aDest);
    assert(aStr=cOut);
  finally
    Sys.FreeAndNil(aImap);
    Sys.FreeAndNil(aSource);
    Sys.FreeAndNil(aDest);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestIMAP4);

end.
