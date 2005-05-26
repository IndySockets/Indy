{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11956: IdRawClient.pas 
{
{   Rev 1.0    11/13/2002 08:45:32 AM  JPMugaas
}
unit IdRawClient;

interface

uses
  IdGlobal,
  IdRawBase;

type
  TIdRawClient = class(TIdRawBase)

  published
    property ReceiveTimeout;
    property Host;
    property Port;
    property Protocol;
    property ProtocolIPv6;
    property IPVersion;
  end;

implementation

{ TIdRawClient }

end.
