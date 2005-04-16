{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13804: IdDsnRegister.pas 
{
{   Rev 1.7    9/5/2004 3:16:58 PM  JPMugaas
{ Should work in D9 DotNET.
}
{
{   Rev 1.6    3/8/2004 10:14:54 AM  JPMugaas
{ Property editor for SASL mechanisms now supports TIdDICT.
}
{
{   Rev 1.5    2/26/2004 8:53:14 AM  JPMugaas
{ Hack to restore the property editor for SASL mechanisms.
}
{
{   Rev 1.4    1/25/2004 4:28:42 PM  JPMugaas
{ Removed a discontinued Unit.
}
{
{   Rev 1.3    1/25/2004 3:11:06 PM  JPMugaas
{ SASL Interface reworked to make it easier for developers to use.
{ SSL and SASL reenabled components.
}
{
{   Rev 1.2    10/12/2003 1:49:28 PM  BGooijen
{ Changed comment of last checkin
}
{
{   Rev 1.1    10/12/2003 1:43:28 PM  BGooijen
{ Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc
}
{
{   Rev 1.0    11/14/2002 02:18:56 PM  JPMugaas
}
unit IdDsnRegister;

{$I IdCompilerDefines.inc}

interface

uses
  Classes,
  {$IFDEF VCL9ORABOVE}
     {$IFDEF DOTNET}
      Borland.Vcl.Design.DesignIntF,
      Borland.Vcl.Design.DesignEditors;
     {$ELSE}
      DesignIntf, 
      DesignEditors;
     {$ENDIF}
  {$ELSE}
    {$IFDEF VCL6ORABOVE}
      DesignIntf, 
      DesignEditors;
    {$ELSE}
       Dsgnintf;
    {$ENDIF}
  {$ENDIF}
// Procs
  procedure Register;

implementation
uses
  IdComponent,
  IdGlobal,
  IdDICT,
  IdDsnSASLListEditor,
  IdIMAP4,
  IdMessage,
  {Since we are removing New Design-Time part, we remove the "New Message Part Editor"}
  {IdDsnNewMessagePart, }
  IdSMTP,
  IdPOP3,
  IdStack,
  IdSocketHandle,
  IdTCPServer,
  IdUDPServer,
  IdSASLCollection,
    {$IFDEF Linux}
  QControls, QForms, QStdCtrls, QButtons, QExtCtrls, QActnList
  {$ELSE}
  Controls, Forms, StdCtrls, Buttons, ExtCtrls, ActnList
  {$ENDIF}
  ;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries),TIdSMTP, '',TIdPropEdSASL);
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries),TIdIMAP4, '',TIdPropEdSASL);
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries),TIdPOP3, '',TIdPropEdSASL);
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries),TIdDICT, '',TIdPropEdSASL);
end;

end.
