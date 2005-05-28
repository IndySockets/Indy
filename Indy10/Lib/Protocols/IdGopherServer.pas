{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11874: IdGopherServer.pas 
{
{   Rev 1.7    12/2/2004 4:23:54 PM  JPMugaas
{ Adjusted for changes in Core.
}
{
{   Rev 1.6    2004.02.03 5:44:48 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/21/2004 3:26:46 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.4    2/24/2003 08:54:00 PM  JPMugaas
}
{
{   Rev 1.3    1/17/2003 07:10:26 PM  JPMugaas
{ Now compiles under new framework.
}
{
{   Rev 1.2    1-1-2003 20:13:12  BGooijen
{ Changed to support the new TIdContext class
}
{
{   Rev 1.1    12/6/2002 04:35:10 PM  JPMugaas
{ Now compiles with new code.
}
{
{   Rev 1.0    11/13/2002 08:30:20 AM  JPMugaas
{ Initial import from FTP VC.
}
unit IdGopherServer;

interface

{
2000-Apr-29 Pete Mee
 - Converted to new Indy format.
1999-Oct-03 Pete Mee
 - Gopher server is very basic... started & completed...
}

uses
  IdAssignedNumbers,
  IdContext,
  IdCustomTCPServer;

{Typical connection:
 - Client attaches with no data
 - Server accepts with no data
 - Client sends request with CR LF termate (CRLF only for root)
 - Server sends items available each with CRLF termating
 - Server sends .CRLF
 - Server close connection
}


Type
  TRequestEvent = procedure(AContext:TIdContext;ARequest:String) of object;
  TPlusRequestEvent = procedure(AContext:TIdContext;ARequest:String;
    APlusData : String) of object;

  TIdGopherServer = class(TIdCustomTCPServer)
  private
    fAdminEmail : String;

    fOnRequest:TRequestEvent;
    fOnPlusRequest : TPlusRequestEvent;

    fTruncateUserFriendly : Boolean;
    fTruncateLength : Integer;
  protected
    function DoExecute(AContext:TIdContext): boolean; override;
    procedure InitComponent; override;
  public
    function ReturnGopherItem(ItemType : Char;
      UserFriendlyName, RealResourceName : String;
      HostServer : String; HostPort : Integer): String;
    procedure SendDirectoryEntry(AContext:TIdContext;
      ItemType : Char; UserFriendlyName, RealResourceName : String;
      HostServer : String; HostPort : Integer);
    procedure SetTruncateUserFriendlyName(truncate : Boolean);
    procedure SetTruncateLength(length : Integer);
  published
    property AdminEmail : String read fAdminEmail write fAdminEmail;
    property OnRequest: TRequestEvent read fOnRequest write fOnRequest;
    property OnPlusRequest : TPlusRequestEvent read fOnPlusRequest
      write fOnPlusRequest;
    property TruncateUserFriendlyName : Boolean read fTruncateUserFriendly
      write SetTruncateUserFriendlyName default True;
    property TruncateLength : Integer read fTruncateLength
      write SetTruncateLength default 70;
  end;

implementation

uses
  IdGlobal, IdGopherConsts, IdResourceStringsProtocols, IdSys;

procedure TIdGopherServer.InitComponent;
begin
  inherited;
  DefaultPort := IdPORT_GOPHER;
  fAdminEmail := '<gopher@domain.example>';    {Do not Localize}
end;

function TIdGopherServer.DoExecute(AContext:TIdContext): boolean;
var
   s : String;
   i : Integer;
begin
  result := true;
  with AContext.Connection do begin
    while Connected do begin
      try
        s:=IOHandler.ReadLn;
        i := Pos(TAB, s);
        if i > 0 then begin
          // Is a Gopher+ request
          if Assigned(OnPlusRequest) then begin
            OnPlusRequest(AContext, Copy(s, 1, i - 1), Copy(s, i + 1, length(s)));
          end else if Assigned(OnRequest) then begin
            OnRequest(AContext, s);
          end else begin
            AContext.Connection.IOHandler.Write(IdGopherPlusData_ErrorBeginSign
              + IdGopherPlusError_NotAvailable
              + RSGopherServerNoProgramCode + EOL
              + IdGopherPlusData_EndSign);
          end;
        end else if Assigned(OnRequest) then begin
           OnRequest(AContext, s)
        end else begin
            AContext.Connection.IOHandler.Write(RSGopherServerNoProgramCode
              + EOL + IdGopherPlusData_EndSign);
        end;
      except
        break;
      end;
      AContext.Connection.Disconnect;
    end;
  end;
end;

function TIdGopherServer.ReturnGopherItem(ItemType : Char;
  UserFriendlyName, RealResourceName : String;
  HostServer : String; HostPort : Integer): String;
begin
     if fTruncateUserFriendly then begin
        if (Length(UserFriendlyName) > fTruncateLength)
        and (fTruncateLength <> 0) then begin
            UserFriendlyName := Copy(UserFriendlyName, 1, fTruncateLength);
        end;
     end;
    result := ItemType + UserFriendlyName +
       TAB + RealResourceName + TAB + HostServer + TAB + Sys.IntToStr(HostPort);
end;

procedure TIdGopherServer.SendDirectoryEntry;
{
Format of server reply to directory (assume no spacing between - i.e.,
one line, with CR LF at the end)
 - Item Type
 - User Description (without tab characters)
 - Tab
 - Server-assigned string to this individual Item Type resource
 - Tab
 - Domain Name of host
 - Tab
 - Port # of host
}
begin
     AContext.Connection.IOHandler.WriteLn(ReturnGopherItem(ItemType, UserFriendlyName,
       RealResourceName, HostServer, HostPort));
end;

procedure TIdGopherServer.SetTruncateUserFriendlyName;
begin
     fTruncateUserFriendly := Truncate;
end;

procedure TIdGopherServer.SetTruncateLength;
begin
     fTruncateLength := Length;
end;

end.
