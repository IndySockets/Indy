{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13816: IdEchoServer.pas 
{
{   Rev 1.7    12/2/2004 4:23:52 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.6    1/21/2004 3:27:48 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.5    2003.11.29 10:18:54 AM  czhower
{ Updated for core change to InputBuffer.
}
{
{   Rev 1.4    3/6/2003 5:08:50 PM  SGrobety
{ Updated the read buffer methodes to fit the new core (InputBuffer ->
{ InputBufferAsString + call to CheckForDataOnSource)
}
{
{   Rev 1.3    2/24/2003 08:41:32 PM  JPMugaas
{ Should compile with new code.
}
{
{   Rev 1.2    1/17/2003 05:35:06 PM  JPMugaas
{ Now compiles with new design.
}
{
{   Rev 1.1    1-1-2003 20:13:00  BGooijen
{ Changed to support the new TIdContext class
}
{
{   Rev 1.0    11/14/2002 02:19:30 PM  JPMugaas
}
unit IdEchoServer;

interface

{
2000-Apr=22 J Peter Mugaas
  Ported to Indy
1999-May-13
  Final Version
2000-Jan-13 MTL
  Moved to new Palette Scheme (Winshoes Servers)
Original Author: Ozz Nixon
}

uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdECHOServer = class ( TIdCustomTCPServer )
  protected
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_ECHO;
  end;

implementation

procedure TIdECHOServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_ECHO;
end;

function TIdECHOServer.DoExecute (AContext:TIdContext): boolean;
begin
  result := true;
  with AContext.Connection do begin
    while Connected do begin
      IOHandler.CheckForDataOnSource;
      IOHandler.Write(IOHandler.InputBufferAsString);
     // Write(CurrentReadBuffer);
    end;
  end;
end;

end.
