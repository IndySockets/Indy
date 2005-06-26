unit IdTestMD5Hash;

interface
uses
  IdTest;

type
  TIdTestMD5Hash = class(TIdTest)
  published
    procedure TestRFC;
  end;

implementation
uses IdHashMessageDigest, IdObjs, IdSys;

{ TIdTestMD5Header }

//tests specified by http://www.faqs.org/rfcs/rfc1321.html
procedure TIdTestMD5Hash.TestRFC;
var LH :  TIdHashMessageDigest5;
  LStrm : TIdStream;
  s : String;
begin
  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdMemoryStream.Create;
    try
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='d41d8cd98f00b204e9800998ecf8427e','test "" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('a');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='0cc175b9c0f1b6a831c399e269772661','test "a" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('abc');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='900150983cd24fb0d6963f7d28e17f72','test "abc" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('message digest');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='f96b697d7cb7938d525a2f31aaf161d0','test "abc" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('abcdefghijklmnopqrstuvwxyz');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='c3fcd3d76192e4007dfb496cca67e13b','test "abcdefghijklmnopqrstuvwxyz" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='d174ab98d277d9f5a5611c2c9f419d9f','test "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;

  LH :=  TIdHashMessageDigest5.Create;
  try
    LStrm := TIdStringStream.Create('12345678901234567890123456789012345678901234567890123456789012345678901234567890');
    try
      LStrm.Position := 0;
      s :=  TIdHashMessageDigest5.AsHex(LH.HashValue(LStrm));
      Assert(Sys.LowerCase(s)='57edf4a22be3c955ac49da2e2107b67a','test "12345678901234567890123456789012345678901234567890123456789012345678901234567890" Failed');
    finally
      Sys.FreeAndNil(LStrm);
    end;
  finally
    Sys.FreeAndNil(LH);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestMD5Hash);
end.
