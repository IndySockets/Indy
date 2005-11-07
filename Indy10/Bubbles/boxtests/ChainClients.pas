{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18245: ChainClients.pas 
{
{   Rev 1.5    6/24/2003 01:15:08 PM  JPMugaas
{ Updated for API change.
}
{
{   Rev 1.4    2003.05.19 10:18:02 AM  czhower
}
{
{   Rev 1.3    2003.04.22 9:56:18 PM  czhower
}
{
    Rev 1.2    4/16/2003 4:51:54 PM  BGooijen
}
{
{   Rev 1.1    2003.04.15 12:46:10 PM  czhower
}
{
{   Rev 1.11    2003.04.10 11:23:46 PM  czhower
}
{
{   Rev 1.10    2003.03.27 1:32:06 AM  czhower
{ More fiber tests
}
{
{   Rev 1.9    2003.03.27 12:46:20 AM  czhower
}
{
{   Rev 1.8    2003.03.27 12:29:34 AM  czhower
}
{
{   Rev 1.7    2003.02.27 12:55:40 AM  czhower
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
unit ChainClients;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  IdFiber, IdTCPClient, IdSync, ExtCtrls, IdIOHandlerChain,
  ComCtrls, BXBubble;

type
  TformChainClients = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    lablThreads: TLabel;
    lablReturns: TLabel;
    butnFiber: TButton;
    editFibers: TEdit;
    editRepeat: TEdit;
    editDocument: TEdit;
    editHost: TEdit;
    memoTest: TMemo;
    ChainClient: TBXBubble;
    GroupBox1: TGroupBox;
    radoTCP: TRadioButton;
    radoHTTP: TRadioButton;
    GroupBox2: TGroupBox;
    radoWinsock: TRadioButton;
    radoIOCP: TRadioButton;
    procedure butnFiberClick(Sender: TObject);
    procedure ChainClientPlayground(Sender: TBXBubble);
  private
  protected
    FMainFiber: TIdConvertedFiber;
    FStream: TStringStream;
    FReturnCount: Integer;
    FThreadCount: Integer;
    //
    procedure HTTPTestFiber(const AUseHTTP: Boolean; const AUseIOCP: Boolean);
    procedure OnFiberIdle(AFiber: TObject);
    procedure OnFiberSwitch(AFiberWeaver: TIdFiberWeaver; AFiber: TIdFiberBase);
    procedure UpdateLabels;
  public
  end;

  TClientFiber = class(TIdFiber)
  protected
    FChainEngine: TIdChainEngine;
    FDocument: string;
    FFiberWeaver: TIdFiberWeaver;
    FHost: string;
  end;

  TTCPFiber = class(TClientFiber)
  protected
    procedure Execute; override;
  end;

  THTTPFiber = class(TClientFiber)
  protected
    procedure Execute; override;
  end;

var
  formChainClients: TformChainClients;

implementation
{$R *.dfm}

uses
  IdIOHandlerStack, IdChainEngineIOCP, IdCoreGlobal, IdStack,
  IdChainEngineStack, IdHTTP, IdFiberWeaverDefault,
  SyncObjs;

procedure TformChainClients.UpdateLabels;
begin
  lablThreads.Caption := 'Threads: ' + IntToStr(FThreadCount);
  lablReturns.Caption := 'Returns: ' + IntToStr(FReturnCount);
end;

procedure TformChainClients.butnFiberClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to StrToInt(editRepeat.Text) do begin
    HTTPTestFiber(radoHTTP.Checked, radoIOCP.Checked);
  end;
  memoTest.Lines.Add(' ======= Done ========== ');
end;

{ TTCPFiber }

procedure TTCPFiber.Execute;
var
  LHTTPResult: TStringStream;
  LIOHandler: TIdIOHandlerChain;
begin
  // The IOHandlerChain "links" the IOHandler to the FiberWeaver and integrates
  // with its scheduling mechanism
  //
  // The fiber is also passed so it knows which fiber it will use for this
  // instance of IOHandler.
  //
  // The IOHandlerChain is actually independent of the IO itself, it merely
  // queues and communicates with the ChainEngine. The ChainEngine does all the
  // actuall IO and will be pluggable. Right now its using Stack as Phase I, but
  // later will have options to use IOCP, Overlapped IO or other.
  LIOHandler := TIdIOHandlerChain.Create(nil, FChainEngine, FFiberWeaver
   , Self); try
    with TIdTCPClient.Create(nil) do try
      IOHandler := LIOHandler;
      Host := FHost;
      Port := 80;
      Connect; try
        IOHandler.Write('GET ' + FDocument + ' HTTP/1.0' + EOL + EOL);
        LHTTPResult := TStringStream.Create(''); try
          IOHandler.ReadStream(LHTTPResult, -1, True);
          with formChainClients.memoTest.Lines do begin
            Add(LHTTPResult.DataString);
            Add(EOL + '_____________________' + EOL);
          end;
          Inc(formChainClients.FReturnCount);
          formChainClients.UpdateLabels;
        finally FreeAndNil(LHTTPResult); end;
      finally Disconnect; end;
    finally Free; end;
  finally FreeAndNil(LIOHandler); end;
end;

procedure TformChainClients.HTTPTestFiber(const AUseHTTP: Boolean;
 const AUseIOCP: Boolean);
var
  i: Integer;
  LChainEngine: TIdChainEngine;
  LFiberWeaver: TIdFiberWeaverDefault;
  LFibers: TList;
  LFiber: TClientFiber;
  LSelfFiber: TIdConvertedFiber;
begin
  if AUseIOCP then begin
    LChainEngine := TIdChainEngineIOCP.Create(nil);
  end else begin
    LChainEngine := TIdChainEngineStack.Create(nil);
  end;
  try
    // All fibers MUST have a parent fiber. The parent fiber is the
    // fiber that gets "fallen back" on when all other fibers have finished.
    // A converted fiber is a special fiber, its a fiber that is created "out of"
    // the current thread.
    LSelfFiber := TIdConvertedFiber.Create; try
      LSelfFiber.Name := 'Converted';
      // The fiber weaver is a scheduler for the fibers. It schedules the fibers
      // onto threads and
      LFiberWeaver := TIdFiberWeaverDefault.Create(nil); try
        // This is a list of fibers so we can destroy them later.
        LFibers := TList.Create; try
          // Create the specified number of fibers and add them to the FiberWeaver
          for i := 1 to StrToInt(editFibers.Text) do begin
            if AUseHTTP then begin
              LFiber := THTTPFiber.Create(LSelfFiber, LFiberWeaver);
            end else begin
              LFiber := TTCPFiber.Create(LSelfFiber, LFiberWeaver);
            end;
            LFiber.Name := 'Fiber ' + IntToStr(i);
            with LFiber do begin
              FChainEngine := LChainEngine;
              FFiberWeaver := LFiberWeaver;
              FHost := Trim(editHost.Text);
              FDocument := Trim(editDocument.Text);
            end;
            LFibers.Add(LFiber);
          end;
          // Run fibers. This will run all fibers until every fiber has run and
          // completed. It will then return. In this case, all fibers will run
          // under this thread.
          LFiberWeaver.ProcessInThisFiber(LSelfFiber);
          // Free the fibers
          for i := 0 to LFibers.Count - 1 do begin
            TIdFiber(LFibers[i]).Free;
          end;
        finally FreeAndNil(LFibers); end;
      // Freeing causes AVs - trying to fix this now
      finally FreeAndNil(LFiberWeaver); end;
    finally FreeAndNil(LSelfFiber); end;
  finally FreeAndNil(LChainEngine); end;
end;

procedure TformChainClients.OnFiberSwitch(AFiberWeaver: TIdFiberWeaver;
 AFiber: TIdFiberBase);
begin
  Application.ProcessMessages;
end;

procedure TformChainClients.OnFiberIdle(AFiber: TObject);
begin
  Application.ProcessMessages;
end;

{ THTTPFiber }

procedure THTTPFiber.Execute;
var
  LHTTPResult: TStringStream;
  LIOHandler: TIdIOHandlerChain;
begin
  LIOHandler := TIdIOHandlerChain.Create(nil, FChainEngine, FFiberWeaver
   , Self); try
    with TIdHTTP.Create(nil) do try
      IOHandler := LIOHandler;
      LHTTPResult := TStringStream.Create(''); try
        Get('http://' + FHost + FDocument, LHTTPResult);
        with formChainClients.memoTest.Lines do begin
          Add(LHTTPResult.DataString);
          Add(EOL + '_____________________' + EOL);
        end;
        Inc(formChainClients.FReturnCount);
        formChainClients.UpdateLabels;
      finally FreeAndNil(LHTTPResult); end;
    finally Free; end;
  finally FreeAndNil(LIOHandler); end;
end;

procedure TformChainClients.ChainClientPlayground(Sender: TBXBubble);
begin
  ShowModal;
end;

end.
