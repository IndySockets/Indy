{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11773: IdSystat.pas 
{
{   Rev 1.4    10/26/2004 10:49:20 PM  JPMugaas
{ Updated ref.
}
{
{   Rev 1.3    1/21/2004 4:04:04 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.2    2/24/2003 10:29:46 PM  JPMugaas
}
{
{   Rev 1.1    12/6/2002 05:30:38 PM  JPMugaas
{ Now decend from TIdTCPClientCustom instead of TIdTCPClient.
}
{
{   Rev 1.0    11/13/2002 08:02:24 AM  JPMugaas
}
unit IdSystat;
{*******************************************************}
{                                                       }
{       Indy Systat Client TIdSystat                    }
{                                                       }
{       Copyright (C) 2002 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2002-August-13                                  }
{       Based on RFC 866                                }
{                                                       }
{*******************************************************}
{Note that this protocol is officially called Active User}
{2002-Aug-13  J. Peter Mugaas
  -Original version}

interface
uses
  Classes,
  IdAssignedNumbers,
  IdTCPConnection,
  IdTCPClient,
  SysUtils,
  IdTStrings;

type
  TIdSystat = class(TIdTCPClientCustom)
  protected
    procedure InitComponent; override;
  public
    procedure GetStat(ADest : TIdStrings);
  published
    property Port default IdPORT_SYSTAT;
  end;

{
Note that no result parsing is done because RFC 866 does not specify a syntax for
a user list.

Quoted from RFC 866:

   There is no specific syntax for the user list.  It is recommended
   that it be limited to the ASCII printing characters, space, carriage
   return, and line feed.  Each user should be listed on a separate
   line.
}

implementation

{ TIdSystat }

procedure TIdSystat.InitComponent;
begin
  inherited;
  Port := IdPORT_SYSTAT;
end;

procedure TIdSystat.GetStat(ADest: TIdStrings);
begin
  Connect;
  try
    ADest.Text := IOHandler.AllData;
  finally
    Disconnect;
  end;
end;

end.
