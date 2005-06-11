{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13746: IdChargenServer.pas 
{
{   Rev 1.4    12/2/2004 4:23:48 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.3    1/21/2004 1:49:34 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    1/17/2003 05:35:28 PM  JPMugaas
{ Now compiles with new design.
}
{
{   Rev 1.1    1-1-2003 20:12:40  BGooijen
{ Changed to support the new TIdContext class
}
{
{   Rev 1.0    11/14/2002 02:14:02 PM  JPMugaas
}
unit IdChargenServer;

interface

{
2000-Apr-17 Kudzu
  Converted to Indy
  Improved efficiency

Original Author: Ozz Nixon
}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdChargenServer = class(TIdCustomTCPServer)
  protected
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_CHARGEN;
  end;

implementation

{ TIdChargenServer }

procedure TIdChargenServer.InitComponent;
begin
  inherited InitComponent;
  DefaultPort := IdPORT_CHARGEN;
end;

function TIdChargenServer.DoExecute(AContext:TIdContext): boolean;
var
  Counter, Width, Base: integer;
begin
  Base := 0;
  result := true;
  Counter := 1;
  Width := 1;
  with AContext.Connection do begin
    while Connected do begin
      Write(Chr(Counter + 31));
      Inc(Counter);
      Inc(Width);
      if Width = 72 then begin
        Writeln('');  {Do not Localize}
        Width := 1;
        Inc(Base);
        if Base = 95 then begin
          Base := 1;
        end;
        Counter := Base;
      End;
      if Counter = 95 then begin
        Counter := 1;
      end;
    end;
  end;
end;

end.
