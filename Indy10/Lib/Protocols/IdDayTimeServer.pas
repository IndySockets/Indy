{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13784: IdDayTimeServer.pas 
{
{   Rev 1.4    12/2/2004 4:23:50 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.3    1/21/2004 2:12:40 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    1/17/2003 05:35:18 PM  JPMugaas
{ Now compiles with new design.
}
{
{   Rev 1.1    1-1-2003 20:12:48  BGooijen
{ Changed to support the new TIdContext class
}
{
{   Rev 1.0    11/14/2002 02:17:06 PM  JPMugaas
}
unit IdDayTimeServer;

interface

{
2000-Apr-22: J Peter Mugass
  -Ported to Indy
1999-Apr-13
  -Final Version
2000-JAN-13 MTL
  -Moved to new Palette Scheme (Winshoes Servers)
Original Author: Ozz Nixon
}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdDayTimeServer = class(TIdCustomTCPServer)
  protected
    FTimeZone: String;
    //
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property TimeZone: String read FTimeZone write FTimeZone;
    property DefaultPort default IdPORT_DAYTIME;
  end;

implementation

uses
  IdGlobal, IdSys;

procedure TIdDayTimeServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_DAYTIME;
  FTimeZone := 'EST';  {Do not Localize}
end;

function TIdDayTimeServer.DoExecute(AContext:TIdContext ): boolean;
begin
  result := true;
  with AContext.Connection do begin
    Writeln(Sys.FormatDateTime('dddd, mmmm dd, yyyy hh:nn:ss', Sys.Now) + '-' + FTimeZone);    {Do not Localize}
    Disconnect;
  end;
end;

end.
