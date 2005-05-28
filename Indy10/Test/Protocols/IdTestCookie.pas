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
 //should be valid for all subdomains
 aCookie.Domain:='.example.com';

 aSuccess:=aCookie.IsValidCookie('sub.example.com');
 Assert(aSuccess);

 aSuccess:=aCookie.IsValidCookie('sub.sub.example.com');
 Assert(aSuccess);
 finally
 Sys.FreeAndNil(aCookie);
 end;

end;

end.
