unit IdTestMessageCoderMime;

interface

uses
  IdMessageCoderMIME,
  IdSys,
  IdTest;

type

  TIdTestMessageCoderMime = class(TIdTest)
  published
    procedure TestFilename;
  end;

implementation

procedure TIdTestMessageCoderMime.TestFilename;
//http://support.microsoft.com/kb/177506/EN-US/
var
 d:TIdMessageDecoderMIME;
 s:string;
begin
 d:=TIdMessageDecoderMIME.Create(nil);
 try

 //basic check of invalid chars at begin,middle,end
 s:=d.RemoveInvalidCharsFromFilename(':a:b:');
 Assert(s='_a_b_',s);

 {
 should this routine be platform specific?
 eg under nt-based system, space is a valid character?
 or is this an invalid test?
 //space is only invalid on win95 etc
 s:=d.RemoveInvalidCharsFromFilename('a b.txt');
 Assert(s='a b.txt',s);
 }

 finally
 Sys.FreeAndNil(d);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestMessageCoderMime);

end.
