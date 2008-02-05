{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17073: Main.pas }
{
{   Rev 1.3    2003.03.26 12:32:14 AM  czhower
{ TCP server and comps created on form now.
}
{
{   Rev 1.2    2003.03.26 12:26:46 AM  czhower
}
{
    Rev 1.1    3/14/2003 2:38:02 PM  BGooijen
  Synchronised logging
}
{
    Rev 1.0    3/13/2003 5:03:32 PM  BGooijen
  Initial check in
}
{
{   Rev 1.6    2003.02.25 1:38:28 AM  czhower
}
{
{   Rev 1.5    2003.02.18 1:36:18 PM  czhower
}
{
{   Rev 1.4    2003.01.17 4:41:30 PM  czhower
}
{
{   Rev 1.3    2003.01.09 11:25:30 PM  czhower
}
{
{   Rev 1.0    2002.12.07 6:44:02 PM  czhower
}
unit Main;

{TODO

-Create about 10 fibers. Does not handle errors well.

-Schedule accross multiple threads

-ChainEngines. Make a component?

-Improve the speed of TIdChainQueue, TList is not very efficient

-Make chain engine a component, and componentize items to be used at design time

-ChainEngine
// TODO: Have an option that allows writes to occur before reads (or vice versa) if they are farther
// down the queue.
// Would be an option as it could goof up some implementations, but most would deal with it fine and
// would have significant performance boosts in ADSL environments.

-Need to handle exceptions. May have trouble in pre D7, see below.
 -May be easier to simply swap the threadvar pointer. This would create
  "Fibervar" support.
 -Another option is to never allow switchto while an active exception is in process.
 -The functions mentioned below are deprecated
 -Find TLS discussion and limits from notes

"Tjipke A. van der Plaats" <info@tiriss.com>
any knowledge of fibers in your team? If, for example, you would like to be
able to support exceptions for each fiber, you need to preserve the
exception stack (RaiseList): and there is a bug in that part of Delphi that
was only just fixed in D7 (SetRaiseList doesn't work in pre D7 versions).


}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  IdFiber, IdTCPClient, IdSync, IdFiberWeaver, ExtCtrls, IdIOHandlerChain,IdContext,IdHTTPHeaderInfo,IdCustomHTTPServer,
  ComCtrls, IdBaseComponent, IdComponent, IdTCPServer,IdCmdTCPServer,IdHTTPServer,
  IdServerIOHandler, IdServerIOHandlerChain, IdChainEngineStack,
  IdScheduler, IdSchedulerFiber;

type
  TformMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    memoTest: TMemo;
    tcpsTest: TIdCmdTCPServer;
    IdServerIOHandlerChain1: TIdServerIOHandlerChain;
    IdChainEngineStack1: TIdChainEngineStack;
    IdSchedulerFiber1: TIdSchedulerFiber;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  protected
    procedure IdHTTPServer1Get(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1Connect(AContext:TIdContext);
    procedure IdHTTPServer1DisConnect(AContext:TIdContext);
  public
    IdHTTPServer1:TIdHTTPServer;
  end;

var
  formMain: TformMain;

implementation
{$R *.dfm}

uses
  Global,
  SyncObjs;

type
  TConnectSync = class(TIdSync)
  protected
    procedure DoSynchronize; override;
  public
    class procedure CreateSync;
  end;

  TDisconnectSync = class(TConnectSync)
  protected
    procedure DoSynchronize; override;
  end;

procedure TformMain.Button1Click(Sender: TObject);
begin
  tcpsTest.Active := True;
end;

procedure TformMain.Button2Click(Sender: TObject);
begin
//TIdServerIOHandlerChain(IdHTTPServer1.IOHandler).ChainEngine:=TIdChainEngineStack.create(IdHTTPServer1.IOHandler);
  IdHTTPServer1:=TIdHTTPServer.create(self);
  IdHTTPServer1.KeepAlive:=false;
  IdHTTPServer1.OnCommandGet:=IdHTTPServer1Get;
  IdHTTPServer1.OnConnect:=IdHTTPServer1Connect;
  IdHTTPServer1.OnDisconnect:=IdHTTPServer1DisConnect;
  IdHTTPServer1.IOHandler:=TIdServerIOHandlerChain.Create(IdHTTPServer1);
  IdHTTPServer1.Scheduler:=TIdSchedulerFiber.Create(IdHTTPServer1);
  IdHTTPServer1.Active := true;
end;
procedure TformMain.IdHTTPServer1Get(AContext:TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LDoc:string;
begin
  LDoc:=ARequestInfo.Document;
  if copy(LDoc,length(LDoc),1)='/' then
    LDoc:=LDoc+'index.html';
  if copy(LDoc,1,1)='/' then delete(LDoc,1,1);
  AResponseInfo.ContentStream:=TFileStream.create(ExtractFilePath(paramstr(0))+'web\'+ldoc, fmOpenRead	or fmShareDenyWrite);
//  AResponseInfo.ContentText:='YES, it works!!!';
end;

procedure TformMain.IdHTTPServer1Connect(AContext:TIdContext);
begin
  TConnectSync.CreateSync;
end;

procedure TformMain.IdHTTPServer1DisConnect(AContext:TIdContext);
begin
  TDisconnectSync.CreateSync;
end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(IdHTTPServer1);
end;

{ TConnectSync }

class procedure TConnectSync.CreateSync;
var LCon : TConnectSync;
begin
  LCon := Create;
  LCon.Synchronize;
end;

procedure TConnectSync.DoSynchronize;
begin
  formMain.memoTest.Lines.Add('<<Client connected>>');
end;

{ TDisconnectSync }

procedure TDisconnectSync.DoSynchronize;
begin
  formMain.memoTest.Lines.Add('<<Client disconnected>>');
end;

end.
