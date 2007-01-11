unit IdTestSHA1Hash;

{
refer http://www.faqs.org/rfcs/rfc3174.html
examples are given in section 7.1
}

interface

uses
  IdTest;

type

  TIdTestSHA1Hash = class(TIdTest)
  private
    procedure CheckHash(const aStr,aExpect:string);
  published
    procedure TestRFC;
  end;

implementation

uses
  IdHashSHA1,
  IdObjs,
  IdSys;

procedure TIdTestSHA1Hash.TestRFC;
{
Note:  For test 3 and 4, we were getting failures with the checksums listed in
RFC 3174.

I did some testing with the following:

Microsoft's fciv
(File Checksum Integrity Verifier version 2.05).

and from:

SlavaSoft Optimizing Checksum Utility - fsum 2.51
Implemented using SlavaSoft QuickHash Library <www.slavasoft.com>
Copyright (C) SlavaSoft Inc. 1999-2004. All rights reserved.

and both returned the same checks8um and that didn't match the RFC.

I suspect that the RFC was wrong and that FCIV, lavaSoft Optimizing Checksum Utility,
and our code are correct.

}
const
  s1='abc';
  e1='A9993E364706816ABA3E25717850C26C9CD0D89D';

  s2='abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq';
  e2='84983E441C3BD26EBAAE4AA1F95129E5E54670F1';

  s3='a';
//  e3='34AA973CD4C4DAA4F61EEB2BDBAD27316534016F';
  e3='86F7E437FAA5A7FCE15D1DDCB9EAEAEA377667B8';

  s4='0123456701234567012345670123456701234567012345670123456701234567';
  //  e4='DEA356A2CDDD90C7A7ECEDC5EBB563934F460452';
  e4='E0C094E867EF46C350EF54A7F59DD60BED92AE83';

begin
  CheckHash(s1,e1);
  CheckHash(s2,e2);
  CheckHash(s3,e3);
  CheckHash(s4,e4);
end;

procedure TIdTestSHA1Hash.CheckHash(const aStr, aExpect: string);
var
  LH :  TIdHashSHA1;
  LStrm : TIdStream;
  s : String;
begin
  LH :=  TIdHashSHA1.Create;
  try
    s :=  lh.HashStringAsHex(aStr);
    Assert(Sys.UpperCase(s)=aExpect,aStr);
  finally
    Sys.FreeAndNil(LH);
  end;
end;

initialization

  TIdTest.RegisterTest(TIdTestSHA1Hash);

end.
