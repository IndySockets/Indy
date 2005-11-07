{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11257: HeaderListTest.pas 
{
{   Rev 1.0    11/12/2002 09:18:24 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit HeaderListTest;

interface
uses IndyBox,
     IdHeaderList;

type
  THeaderListProc = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

{ THeaderListProc }

procedure THeaderListProc.Test;
var h : TIdHeaderList;
begin
  h := TIdHeaderList.Create;
  try
    h.Add('Subject: This is a');
    h.Add(' folded line.');
    Check(h.Values['Subject']='This is a folded line.' ,'Wrong value');
    h.Values['Subject'] := '';
    Check(h.Count = 0,'HeaderList count should have been zero');
    h.Add('Subject: This is a');
    h.Add(' folded line.');
    h.Add('Subject2: This is a');
    h.Add(' folded line.');
    h.Values['Subject'] := '';
    Check(h.Count = 2,'HeaderList count should have been two.');
    Check(h.Values['Subject2']='This is a folded line.','Expected value not returned');
    h.Values['Subject2'] := '';
    h.Add('FirstValue: This is a');
    h.Add(' folded line.');
    h.Add('Dummy: This is a dummy line for a test');
    Check(h.Values['FirstValue']='This is a folded line.','Expected value not returned');
  finally
    h.Free;
  end;
end;

initialization
  TIndyBox.RegisterBox(THeaderListProc, 'HeaderList', 'Misc');
end.
