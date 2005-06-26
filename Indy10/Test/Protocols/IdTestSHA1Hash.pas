unit IdTestSHA1Hash;

interface
uses IdTest;

type
  TIdTestSHA1Hash = class(TIdTest)
  published
    procedure TestRFC;
  end;

implementation
uses IdHashSHA1, IdObjs, IdSys;

{ TIdTestSHA1Hash }

procedure TIdTestSHA1Hash.TestRFC;
var LH :  TIdHashSHA1;
  LStrm : TIdStream;
  s : String;
begin
  LH :=  TIdHashSHA1.Create;
  try
    LStrm := TIdStringStream.Create('abc');
    try
      s :=  TIdHashSHA1.AsHex(LH.HashValue(LStrm));
      Assert(Sys.UpperCase(s)='A9993E364706816ABA3E25717850C26C9CD0D89D','test "abc" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashSHA1.Create;
  try
    LStrm := TIdStringStream.Create('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq');
    try
      s :=  TIdHashSHA1.AsHex(LH.HashValue(LStrm));
      Assert(Sys.UpperCase(s)='84983E441C3BD26EBAAE4AA1F95129E5E54670F1','test "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashSHA1.Create;
  try
    LStrm := TIdStringStream.Create('a');
    try
      s :=  TIdHashSHA1.AsHex(LH.HashValue(LStrm));
      Assert(Sys.UpperCase(s)='34AA973CD4C4DAA4F61EEB2BDBAD27316534016F','test "a" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashSHA1.Create;
  try
    LStrm := TIdStringStream.Create('0123456701234567012345670123456701234567012345670123456701234567');
    //an exact multiple of 512 bits
    try
      s :=  TIdHashSHA1.AsHex(LH.HashValue(LStrm));
      Assert(Sys.UpperCase(s)='DEA356A2CDDD90C7A7ECEDC5EBB563934F460452','test "0123456701234567012345670123456701234567012345670123456701234567" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestSHA1Hash);
end.
