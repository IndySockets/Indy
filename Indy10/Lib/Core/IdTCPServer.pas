{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12002: IdTCPServer.pas 
{
{   Rev 1.69    12/2/2004 9:26:42 PM  JPMugaas
{ Bug fix.
}
unit IdTCPServer;

interface
uses IdCustomTCPServer;

type
  EIdTCPNoOnExecute = class(EIdTCPServerError);
  TIdTCPServer = class(TIdCustomTCPServer)
  protected
     procedure CheckOkToBeActive;  override;
  public
  published
    property OnExecute;
  end;

implementation
uses IdResourceStringsCore;

{ TIdTCPServer }

procedure TIdTCPServer.CheckOkToBeActive;
begin
  inherited CheckOkToBeActive;

  if not Assigned( FOnExecute) then
  begin
    raise EIdTCPNoOnExecute.Create(RSNoOnExecute);
  end;

end;

end.
