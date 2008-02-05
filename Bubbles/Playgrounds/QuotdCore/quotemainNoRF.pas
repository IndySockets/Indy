{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14980: quotemainNoRF.pas 
{
{   Rev 1.0    1/9/2003 03:40:26 PM  JPMugaas
{ Quotdtest without RunnableFiber links.
}
{
{   Rev 1.1    1/6/2003 12:07:46 PM  JPMugaas
{ Now works with Context.
}
{
{   Rev 1.0    12/28/2002 8:16:26 AM  JPMugaas
{ Used for testing some new core stuff.
}
unit quotemainNoRF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer;

type
  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses IdYarn;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
//  GIdRunAbleClass := TIdRunAbleFiber;
end;

procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
begin
  AContext.Connection.IOHandler.WriteLn('To err is human, to forgive, is divine.');
  AContext.Connection.Disconnect;
end;

end.
