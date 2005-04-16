{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  22744: IdFTPServerContextBase.pas 
{
{   Rev 1.0    8/24/2003 06:47:42 PM  JPMugaas
{ FTPContext base class so that the ThreadClass may be shared with the
{ FileSystem classes.
}
unit IdFTPServerContextBase;

interface
uses
  Classes,
  IdContext;

{This is for a basic thread class that can be shared with the FTP File System component
and any other file system class so they can share more information than just the Username}
type
  TIdFTPUserType = (utNone, utAnonymousUser, utNormalUser);
  TIdFTPServerContextBase = class(TIdContext)
  protected
      FUserType: TIdFTPUserType;
    FAuthenticated: Boolean;
    FALLOSize: Integer;
    FCurrentDir: string;
      FHomeDir: string;
    FUsername: string;
    FPassword: string;
     FRESTPos: Integer;
    FRNFR: string;
    procedure ReInitialize; virtual;
  public
    property Authenticated: Boolean read FAuthenticated write FAuthenticated;
    property ALLOSize: Integer read FALLOSize write FALLOSize;
    property CurrentDir: string read FCurrentDir write FCurrentDir;

    property HomeDir: string read FHomeDir write FHomeDir;
    property Password: string read FPassword write FPassword;
    property Username: string read FUsername write FUsername;
    property UserType: TIdFTPUserType read FUserType write FUserType;
    property RESTPos: Integer read FRESTPos write FRESTPos;
    property RNFR: string read FRNFR write FRNFR;
  end;
  
implementation

{ TIdFTPServerContextBase }

procedure TIdFTPServerContextBase.ReInitialize;
begin
  UserType := utNone;
  FAuthenticated := False;
  FALLOSize := 0;
  FCurrentDir := '/';    {Do not Localize}
    FHomeDir := '';    {Do not Localize}
  FUsername := '';    {Do not Localize}
  FPassword := '';    {Do not Localize}
    FRESTPos := 0;
  FRNFR := '';    {Do not Localize}
end;

end.
