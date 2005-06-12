program IndyNetTest;

{$APPTYPE CONSOLE}

uses
  IdRegisterTests,
  IdTest;

var
 r:TIdBasicRunner;
begin
 r:=TIdBasicRunner.Create;
 r.Execute;
end.
