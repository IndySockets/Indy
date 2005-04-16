{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11651: IdLogEvent.pas 
{
{   Rev 1.2    2004.05.20 12:34:28 PM  czhower
{ Removed more non .NET compatible stream read and writes
}
{
{   Rev 1.1    2003.10.17 8:17:22 PM  czhower
{ Removed const
}
{
{   Rev 1.0    11/13/2002 07:56:08 AM  JPMugaas
}
unit IdLogEvent;

interface

uses
  Classes,
  IdLogBase;

type
  TLogItemStatusEvent = procedure(ASender: TComponent; AText: string) of object;
  TLogItemDataEvent = procedure(ASender: TComponent; AText: string; AData: string)
   of object;

  TIdLogEvent = class(TIdLogBase)
  protected
    FOnReceived: TLogItemDataEvent;
    FOnSent: TLogItemDataEvent;
    FOnStatus: TLogItemStatusEvent;
    //
    procedure LogStatus(AText: string); override;
    procedure LogReceivedData(AText: string; AData: string); override;
    procedure LogSentData(AText: string; AData: string); override;
  public
  published
    property OnReceived: TLogItemDataEvent read FOnReceived write FOnReceived;
    property OnSent: TLogItemDataEvent read FOnSent write FOnSent;
    property OnStatus: TLogItemStatusEvent read FOnStatus write FOnStatus;
  end;

implementation

{ TIdLogEvent }

procedure TIdLogEvent.LogReceivedData(AText, AData: string);
begin
  if Assigned(OnReceived) then begin
    OnReceived(Self, AText, AData);
  end;
end;

procedure TIdLogEvent.LogSentData(AText, AData: string);
begin
  if Assigned(OnSent) then begin
    OnSent(Self, AText, AData);
  end;
end;

procedure TIdLogEvent.LogStatus(AText: string);
begin
  if Assigned(OnStatus) then begin
    OnStatus(Self, AText);
  end;
end;

end.
