{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14978: quotdNoRF.dpr 
{
{   Rev 1.0    1/9/2003 03:40:22 PM  JPMugaas
{ Quotdtest without RunnableFiber links.
}
{
{   Rev 1.0    12/28/2002 8:16:20 AM  JPMugaas
{ Used for testing some new core stuff.
}
program quotdNoRF;

uses
  Forms,
  quotemainNoRF in 'quotemainNoRF.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
