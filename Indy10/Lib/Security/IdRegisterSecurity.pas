{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  116951: IdRegisterSecurity.pas 
{
{   Rev 1.1    3/28/2005 1:11:30 PM  JPMugaas
{ Package build errors.
}
{
{   Rev 1.0    3/28/2005 5:59:14 AM  JPMugaas
{ New Security package.
}
unit IdRegisterSecurity;

interface
uses
  Classes;

// Procedures
  procedure Register;

implementation
uses IdIOHandlerTls,
     IdServerIOHandlerTls,
     IdDsnCoreResourceStrings;

procedure Register;
begin
  RegisterComponents(RSRegIndyIOHandlers,
    [TIdIOHandlerTls,
    TIdServerIOHandlerTls]);
end;

end.
