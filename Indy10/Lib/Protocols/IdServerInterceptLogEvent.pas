{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17444: IdServerInterceptLogEvent.pas }
{
{   Rev 1.1    10/17/2003 6:24:58 PM  BGooijen
{ Removed const 
}
{
    Rev 1.0    3/22/2003 11:06:06 PM  BGooijen
  Initial check in.
  ServerIntercept to log data/status to an event.
}
unit IdServerInterceptLogEvent;

interface

uses
  IdServerInterceptLogBase;

type
  TIdServerInterceptLogEvent=class;
  
  TIdOnLogString=procedure (ASender: TIdServerInterceptLogEvent; AText: string) of object;

  TIdServerInterceptLogEvent = class(TIdServerInterceptLogBase)
  protected
    FOnLogString:TIdOnLogString;
  public
    procedure DoLogWriteString(AText: string);override;
  published
    property OnLogString:TIdOnLogString read FOnLogString write FOnLogString;
  end;

implementation

{ TIdServerInterceptLogEvent }

procedure TIdServerInterceptLogEvent.DoLogWriteString(AText: string);
begin
  if Assigned(FOnLogString) then begin
    FOnLogString(self,AText);
  end;
end;

end.
