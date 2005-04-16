{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17440: IdServerInterceptLogBase.pas }
{
{   Rev 1.6    1/19/05 11:18:16 AM  RLebeau
{ bug fix for GetConnectionID()
}
{
{   Rev 1.5    2004.02.03 5:45:38 PM  czhower
{ Name changes
}
{
{   Rev 1.4    2004.01.22 5:58:58 PM  czhower
{ IdCriticalSection
}
{
{   Rev 1.3    1/21/2004 4:03:20 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    2003.10.17 6:15:02 PM  czhower
{ consts removed
}
{
{   Rev 1.1    2003.10.14 1:31:14 PM  czhower
{ DotNet
}
{
    Rev 1.0    3/22/2003 10:59:20 PM  BGooijen
  Initial check in.
  ServerIntercept to ease debugging, data/status are logged to a file
}
unit IdServerInterceptLogBase;

interface

uses
  Classes,
  IdIntercept, IdGlobal, IdLogBase;

type
  TIdServerInterceptLogBase = class(TIdServerIntercept)
  protected
    FLock: TIdCriticalSection;
    FLogTime: Boolean;
    FReplaceCRLF: Boolean;
    //
    FHasInit:boolean; // BGO: can be removed later, see comment below (.Init)
    procedure InitComponent; override;
  public
    procedure Init; override;
    function Accept(AConnection: TComponent): TIdConnectionIntercept; override;
    destructor Destroy;override;
    procedure DoLogWriteString(AText: string);virtual;abstract;
    procedure LogWriteString(AText: string);virtual;
  published
    property LogTime: Boolean read FLogTime write FLogTime default True;
    property ReplaceCRLF: Boolean read FReplaceCRLF write FReplaceCRLF default true;
  end;

  TIdServerInterceptLogFileConnection = class(TIdLogBase) //BGO: i just love long class names <g>
  protected
    FServerInterceptLog:TIdServerInterceptLogBase;
    procedure LogReceivedData(AText: string; AData: string); override;
    procedure LogSentData(AText: string; AData: string); override;
    procedure LogStatus(AText: string); override;
    function GetConnectionID:string;virtual;
  end;

implementation

uses
  IdIOHandlerSocket,
  IdResourceStringsCore,
  IdTCPConnection,
  SysUtils;

{ TIdServerInterceptLogFile }

function TIdServerInterceptLogBase.Accept( AConnection: TComponent): TIdConnectionIntercept;
begin
  Result:=TIdServerInterceptLogFileConnection.create(nil);
  TIdServerInterceptLogFileConnection(Result).FServerInterceptLog:=self;
  TIdServerInterceptLogFileConnection(Result).LogTime:=FLogTime;
  TIdServerInterceptLogFileConnection(Result).ReplaceCRLF:=FReplaceCRLF;
  TIdServerInterceptLogFileConnection(Result).Active:=true;
end;

procedure TIdServerInterceptLogBase.InitComponent;
begin
  Inherited;
  FReplaceCRLF:=true;
  FLogTime:=true;
  FLock := TIdCriticalSection.Create;
end;

destructor TIdServerInterceptLogBase.Destroy;
begin
  FreeAndNil(FLock);
  inherited;
end;

procedure TIdServerInterceptLogBase.Init;
begin
end;

procedure TIdServerInterceptLogBase.LogWriteString(AText: string);
begin
  if (Length(AText) > 0) then begin
    FLock.Enter;
    try
      if not FHasInit then begin
        Init; // BGO: This is just a hack, TODO find out where to call init
        FHasInit:=true;
      end;
      DoLogWriteString(AText);
    finally
      FLock.Leave;
    end;
  end;
end;

{ TIdServerInterceptLogFileConnection }

procedure TIdServerInterceptLogFileConnection.LogReceivedData(AText, AData: string);
begin
  FServerInterceptLog.LogWriteString(GetConnectionID + ' ' + RSLogRecv + AText + ': ' + AData + EOL);  {Do not translate}
end;

procedure TIdServerInterceptLogFileConnection.LogSentData(AText, AData: string);
begin
  FServerInterceptLog.LogWriteString(GetConnectionID + ' ' + RSLogSent + AText + ': ' + AData + EOL);  {Do not translate}
end;

procedure TIdServerInterceptLogFileConnection.LogStatus(AText: string);
begin
  FServerInterceptLog.LogWriteString(GetConnectionID + ' ' + RSLogStat + AText + EOL);
end;

function TIdServerInterceptLogFileConnection.GetConnectionID:string;
var
  LSocket: TIdIOHandlerSocket;
begin
  if (FConnection is TIdTCPConnection) then begin
    LSocket := TIdTCPConnection(FConnection).Socket;
    if (LSocket <> nil) then begin
      if (LSocket.Binding <> nil) then begin
        with LSocket.Binding do begin
          Result := PeerIP + ':' + IntToStr(PeerPort);
        end;
        Exit;
      end;
    end;
  end;
  Result := '0.0.0.0:0';
end;

end.
 
