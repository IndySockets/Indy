unit IdTestCookie;

interface

uses
  IdTest,
  IdSys,
  IdCookie;

type

  TIdTestNetscapeCookie = class(TIdTest)
  published
    procedure TestSubDomain;
  end;

implementation

procedure TIdTestNetscapeCookie.TestSubDomain;
var
 aCookie:TIdNetscapeCookie;
 aSuccess:Boolean;
begin

 aCookie:=TIdNetscapeCookie.Create(nil);
 try
 //subdomain should not be valid for other or parent
 aCookie.Domain:='c1.b.a';

 aSuccess:=aCookie.IsValidCookie('c2.b.a');
 Assert(not aSuccess);

 aSuccess:=aCookie.IsValidCookie('b.a');
 Assert(not aSuccess);

 //should be valid for all subdomains
 aCookie.Domain:='.b.a';

 aSuccess:=aCookie.IsValidCookie('c.b.a');
 Assert(aSuccess);

 aSuccess:=aCookie.IsValidCookie('d.c.b.a');
 Assert(aSuccess);

 finally
 Sys.FreeAndNil(aCookie);
 end;

end;

initialization

  TIdTest.RegisterTest(TIdTestNetscapeCookie);

end.
