{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.5    10/26/2004 10:51:40 PM  JPMugaas
  Updated ref.

  Rev 1.4    7/6/2004 4:53:46 PM  DSiders
  Corrected spelling of Challenge in properties, methods, types.

  Rev 1.3    2004.02.03 5:44:40 PM  czhower
  Name changes

  Rev 1.2    2004.01.22 2:05:16 PM  czhower
  TextIsSame

  Rev 1.1    1/21/2004 4:21:08 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 08:04:16 AM  JPMugaas
}
unit IdUserAccounts;
{
 Original Author: Sergio Perry
 Date: 24/04/2001

 2002-05-03 - Andrew P.Rybin
   - TIdCustomUserManager,TIdSimpleUserManager,UserId
   - universal TIdUserManagerAuthenticationEvent> Sender: TObject
}

interface
{$i IdCompilerDefines.inc}

uses
  Classes,
  IdException,
  IdGlobal,
  IdBaseComponent,
  IdComponent,
  IdStrings;

type
  TIdUserHandle = UInt32;//ptr,object,collection.item.id or THandle
  TIdUserAccess = Integer; //<0-denied, >=0-accept; ex: 0-guest,1-user,2-power user,3-admin

var
  IdUserHandleNone: TIdUserHandle = High(UInt32)-1; //Special handle: empty handle
  IdUserHandleBroadcast: TIdUserHandle = High(UInt32); //Special handle
  IdUserAccessDenied: TIdUserAccess = Low(Integer); //Special access

type
  TIdCustomUserManagerOption = (umoCaseSensitiveUsername, umoCaseSensitivePassword);
  TIdCustomUserManagerOptions = set of TIdCustomUserManagerOption;

  TIdUserManagerAuthenticationEvent = procedure(Sender: TObject; {TIdCustomUserManager, TIdPeerThread, etc}
    const AUsername: String;
    var VPassword: String;
    var VUserHandle: TIdUserHandle;
    var VUserAccess: TIdUserAccess) of object;
  TIdUserManagerLogoffEvent = procedure(Sender: TObject; var VUserHandle: TIdUserHandle) of object;

  TIdCustomUserManager = class(TIdBaseComponent)
  protected
    FDomain: String;
    FOnAfterAuthentication: TIdUserManagerAuthenticationEvent; //3
    FOnBeforeAuthentication: TIdUserManagerAuthenticationEvent;//1
    FOnLogoffUser: TIdUserManagerLogoffEvent;//4
    //
    procedure DoBeforeAuthentication(const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); virtual;
    // Descendants must override this method:
    procedure DoAuthentication (const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); virtual; abstract;
    procedure DoAfterAuthentication (const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); virtual;
    procedure DoLogoffUser(var VUserHandle: TIdUserHandle); virtual;
    function  GetOptions: TIdCustomUserManagerOptions; virtual;
    procedure SetDomain(const AValue: String); virtual;
    procedure SetOptions(const AValue: TIdCustomUserManagerOptions); virtual;

    // props
    property  Domain: String read FDomain write SetDomain;
    property  Options: TIdCustomUserManagerOptions read GetOptions write SetOptions;
    // events
    property  OnBeforeAuthentication: TIdUserManagerAuthenticationEvent
      read FOnBeforeAuthentication write FOnBeforeAuthentication;
    property  OnAfterAuthentication: TIdUserManagerAuthenticationEvent
      read FOnAfterAuthentication write FOnAfterAuthentication;
    property  OnLogoffUser: TIdUserManagerLogoffEvent read FOnLogoffUser write FOnLogoffUser;
  public
    //Challenge user is a nice backdoor for some things we will do in a descendent class
    function  ChallengeUser(var VIsSafe : Boolean; const AUserName : String) : String; virtual;
    function  AuthenticateUser(const AUsername, APassword: String): Boolean; overload;
    function  AuthenticateUser(const AUsername, APassword: String; var VUserHandle: TIdUserHandle): TIdUserAccess; overload;
    class function IsRegisteredUser(AUserAccess: TIdUserAccess): Boolean;
    procedure LogoffUser(AUserHandle: TIdUserHandle); virtual;
    procedure UserDisconnected(const AUser : String); virtual;
    function SendsChallange : Boolean;  virtual;
  End;//TIdCustomUserManager

  //=============================================================================
  // * TIdSimpleUserManager *
  //=============================================================================
  TIdSimpleUserManager = class(TIdCustomUserManager)
  protected
    FOptions: TIdCustomUserManagerOptions;
    FOnAuthentication: TIdUserManagerAuthenticationEvent;
    //
    procedure DoAuthentication (const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); override;
    function  GetOptions: TIdCustomUserManagerOptions; override;
    procedure SetOptions(const AValue: TIdCustomUserManagerOptions); override;
  published
    property  Domain;
    property  Options;
    // events
    property  OnBeforeAuthentication;
    property  OnAuthentication: TIdUserManagerAuthenticationEvent read FOnAuthentication write FOnAuthentication;
    property  OnAfterAuthentication;
    property  OnLogoffUser;
  End;//TIdSimpleUserManager

  //=============================================================================
  // * TIdUserManager *
  //=============================================================================
const
  IdUserAccountDefaultAccess = 0;//guest

type
  TIdUserManager = class;

  TIdUserAccount = class(TCollectionItem)
  protected
    FAttributes: TStrings;
    {$IFDEF USE_OBJECT_ARC}
    // When ARC is enabled, object references MUST be valid objects.
    // It is common for users to store non-object values, though, so
    // we will provide separate properties for those purposes
    //
    // TODO; use TValue instead of separating them
    //
    FDataObject: TObject;
    FDataValue: PtrInt;
    {$ELSE}
    FData: TObject;
    {$ENDIF}
    FUserName: string;
    FPassword: string;
    FRealName: string;
    FAccess: TIdUserAccess;
    //
    procedure SetAttributes(const AValue: TStrings);
    procedure SetPassword(const AValue: String); virtual;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    //
    function  CheckPassword(const APassword: String): Boolean; virtual;
    //
    {$IFDEF USE_OBJECT_ARC}
    property  Data: TObject read FDataObject write FDataObject;
    property  DataValue: PtrInt read FDataValue write FDataValue;
    {$ELSE}
    property  Data: TObject read FData write FData;
    {$ENDIF}
  published
    property  Access: TIdUserAccess read FAccess write FAccess default IdUserAccountDefaultAccess;
    property  Attributes: TStrings read FAttributes write SetAttributes;
    property  UserName: string read FUserName write FUserName;
    property  Password: string read FPassword write SetPassword;
    property  RealName: string read FRealName write FRealName;
  End;//TIdUserAccount

  TIdUserAccounts = class(TOwnedCollection)
  protected
    FCaseSensitiveUsernames: Boolean;
    FCaseSensitivePasswords: Boolean;
    //
    function  GetAccount(const AIndex: Integer): TIdUserAccount;
    function  GetByUsername(const AUsername: String): TIdUserAccount;
    procedure SetAccount(const AIndex: Integer; AAccountValue: TIdUserAccount);
  public
    function Add: TIdUserAccount; reintroduce;
    constructor Create(AOwner: TIdUserManager);
    //
    property CaseSensitiveUsernames: Boolean read FCaseSensitiveUsernames
      write FCaseSensitiveUsernames;
    property CaseSensitivePasswords: Boolean read FCaseSensitivePasswords
      write FCaseSensitivePasswords;
    property UserNames[const AUserName: String]: TIdUserAccount read GetByUsername; default;
    property Items[const AIndex: Integer]: TIdUserAccount read GetAccount write SetAccount;
  end;//TIdUserAccounts

  TIdUserManager = class(TIdCustomUserManager)
  protected
    FAccounts: TIdUserAccounts;
    //
    procedure DoAuthentication (const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); override;
    function  GetOptions: TIdCustomUserManagerOptions; override;
    procedure SetAccounts(AValue: TIdUserAccounts);
    procedure SetOptions(const AValue: TIdCustomUserManagerOptions); override;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
  published
    property Accounts: TIdUserAccounts read FAccounts write SetAccounts;

    property  Options;
    // events
    property  OnBeforeAuthentication;
    property  OnAfterAuthentication;
  End;//TIdUserManager

implementation

uses
  SysUtils;

{ How add UserAccounts to your component:
1) property UserAccounts: TIdCustomUserManager read FUserAccounts write SetUserAccounts;
2) procedure SetUserAccounts(const AValue: TIdCustomUserManager);
   begin
     if FUserAccounts <> AValue then begin
       if Assigned(FUserAccounts) then begin
         FUserAccounts.RemoveFreeNotification(Self);
       end;
       FUserAccounts := AValue;
       if Assigned(FUserAccounts) then begin
         FUserAccounts.FreeNotification(Self);
       end;
     end;
   end;
3) procedure Notification(AComponent: TComponent; Operation: TOperation);
   begin
     ...
     if (Operation = opRemove) and (AComponent = FUserAccounts) then begin
       FUserAccounts := nil;
     end;
     ...
     inherited Notification(AComponent, Operation);
   end;
4) ... if Assigned(FUserAccounts) then begin
   FAuthenticated := FUserAccounts.AuthenticateUser(FUsername, ASender.UnparsedParams);
   if FAuthenticated then else
}

{ TIdCustomUserManager }

function TIdCustomUserManager.AuthenticateUser(const AUsername, APassword: String): Boolean;
var
  LUserHandle: TIdUserHandle;
Begin
  Result := IsRegisteredUser(AuthenticateUser(AUsername, APassword, LUserHandle));
  LogoffUser(LUserHandle);
End;//AuthenticateUser

function TIdCustomUserManager.AuthenticateUser(const AUsername, APassword: String; var VUserHandle: TIdUserHandle): TIdUserAccess;
var
  LPassword: String;
Begin
  LPassword := APassword;
  VUserHandle := IdUserHandleNone;
  Result := IdUserAccessDenied;
  DoBeforeAuthentication(AUsername, LPassword, VUserHandle, Result);
  DoAuthentication(AUsername, LPassword, VUserHandle, Result);
  DoAfterAuthentication(AUsername, LPassword, VUserHandle, Result);
End;//

class function TIdCustomUserManager.IsRegisteredUser(AUserAccess: TIdUserAccess): Boolean;
Begin
  Result := AUserAccess>=0;
End;

procedure TIdCustomUserManager.DoBeforeAuthentication(const AUsername: String; var VPassword: String;
  var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess);
Begin
  if Assigned(FOnBeforeAuthentication) then begin
    FOnBeforeAuthentication(SELF,AUsername,VPassword,VUserHandle,VUserAccess);
  end;
End;//

procedure TIdCustomUserManager.DoAfterAuthentication(const AUsername: String; var VPassword: String;
  var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess);
Begin
  if Assigned(FOnAfterAuthentication) then begin
    FOnAfterAuthentication(SELF,AUsername,VPassword,VUserHandle,VUserAccess);
  end;
End;//

function TIdCustomUserManager.GetOptions: TIdCustomUserManagerOptions;
Begin
  Result := [];
End;//

procedure TIdCustomUserManager.SetOptions(const AValue: TIdCustomUserManagerOptions);
Begin
End;

procedure TIdCustomUserManager.SetDomain(const AValue: String);
begin
  if FDomain<>AValue then begin
    FDomain := AValue;
  end;
end;

procedure TIdCustomUserManager.LogoffUser(AUserHandle: TIdUserHandle);
Begin
  DoLogoffUser(AUserHandle);
End;//free resources, unallocate handles, etc...

//=============================================================================

procedure TIdCustomUserManager.DoLogoffUser(var VUserHandle: TIdUserHandle);
Begin
  if Assigned(FOnLogoffUser) then begin
    FOnLogoffUser(SELF, VUserHandle);
  end;
End;//

function TIdCustomUserManager.ChallengeUser(var VIsSafe : Boolean;
  const AUserName: String): String;
begin
  VIsSafe := True;
  Result := '';
end;

procedure TIdCustomUserManager.UserDisconnected(const AUser: String);
begin

end;

function TIdCustomUserManager.SendsChallange : Boolean;
begin
  Result := False;
end;

{ TIdUserAccount }

function TIdUserAccount.CheckPassword(const APassword: String): Boolean;
begin
  if (Collection as TIdUserAccounts).CaseSensitivePasswords then begin
    Result := Password = APassword;
  end else begin
    Result := TextIsSame(Password, APassword);
  end;
end;

constructor TIdUserAccount.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FAttributes := TStringList.Create;
  FAccess := IdUserAccountDefaultAccess;
end;

destructor TIdUserAccount.Destroy;
begin
  FreeAndNil(FAttributes);
  inherited Destroy;
end;

procedure TIdUserAccount.SetAttributes(const AValue: TStrings);
begin
  FAttributes.Assign(AValue);
end;

procedure TIdUserAccount.SetPassword(const AValue: String);
begin
  FPassword := AValue;
end;

{ TIdUserAccounts }

constructor TIdUserAccounts.Create(AOwner: TIdUserManager);
begin
  inherited Create(AOwner, TIdUserAccount);
end;

function TIdUserAccounts.GetAccount(const AIndex: Integer): TIdUserAccount;
begin
  Result := TIdUserAccount(inherited Items[AIndex]);
end;

function TIdUserAccounts.GetByUsername(const AUsername: String): TIdUserAccount;
var
  i: Integer;
begin
  Result := nil;
  if CaseSensitiveUsernames then begin
    for i := 0 to Count - 1 do begin
      if AUsername = Items[i].UserName then begin
        Result := Items[i];
        Break;
      end;
    end;
  end
  else begin
    for i := 0 to Count - 1 do begin
      if TextIsSame(AUsername, Items[i].UserName) then begin
        Result := Items[i];
        Break;
      end;
    end;
  end;
end;

procedure TIdUserAccounts.SetAccount(const AIndex: Integer; AAccountValue: TIdUserAccount);
begin
  inherited SetItem(AIndex, AAccountValue);
end;

function TIdUserAccounts.Add: TIdUserAccount;
begin
  Result := inherited Add as TIdUserAccount;
end;

{ IdUserAccounts - Main Component }

procedure TIdUserManager.InitComponent;
begin
  inherited;
  FAccounts := TIdUserAccounts.Create(Self);
end;

destructor TIdUserManager.Destroy;
begin
  FreeAndNil(FAccounts);
  inherited Destroy;
end;

procedure  TIdUserManager.DoAuthentication(const AUsername: String; var VPassword: String;
  var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess);
var
  LUser: TIdUserAccount;
begin
  VUserHandle := IdUserHandleNone;
  VUserAccess := IdUserAccessDenied;

  LUser := Accounts[AUsername];
  if Assigned(LUser) then begin
    if LUser.CheckPassword(VPassword) then begin
      VUserHandle := LUser.ID;
      VUserAccess := LUser.Access;
    end;
  end;
end;

procedure TIdUserManager.SetAccounts(AValue: TIdUserAccounts);
begin
  FAccounts.Assign(AValue);
end;

function TIdUserManager.GetOptions: TIdCustomUserManagerOptions;
Begin
  Result := [];
  if FAccounts.CaseSensitiveUsernames then begin
    Include(Result, umoCaseSensitiveUsername);
  end;
  if FAccounts.CaseSensitivePasswords then begin
    Include(Result, umoCaseSensitivePassword);
  end;
End;//

procedure TIdUserManager.SetOptions(const AValue: TIdCustomUserManagerOptions);
Begin
  FAccounts.CaseSensitiveUsernames := umoCaseSensitiveUsername in AValue;
  FAccounts.CaseSensitivePasswords := umoCaseSensitivePassword in AValue;
End;//

{ TIdSimpleUserManager }

procedure TIdSimpleUserManager.DoAuthentication(const AUsername: String; var VPassword: String;
  var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess);
Begin
  if Assigned(FOnAuthentication) then begin
    FOnAuthentication(SELF,AUsername,VPassword,VUserHandle,VUserAccess);
  end;
End;//

function TIdSimpleUserManager.GetOptions: TIdCustomUserManagerOptions;
Begin
  Result := FOptions;
End;//

procedure TIdSimpleUserManager.SetOptions(
  const AValue: TIdCustomUserManagerOptions);
Begin
  FOptions := AValue;
End;//

end.
