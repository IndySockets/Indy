{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11649: IdLogDebug.pas 
{
{   Rev 1.4    8/6/04 12:21:28 AM  RLebeau
{ Removed TIdLogDebugTarget type, not used anywhere
}
{
{   Rev 1.3    2004.02.03 4:17:16 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.2    2003.10.17 8:17:22 PM  czhower
{ Removed const
}
{
    Rev 1.1    4/22/2003 4:34:22 PM  BGooijen
  DebugOutput is now in IdGlobal
}
{
{   Rev 1.0    11/13/2002 07:56:02 AM  JPMugaas
}
unit IdLogDebug;

interface

uses
  Classes,
  IdLogBase;

type
  TIdLogDebug = class(TIdLogBase)
  protected
    procedure LogStatus(AText: string); override;
    procedure LogReceivedData(AText: string; AData: string); override;
    procedure LogSentData(AText: string; AData: string); override;
  end;

implementation

uses
  IdGlobal;

{ TIdLogDebug }

procedure TIdLogDebug.LogReceivedData(AText, AData: string);
begin
  DebugOutput('Recv ' + AText + ': ' + AData);    {Do not Localize}
end;

procedure TIdLogDebug.LogSentData(AText, AData: string);
begin
  DebugOutput('Sent ' + AText + ': ' + AData);    {Do not Localize}
end;

procedure TIdLogDebug.LogStatus(AText: string);
begin
  DebugOutput('Stat ' + AText);    {Do not Localize}
end;

end.
