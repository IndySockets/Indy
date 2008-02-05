{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11275: SNTPBox.pas 
{
{   Rev 1.0    11/12/2002 09:19:46 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit SNTPBox;

interface

uses
  IndyBox,
  IdSNTP;

type

  TSNTPBox = class(TIndyBox)
  protected
    FClient: TIdSNTP;
  public
    procedure Test; override;
    procedure DoGetTime;
    procedure DoSetTime;
  end;

implementation

uses
  Windows,
  SysUtils,
  IniFiles;


const

  {
   SNTP hosts:
   clock.psu.edu  clock.isc.org  time.twc.weather.com  tick.uh.edu  tick.mhpcc.edu
  }

  GTimeHost = 'clock.psu.edu';
  GTimeout = 5000;


procedure TSNTPBox.Test;
begin

  FClient := TIdSNTP.Create(Nil);

  FClient.Host := Trim(GlobalParamValue('SNTP Server'));
  if Length(FClient.Host) = 0 then
  begin
    FClient.Host := GTimeHost;
  end;
  FClient.ReceiveTimeout := GTimeout;

  try
    Status('SNTP Client Tests (2)');

    DoGetTime;
    DoSetTime;

    Status('SNTP Client Tests... Done');
  finally
    FreeAndNil(FClient);
  end;
end;


procedure TSNTPBox.DoGetTime;
var
  iCounter: integer;
  iCount: integer;
  sMsgForm: string;

begin
  iCount := 10;
  sMsgForm := '[%d] GetTime - Time %s RoundTrip %s Adjustment %s';

  Status(Format('SNTP Client Test (1) GetTime [1..%d]', [ iCount ]));

  for iCounter := 1 to iCount do
  begin
    Status(Format(sMsgForm,
      [ iCounter,
        FormatDateTime('hh:nn:ss.zzz', FClient.DateTime),
        FormatDateTime('hh:nn:ss.zzz', FClient.RoundTripDelay),
        FormatDateTime('hh:nn:ss.zzz', FClient.AdjustmentTime) ] ));
    Sleep(GTimeout);
  end;

  Status('SNTP Client Test (1) GetTime... Done.');

end;


procedure TSNTPBox.DoSetTime;
var
//  ASystemTime: TSystemTime;
  ADateTime: TDateTime;
//  iCounter: integer;
  wMo, wDay, wYr: Word;

begin

  ADateTime := Now;
  DecodeDate(ADateTime, wYr, wMo, wDay);
//  ADateTime := EncodeDate(wYr, wMo, wDay) + EncodeTime(0, 0, 0, 1);

  Status('SNTP Client Test (2) SetTime');
  Status('SetTime - Time on Test entry    ' + FormatDateTime('hh:nn:ss.zzz', Now));
//  SetLocalTime(DateTimeToSystemTime(ADateTime));
  Status('SetTime - Time before Test      ' + FormatDateTime('hh:nn:ss.zzz', Now));
  FClient.SyncTime;
  Status('SetTime - Time after Test       ' + FormatDateTime('hh:nn:ss.zzz', Now));
  Status('SNTP Client Test (2) SetTime... Done.');

end;


initialization
  TIndyBox.RegisterBox(TSNTPBox, 'SNTP Client', 'Clients');
end.
