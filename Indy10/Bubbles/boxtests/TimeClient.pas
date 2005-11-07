{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13712: TimeClient.pas 
{
    Rev 1.1    4/5/2003 3:40:38 PM  BGooijen
  Now uses another host
}
{
{   Rev 1.0    11/13/2002 04:01:42 PM  JPMugaas
}
unit TimeClient;

interface

uses
  IndyBox;

type
  TTimeClient = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  IdTime,
  SysUtils;

const
  // List of time servers available at:
  // http://www.eecis.udel.edu/~mills/ntp/servers.htm

 GTimeHost = 'clock.psu.edu'; //'ntp.marine.csiro.au';

{ TTimeClient }

procedure TTimeClient.Test;
var
  i: integer;
begin
  with TIdTime.Create(nil) do try
    Host := Trim(GlobalParamValue('NTP Server'));
    if Length(Host) = 0 then
    begin
      Host := GTimeHost;
    end;
    for i := 1 to 10 do begin
      Status(IntToStr(i) + ': ' + DateTimeToStr(DateTime));
    end;
  finally Free; end;
end;

initialization
  TIndyBox.RegisterBox(TTimeClient, 'Time Client', 'Clients');
end.
