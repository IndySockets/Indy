{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13794: IdDiscardServer.pas 
{
{   Rev 1.8    12/2/2004 4:23:50 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.7    1/21/2004 2:12:46 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.6    2003.11.29 10:18:48 AM  czhower
{ Updated for core change to InputBuffer.
}
{
{   Rev 1.5    3/6/2003 5:08:48 PM  SGrobety
{ Updated the read buffer methodes to fit the new core (InputBuffer ->
{ InputBufferAsString + call to CheckForDataOnSource)
}
{
{   Rev 1.4    2/24/2003 08:33:44 PM  JPMugaas
}
{
{   Rev 1.3    1/17/2003 05:35:12 PM  JPMugaas
{ Now compiles with new design.
}
{
{   Rev 1.2    1-1-2003 20:12:56  BGooijen
{ Changed to support the new TIdContext class
}
{
{   Rev 1.1    12/6/2002 02:35:28 PM  JPMugaas
{ Now compiles with Indy 10.
}
{
{   Rev 1.0    11/14/2002 02:18:08 PM  JPMugaas
}
unit IdDiscardServer;

interface

{
2000-Apr-22: J Peter Mugass
  Ported to Indy
1999-Apr-13
  Final Version
2000-JAN-13 MTL
  Moved to new Palette Scheme (Winshoes Servers)
Original Author: Ozz Nixon
}

uses
  Classes,
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

Type
  TIdDISCARDServer = class ( TIdCustomTCPServer )
  protected
    function DoExecute(AContext:TIdContext ): Boolean; override;
    procedure InitComponent; override;
  published
    property DefaultPort default IdPORT_DISCARD;
  end;

implementation

uses
  IdGlobal,
  SysUtils;

procedure TIdDISCARDServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_DISCARD;
end;

function TIdDISCARDServer.DoExecute(AContext:TIdContext): Boolean;
begin
  Result := True;
  // Discard it
  AContext.Connection.IOHandler.CheckForDataOnSource;
  AContext.Connection.IOHandler.InputBufferAsString;
  //InputBuffer.Remove(AContext.Connection.IOHandler.InputBuffer.Size);
end;

end.
