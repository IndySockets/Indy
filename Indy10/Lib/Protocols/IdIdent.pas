{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11623: IdIdent.pas 
{
{   Rev 1.6    2004.02.03 5:43:46 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/21/2004 3:10:36 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.4    3/27/2003 3:42:00 PM  BGooijen
  Changed because some properties are moved to IOHandler
}
{
{   Rev 1.3    2/24/2003 09:00:34 PM  JPMugaas
}
{
{   Rev 1.2    12/8/2002 07:25:18 PM  JPMugaas
{ Added published host and port properties.
}
{
{   Rev 1.1    12/6/2002 05:30:00 PM  JPMugaas
{ Now decend from TIdTCPClientCustom instead of TIdTCPClient.
}
{
{   Rev 1.0    11/13/2002 07:54:40 AM  JPMugaas
}
unit IdIdent;

interface
uses Classes, IdAssignedNumbers, IdException, IdTCPClient;
{ 2001 - Feb 12 - J. Peter Mugaas
         started this client

  This is the Ident client which is based on RFC 1413.
}
const
  IdIdentQryTimeout = 60000;
type
  EIdIdentException = class(EIdException);
  EIdIdentReply = class(EIdIdentException);
  EIdIdentInvalidPort = class(EIdIdentReply);
  EIdIdentNoUser = class(EIdIdentReply);
  EIdIdentHiddenUser = class(EIdIdentReply);
  EIdIdentUnknownError = class(EIdIdentReply);
  EIdIdentQueryTimeOut = class(EIdIdentReply);

  TIdIdent = class(TIdTCPClientCustom)
  protected
    FQueryTimeOut : Integer;
    FReplyString : String;
    function GetReplyCharset: String;
    function GetReplyOS: String;
    function GetReplyOther: String;
    function GetReplyUserName: String;
    function FetchUserReply : String;
    function FetchOS : String;
    Procedure ParseError;
    procedure InitComponent; override;
  public
    Procedure Query(APortOnServer, APortOnClient : Word);
    Property Reply : String read FReplyString;
    Property ReplyCharset : String read GetReplyCharset;
    Property ReplyOS : String read GetReplyOS;
    Property ReplyOther : String read GetReplyOther;
    Property ReplyUserName : String read GetReplyUserName;

  published
    property QueryTimeOut : Integer read FQueryTimeOut write FQueryTimeOut default IdIdentQryTimeout;
    Property Port default IdPORT_AUTH;
    property Host;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdResourceStringsProtocols;

const IdentErrorText : Array[0..3] of string =
  ('INVALID-PORT', 'NO-USER', 'HIDDEN-USER', 'UNKNOWN-ERROR');    {Do not Localize}
{ TIdIdent }

procedure TIdIdent.InitComponent;
begin
  inherited;
  FQueryTimeOut := IdIdentQryTimeout;
  Port := IdPORT_AUTH;
end;

function TIdIdent.FetchOS: String;
var Buf : String;
begin
  Buf := FetchUserReply;
  Result := Sys.Trim(Fetch(Buf,':'));    {Do not Localize}
end;

function TIdIdent.FetchUserReply: String;
var Buf : String;
begin
  Result := '';    {Do not Localize}
  Buf := FReplyString;
  Fetch(Buf,':');    {Do not Localize}
  if Sys.UpperCase(Sys.Trim(Fetch(Buf,':'))) = 'USERID' then    {Do not Localize}
    Result := Sys.TrimLeft(Buf);
end;

function TIdIdent.GetReplyCharset: String;
var Buf : String;
begin
  Buf := FetchOS;
  if (Length(Buf) > 0) and (Pos(',',Buf)>0) then    {Do not Localize}
  begin
    Result := Sys.Trim(Fetch(Buf,','));    {Do not Localize}
  end
  else
    Result := 'US-ASCII';    {Do not Localize}
end;

function TIdIdent.GetReplyOS: String;
var Buf : String;
begin
  Buf := FetchOS;
  if Length(Buf) > 0 then
  begin
    Result := Sys.Trim(Fetch(Buf,','));    {Do not Localize}
  end
  else
    Result := '';    {Do not Localize}
end;

function TIdIdent.GetReplyOther: String;
var Buf : String;
begin
  if FetchOS = 'OTHER' then    {Do not Localize}
  begin
    Buf := FetchUserReply;
    Fetch(Buf,':');    {Do not Localize}
    Result := Sys.TrimLeft(Buf);
  end;
end;

function TIdIdent.GetReplyUserName: String;
var Buf : String;
begin
  if FetchOS <> 'OTHER' then    {Do not Localize}
  begin
    Buf := FetchUserReply;
    {OS ID}
    Fetch(Buf,':');    {Do not Localize}
    Result := Sys.TrimLeft(Buf);
  end;
end;

procedure TIdIdent.ParseError;
var Buf : String;
begin
  Buf := FReplyString;
  Fetch(Buf,':');    {Do not Localize}
  if Sys.Trim(Fetch(Buf,':')) = 'ERROR' then    {Do not Localize}
  begin
    case PosInStrArray(Sys.UpperCase(Sys.Trim(Buf)),IdentErrorText) of
          {Invalid Port}
      0 : Raise EIdIdentInvalidPort.Create(RSIdentInvalidPort);
          {No user}
      1 : Raise EIdIdentNoUser.Create(RSIdentNoUser);
          {Hidden User}
      2 : Raise EIdIdentHiddenUser.Create(RSIdentHiddenUser)
    else  {Unknwon or other error}
      Raise EIdIdentUnknownError.Create(RSIdentUnknownError);
    end;
  end;
end;

procedure TIdIdent.Query(APortOnServer, APortOnClient: Word);
var RTO : Boolean;
begin
  FReplyString := '';    {Do not Localize}
  Connect;
  try
    WriteLn(Sys.IntToStr(APortOnServer)+', '+Sys.IntToStr(APortOnClient));    {Do not Localize}
    FReplyString := IOHandler.ReadLn('',FQueryTimeOut);    {Do not Localize}
    {We check here and not return an exception at the moment so we can close our
    connection before raising our exception if the read timed out}
    RTO := IOHandler.ReadLnTimedOut;
  finally
    Disconnect;
  end;
  if RTO then
    Raise EIdIdentQueryTimeOut.Create(RSIdentReplyTimeout)
  else
    ParseError;
end;

end.
