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

 //space is only invalid on win95 etc
 s:=d.RemoveInvalidCharsFromFilename('a b.txt');
 Assert(s='a_b.txt',s);
 
 finally
 Sys.FreeAndNil(d);
 end;
end;

initialization

  TIdTest.RegisterTest(TIdTestMessageCoderMime);

end.
