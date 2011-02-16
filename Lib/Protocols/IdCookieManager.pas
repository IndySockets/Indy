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
  Rev 1.5    2004.10.27 9:17:46 AM  czhower
  For TIdStrings

  Rev 1.4    7/28/04 11:43:32 PM  RLebeau
  Bug fix for CleanupCookieList()

  Rev 1.3    2004.02.03 5:45:02 PM  czhower
  Name changes

  Rev 1.2    1/22/2004 7:10:02 AM  JPMugaas
  Tried to fix AnsiSameText depreciation.

  Rev 1.1    2004.01.21 1:04:54 PM  czhower
  InitComponenet

  Rev 1.0    11/14/2002 02:16:26 PM  JPMugaas

  2001-Mar-31 Doychin Bondzhev
  - Added new method AddCookie2 that is called when we have Set-Cookie2 as response
  - The common code in AddCookie and AddCookie2 is now in DoAdd

  2001-Mar-24 Doychin Bondzhev
  - Added OnNewCookie event
    This event is called for every new cookie. Can be used to ask the user program
    do we have to store this cookie in the cookie collection
  - Added new method AddCookie
    This calls the OnNewCookie event and if the result is true it adds the new cookie
    in the collection
}

unit IdCookieManager;

{
  Implementation of the HTTP State Management Mechanism as specified in RFC 2109, 2965.

  Author: Doychin Bondzhev (doychin@dsoft-bg.com)
  Copyright: (c) Chad Z. Hower and The Indy Team.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdBaseComponent,
  IdCookie,
  IdHeaderList,
  IdURI;

Type
  TOnNewCookieEvent = procedure(ASender: TObject; ACookie: TIdCookie; var VAccept: Boolean) of object;

  TOnCookieManagerEvent = procedure(ASender: TObject; ACookieCollection: TIdCookies) of object;
  TOnCookieCreateEvent = TOnCookieManagerEvent;
  TOnCookieDestroyEvent = TOnCookieManagerEvent;

  TIdCookieManager = class(TIdBaseComponent)
  protected
    FOnCreate: TOnCookieCreateEvent;
    FOnDestroy:  TOnCookieDestroyEvent;
    FOnNewCookie: TOnNewCookieEvent;
    FCookieCollection: TIdCookies;

    procedure CleanupCookieList;
    procedure DoOnCreate; virtual;
    procedure DoOnDestroy; virtual;
    function DoOnNewCookie(ACookie: TIdCookie): Boolean; virtual;
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    //
    procedure AddServerCookie(const ACookie: String; AURL: TIdURI);
    procedure AddServerCookies(const ACookies: TStrings; AURL: TIdURI);

    procedure AddCookies(ASource: TIdCookieManager);
    procedure CopyCookie(ACookie: TIdCookie);
    //
    procedure GenerateClientCookies(AURL: TIdURI; SecureOnly: Boolean;
      Headers: TIdHeaderList);
    //
    property CookieCollection: TIdCookies read FCookieCollection;
  published
    property OnCreate: TOnCookieCreateEvent read FOnCreate write FOnCreate;
    property OnDestroy: TOnCookieDestroyEvent read FOnDestroy write FOnDestroy;
    property OnNewCookie: TOnNewCookieEvent read FOnNewCookie write FOnNewCookie;
  end;

//procedure SplitCookies(const ACookie: String; ACookies: TStrings);

implementation

uses
  IdAssignedNumbers, IdException, IdGlobal, IdGlobalProtocols, SysUtils;

{ TIdCookieManager }

destructor TIdCookieManager.Destroy;
begin
  CleanupCookieList;
  DoOnDestroy;
  FreeAndNil(FCookieCollection);
  inherited Destroy;
end;

function SortCookiesFunc(Item1, Item2: TIdCookie): Integer;
begin
  // using the algorithm defined in draft-21 section 5.4

  if Item1 = Item2 then
  begin
    Result := 0;
  end
  else if Length(Item2.Path) > Length(Item1.Path) then
  begin
    Result := 1;
  end
  else if Length(Item1.Path) = Length(Item2.Path) then
  begin
    if Item2.CreatedAt < Item1.CreatedAt then begin
      Result := 1;
    end else begin
      Result := -1;
    end;
  end else
  begin
    Result := -1;
  end;
end;

procedure TIdCookieManager.GenerateClientCookies(AURL: TIdURI; SecureOnly: Boolean;
  Headers: TIdHeaderList);
var
  I: Integer;
  LCookieList: TIdCookieList;
  LResultList: TList;
  LCookie: TIdCookie;
  LCookiesToSend: String;
  LNow: TDateTime;
begin
  // check for expired cookies first...
  CleanupCookieList;

  LCookieList := CookieCollection.LockCookieList(caRead);
  try
    if LCookieList.Count > 0 then begin
      LResultList := TList.Create;
      try
        // Search for cookies for this domain and URI
        for I := 0 to LCookieList.Count-1 do begin
          LCookie := LCookieList.Cookies[I];
          if LCookie.IsAllowed(AURL, SecureOnly) then begin
            LResultList.Add(LCookie);
          end;
        end;

        if LResultList.Count > 0 then begin
          // order cookies from most-specific path to least-specific path
          LResultList.Sort(@SortCookiesFunc);
          LNow := Now;
          for I := 0 to LResultList.Count-1 do begin
            LCookie := TIdCookie(LResultList.Items[I]);
            LCookie.LastAccessed := LNow;
          end;

          for I := 0 to LResultList.Count-1 do begin
            LCookie := TIdCookie(LResultList.Items[I]);
            if LCookiesToSend <> '' then begin
              LCookiesToSend := LCookiesToSend + '; '; {Do not Localize}
            end;
            LCookiesToSend := LCookiesToSend + LCookie.ClientCookie;
          end;

          if LCookiesToSend <> '' then begin
            Headers.AddValue('Cookie', LCookiesToSend); {Do not Localize}
          end;
        end;
      finally
        LResultList.Free;
      end;
    end;
  finally
    CookieCollection.UnlockCookieList(caRead);
  end;
end;

{
procedure SplitCookies(const ACookie: String; ACookies: TStrings);
var
  LTemp: String;
  I, LStart: Integer;
begin
  LTemp := Trim(ACookie);
  I := 1;
  LStart := 1;
  while I <= Length(LTemp) do
  begin
    I := FindFirstOf('=;,', LTemp, -1, I); {do not localize
    if I = 0 then begin
      Break;
    end;
    if LTemp[I] = '=' then begin {Do not Localize
      I := FindFirstOf('";,', LTemp, -1, I+1); {do not localize
      if I = 0 then begin
        Break;
      end;
      if LTemp[I] = '"' then begin {Do not Localize
        I := FindFirstOf('"', LTemp, -1, I+1); {do not localize
        if I <> 0 then begin
          I := FindFirstOf(';,', LTemp, -1, I+1); {do not localize
        end;
        if I = 0 then begin
          Break;
        end;
      end;
    end;
    if LTemp[I] = ';' then begin
      Inc(I);
      Continue;
    end;
    ACookies.Add(Copy(LTemp, LStart, LStart-I));
    Inc(I);
    LStart := I;
  end;
  if LStart <= Length(LTemp) then begin
    ACookies.Add(Copy(LTemp, LStart, MaxInt));
  end;
end;
}

procedure TIdCookieManager.AddServerCookie(const ACookie: String; AURL: TIdURI);
var
  LCookie: TIdCookie;
begin
  // TODO: use TIdCookies.AddServerCookie() after adding
  // a way for it to query the manager for rejections...
  //
  //FCookieCollection.AddServerCookie(ACookie, AURI);

  LCookie := FCookieCollection.Add;
  try
    if LCookie.ParseServerCookie(ACookie, AURL) then
    begin
      if not LCookie.IsRejected(AURL) then
      begin
        if DoOnNewCookie(LCookie) then
        begin
          if FCookieCollection.AddCookie(LCookie, AURL) then begin
            LCookie := nil;
            Exit;
          end;
        end;
      end;
    end;
  finally
    if LCookie <> nil then
    begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

procedure TIdCookieManager.AddCookies(ASource: TIdCookieManager);
begin
  if (ASource <> nil) and (ASource <> Self) then begin
    FCookieCollection.AddCookies(ASource.CookieCollection);
  end;
end;

procedure TIdCookieManager.AddServerCookies(const ACookies: TStrings; AURL: TIdURI);
var
  I: Integer;
begin
  for I := 0 to ACookies.Count-1 do begin
    AddServerCookie(ACookies[I], AURL);
  end;
end;

procedure TIdCookieManager.CopyCookie(ACookie: TIdCookie);
var
  LCookie: TIdCookie;
begin
  LCookie := TIdCookieClass(ACookie.ClassType).Create(FCookieCollection);
  try
    LCookie.Assign(ACookie);
    if LCookie.Domain <> '' then
    begin
      if DoOnNewCookie(LCookie) then
      begin
        if FCookieCollection.AddCookie(LCookie, nil) then begin
          LCookie := nil;
        end;
      end;
    end;
  finally
    if LCookie <> nil then
    begin
      LCookie.Collection := nil;
      LCookie.Free;
    end;
  end;
end;

function TIdCookieManager.DoOnNewCookie(ACookie: TIdCookie): Boolean;
begin
  Result := True;
  if Assigned(FOnNewCookie) then begin
    OnNewCookie(Self, ACookie, Result);
  end;
end;

procedure TIdCookieManager.DoOnCreate;
begin
  if Assigned(FOnCreate) then begin
    OnCreate(Self, FCookieCollection);
  end;
end;

procedure TIdCookieManager.DoOnDestroy;
begin
  if Assigned(FOnDestroy) then
  begin
    OnDestroy(Self, FCookieCollection);
  end;
end;

procedure TIdCookieManager.CleanupCookieList;
var
  LExpires: TDateTime;
  i, LLastCount: Integer;
  LCookieList: TIdCookieList;
begin
  LCookieList := FCookieCollection.LockCookieList(caReadWrite);
  try
    for i := LCookieList.Count-1 downto 0 do
    begin
      LExpires := LCookieList.Cookies[i].Expires;
      if (LExpires <> 0.0) and (LExpires < Now) then
      begin
        // The Cookie has expired. It has to be removed from the collection
        LLastCount := LCookieList.Count; // RLebeau
        LCookieList.Cookies[i].Free;
        // RLebeau - the cookie may already be removed from the list via
        // its destructor.  If that happens then doing so again below can
        // cause an "index out of bounds" error, so don't do it if not needed.
        if LLastCount = LCookieList.Count then begin
          LCookieList.Delete(i);
        end;
      end;
    end;
  finally
    FCookieCollection.UnlockCookieList(caReadWrite);
  end;
end;

procedure TIdCookieManager.InitComponent;
begin
  inherited InitComponent;
  FCookieCollection := TIdCookies.Create(Self);
  DoOnCreate;
end;

end.
