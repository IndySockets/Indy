{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17112: TCPServerPlaygroundTest.dpr }
{
    Rev 1.0    3/13/2003 8:36:16 PM  BGooijen
  Initial checkin, console application to test the server
}
program TCPServerPlaygroundTest;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  IdTCPClient, IdIOHandlerStack;

var
  LIdTCPClient:TIdTCPClient;
  LIOHandler:TIdIOHandlerStack;
begin
  try
    LIOHandler:=TIdIOHandlerStack.Create(nil);
    try
      LIdTCPClient:=TIdTCPClient.Create(nil);
      try
        LIdTCPClient.IOHandler:=LIOHandler;
        LIdTCPClient.Host:='localhost';
        LIdTCPClient.Port:=6575;
        LIdTCPClient.Connect;

        LIdTCPClient.IOHandler.WriteLn('test1');
        if LIdTCPClient.IOHandler.ReadLn<>'ok1' then begin
          system.writeln('Invalid response for test1');
        end else begin
          system.writeln('Test1 ok');
        end;
        LIdTCPClient.IOHandler.readln;// (a dot) clear buffer

        LIdTCPClient.IOHandler.WriteLn('test2');
        if LIdTCPClient.IOHandler.ReadLn<>'ok2' then begin
          system.writeln('Invalid response for test2');
        end else begin
          system.writeln('Test2 ok');
        end;
        LIdTCPClient.IOHandler.readln;// (a dot) clear buffer

        LIdTCPClient.IOHandler.WriteLn('test3');
        if LIdTCPClient.IOHandler.ReadLn<>'ok3' then begin
          system.writeln('Invalid response for test3');
        end else begin
          system.writeln('Test3 ok');
        end;
        LIdTCPClient.IOHandler.readln;// (a dot) clear buffer

        LIdTCPClient.Disconnect;
      finally
        LIdTCPClient.free;
      end;
    finally
      LIOHandler.free;
    end;
  except on e:exception do
    system.Writeln('Exception: '+e.message);
  end;
  system.Writeln('Press <enter> to terminate');
  system.readln;
end.
