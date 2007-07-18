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
  Rev 1.2    2003.11.04 3:49:00 PM  czhower
  Update to sync TC

  Rev 1.1    2003.10.21 12:19:02 AM  czhower
  TIdTask support and fiber bug fixes.
}

unit IdTask;

interface

uses
  IdYarn,
  SysUtils;

type
  TIdTask = class(TObject)
  protected
    FBeforeRunDone: Boolean;
    FData: TObject;
    FYarn: TIdYarn;
    //
    procedure AfterRun; virtual;
    procedure BeforeRun; virtual;
    function Run: Boolean; virtual; abstract;
    procedure HandleException(AException: Exception); virtual;
  public
    constructor Create(
      AYarn: TIdYarn
      ); reintroduce; virtual;
    destructor Destroy; override;
    // The Do's are separate so we can add events later if necessary without
    // needing the inherited calls to perform them, as well as allowing
    // us to keep the real runs as protected
    procedure DoAfterRun;
    procedure DoBeforeRun;
    function DoRun: Boolean;
    procedure DoException(AException: Exception);
    // BeforeRunDone property to allow flexibility in alternative schedulers
    property BeforeRunDone: Boolean read FBeforeRunDone;
    //
    property Data: TObject read FData write FData;
    property Yarn: TIdYarn read FYarn;
  end;

implementation

uses IdGlobal;

{ TIdTask }

procedure TIdTask.AfterRun;
begin
end;

procedure TIdTask.BeforeRun;
begin
end;

procedure TIdTask.HandleException(AException: Exception);
begin
end;

constructor TIdTask.Create(AYarn: TIdYarn);
begin
  inherited Create;
  FYarn := AYarn;
  FBeforeRunDone := False;
end;

destructor TIdTask.Destroy;
begin
  // Dont free the yarn, that is the responsibilty of the thread / fiber.
  // .Yarn here is just a reference, not an ownership
  FreeAndNil(FData);
  inherited Destroy;
end;

procedure TIdTask.DoAfterRun;
begin
  AfterRun;
end;

procedure TIdTask.DoBeforeRun;
begin
  FBeforeRunDone := True;
  BeforeRun;
end;

function TIdTask.DoRun: Boolean;
begin
  Result := Run;
end;

procedure TIdTask.DoException(AException: Exception);
begin
  HandleException(AException);
end;

end.
