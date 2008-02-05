unit IdTestCoderUUE;

interface

uses
  IdTest,
  IdObjs,
  IdSys,
  IdGlobal,
  IdCoderUUE;

type

  TIdTestCoderUUE = class(TIdTest)
  published
    procedure Test;
  end;

implementation

procedure TIdTestCoderUUE.Test;
var
  aEnc:TIdEncoderUUE;
  aStr:string;
  aDec:TIdDecoderUUE;
const
  cPlain='Cat';
  cEncoded='#0V%T';
begin
  //todo test large strings
  //todo test streams

  aEnc:=TIdEncoderUUE.Create;
  try
    aStr:=aEnc.Encode(cPlain);
    Assert(aStr=cEncoded,aStr);
  finally
    Sys.FreeAndNil(aEnc);
  end;

  aDec:=TIdDecoderUUE.Create;
  try
    aStr:=aDec.DecodeString(cEncoded);
    Assert(aStr=cPlain);
  finally
    Sys.FreeAndNil(aDec);
  end;

end;

initialization

  TIdTest.RegisterTest(TIdTestCoderUUE);

end.
