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
  Rev 1.2    7/6/2004 4:53:52 PM  DSiders
  Corrected spelling of Challenge in properties, methods, types.

  Rev 1.1    4/12/2003 10:24:10 PM  GGrieve
  Fix to Compile

  Rev 1.0    11/13/2002 08:04:22 AM  JPMugaas
}
unit IdUserAccountsOTP;
{*******************************************************}
{                                                       }
{       Indy OTP User Account Manager                   }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author J. Peter Mugaas                 }
{       2002-Nov-2                                      }
{       Based on RFC 2289                               }
{                                                       }
{*******************************************************}
{
Note:  One vulnerability in OTP is a race condition where
a user connects to a server, gets a Challenge, then a hacker
connects to the system and then the hacker guesses the OTP password.
To prevent this, servers should not allow a user to connect to the server
during the authentication process.
}
{2002-Nov-3  J. Peter Mugaas
  -Renamed units and classes from SKey to OTP.  SKey is a
   trademark of BellCore.  One Time Only (OTP is a more accurate description anyway.
  -Made properties less prone to entry errors
  -Now disregards white space with OTP
  -Will now accept the OTP Password as Hexidecimal
  -Will now accept the OTP Password in either lower or uppercase }

interface
uses
  Classes,
  IdBaseComponent,
  IdComponent,
  IdException,
  IdUserAccounts,
  SyncObjs;

const DEF_MAXCount = 900;
type
  TIdOTPUserManager = class;
  TIdOTPUserAccounts = class;

  TIdOTPPassword = (IdPW_NoEncryption, IdPW_OTP_MD4, IdPW_OTP_MD5, IdPW_OTP_SHA1);
  TIdOTPUserAccount = class(TIdUserAccount)
  protected
    FPasswordType : TIdOTPPassword;
    FCurrentCount : Cardinal;
    FSeed : String;
    FAuthenticating : Boolean;
    FNoReenter : TCriticalSection;
    procedure SetSeed(const AValue : String);
    procedure SetPassword(const AValue: String); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function  CheckPassword(const APassword: String): Boolean; override;
  published
    property CurrentCount : Cardinal read FCurrentCount write FCurrentCount;
    property Seed : String read FSeed write SetSeed;
    property PasswordType : TIdOTPPassword read FPasswordType write FPasswordType;
    property Authenticating : Boolean read FAuthenticating write FAuthenticating;
  end;

  TIdOTPUserAccounts = class(TOwnedCollection)
  protected
    //
    function  GetAccount(const AIndex: Integer): TIdOTPUserAccount;
    function  GetByUsername(const AUsername: String): TIdOTPUserAccount;
    procedure SetAccount(const AIndex: Integer; AAccountValue: TIdOTPUserAccount);
  public
    function Add: TIdOTPUserAccount; reintroduce;
    constructor Create(AOwner: TIdOTPUserManager);
    //
    property UserNames[const AUserName: String]: TIdOTPUserAccount read GetByUsername; default;
    property Items[const AIndex: Integer]: TIdOTPUserAccount read GetAccount write SetAccount;
  end;//TIdOTPUserAccounts

  TIdOTPUserManager = class(TIdCustomUserManager)
  protected
    FMaxCount : Cardinal;
    FAccounts : TIdOTPUserAccounts;
    FDefaultPassword : String;
    procedure  DoAuthentication(const AUsername: String; var VPassword: String;
      var VUserHandle: TIdUserHandle; var VUserAccess: TIdUserAccess); override;
    procedure SetMaxCount(const AValue: Cardinal);
    procedure SetDefaultPassword(const AValue : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UserDisconnected(const AUser : String); override;
        //Challenge user is a nice backdoor for some things we will do in a descendent class
    function  ChallengeUser(var VIsSafe : Boolean; const AUserName : String) : String; override;
    procedure SaveUserAccounts(const AIniFile : String);
    procedure LoadUserAccounts(const AIniFile : String);
    property Accounts : TIdOTPUserAccounts  read FAccounts;
  published
    property DefaultPassword : String read FDefaultPassword write SetDefaultPassword;
    property MaxCount : Cardinal read FMaxCount write SetMaxCount default DEF_MAXCount;
  end;
  EIdOTPException = class(EIdException);
  EIdOTPInvalidSeed = class(EIdOTPException);
  EIdOTPInvalidCount = class(EIdOTPException);
  EIdOTPInvalidPassword = class(EIdOTPException);

function GenerateSeed : String;

implementation
uses
  IdGlobal,
  IdOTPCalculator;

resourcestring
  RSOTP_Challenge = 'Response to %s required for OTP.';
  RSOTP_SeedBadFormat = 'The seed must be alphanumeric and it must at least 1 character but no more than 16 characters.';
  RSOTP_InvalidCount = 'The count must be greater than 1.';
  RSOTP_InvalidPassword = 'The password must be longer than 10 characters but no more than 63 characters.';
  //This must be longer than 9 characters but no more than 63 characters in length
  RSOTP_DefaultPassword = 'PleaseChangeMeNow';

const
  CharMap='abcdefghijklmnopqrstuvwxyz1234567890';    {Do not Localize}

function GetRandomString(NumChar: cardinal): string;
var
  i: integer;
  MaxChar: cardinal;
begin
  randomize;
  MaxChar := length(CharMap) - 1;
  for i := 1 to NumChar do
  begin
    // Add one because CharMap is 1-based
    Result := result + CharMap[Random(maxChar) + 1];
  end;
end;

function IsValidPassword(const AValue : String): Boolean;
begin
  Result := (Length(AValue)>9) and (Length(AValue)<64);
end;

function IsValidSeed(ASeed : String) : Boolean;
var i : Integer;
begin
  Result := (ASeed<>'') and (Length(ASeed)<17);
  if Result then
  begin
    for i := 1 to Length(ASeed) do
    begin
      if Pos(ASeed[i],CharMap)=0 then
      begin
        Result := False;
        break;
      end;
    end;
  end;
end;

function GenerateSeed : String;
begin
  Randomize;
  Result := GetRandomString( Random(15)+1);
end;

function LowStripWhiteSpace(const AString : String): String;
var i : Integer;
begin
  Result := '';
  for i := 1 to Length(AString) do
  begin
    if not (AString[i] in LWS) then
    begin
      Result := Result + LowerCase(AString[i]);
    end;
  end;
end;

{ TIdOTPUserManager }

function TIdOTPUserManager.ChallengeUser(var VIsSafe: Boolean;
  const AUserName: String): String;
var LUser : TIdOTPUserAccount;
begin
  Result := '';
  LUser := FAccounts.UserNames[AUserName];
  if (Assigned(LUser)=False) or (LUser.PasswordType = IdPW_NoEncryption)  then
  begin
    Exit;
  end;
  VIsSafe := LUser.Authenticating=False;
  if VIsSafe then
  begin
  //Note that we want to block any attempts to access the server after the challanage
  //is given.  This is required to prevent a race condition that a hacker can
  //exploit.
    LUser.FNoReenter.Acquire;
    try
      LUser.Authenticating:=True;
      Result := 'otp-';       {Do not translate}
      case LUser.PasswordType of
        IdPW_OTP_MD4  : Result := Result + 'md4 ';  {Do not translate}
        IdPW_OTP_MD5  : Result := Result + 'md5 ';  {Do not translate}
        IdPW_OTP_SHA1 : Result := Result + 'sha1 '; {Do not translate}
      end;
      Result := Result + IntToStr( LUser.CurrentCount)+' '+LUser.Seed;
      Result := Format(RSOTP_Challenge, [Result]);
    finally
      LUser.FNoReenter.Release;
    end;
  end;
end;

constructor TIdOTPUserManager.Create(AOwner: TComponent);
begin
  inherited;
  FAccounts := TIdOTPUserAccounts.Create(Self);
  FMaxCount := DEF_MAXCount;
  FDefaultPassword := RSOTP_DefaultPassword;
end;

destructor TIdOTPUserManager.Destroy;
begin
  FreeAndNil(FAccounts);
  inherited;
end;

procedure TIdOTPUserManager.DoAuthentication(const AUsername: String;
  var VPassword: String; var VUserHandle: TIdUserHandle;
  var VUserAccess: TIdUserAccess);
var
  LUser: TIdUserAccount;

begin
  inherited;
  VUserHandle := IdUserHandleNone;
  VUserAccess := IdUserAccessDenied;

  LUser := FAccounts[AUsername];
  if Assigned(LUser) then begin
    if LUser.CheckPassword(VPassword) then begin
      VUserHandle := LUser.ID;
      VUserAccess := LUser.Access;
    end;
  end;
end;

procedure TIdOTPUserManager.LoadUserAccounts(const AIniFile: String);
begin

end;

procedure TIdOTPUserManager.SaveUserAccounts(const AIniFile: String);
begin

end;

procedure TIdOTPUserManager.SetDefaultPassword(const AValue: String);
begin
  if IsValidPassword(AValue) then
  begin
    FDefaultPassword := AValue;
  end
  else
  begin
    raise EIdOTPInvalidPassword.Create(RSOTP_InvalidPassword);
  end;
end;

procedure TIdOTPUserManager.SetMaxCount(const AValue: Cardinal);
begin
  if AValue > 1 then
  begin
    FMaxCount := AValue;
  end
  else
  begin
    raise EIdOTPInvalidCount.Create(RSOTP_InvalidCount);
  end;
end;

procedure TIdOTPUserManager.UserDisconnected(const AUser: String);
begin
  inherited UserDisconnected(AUser);
  FAccounts.UserNames[AUser].Authenticating := False;
end;

{ TIdOTPUserAccounts }

function TIdOTPUserAccounts.Add: TIdOTPUserAccount;
begin
  Result := inherited Add as TIdOTPUserAccount;
  Result.Seed := GenerateSeed;
  Result.CurrentCount := TIdOTPUserManager(GetOwner).MaxCount;
  Result.Password := TIdOTPUserManager(GetOwner).DefaultPassword;
end;

constructor TIdOTPUserAccounts.Create(AOwner: TIdOTPUserManager);
begin
  inherited Create(AOwner, TIdOTPUserAccount);
end;

function TIdOTPUserAccounts.GetAccount(
  const AIndex: Integer): TIdOTPUserAccount;
begin
  Result := TIdOTPUserAccount(inherited Items[AIndex]);
end;

function TIdOTPUserAccounts.GetByUsername(
  const AUsername: String): TIdOTPUserAccount;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if AUsername = Items[i].UserName then begin
      Result := Items[i];
      Break;
    end;
  end;
end;

procedure TIdOTPUserAccounts.SetAccount(const AIndex: Integer;
  AAccountValue: TIdOTPUserAccount);
begin
  inherited SetItem(AIndex, AAccountValue);
end;

{ TIdOTPUserAccount }

function TIdOTPUserAccount.CheckPassword(
  const APassword: String): Boolean;
var LWordOTP : String;
    LHashSum : Int64;
    LRecPass : String;
    LHexOTP : String;
begin
  LHexOTP := '';
  LRecPass := APassword;
  case FPasswordType of
    IdPW_NoEncryption : LWordOTP := Password;
    IdPW_OTP_MD4 :
    begin
      LRecPass := LowStripWhiteSpace(APassword);
      LHashSum  := TIdOTPCalculator.GenerateKeyMD4(FSeed,Password,FCurrentCount);
      LWordOTP := LowStripWhiteSpace(TIdOTPCalculator.ToSixWordFormat(LHashSum));
      LHexOTP := LowStripWhiteSpace(TIdOTPCalculator.ToHex(LHashSum));
    end;
    IdPW_OTP_MD5 :
    begin
      LRecPass := LowStripWhiteSpace(APassword);
      LHashSum := TIdOTPCalculator.GenerateKeyMD5(FSeed,Password,FCurrentCount);
      LWordOTP := LowStripWhiteSpace(TIdOTPCalculator.ToSixWordFormat(LHashSum));
      LHexOTP := LowStripWhiteSpace(TIdOTPCalculator.ToHex(LHashSum));
    end;
    IdPW_OTP_SHA1 :
    begin
      LRecPass := LowStripWhiteSpace(APassword);
      LHashSum := TIdOTPCalculator.GenerateKeySHA1(FSeed,Password,FCurrentCount);
      LWordOTP := LowStripWhiteSpace(TIdOTPCalculator.ToSixWordFormat(LHashSum));
      LHexOTP := LowStripWhiteSpace(TIdOTPCalculator.ToHex(LHashSum));
    end;
  end;
  Result := (LRecPass = LWordOTP);
  if (Result = False) and (LHexOTP<>'') then
  begin
    Result := (LRecPass = LHexOTP);
  end;
  if Result then
  begin
    FNoReenter.Acquire;
    try
      if CurrentCount = 0 then
      begin
        Seed := GenerateSeed;
      end
      else
      begin
        Dec(FCurrentCount);
      end;
      Authenticating := False;
    finally
      FNoReenter.Release;
    end;
  end;
end;

constructor TIdOTPUserAccount.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FNoReenter := TCriticalSection.Create;
end;

destructor TIdOTPUserAccount.Destroy;
begin
  FreeAndNil(FNoReenter);
  inherited;
end;

procedure TIdOTPUserAccount.SetPassword(const AValue: String);
begin
  if IsValidPassword(AValue) then
  begin
    inherited SetPassword(AValue);
  end
  else
  begin
    raise EIdOTPInvalidPassword.Create(RSOTP_InvalidPassword);
  end;
end;

procedure TIdOTPUserAccount.SetSeed(const AValue: String);
begin
  if IsValidSeed(LowerCase(AValue)) then
  begin
    FSeed := LowerCase(AValue);
    FCurrentCount := TIdOTPUserManager( TIdOTPUserAccounts(Collection).GetOwner).MaxCount;
  end
  else
  begin
    raise EIdOTPInvalidSeed.Create(RSOTP_SeedBadFormat);
  end;
end;

end.
