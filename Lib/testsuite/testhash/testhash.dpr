program testhash;

{$IFNDEF FPC}
{$APPTYPE CONSOLE}
{$ELSE}
{$MODE DELPHI}
{$ENDIF}

uses
  IdGlobal,
  IdGlobalProtocols,
  IdHash,
  IdHashCRC,
  IdHashMessageDigest,
  IdHashSHA1,
  SysUtils;

function Test(var VTime : Cardinal; var VRes : String; AHash : TIdHash; const AVal, AExpected : String): Boolean;
var LBegin, LEnd : Cardinal;
begin  
  LBegin := IdGlobal.Ticks;
  try
    VRes := AHash.HashStringAsHex(AVal)
  finally
    LEnd := IdGlobal.Ticks;
    VTime := IdGlobal.GetTickDiff(LBegin,Lend);
    VRes := LowerCase(VRes);
  end;
  if AExpected = '' then
  begin
    Result := True;
  end
  else
  begin
    Result := UpperCase(VRes) = UpperCase(AExpected);
  end;
end;

function DevideString(const A : String; const AAlign : Integer) : String;
var i, j, lLen : Integer;
begin
  Result := '';
  LLen := Length(a);
  for I := 1 to (Length(A) div AAlign) do
  begin
    Result := Result + ' ';
    for j := 0 to (AAlign - 1) do
    begin
      if (i+j) <= LLen then
      begin
        Result := Result + A[I+j];
      end;
    end;
  end;
  Result := Trim(Result);
end;


procedure DoTest(AHash: TIdHash; const ATestVal, AExpected: String;
  const ATimes: LongWord);
var
  LRes : String;
  LVTime : Cardinal;
  LTestStr : String;
  i : Integer;
begin
    if ATimes >1 then
    begin
       LTestStr := '';
       for i := 0 to ATimes - 1 do
       begin
         LTestStr := LTestStr + ATestVal;
       end;
    end
    else
    begin
      LTestStr :=  ATestVal;
    end;
    if ATimes >1 then
    begin
      //use FormatFloat to output numbers so it's printed with commas
      WriteLn('Test String:   "'+ATestVal+'" (multiplied by ' +FormatFloat('#,###',ATimes) + ')');
    end
    else
    begin
      WriteLn('Test String:   "'+ATestVal+'"');
    end;
    if Test(LVTime,LRes,AHash,LTestStr,AExpected) then
    begin
      WriteLn('Test result:   Passed');
      WriteLn('Time:          '+FormatFloat('#,##0',LVTime));
    end
    else
    begin
      WriteLn('Test result:     !!!FAILED!!!');
    end;
    WriteLn('Result:        '+DevideString(LRes,4));
    WriteLn('Expected:      '+DevideString(AExpected,4));
    WriteLn('');
end;

procedure TestItCRC16(const ATestVal, AExpected:String; const ATimes : LongWord = 1);

var LH : TIdHash;
begin
  LH := TIdHashCRC16.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

procedure TestItCRC32(const ATestVal, AExpected:String; const ATimes : LongWord = 1);
var LH : TIdHash;

begin
  LH := TIdHashCRC32.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

procedure TestItMD2(const ATestVal, AExpected:String; const ATimes : LongWord = 1);

var LH : TIdHash;
begin
  LH := TIdHashMessageDigest2.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

procedure TestItMD4(const ATestVal, AExpected:String; const ATimes : LongWord = 1);

var LH : TIdHash;
begin
  LH := TIdHashMessageDigest4.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

procedure TestItMD5(const ATestVal, AExpected:String; const ATimes : LongWord = 1);

var LH : TIdHash;

begin
  LH := TIdHashMessageDigest5.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

procedure TestItSHA1(const ATestVal, AExpected:String; const ATimes : LongWord = 1);
var LH : TIdHash;
begin
  LH := TIdHashSHA1.Create;
  try
    DoTest(LH,ATestVal,AExpected,ATimes);
  finally
    FreeAndNil(LH);
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  WriteLn('===');
  WriteLn('CRC16 test cases - from http://users.physik.tu-muenchen.de/gammel/matpack/demos/Cryptography/MpCRC-demo.cpp - reflect_in+reflect_out');
  WriteLn('===');
  WriteLn('');
  TestItCRC16('','0000');  // reflect_in+reflect_out
  TestItCRC16('A',LowerCase('30C0'));  // reflect_in+reflect_out
  TestItCRC16('123456789',LowerCase('BB3D')); // reflect_in+reflect_out

  WriteLn('===');
  WriteLn('CRC32 test cases - from http://users.physik.tu-muenchen.de/gammel/matpack/demos/Cryptography/MpCRC-demo.cpp - reflect_in+reflect_out');
  WriteLn('===');
  WriteLn('');
  TestItCRC32('','00000000');     // reflect_in+reflect_out
  TestItCRC32('A','D3D99E8B');  // reflect_in+reflect_out
  TestItCRC32('123456789','CBF43926');// reflect_in+reflect_out
  WriteLn('===');
  WriteLn('RFC 1319 - The MD2 Message-Digest Algorithm');
  WriteLn('===');
  WriteLn('');
  TestItMD2('','8350e5a3e24c153df2275c9f80692773');
  TestItMD2('a','32ec01ec4a6dac72c0ab96fb34c0b5d1');
  TestITMD2('abc','da853b0d3f88d99b30283a69e6ded6bb');
  TestItMD2('message digest','ab4f496bfb2a530b219ff33031fe06b0');
  TestItMD2('abcdefghijklmnopqrstuvwxyz','4e8ddff3650292ab5a4108c3aa47940b');
  TestItMD2('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789','da33def2a42df13975352846c30338cd');
  TestItMD2('12345678901234567890123456789012345678901234567890123456789012345678901234567890','d5976f79d83d3a0dc9806c3c66f3efd8');
  WriteLn('===');
  WriteLn('RFC 1320 - The MD4 Message-Digest Algorithm');
  WriteLn('===');
  WriteLn('');
  TestItMD4('','31d6cfe0d16ae931b73c59d7e0c089c0');
  TestItMD4('a','bde52cb31de33e46245e05fbdbd6fb24');
  TestItMD4('abc','a448017aaf21d8525fc10ae87aa6729d');
  TestItMD4('message digest','d9130a8164549fe818874806e1c7014b');
  TestItMD4('abcdefghijklmnopqrstuvwxyz','d79e1c308aa5bbcdeea8ed63df412da9');
  TestItMD4('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789','043f8582f241db351ce627e153e7f0e4');
  TestItMD4('12345678901234567890123456789012345678901234567890123456789012345678901234567890','e33b4ddc9c38f2199c3e7b164fcc0536');
  WriteLn('===');
  WriteLn('RFC 1321 - The MD5 Message-Digest Algorithm');
  WriteLn('===');
  WriteLn('');
  TestItMD5('','d41d8cd98f00b204e9800998ecf8427e');
  TestItMD5('a','0cc175b9c0f1b6a831c399e269772661');
  TestItMD5('abc','900150983cd24fb0d6963f7d28e17f72');
  TestItMD5('message digest','f96b697d7cb7938d525a2f31aaf161d0');
  TestItMD5('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789','d174ab98d277d9f5a5611c2c9f419d9f');
  TestItMD5('12345678901234567890123456789012345678901234567890123456789012345678901234567890','57edf4a22be3c955ac49da2e2107b67a');
  WriteLn('');

  WriteLn('===');
  WriteLn('RFC 3174 - US Secure Hash Algorithm 1 (SHA1)');
  WriteLn('===');
  WriteLn('');
  TestItSHA1('abc',Lowercase('A9993E364706816ABA3E25717850C26C9CD0D89D'));
  TestItSHA1('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq',Lowercase('84983E441C3BD26EBAAE4AA1F95129E5E54670F1'));
  TestItSHA1('a',Lowercase('34AA973CD4C4DAA4F61EEB2BDBAD27316534016F'),1000000);
  TestItSHA1('0123456701234567012345670123456701234567012345670123456701234567',LowerCase('DEA356A2CDDD90C7A7ECEDC5EBB563934F460452'),10);

  WriteLn('===');
  WriteLn('Speed hashing using abc"');
  WriteLn('===');
   WriteLn('MD2');
  TestItMD2('abc','',1000000);
   WriteLn('MD4');
  TestItMD4('abc','',1000000);
  WriteLn('MD5');
  TestItMD5('abc','',1000000);
  WriteLn('SHA1');
  TestItSHA1('abc','',1000000);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
