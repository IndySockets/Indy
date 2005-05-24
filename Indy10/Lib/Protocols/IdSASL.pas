{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11729: IdSASL.pas 
{
{   Rev 1.3    10/26/2004 10:55:32 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.2    2004.02.03 5:44:18 PM  czhower
{ Name changes
}
{
{   Rev 1.1    1/21/2004 3:11:34 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 08:00:06 AM  JPMugaas
}
{

SASL Base mechanism for Indy.
See RFC 2222

2002 - 5-19 - J. Peter Mugaas
  started this class definition for Indy 10.
2002 - 08  - J.M. Berg
  reworked, restructured a bit, made work with Indy 9 (most changes
    are in other units though)

This class is not useful in and of itself.  It is for deriving descendant classes
for implementing reusable SASL authentication mechanism classes for components
such as IdPOP3, IdSMTP, and IdIMAP4.
But since they tie into the SASLList, its not restricted to message clients.

Descendant classes will be responsible for implementing the SASL mechanism
completely and holding any data required for authentication, unless descend
from the UserPass mechanism and link to a UserPass provider.
}

{$BOOLEVAL OFF}
unit IdSASL;

interface

uses
  Classes,
  IdBaseComponent,
  IdTCPConnection,
  IdException,
  IdSys,
  IdObjs;

type
  TIdSASLResult = (srSuccess, srFailure, srAborted);
  TIdSASLServiceName = string[20];

  TIdSASL = class(TIdBaseComponent)
  protected
    FSecurityLevel : Cardinal;
    function GetSecurityLevel : Cardinal;
    procedure InitComponent; override;
  public
    destructor Destroy; override;

    {
      The following 3 methods are called when SASL Authentication is
      used. The challenge etc. is already Base64 decoded, if the protocol
      uses Base64 encoding, the mechanism should only process the data
      according to the mechanism, not for any transmission. The same holds
      for return values.
    }
    function StartAuthenticate(const AChallenge: string): string; virtual; abstract;

    function ContinueAuthenticate(const ALastResponse: string): string; virtual;
    { For cleaning up after Authentication }
    procedure FinishAuthenticate; virtual;

    {
      For determining if the SASL Mechanism is supported from a list of SASL Mechanism.
      (Those can be obtained with EHLO with SMTP.)
    }
    function IsAuthProtocolAvailable(AFeatStrings : TIdStrings) : Boolean; virtual;


    {
    Level of security offered by SASL mechanism
      0 - no security, public - broadcast it on the even news, and post it to
          every newsgroup for good measure
      100 - well, at least there's a lock.  Of course, any locksmith or crook
            has a skeleton key
      200 -   well, maybe it would take a little fiddling but not much
      $FFFFFFFF - Best security.  So secret that users are screened
                  thouroughly, for example, the user has to account for
                  every second of their life under a polygraph and their
                  distant relatives are under 24 hour surveillance :-)

      This value is advisory only, and programmers are free if they decide
      to honour it or not. I suggest the mechanisms are tried in order,
      higher security level first.
    }
    property SecurityLevel : Cardinal read GetSecurityLevel;


    {
      Returns the service name of the descendant class,
      this is a string[20] in accordance with the SASL specification.
    }
    class function ServiceName: TIdSASLServiceName; virtual;

  end;


var
  GlobalSASLList: TThreadList;
  // this is used at design time to get a list of all
  // SASL mechanism components that are available
  // because they add at runtime as well, it must be a threadlist

implementation

uses
  IdGlobal;

{ TIdSASL }

function TIdSASL.ContinueAuthenticate(const ALastResponse: string): string;
begin
  // intentionally empty
end;

procedure TIdSASL.InitComponent;
begin
  inherited;
  GlobalSASLList.Add(Self);
end;

destructor TIdSASL.Destroy;
begin
  GlobalSASLList.Remove(Self);
  inherited;
end;

procedure TIdSASL.FinishAuthenticate;
begin
  // do nothing, deliberately
end;

function TIdSASL.GetSecurityLevel: Cardinal;
begin
  Result := FSecurityLevel;
end;

function TIdSASL.IsAuthProtocolAvailable(AFeatStrings: TIdStrings): Boolean;
begin
  Result := (Assigned(AFeatStrings)) and ( AFeatStrings.IndexOf ( ServiceName ) <> -1 );
end;

class function TIdSASL.ServiceName: TIdSASLServiceName;
begin
  Result := ''; {do not localize}
  // this class should never be instantiated or added to the list
  // but BCB required class methods to not be abstract!!
end;

initialization
  GlobalSASLList := TThreadList.Create;
finalization
  Sys.FreeAndNil(GlobalSASLList);
end.
