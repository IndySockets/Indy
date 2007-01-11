unit IdTestMD5Hash;

interface

uses
  IdTest;

type

  TIdTestMD5Hash = class(TIdTest)
  private
    procedure TryHash(const aStr, aExpect: string);
  published
    procedure TestRFC;
  end;

implementation

uses
  IdHashMessageDigest,
  IdObjs,
  IdSys;

procedure TIdTestMD5Hash.TryHash(const aStr,aExpect:string);
var
  LH:TIdHashMessageDigest5;
  s:string;
begin
  LH :=  TIdHashMessageDigest5.Create;
  try
    s :=  lh.HashStringAsHex(aStr);
    Assert(Sys.LowerCase(s)=aExpect);
  finally
    Sys.FreeAndNil(LH);
  end;
end;

//tests specified by http://www.faqs.org/rfcs/rfc1321.html
procedure TIdTestMD5Hash.TestRFC;
begin
  TryHash('',
    'd41d8cd98f00b204e9800998ecf8427e');

  TryHash('a',
    '0cc175b9c0f1b6a831c399e269772661');

  TryHash('abc',
    '900150983cd24fb0d6963f7d28e17f72');

  TryHash('message digest',
    'f96b697d7cb7938d525a2f31aaf161d0');

  TryHash('abcdefghijklmnopqrstuvwxyz',
    'c3fcd3d76192e4007dfb496cca67e13b');

  TryHash('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
    'd174ab98d277d9f5a5611c2c9f419d9f');

  TryHash('12345678901234567890123456789012345678901234567890123456789012345678901234567890',
    '57edf4a22be3c955ac49da2e2107b67a');
end;

initialization

  TIdTest.RegisterTest(TIdTestMD5Hash);
  
end.
